// To parse this JSON data, do
//
//     final liftActionLog = liftActionLogFromMap(jsonString);

import 'dart:convert';

LiftActionLog liftActionLogFromMap(String str) => LiftActionLog.fromMap(json.decode(str));

String liftActionLogToMap(LiftActionLog data) => json.encode(data.toMap());

class LiftActionLog {
    int? cargoLiftLogId;
    String? employeeBadge;
    String? employeeName;
    String? departmentCode;
    String? departmentName;
    String? lineCode;
    int? cargoLiftId;
    String? cargoLiftCode;
    String? cargoLiftName;
    String? cargoLiftButton;
    String? floorName;
    String? createdAt;
    String? userImage;

    LiftActionLog({
        this.cargoLiftLogId,
        this.employeeBadge,
        this.employeeName,
        this.departmentCode,
        this.departmentName,
        this.lineCode,
        this.cargoLiftId,
        this.cargoLiftCode,
        this.cargoLiftName,
        this.cargoLiftButton,
        this.floorName,
        this.createdAt,
        this.userImage,
    });

    LiftActionLog copyWith({
        int? cargoLiftLogId,
        String? employeeBadge,
        String? employeeName,
        String? departmentCode,
        String? departmentName,
        String? lineCode,
        int? cargoLiftId,
        String? cargoLiftCode,
        String? cargoLiftName,
        String? cargoLiftButton,
        String? floorName,
        String? createdAt,
        String? userImage,
    }) => 
        LiftActionLog(
            cargoLiftLogId: cargoLiftLogId ?? this.cargoLiftLogId,
            employeeBadge: employeeBadge ?? this.employeeBadge,
            employeeName: employeeName ?? this.employeeName,
            departmentCode: departmentCode ?? this.departmentCode,
            departmentName: departmentName ?? this.departmentName,
            lineCode: lineCode ?? this.lineCode,
            cargoLiftId: cargoLiftId ?? this.cargoLiftId,
            cargoLiftCode: cargoLiftCode ?? this.cargoLiftCode,
            cargoLiftName: cargoLiftName ?? this.cargoLiftName,
            cargoLiftButton: cargoLiftButton ?? this.cargoLiftButton,
            floorName: floorName ?? this.floorName,
            createdAt: createdAt ?? this.createdAt,
            userImage:  userImage ?? this.userImage,
        );

    factory LiftActionLog.fromMap(Map<String, dynamic> json) => LiftActionLog(
        cargoLiftLogId: json["cargo_lift_log_id"],
        employeeBadge: json["employee_badge"],
        employeeName: json["employee_name"],
        departmentCode: json["department_code"],
        departmentName: json["department_name"],
        lineCode: json["line_code"],
        cargoLiftId: json["cargo_lift_id"],
        cargoLiftCode: json["cargo_lift_code"],
        cargoLiftName: json["cargo_lift_name"],
        cargoLiftButton: json["cargo_lift_button"],
        floorName: json["floor_name"],
        createdAt: json["created_at"],
        userImage: json["image"]
    );

    Map<String, dynamic> toMap() => {
        "cargo_lift_log_id": cargoLiftLogId,
        "employee_badge": employeeBadge,
        "employee_name": employeeName,
        "department_code": departmentCode,
        "department_name": departmentName,
        "line_code": lineCode,
        "cargo_lift_id": cargoLiftId,
        "cargo_lift_code": cargoLiftCode,
        "cargo_lift_name": cargoLiftName,
        "cargo_lift_button": cargoLiftButton,
        "floor_name": floorName,
        "created_at": createdAt,
        "image": userImage,
    };
}
