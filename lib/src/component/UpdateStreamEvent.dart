
class UpdateStreamEvent {
  final String tag;
  final int page;
  final bool isRefresh;

  UpdateStreamEvent({required this.tag, required this.page, required this.isRefresh});
}
