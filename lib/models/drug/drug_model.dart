// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Drug extends Equatable {
  const Drug({
    required this.name,
    required this.dose,
  });

  final String name;
  final Dose dose;

  factory Drug.fromJson(dynamic json) {
    return Drug(
      name: json['name'],
      dose: Dose.fromJson(json['dose']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dose': dose.toJson(),
    };
  }

  Drug updateDose({
    double? unit,
    int? frequency,
    int? duration,
    String? form,
    String? frequencyUnit,
    String? durationUnit,
  }) {
    return Drug(
      name: name,
      dose: Dose(
        unit: unit ?? dose.unit,
        frequency: frequency ?? dose.frequency,
        duration: duration ?? dose.duration,
        form: form ?? dose.form,
        frequencyUnit: frequencyUnit ?? dose.frequencyUnit,
        durationUnit: durationUnit ?? dose.durationUnit,
      ),
    );
  }

  @override
  List<Object?> get props => [name];
}

class Dose extends Equatable {
  final double unit;
  final int frequency;
  final String frequencyUnit;
  final int duration;
  final String durationUnit;
  final String form;

  const Dose({
    required this.unit,
    required this.frequency,
    required this.frequencyUnit,
    required this.duration,
    required this.durationUnit,
    required this.form,
  });

  @override
  List<Object?> get props => [
        unit,
        frequency,
        duration,
        form,
      ];

  factory Dose.Initial() {
    return const Dose(
      unit: 0.0,
      frequency: 0,
      duration: 0,
      form: '',
      frequencyUnit: '',
      durationUnit: '',
    );
  }

  factory Dose.fromJson(dynamic json) {
    return Dose(
      unit: json['unit'],
      frequency: json['frequency'],
      duration: json['duration'],
      form: json['form'],
      frequencyUnit: json['frequencyunit'],
      durationUnit: json['durationunit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'frequency': frequency,
      'duration': duration,
      'form': form,
      'frequencyunit': frequencyUnit,
      'durationunit': durationUnit,
    };
  }

  Dose copyWith({
    double? unit,
    int? frequency,
    int? duration,
    String? form,
    String? frequencyUnit,
    String? durationUnit,
  }) {
    return Dose(
      unit: unit ?? this.unit,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      form: form ?? this.form,
      frequencyUnit: frequencyUnit ?? this.frequencyUnit,
      durationUnit: durationUnit ?? this.durationUnit,
    );
  }
}
