import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_register/ShopRegisterScreen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // single child scroll view prevent error when keyboard is opened
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),


                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "login now to browse out hot offers",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(
                  height: 40,
                ),
                defaultTextField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'email',
                    prefix: Icons.email_outlined,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your email address';
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                defaultTextField(
                    controller: passController,
                    type: TextInputType.visiblePassword,
                    label: 'Password',
                    prefix: Icons.lock_clock_outlined,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your password ';
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                defaultButton(
                    width: double.infinity, btnText: 'LOGIN', function: () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ?'),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, ShopRegisterScreen());
                        },
                        child: Text('Register'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
