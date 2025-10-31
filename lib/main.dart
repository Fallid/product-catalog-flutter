import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog/core/utils/dimension/screen_dimension.dart';
import 'package:product_catalog/features/products/presentation/product_list_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) => MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalog',
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: ClampingScrollWrapper.builder(
              context,
              MaxWidthBox(maxWidth: 1200, child: child!),
            ),
            breakpoints: ScreenDimension.breakpoint,
            breakpointsLandscape: ScreenDimension.breakpointsLandscape,
          ),
      home: ProductListScreen(),
    );
  }
}
