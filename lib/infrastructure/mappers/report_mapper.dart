import 'package:isp/domain/entities/report.dart';
import 'package:isp/infrastructure/models/reportdb/reportdb_response.dart';

class ReportMapper {
  static Report reportDBToEntity(ReportDbResponse reportdb) => Report(
    id: reportdb.id,
    reportNumber: reportdb.reportNumber,
    reportDateTime: reportdb.reportDateTime,
    detectedDateTime: reportdb.detectedDateTime,
    detectedLocationUnit: reportdb.detectedLocationUnit,
    involvedMaterialPersonnel: reportdb.involvedMaterialPersonnel,
    evidenceFile: reportdb.evidenceFile,
    detailedDescription: reportdb.detailedDescription,
    registrationIp: reportdb.registrationIp,
    userAgent: reportdb.userAgent,
    creationDate: reportdb.creationDate,
    lastModifiedIp: reportdb.lastModifiedIp, // ahora puede ser null
    lastModifiedUserAgent:
        reportdb.lastModifiedUserAgent, // ahora puede ser null
    lastModifiedDate: reportdb.lastModifiedDate, // ahora puede ser null
  );
}
