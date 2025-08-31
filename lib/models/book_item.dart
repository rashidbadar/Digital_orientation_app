class BookItem {
  final String title;
  final String imagePath;
  final String? offlineHtmlPath;
  final String? onlineUrl;

  BookItem({
    required this.title,
    required this.imagePath,
    this.offlineHtmlPath,
    this.onlineUrl,
  });
}
