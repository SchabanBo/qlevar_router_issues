import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: QR.router(AppRoutes.initRoutes(), initRoute: '/main'),
      routeInformationParser: QR.routeParser(),
    );
  }
}

class AppRoutes {
  static QRCustomPage customPage =
      QRCustomPage(transitionsBuilder: (ctx, animation, secondary, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  });

  static QRoute makeRoute(
      {String path, QRoutePage page, List<QRouteBase> children}) {
    return QRoute(
        path: path, page: page, children: children, pageType: customPage);
  }

  static List<QRouteBase> initRoutes() {
    final routes = <QRouteBase>[
      makeRoute(path: '/main', page: (child) => PageMain(child), children: [
        makeRoute(path: '/apps', page: (child) => PageAppManeg(child)),
        makeRoute(path: '/home', page: (child) => Text('/home')),
        makeRoute(
            path: '/app/:id',
            page: (child) => Text('/app/${QR.params['id'].asInt}')),
        makeRoute(
            path: '/app-edit/:id', page: (child) => Text('/app-edit/:id')),
        makeRoute(path: '/app-cfg/:id', page: (child) => Text('/app-cfg/:id')),
        makeRoute(path: '/app-img/:id', page: (child) => Text('/app-img/:id')),
        makeRoute(path: '/app-op/:id', page: (child) => Text('/app-op/:id')),
      ]),
    ];
    return routes;
  }
}

class PageMain extends StatelessWidget {
  final QRouteChild child;
  PageMain(this.child);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () => QR.to('/main/apps'), child: Text('Go apps')),
          TextButton(
              onPressed: () => QR.to('/main/app/1'), child: Text('Go app 1')),
          SizedBox(width: 400, height: 400, child: child.childRouter)
        ],
      ),
    );
  }
}

class PageAppManeg extends StatelessWidget {
  final QRouteChild child;
  PageAppManeg(this.child);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => QR.to('/main/app/1'), child: Text('Go app 1'));
  }
}
