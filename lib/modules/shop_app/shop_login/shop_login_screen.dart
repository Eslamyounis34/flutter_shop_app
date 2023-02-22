import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/shop_layout.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_login/cubit/login_cubit.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_login/cubit/login_states.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_register/ShopRegisterScreen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/data/local/chache_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            var loginModel = state.loginModel;
            if (loginModel.status == true) {
              print(loginModel.data!.email.toString());
              print(loginModel.data!.token.toString());

              CacheHelper.saveData(
                      key: "token", value: loginModel.data!.token.toString())
                  .then((value) => {navigteAndFinish(context, ShopLayout())});
            } else {
              print(loginModel.message.toString());
              showToast(
                  msg: loginModel.message.toString(), state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              // single child scroll view prevent error when keyboard is opened
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
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
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_clock_outlined,
                            sufficIcon: ShopLoginCubit.get(context).suffix,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your password ';
                              }
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        BuildCondition(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              width: double.infinity,
                              btnText: 'LOGIN',
                              function: () {
                                print(
                                    'test credentials ' + passController.text);
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passController.text);
                                }
                              }),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
            ),
          );
        },
      ),
    );
  }
}
