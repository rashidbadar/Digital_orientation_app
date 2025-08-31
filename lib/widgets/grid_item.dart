import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const GridItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Section with loading state
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _hasError
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Image not found',
                            style: TextStyle(fontSize: 10, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Image.asset(widget.imagePath, fit: BoxFit.contain),
              ),
            ),

            // Title Section
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    try {
      // Precache the image to check if it exists and handle loading
      await precacheImage(AssetImage(widget.imagePath), context);
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }
}
