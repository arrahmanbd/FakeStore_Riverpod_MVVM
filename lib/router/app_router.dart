
import 'export.dart';

//Here all name decleared
const String home = "home";
const String auth = "auth";
const String cart = "cart";
const String details = "details";

//This class Generate A custom route which will be used in .pushedNamed method.
class AppRouter {
  static Route<dynamic> gen(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case auth:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case details:
        final selectedProduct = settings.arguments as ProductModel;
        return MaterialPageRoute(
            builder: (_) => DetailsPage(product: selectedProduct));
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}

//Easy to Navigate
goTo(context, name, {args}) {
  Navigator.pushNamed(context, name, arguments: args);
}


//If we dont have any routes then This page will appear
//Like 404 page
class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  _NotFoundPageState createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Found"),
      ),
      body: const Center(
        child: Text("Sorry, We couldn't found your page"),
      ),
    );
  }
}
