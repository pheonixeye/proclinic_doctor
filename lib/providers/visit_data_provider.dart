import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/errors/no_visit_selected.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PxVisitData extends ChangeNotifier {
  Visit? _visit;
  Visit? get visit => _visit;

  // List<VisitSupplyItem>? _supplies;
  // List<VisitSupplyItem>? get supplies => _supplies;

  void selectVisit(Visit? value) {
    _visit = value;
    notifyListeners();
  }

  Future<void> addSuppliesToVisit(VisitSupplyItem item) async {
    if (_visit != null &&
        _visit!.supplies.any((i) => i.nameEn == item.nameEn)) {
      final oldItem =
          _visit!.supplies.firstWhere((x) => x.nameEn == item.nameEn);
      final index = _visit!.supplies.indexOf(oldItem);
      final amount = (oldItem.amount + 1.0);
      final price = (amount * item.price);
      final newItem = VisitSupplyItem(
        id: item.id,
        nameEn: item.nameEn,
        nameAr: item.nameAr,
        amount: amount,
        price: price,
      );
      _visit!.supplies[index] = newItem;
    } else {
      _visit!.supplies.add(item);
    }
    notifyListeners();
    await Future.wait([
      updateVisitSupplies(_visit!.supplies),
      _deductSuppliesFromStore(item),
    ]);
  }

  Future<void> removeSuppliesFromVisit(VisitSupplyItem item) async {
    if (_visit != null &&
        _visit!.supplies.any((i) => i.nameEn == item.nameEn)) {
      final oldItem =
          _visit!.supplies.firstWhere((x) => x.nameEn == item.nameEn);
      final index = _visit!.supplies.toList().indexOf(oldItem);
      final amount = (item.amount - 1.0);
      final price = ((oldItem.price ~/ oldItem.amount) * amount);
      if (amount == 0) {
        _visit!.supplies.remove(item);
      } else {
        final newItem = VisitSupplyItem(
          id: item.id,
          nameEn: item.nameEn,
          nameAr: item.nameAr,
          amount: amount,
          price: price,
        );
        _visit!.supplies[index] = newItem;
      }
    }
    notifyListeners();
    await Future.wait([
      updateVisitSupplies(_visit!.supplies),
      _returnSuppliesToStore(item),
    ]);
  }

  Future<void> updateVisitSupplies(List<VisitSupplyItem> supplies) async {
    if (_visit != null) {
      await Database.instance.visits.updateOne(
        where.eq("_id", _visit!.id),
        {
          r"$set": {
            "supplies": supplies.map((e) => e.toJson()).toList(),
          },
        },
      );
      final result =
          await Database.instance.visits.findOne(where.eq("_id", _visit!.id));
      selectVisit(Visit.fromJson(result));
    } else {
      throw Exception("No Selected Visit.");
    }
  }

  Future<void> _deductSuppliesFromStore(VisitSupplyItem item) async {
    await Database.instance.supplies.updateOne(
      where.eq('_id', item.id),
      {
        r'$inc': {
          'amount': -1.0,
        },
      },
    );
  }

  Future<void> _returnSuppliesToStore(VisitSupplyItem item) async {
    await Database.instance.supplies.updateOne(
      where.eq('_id', item.id),
      {
        r'$inc': {
          'amount': 1.0,
        },
      },
    );
  }

  //------------------------------------//

  VisitData? _data;
  VisitData? get data => _data;

  Future<void> fetchVisitData() async {
    if (visit == null) {
      throw NoVisitSelectedException();
    }
    final result = await Database.instance.visitData
        .findOne(where.eq(SxVD.VISITID, visit!.id));
    _data = VisitData.fromJson(result);
    notifyListeners();
    _drugs = _data!.drugs;
    _labs = _data!.labs;
    _rads = _data!.rads;
    notifyListeners();
  }

  List<String> _labs = [];
  List<String> get labs => _labs;

  List<String> _rads = [];
  List<String> get rads => _rads;

  List<PrescribedDrug> _drugs = [];
  List<PrescribedDrug> get drugs => _drugs;

  void setLabs(String value) {
    _labs.contains(value) ? _labs.remove(value) : _labs.add(value);
    notifyListeners();
  }

  void setRads(String value) {
    _rads.contains(value) ? _rads.remove(value) : _rads.add(value);
    notifyListeners();
  }

  void setDrugs(PrescribedDrug value) {
    _drugs.contains(value) ? _drugs.remove(value) : _drugs.add(value);
    notifyListeners();
  }

  void filterLabs(String value) {
    value.isEmpty
        ? _labs = _data!.labs
        : _labs = _labs
            .where((e) => e.toLowerCase().startsWith(value.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void filterRads(String value) {
    value.isEmpty
        ? _rads = _data!.rads
        : _rads = _rads
            .where((e) => e.toLowerCase().startsWith(value.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void filterDrugs(String value) {
    value.isEmpty
        ? _drugs = _data!.drugs
        : _drugs = _drugs
            .where((e) => e.name.toLowerCase().startsWith(value.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void setDose(
    String drug, {
    double? unit,
    int? frequency,
    int? duration,
    String? form,
    String? frequecyUnit,
    String? durationUnit,
  }) {
    var d = _drugs.firstWhere((element) => element.name == drug);
    var i = _drugs.indexOf(d);
    _drugs[i] = d.updateDose(
      unit: unit,
      frequency: frequency,
      duration: duration,
      form: form,
      frequencyUnit: frequecyUnit,
      durationUnit: durationUnit,
    );
    notifyListeners();
  }

  bool validateDrugPrescription() {
    bool isValid = false;
    _drugs.map((e) {
      final d = e.dose;
      if (d.duration == 0 ||
          d.unit == 0 ||
          d.durationUnit == '' ||
          d.form == '' ||
          d.frequency == 0 ||
          d.frequencyUnit == '') {
        isValid = false;
      } else {
        isValid = true;
      }
    }).toList();
    return isValid;
  }

  Future<void> updateVisitData(String attribute, dynamic value) async {
    await Database.instance.visitData.updateOne(
      where.eq(SxVD.VISITID, visit!.id),
      {
        r'$set': {
          attribute: value,
        }
      },
    );
    await fetchVisitData();
  }
}
