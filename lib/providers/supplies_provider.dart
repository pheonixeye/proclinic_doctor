import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/models/supply_item/supply_item.dart';
import 'package:proclinic_doctor_windows/models/visit_supply_item/visit_supply_item.dart';

class PxSupplies extends ChangeNotifier {
  PxSupplies({required this.docid});
  final int? docid;

  List<SupplyItem> _supplies = [];

  List<SupplyItem> get supplies => _supplies;

  List<SupplyItem> _filteredSupplies = [];
  List<SupplyItem> get filteredSupplies => _filteredSupplies;

  void filterSupplies(String val) {
    val.isEmpty
        ? _filteredSupplies = _supplies
        : _filteredSupplies = _supplies
            .where((x) => x.nameEn.toLowerCase().startsWith(val.toLowerCase()))
            .toList();
    notifyListeners();
  }

  Future<void> fetchAllDoctorSupplies() async {
    if (docid != null) {
      final result = await Database.instance.supplies
          .find(where.eq("docid", docid))
          .toList();
      _supplies = result.map((e) => SupplyItem.fromMap(e)).toList();
      notifyListeners();
    }
  }

  Future<void> deductSupplyItemsFromStore(
    List<VisitSupplyItem>? visitItems,
  ) async {
    if (visitItems != null) {
      for (final visitItem in visitItems) {
        late final SupplyItem _item;
        final supplyItem = await Database.instance.supplies.findOne(
          where.eq("_id", visitItem.id),
        );
        if (supplyItem != null) {
          _item = SupplyItem.fromMap(supplyItem);
        }
        await Database.instance.supplies.updateOne(
          where.eq("_id", visitItem.id),
          {
            r"$set": {
              'amount': (_item.amount - visitItem.amount),
            },
          },
        );
      }

      await fetchAllDoctorSupplies();
      filterSupplies('');
    }
  }
}
