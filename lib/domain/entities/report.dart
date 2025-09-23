class Report {
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
  final String lastModifiedIp;
  final String lastModifiedUserAgent;
  final DateTime lastModifiedDate;

  Report({
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
    required this.lastModifiedIp,
    required this.lastModifiedUserAgent,
    required this.lastModifiedDate,
  });
}
