import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:page_transition/page_transition.dart';

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| // Run the below in the terminal to create new a page and controller.
| // "flutter pub run nylo_framework:main make:page my_page -c"
| // Learn more https://nylo.dev/docs/2.x/router
|--------------------------------------------------------------------------
*/

buildRouter() => nyRoutes((router) {
      router.route("/", (context) => HomePage());

      // Add your routes here
      router.route(HomePage.route, (context) => HomePage(),
          transition: PageTransitionType.leftToRight);
    });
