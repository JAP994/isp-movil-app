class ReportDbResponse {
  final int id;
  final String reportNumber;
  final DateTime reportDateTime;
  final DateTime detectedDateTime;
  final String detectedLocationUnit;
  final String involvedMaterialPersonnel;
  final String evidenceFile;
  final String detailedDescription;
  final String registrationIp;
  final String userAgent;
  final DateTime creationDate;
  final String? lastModifiedIp; // ahora opcional
  final String? lastModifiedUserAgent; // ahora opcional
  final DateTime? lastModifiedDate; // ahora opcional

  ReportDbResponse({
    required this.id,
    required this.reportNumber,
    required this.reportDateTime,
    required this.detectedDateTime,
    required this.detectedLocationUnit,
    required this.involvedMaterialPersonnel,
    required this.evidenceFile,
    required this.detailedDescription,
    required this.registrationIp,
    required this.userAgent,
    required this.creationDate,
    this.lastModifiedIp,
    this.lastModifiedUserAgent,
    this.lastModifiedDate,
  });

  factory ReportDbResponse.fromJson(Map<String, dynamic> json) =>
      ReportDbResponse(
        id: json["id"],
        reportNumber: json["reportNumber"],
        reportDateTime: DateTime.parse(json["reportDateTime"]),
        detectedDateTime: DateTime.parse(json["detectedDateTime"]),
        detectedLocationUnit: json["detectedLocationUnit"],
        involvedMaterialPersonnel: json["involvedMaterialPersonnel"],
        evidenceFile: json["evidenceFile"],
        detailedDescription: json["detailedDescription"],
        registrationIp: json["registrationIp"],
        userAgent: json["userAgent"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModifiedIp: json["lastModifiedIp"], // puede ser null
        lastModifiedUserAgent: json["lastModifiedUserAgent"], // puede ser null
        lastModifiedDate: json["lastModifiedDate"] != null
            ? DateTime.parse(json["lastModifiedDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reportNumber": reportNumber,
    "reportDateTime": reportDateTime.toIso8601String(),
    "detectedDateTime": detectedDateTime.toIso8601String(),
    "detectedLocationUnit": detectedLocationUnit,
    "involvedMaterialPersonnel": involvedMaterialPersonnel,
    "evidenceFile": evidenceFile,
    "detailedDescription": detailedDescription,
    "registrationIp": registrationIp,
    "userAgent": userAgent,
    "creationDate": creationDate.toIso8601String(),
    "lastModifiedIp": lastModifiedIp,
    "lastModifiedUserAgent": lastModifiedUserAgent,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
  };
}
