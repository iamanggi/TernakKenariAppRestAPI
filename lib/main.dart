import 'package:canary/data/Repository/auth_repository.dart';
import 'package:canary/data/Repository/get_all_burung_tersedia_repository.dart';
import 'package:canary/data/Repository/profile_buyer_repository.dart';
import 'package:canary/presentation/auth/bloc/login/login_bloc.dart';
import 'package:canary/presentation/auth/bloc/register/register_bloc.dart';
import 'package:canary/presentation/auth/login_screen.dart';
import 'package:canary/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc.dart';
import 'package:canary/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:canary/services/service_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LoginBloc(
                authRepository: AuthRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => RegisterBloc(
                authRepository: AuthRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => ProfileBuyerBloc(
                profileBuyerRepository: ProfileBuyerRepository(
                  ServiceHttpClient(),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => GetBurungTersediaBloc(
                getAllBurungTersediaRepository: GetAllBurungTersediaRepository(
                  ServiceHttpClient(),
                ),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
