import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';

/// Grid widget for displaying user photos
class PhotoGrid extends StatelessWidget {
  final List<String> photoUrls;
  final VoidCallback? onAddPhoto;

  const PhotoGrid({
    super.key,
    required this.photoUrls,
    this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: photoUrls.length + (onAddPhoto != null ? 1 : 0),
      itemBuilder: (context, index) {
        // Add photo button
        if (index == photoUrls.length && onAddPhoto != null) {
          return GestureDetector(
            onTap: onAddPhoto,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.textMuted.withValues(alpha: 0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          );
        }
        
        // Photo item
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: photoUrls[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.border,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.border,
              child: const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
