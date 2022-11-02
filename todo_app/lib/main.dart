import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider()..darkThemePreference.getTheme(),
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return DynamicColorBuilder(
            builder: (lightColorScheme, darkColorScheme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                //theme: AppTheme.themeData(provider.darkTheme, context, lightColorScheme, darkColorScheme),
                theme: ThemeData(
                  colorScheme: lightColorScheme?? ColorScheme.fromSwatch(primarySwatch: Colors.blue),
                  useMaterial3: true
                ),
                themeMode: ThemeMode.light,
                home: Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        Checkbox(
                          value: provider.darkTheme,
                          onChanged: (bool? value) {
                            provider.darkTheme = value!;
                          },
                        ),
                        OutlinedButton(onPressed: () { }, child: Text("Test color")),
                        FloatingActionButton(onPressed: () { }, child: Icon(Icons.add), isExtended: true,),
                        ElevatedButton(onPressed: () { }, child: Text("Elevated"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)
                          ),),
                        const Card(
                          margin: EdgeInsets.all(40),
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text("Card"),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              );
            },
          );
        },
      ),
    );
  }
}