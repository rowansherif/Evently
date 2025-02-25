import 'package:events_app/ui/auth/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenViewModel extends ChangeNotifier {
  //TODO: Hold data & Handle logic
  var emailController = TextEditingController(text: 'rowan@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //TODO: Show loading
      navigator.showMyLoading('Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // var user = await FirebaseUtils.readUserFromFireStore(
        //     credential.user?.uid ?? '');
        // if (user == null) {
        //   return;
        // }
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.updateUserData(user);
        // eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        print('login successfully');
        print(credential.user?.uid ?? '');
        //TODO: hide loading
        navigator.hideMyLoading();
        //TODO: show message  (Login successfully)
        navigator.showMyMessage('Login successfully');
        // DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(
        //     context: context,
        //     msg: 'Login successfully',
        //     title: 'Login',
        //     posActionName: 'Ok',
        //     posAction: () {
        //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        //     });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print('Wrong E-mail or Password');
          //TODO: hide loading
          navigator.hideMyLoading();
          //TODO: show message  (Login successfully)
          navigator.showMyMessage('Wrong E-mail or Password');
          // DialogUtils.hideLoading(context);
          // DialogUtils.showMessage(
          //     context: context,
          //     msg: 'Wrong E-mail or Password',
          //     title: 'Error',
          //     posActionName: 'Ok');
        } else if (e.code == 'network-request-failed') {
          print('No Internet Connection');
          //TODO: hide loading
          navigator.hideMyLoading();
          //TODO: show message  (Login successfully)
          navigator.showMyMessage('No Internet Connection');

          // DialogUtils.hideLoading(context);
          // DialogUtils.showMessage(
          //     context: context,
          //     msg: 'No Internet Connection',
          //     title: 'Error',
          //     posActionName: 'Ok');
        }
      } catch (e) {
        print(e.toString());
        //TODO: hide loading
        navigator.hideMyLoading();
        //TODO: show message  (Login successfully)
        navigator.showMyMessage(e.toString());
        // DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(
        //     context: context,
        //     msg: e.toString(),
        //     title: 'Error',
        //     posActionName: 'Ok');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //TODO: show loading
    navigator.showMyLoading('Loading...');
    final credentials =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // MyUser myUser = MyUser(
    //     id: credentials.user?.uid ?? '',
    //     name: credentials.user?.displayName ?? '',
    //     email: credentials.user?.email ?? '');
    // FirebaseUtils.addUserToFireStore(myUser);
    // var userProvider = Provider.of<UserProvider>(context, listen: false);
    // userProvider.updateUserData(myUser);
    print('signed in successfully');
    //TODO: hide loading
    navigator.hideMyLoading();
    //TODO: show message
    navigator.showMyMessage('Login with Google Successfully');
    // DialogUtils.hideLoading(context);
    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
