import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog/core/utils/dimension/screen_dimension.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'features/products/presentation/pages/product_list_page.dart';

final helloWorldProvider = Provider((_) => 'Hello world');
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
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: ClampingScrollWrapper.builder(
              context,
              MaxWidthBox(maxWidth: 1200, child: child!),
            ),
            breakpoints: ScreenDimension.breakpoint,
            breakpointsLandscape: ScreenDimension.breakpointsLandscape,
          ),
      home: Scaffold(
        appBar: AppBar(title:  Text('Example', style: TextStyle(fontSize: 18.sp),)),
        body: Center(child: Text(value)),
      ),
    );
  }
}
