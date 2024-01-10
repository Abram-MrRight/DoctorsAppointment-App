import 'package:doctors_appt/controllers/auth_controller.dart';

import '../../consts/consts.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen({super.key, this.unwrapped = false});
  bool unwrapped;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    AuthController().isUserAlreadyLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.unwrapped ? Center(
      child: CircularProgressIndicator(

      ),
    ) : CircularProgressIndicator(
      backgroundColor: Colors.blue,
      color: Colors.white,
    );
  }
}
