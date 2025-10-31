import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog/core/domain/product.dart';
import 'package:product_catalog/core/domain/rating.dart';
import 'package:product_catalog/core/utils/dimension/screen_dimension.dart';
import 'package:product_catalog/features/cart/application/cart_provider.dart';
import 'package:product_catalog/features/cart/presentation/cart_screen.dart';
import 'package:product_catalog/features/products/presentation/product_detail_screen.dart';
import 'package:product_catalog/features/products/presentation/product_search_screen.dart';
import 'package:product_catalog/features/products/application/product_list_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productListProvider);
    final cartCount = ref.watch(cartCountProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Catalog', style: TextStyle(fontSize: 20.sp)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductSearchScreen(),
                ),
              );
            },
            icon: Icon(Icons.search_outlined, size: 24.r),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_bag_outlined, size: 24.r),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.r,
                      minHeight: 16.r,
                    ),
                    child: Text(
                      '$cartCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Text(
                'Product tidak tersedia',
                style: TextStyle(fontSize: 12.sp),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(productListProvider),
            child: _buildProductGrid(
              products,
              isLoading: false,
              context: context,
            ),
          );
        },
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.r, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    'Something went error',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: () => ref.invalidate(productListProvider),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
        loading:
            () => _buildProductGrid(
              _dummyProducts(),
              isLoading: true,
              context: context,
            ),
      ),
    );
  }

  Widget _buildProductGrid(
    List<Product> products, {
    required bool isLoading,
    required BuildContext context,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ScreenDimension.isTablet(context) ? 4 : 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 2,
            child: InkWell(
              onTap:
                  isLoading
                      ? null
                      : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    ProductDetailScreen(productId: product.id),
                          ),
                        );
                      },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        isLoading
                            ? Bone.square(size: double.infinity)
                            : CachedNetworkImage(
                              placeholder:
                                  (context, url) => CardLoading(height: 60.h),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                              imageUrl: product.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 60.h,
                            ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Product> _dummyProducts() {
    return List.generate(
      6,
      (index) => Product(
        id: index,
        title: 'Loading Product Name',
        price: 0.0,
        description: '',
        category: '',
        image: '',
        rating: Rating(rate: 0.0, count: 0),
      ),
    );
  }
}
