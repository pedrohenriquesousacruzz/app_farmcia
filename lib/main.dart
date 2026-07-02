import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/tema_cubit.dart';
import 'bloc/auto_bloc.dart';
import 'bloc/auto_estado.dart';
import 'bloc/auto_evento.dart';
import 'views/login_google.dart';
import 'models/tema_estado.dart';
import 'views/home_pagina.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AutoBloc()),
      ],
      child: Myapp(),
    ),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          home: LoginPage(),
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AutoBloc, AutoEstado>(
        listener: (context, state) {
          if (state is ConvidadoAutenticadoEstado) {
            Navigator.push(
              context,

              MaterialPageRoute(builder: (_) => const HomePagina()),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Theme.of(context).brightness == Brightness.dark
                  ? [Colors.black, Colors.black87, Colors.black54]
                  : [Colors.black, Color(0xFF2B0000), Color(0xFF6A1F1B)],
            ),
          ),
          child: SafeArea(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,

                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Icon
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_pharmacy_outlined,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        const SizedBox(width: 6),
                                        const Text(
                                          "UPERFARMA",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),

                                    IconButton(
                                      icon: const Icon(
                                        Icons.dark_mode,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<ThemeCubit>()
                                            .toggleTheme();
                                      },
                                    ),
                                  ],
                                ),

                                SizedBox(height: 30),
                                // imagens tela inicio
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      // Creatina
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Transform.rotate(
                                            angle: -0.10,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.asset(
                                                  'assets/Image/creatina.jpeg',
                                                  height: 280,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Omega3
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 8),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Image.asset(
                                            'assets/Image/omega3.jpeg',
                                            height: 250,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Textis centrais
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Soluções",
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "flexíveis para você",
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),

                                //subtexto
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Compre seus remedios sem sair de casa",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,

                                      color: Colors.white70,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),

                                // Login
                                Column(
                                  children: [
                                    // entrar com Google
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginGooglePage(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          138,
                                          42,
                                          37,
                                        ),
                                        foregroundColor: Colors.grey,
                                        minimumSize: const Size(
                                          double.infinity,
                                          50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/Image/google.jpeg',
                                            height: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text("Continuar com Google"),
                                        ],
                                      ),
                                    ),

                                    //Entrar sem conta
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          context.read<AutoBloc>().add(
                                            EntrarSemContaEvento(),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          minimumSize: Size(
                                            double.infinity,
                                            50,
                                          ),
                                          side: BorderSide(color: Colors.white),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Entrar sem conta",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),

                                    //espaco
                                    SizedBox(height: 20),

                                    // criar conta
                                    Center(
                                      child: Text(
                                        "Não tem conta? Criar agora",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
