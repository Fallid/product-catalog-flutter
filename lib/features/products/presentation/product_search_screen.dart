import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog/features/products/application/product_list_provider.dart';
import 'package:product_catalog/features/products/presentation/product_detail_screen.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  ConsumerState<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = ref.watch(productSearchProvider(_searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
          style: TextStyle(fontSize: 16.sp),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
              icon: const Icon(Icons.clear),
            ),
        ],
      ),
      body: searchResultsAsync.when(
        data: (products) {
          if (_searchQuery.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64.r, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text(
                    'Search for products',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64.r, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text(
                    'No products found',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Try searching with different keywords',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.w),
                  leading: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        product.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.sp, color: Colors.amber),
                          SizedBox(width: 4.w),
                          Text(
                            '${product.rating.rate}',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64.r, color: Colors.red),
              SizedBox(height: 16.h),
              Text(
                'Error loading search results',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                error.toString(),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
