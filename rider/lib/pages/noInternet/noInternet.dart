import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  final VoidCallback? onTap;

  const NoInternet({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text('No Internet Connection', style: TextStyle(fontSize: 20)),
            if (onTap != null)
              ElevatedButton(
                onPressed: onTap,
                child: Text('Retry'),
              ),
          ],
        ),
      ),
    );
  }
}
