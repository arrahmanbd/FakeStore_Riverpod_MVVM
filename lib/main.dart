
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'themes/theme_data.dart';
import 'helper/theme_changer.dart';
import 'router/app_router.dart';
import 'router/export.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool dark = ref.watch(themeProvider).isDark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store API',
      theme: dark?darkTheme:lightTheme,
      onGenerateRoute: AppRouter.gen,
      initialRoute: auth,
    );
  }
}
