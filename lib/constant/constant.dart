import 'package:valorant/data/web_service/web_service.dart';

const String baseUrl = "https://valorant-api.com";
const String method = "/v1/agents";
const String apiUrl = baseUrl + method;
final WebService apiProvider = WebService();