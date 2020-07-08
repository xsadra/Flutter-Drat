import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/widgets/avatar/avatar.dart';
import 'package:timetracker/widgets/platform/platform_alert_dialog.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: _buildUserInfo(user),
          preferredSize: Size.fromHeight(180.0),
        ),
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirm = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);

    if (confirm) {
      _signOut(context);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          radius: 50.0,
          photoUrl: user.photoUrl,
          borderColor: Colors.green[900],
        ),
        SizedBox(height: 12.0),
        if (user.displayName != null) ...[
          Text(user.displayName, style: TextStyle(color: Colors.white)),
          SizedBox(height: 12.0),
        ],
        if (user.email != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.email, color: Colors.white),
              SizedBox(width: 8.0),
              Text(user.email, style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 12.0),
        ],
        if (user.phoneNumber != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.phone_android, color: Colors.white),
              SizedBox(width: 8.0),
              Text(user.phoneNumber, style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 12.0),
        ],
      ],
    );
  }
}
