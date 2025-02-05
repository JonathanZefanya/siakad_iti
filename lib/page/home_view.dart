import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isWebViewVisible = false;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://siakad.iti.ac.id'));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690), // Menyesuaikan untuk berbagai ukuran layar
      builder: (context, child) {
        return Scaffold(
          body: isWebViewVisible ? _buildWebView() : _buildHomePage(),
        );
      },
    );
  }

  /// Halaman Awal dengan UI yang lebih Colorful dan Responsif
  Widget _buildHomePage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo ITI
          ZoomIn(
            child: Image.asset('assets/logo_iti.png', height: 120.h),
          ),
          SizedBox(height: 20.h),

          // Animasi Teks Warna-warni
          FadeInDown(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  "Selamat Datang di SIAKAD ITI",
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [Colors.white, Colors.yellow, Colors.cyan, Colors.red],
                ),
                ColorizeAnimatedText(
                  "Kelola akademikmu dengan mudah!",
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 18.sp,
                  ),
                  colors: [Colors.greenAccent, Colors.orange, Colors.blueAccent],
                ),
              ],
              repeatForever: true,
              isRepeatingAnimation: true,
            ),
          ),

          SizedBox(height: 30.h),

          // Tombol Masuk dengan Animasi Bounce
          BounceInUp(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isWebViewVisible = true;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Text(
                "Masuk ke SIAKAD ITI",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Halaman WebView untuk menampilkan SIAKAD ITI
  Widget _buildWebView() {
    return Scaffold(
      body: Column(
        children: [
          // Header Custom
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            color: Colors.blue.shade800,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    "SIAKAD Institut Teknologi Indonesia",
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: [Colors.white, Colors.yellow, Colors.green, Colors.red, Colors.blue],
                  ),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
            ),
          ),

          // WebView
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
