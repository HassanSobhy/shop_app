import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/categories/bloc/categories_bloc.dart';
import 'package:shop_app/modules/categories/bloc/categories_repository.dart';
import 'package:shop_app/modules/home/bloc/bottom_navigation_bar_bloc.dart';
import 'package:shop_app/modules/auth/login/ui/screen/login_screen.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/products/bloc/products_bloc.dart';
import 'package:shop_app/modules/products/bloc/products_repository.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shop_observer.dart';
import 'package:shop_app/bloc/lang/language_cubit.dart';
import 'package:shop_app/utils/lang/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = ShopObserver();
  DioHelper.init();
  await PreferenceUtils.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOnBoarding = false;
  bool isUserToken = false;

  @override
  void initState() {
    isOnBoarding = PreferenceUtils.getData(onBoardingKey) ?? false;
    isUserToken = PreferenceUtils.getData(userTokenKey) != null ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
            create: (BuildContext context) => HomeCubit()..getAllData()),
        BlocProvider<BottomNavigationBarBloc>(
            create: (BuildContext context) => BottomNavigationBarBloc()),
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(ProductsRepository())
            ..add(const GetProductDataEvent("en")),
        ),
        BlocProvider<CategoriesBloc>(
            create: (BuildContext context) =>
                CategoriesBloc(CategoriesRepository())),
        BlocProvider<LanguageCubit>(
            create: (BuildContext context) => LanguageCubit()),
      ],
      child:
          BlocBuilder<LanguageCubit, Locale>(builder: (context, localeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.SUPPORTED_LOCALES,

          /// these delegates make sure that
          ///     the localization data for the proper
          /// language is loaded ...
          localizationsDelegates: [
            /// A class which loads the translations from JSON files
            AppLocalizations.delegate,

            /// Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,

            /// Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: localeState,
          title: 'Shopp App',
          theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0x333739),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              fontFamily: 'Nunito',
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  color: Colors.white, elevation: 0, textTheme: TextTheme())),
          home: isOnBoarding
              ? isUserToken
                  ? HomeScreen()
                  : LoginScreen()
              : OnBoardingScreen(),
        );
      }),
    );
  }
}
