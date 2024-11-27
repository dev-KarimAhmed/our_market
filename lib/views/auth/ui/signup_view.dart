import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/functions/navigate_without_back.dart';
import 'package:our_market/views/auth/logic/models/user_model.dart';
import 'package:our_market/views/auth/ui/widgets/custom_row_with_arrow.dart';
import 'package:our_market/views/auth/ui/widgets/custom_text_btn.dart';
import 'package:our_market/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_market/views/nav_bar/ui/main_home_view.dart';
import 'package:our_market/views/auth/logic/cubit/authentication_cubit.dart';

import '../../../core/functions/show_msg.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess || state is GoogleSignInSuccess) {
          UserDataModel userDataModel = context.read<AuthenticationCubit>().userDataModel!;
          navigateWithoutBack(context, MainHomeView(userDataModel: userDataModel,));
        }
        if (state is SignUpError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: state is SignUpLoading
                  ? const CustomCircleProgIndicator()
                  : SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Welcome To Our Market",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Card(
                              color: AppColors.kWhiteColor,
                              margin: const EdgeInsets.all(24),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: _nameController,
                                      labelText: "Name",
                                      keyboardType: TextInputType.name,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextFormField(
                                      controller: _emailController,
                                      labelText: "Email",
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextFormField(
                                      controller: _passwordController,
                                      labelText: "Password",
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isSecured: true,
                                      suffIcon: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.visibility_off),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomRowWithArrowBtn(
                                      text: "Sign Up",
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<AuthenticationCubit>()
                                              .register(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              );
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomRowWithArrowBtn(
                                      text: "Sign Up With Google",
                                      onTap: () {
                                        context
                                            .read<AuthenticationCubit>()
                                            .googleSignIn();
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Already Have an account?",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomTextButton(
                                          text: "Login",
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
