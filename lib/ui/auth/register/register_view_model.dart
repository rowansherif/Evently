import 'package:events_app/ui/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  //TODO: Hold data & Handle logic

  late RegisterNavigator navigator;

  void register(String email, String password) async {
    //TODO: show loading
    navigator.showMyLoading('Loading...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text);
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUserData(myUser);
      // eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      // await FirebaseUtils.addUserToFireStore(myUser);

      // DialogUtils.hideLoading(context);
      // DialogUtils.showMessage(
      //     context: context,
      //     msg: 'Register successfully',
      //     posActionName: 'Ok',
      //     title: 'Register',
      //     posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
      //TODO: hide loading
      navigator.hideMyLoading();
      //TODO: show message  (Register successfully)
      navigator.showMyMessage('Register successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        //TODO: hide loading
        navigator.hideMyLoading();
        //TODO: show message  (Register successfully)
        navigator.showMyMessage('The password provided is too weak.');

        // DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(
        //     context: context,
        //     title: 'Error',
        //     msg: 'The password provided is too weak.',
        //     posActionName: 'Ok');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        //TODO: hide loading
        navigator.hideMyLoading();
        //TODO: show message  (Register successfully)
        navigator.showMyMessage('The account already exists for that email.');

        // DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(
        //     context: context,
        //     title: 'Error',
        //     msg: 'The account already exists for that email.',
        //     posActionName: 'Ok');
      } else if (e.code == 'network-request-failed') {
        print('No Internet Connection');
        //TODO: hide loading
        navigator.hideMyLoading();
        //TODO: show message  (Register successfully)
        navigator.showMyMessage('No Internet Connection');

        //   DialogUtils.hideLoading(context);
        //   DialogUtils.showMessage(
        //       context: context,
        //       msg: 'No Internet Connection',
        //       title: 'Error',
        //       posActionName: 'Ok');
      }
    } catch (e) {
      print(e.toString());
      //TODO: hide loading
      navigator.hideMyLoading();
      //TODO: show message  (Register successfully)
      navigator.showMyMessage(e.toString());

      // DialogUtils.hideLoading(context);
      // DialogUtils.showMessage(
      //     context: context,
      //     title: 'Error',
      //     msg: e.toString(),
      //     posActionName: 'Ok');
    }
  }
}
