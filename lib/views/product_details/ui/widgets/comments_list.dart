import 'package:flutter/material.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client
            .from("comments_table")
            .stream(primaryKey: ["id"])
            .eq("for_product", productModel.productId!)
            .order("created_at"),
        builder: (_, snapshot) {
          List<Map<String, dynamic>>? data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CustomCircleProgIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>  UserComment(
                commentData: data?[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: data?.length ?? 0,
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Comments Yet"),
            );
          } else {
            return const Center(
              child: Text("Something went error , please try again."),
            );
          }
        });
  }
}

class UserComment extends StatelessWidget {
  const UserComment({
    super.key, required this.commentData,
  });
  final Map<String, dynamic>? commentData;
    // {
    //     "id": "c8c39960-4e79-496f-830c-d8712f48b8c3",
    //     "created_at": "2024-10-31T21:54:50.564511+00:00",
    //     "comment": "good product ui",
    //     "for_user": "469a8270-61e0-4e09-9e89-970b45026cb6",
    //     "for_product": "93523372-9b7f-46bd-9aa0-d775fdeb0f01",
    //     "user_name": "Karim",
    //     "replay": "This is replay"
    // }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            Text(
             commentData?["user_name"] ?? "User Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              commentData?["comment"] ?? "Comment",
            ),
          ],
        ),
     commentData?["replay"] != null ?   
     Column(
       children: [
         Row(
              children: [
                Text(
                  "Replay:-",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
          children: [
            Text(
              commentData!["replay"],
            ),
          ],
        ),
       ],
     ) : Container(),
        
      ],
    );
  }
}
