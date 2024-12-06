import 'dart:convert';

LiftCargoModel liftCargoModelFromMap(String str) =>
    LiftCargoModel.fromMap(json.decode(str));

String liftCargoModelToMap(LiftCargoModel data) => json.encode(data.toMap());

class LiftCargoModel {
  int? cargoLiftId;
  String? cargoLiftUuid;
  String? cargoLiftCode;
  String? cargoLiftName;
  String? departmentCode;
  String? departmentName;
  String? floorName;
  String? cargoLiftPosition;
  String? cargoLiftDescription;

  LiftCargoModel({
    this.cargoLiftId,
    this.cargoLiftUuid,
    this.cargoLiftCode,
    this.cargoLiftName,
    this.departmentCode,
    this.departmentName,
    this.floorName,
    this.cargoLiftPosition,
    this.cargoLiftDescription,
  });

  LiftCargoModel copyWith({
    int? cargoLiftId,
    String? cargoLiftUuid,
    String? cargoLiftCode,
    String? cargoLiftName,
    String? departmentCode,
    String? departmentName,
    String? floorName,
    String? cargoLiftPosition,
    String? cargoLiftDescription,
  }) =>
      LiftCargoModel(
        cargoLiftId: cargoLiftId ?? this.cargoLiftId,
        cargoLiftUuid: cargoLiftUuid ?? this.cargoLiftUuid,
        cargoLiftCode: cargoLiftCode ?? this.cargoLiftCode,
        cargoLiftName: cargoLiftName ?? this.cargoLiftName,
        departmentCode: departmentCode ?? this.departmentCode,
        departmentName: departmentName ?? this.departmentName,
        floorName: floorName ?? this.floorName,
        cargoLiftPosition: cargoLiftPosition ?? this.cargoLiftPosition,
        cargoLiftDescription: cargoLiftDescription ?? this.cargoLiftDescription,
      );

  factory LiftCargoModel.fromMap(Map<String, dynamic> json) => LiftCargoModel(
        cargoLiftId: json["cargo_lift_id"],
        cargoLiftUuid: json["cargo_lift_uuid"],
        cargoLiftCode: json["cargo_lift_code"],
        cargoLiftName: json["cargo_lift_name"],
        departmentCode: json["department_code"],
        departmentName: json["department_name"],
        floorName: json["floor_name"],
        cargoLiftPosition: json["cargo_lift_position"],
        cargoLiftDescription: json["cargo_lift_description"],
      );

  Map<String, dynamic> toMap() => {
        "cargo_lift_id": cargoLiftId,
        "cargo_lift_uuid": cargoLiftUuid,
        "cargo_lift_code": cargoLiftCode,
        "cargo_lift_name": cargoLiftName,
        "department_code": departmentCode,
        "department_name": departmentName,
        "floor_name": floorName,
        "cargo_lift_position": cargoLiftPosition,
        "cargo_lift_description": cargoLiftDescription,
      };
}
