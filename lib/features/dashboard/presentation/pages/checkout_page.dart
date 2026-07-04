import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grand_library/core/constants/app_colors.dart';
import 'package:grand_library/features/dashboard/presentation/providers/cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        const double shipping = 10000;
        final double grandTotal = cart.total + shipping;

        return Scaffold(
          backgroundColor: AppColors.background,

          appBar: AppBar(
            title: const Text("Pembayaran"),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// =========================
                /// DAFTAR PRODUK
                /// =========================
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        "Pesanan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ...cart.items.map((item) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Image.network(
                              item.product.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.product.name),
                            subtitle: Text("Qty : ${item.qty}"),
                            trailing: Text(
                              "Rp ${item.subtotal.toStringAsFixed(0)}",
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 20),

                      const Text(
                        "Ringkasan Pembayaran",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal"),
                          Text("Rp ${cart.total.toStringAsFixed(0)}"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Ongkir"), Text("Rp 10.000")],
                      ),

                      const Divider(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rp ${grandTotal.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// =========================
                /// BUTTON BAYAR
                /// =========================
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                    ),
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembayaran Berhasil 🎉"),
                              ),
                            );

                            context.read<CartProvider>().clear();

                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                    child: const Text(
                      "Bayar Sekarang",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
