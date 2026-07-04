import 'package:flutter/material.dart';
import 'package:grand_library/features/auth/presentation/page/login_page.dart';
import 'package:grand_library/features/auth/presentation/page/register_page.dart';
import 'package:grand_library/features/auth/presentation/page/verify_email_page.dart';
import 'package:grand_library/features/auth/presentation/widget/authguard.dart';
import 'package:grand_library/features/dashboard/presentation/pages/cart_page.dart';
import 'package:grand_library/features/dashboard/presentation/pages/checkout_page.dart';
import 'package:grand_library/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:grand_library/features/dashboard/presentation/pages/product_detail_page.dart';
import 'package:grand_library/myapp.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String dashboard = '/dashboard';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    verifyEmail: (_) => const VerifyEmailPage(),
    dashboard: (_) => const AuthGuard(child: DashboardPage()),
    productDetail: (_) => const ProductDetailPage(),
    cart: (_) => const CartPage(),
    checkout: (_) => const CheckoutPage(),
  };
}
