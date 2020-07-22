import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/widgets/avatar/avatar.dart';
import 'package:timetracker/widgets/platform/platform_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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
          preferredSize: Size.fromHeight(
              user.phoneNumber == null || user.phoneNumber.length == 0
                  ? 180.0
                  : 210),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Time Tracker',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),),
              FlatButton(
                onPressed: () => _launchURL('https://sadra.at'),
                child: Row(
                  children: [
                    Text(
                      'Created by: ',
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'Sadra Babai',
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 70.0),
        ],
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
      mainAxisAlignment: MainAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        if (user.email != null && user.email.trim().length > 5) ...[
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
        if (user.phoneNumber != null && user.phoneNumber.trim().length > 1) ...[
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
