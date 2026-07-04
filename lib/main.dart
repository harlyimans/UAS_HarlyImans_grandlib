import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grand_library/features/auth/presentation/providers/auth_provider.dart';
import 'package:grand_library/features/dashboard/presentation/providers/cart_provider.dart';
import 'package:grand_library/features/dashboard/presentation/providers/product_provider.dart';
import 'package:grand_library/myapp.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase SEBELUM runApp
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
