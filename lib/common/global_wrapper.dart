import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:fff_skin_tools/screen/no_internet_screen.dart';

class GlobalWrapper extends StatefulWidget {
  final Widget child;
  const GlobalWrapper({super.key, required this.child});

  @override
  State<GlobalWrapper> createState() => _GlobalWrapperState();
}

class _GlobalWrapperState extends State<GlobalWrapper> {
  bool hasInternet = true;

  StreamSubscription<InternetConnectionStatus>? _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = InternetConnectionChecker.createInstance()
        .onStatusChange
        .listen((status) {
      if (!mounted) return; // 👈 prevents setState after dispose

      setState(() {
        hasInternet = status == InternetConnectionStatus.connected;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel(); // 👈 fixed memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet ? widget.child : const NoInternetScreen();
  }
}
