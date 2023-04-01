import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PaginatedEnity {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "results")
  final List<dynamic> results;

  PaginatedEnity({
    required this.page,
    required this.totalPages,
    required this.results,
  });
}
