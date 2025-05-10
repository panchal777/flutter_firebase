import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/flutter_secure_storage/secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../router/router_name.dart';

void showLogoutDialog(BuildContext context) {
  // Capture GoRouter instance early
  final goRouter = GoRouter.of(context);

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop(); // Close dialog first
              await FirebaseAuth.instance.signOut();
              await SecureStorage().clearStorage();

              // Delay to ensure dialog pop finishes
              await Future.delayed(Duration(milliseconds: 100));

              // Use captured router (safe from context deactivation)
              goRouter.go(RouteName.login);
            },
            child: Text('Logout'),
          ),
        ],
      );
    },
  );

  // void resetSessionProviders(WidgetRef ref) {
  //   ref.invalidate(databaseProvider);
  //   ref.invalidate(authenticationRepoProvider);
  //   ref.invalidate(authenticationViewModelProvider);
  //   // add all session-scoped providers here
  // }
}
