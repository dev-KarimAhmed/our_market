// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/functions/build_appbar.dart';
import 'package:our_market/core/functions/navigate_without_back.dart';
import 'package:our_market/core/functions/show_msg.dart';
import 'package:our_market/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:our_market/views/auth/ui/widgets/custom_elevated_btn.dart';
import 'package:our_market/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_market/views/nav_bar/ui/main_home_view.dart';
import 'package:our_market/views/profile/ui/profile_view.dart';

class EditNameView extends StatefulWidget {
  const EditNameView({super.key});

  @override
  State<EditNameView> createState() => _EditNameViewState();
}

class _EditNameViewState extends State<EditNameView> {
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..getUserData(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccess) {
            showMsg(
              context,
              "Name Updated Successfully",
            );
            navigateWithoutBack(context, MainHomeView());
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthenticationCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(context, "Edit Name"),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: state is UpdateUserDataLoading
                  ? const CustomCircleProgIndicator()
                  : Column(
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          labelText: "Enter Name",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomEBtn(
                            text: "Update",
                            onTap: () async {
                              if (nameController.text.isNotEmpty) {
                                await cubit.updateUserData(
                                  name: nameController.text,
                                );
                              }
                            }),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
