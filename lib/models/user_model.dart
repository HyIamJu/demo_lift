// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

UserModel userFromMap(String str) => UserModel.fromMap(json.decode(str));

String userToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
    int? cargoLiftUserId;
    int? employeeBadge;
    String? employeeName;
    String? departmentCode;
    String? departmentName;
    String? lineCode;
    String? cargoLiftUserDescription;
    String? cargoLiftUserUuid;
    String? employeeCardNo;
    String? employeeImage;

    UserModel({
        this.cargoLiftUserId,
        this.employeeBadge,
        this.employeeName,
        this.departmentCode,
        this.departmentName,
        this.lineCode,
        this.cargoLiftUserDescription,
        this.cargoLiftUserUuid,
        this.employeeCardNo,
        this.employeeImage,
    });

    UserModel copyWith({
        int? cargoLiftUserId,
        int? employeeBadge,
        String? employeeName,
        String? departmentCode,
        String? departmentName,
        String? lineCode,
        String? cargoLiftUserDescription,
        String? cargoLiftUserUuid,
        String? employeeCardNo,
        String? employeeImage,
    }) => 
        UserModel(
            cargoLiftUserId: cargoLiftUserId ?? this.cargoLiftUserId,
            employeeBadge: employeeBadge ?? this.employeeBadge,
            employeeName: employeeName ?? this.employeeName,
            departmentCode: departmentCode ?? this.departmentCode,
            departmentName: departmentName ?? this.departmentName,
            lineCode: lineCode ?? this.lineCode,
            cargoLiftUserDescription: cargoLiftUserDescription ?? this.cargoLiftUserDescription,
            cargoLiftUserUuid: cargoLiftUserUuid ?? this.cargoLiftUserUuid,
            employeeCardNo: employeeCardNo ?? this.employeeCardNo,
            employeeImage: employeeImage ?? this.employeeImage,
        );

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        cargoLiftUserId: json["cargo_lift_user_id"],
        employeeBadge: json["employee_badge"],
        employeeName: json["employee_name"],
        departmentCode: json["department_code"],
        departmentName: json["department_name"],
        lineCode: json["line_code"],
        cargoLiftUserDescription: json["cargo_lift_user_description"],
        cargoLiftUserUuid: json["cargo_lift_user_uuid"],
        employeeCardNo: json["employee_card_no"],
        employeeImage: json["employee_image"],
    );

    Map<String, dynamic> toMap() => {
        "cargo_lift_user_id": cargoLiftUserId,
        "employee_badge": employeeBadge,
        "employee_name": employeeName,
        "department_code": departmentCode,
        "department_name": departmentName,
        "line_code": lineCode,
        "cargo_lift_user_description": cargoLiftUserDescription,
        "cargo_lift_user_uuid": cargoLiftUserUuid,
        "employee_card_no": employeeCardNo,
        "employee_image": employeeImage,
    };
}
