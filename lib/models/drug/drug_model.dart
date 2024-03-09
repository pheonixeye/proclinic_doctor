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

  @override
  List<Object?> get props => [name];
}

class Dose extends Equatable {
  final double unit;
  final int frequency;
  final int duration;
  final String form;

  const Dose({
    required this.unit,
    required this.frequency,
    required this.duration,
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
    );
  }

  factory Dose.fromJson(dynamic json) {
    return Dose(
      unit: json['unit'],
      frequency: json['frequency'],
      duration: json['duration'],
      form: json['form'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'frequency': frequency,
      'duration': duration,
      'form': form,
    };
  }

  Dose copyWith({double? unit, int? frequency, int? duration, String? form}) {
    return Dose(
      unit: unit ?? this.unit,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      form: form ?? this.form,
    );
  }
}
