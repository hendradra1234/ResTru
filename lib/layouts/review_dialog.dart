import 'package:flutter/material.dart';
import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';

class ReviewDialog extends StatelessWidget {
  static const routeName = '/review';
  final AppProvider provider;
  final String id;
  const ReviewDialog({Key? key, required this.provider, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var namesTextController = TextEditingController();
    var reviewsTextController = TextEditingController();
    var formKeys = GlobalKey<FormState>();
    final dateUploaded = DateTime.now().toString();

    postHandler() {
      if (formKeys.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sending Feedback...")));
        Review review = Review(
            id: id,
            name: namesTextController.text,
            review: reviewsTextController.text,
            date: dateUploaded);
        provider.postReview(review).then((value) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success!")));
          Navigator.pop(context);
        });
      }
    }

    return AlertDialog(
      backgroundColor: baseColor,
      scrollable: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: const Text("Add Feedback"),
      content: Form(
        key: formKeys,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: baseColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                textCapitalization: TextCapitalization.words,
                controller: namesTextController,
                validator: (value) {
                  if (value == null) return "Username required";
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Username",
                    suffixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5, top: 10)),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                controller: reviewsTextController,
                validator: (value) {
                  if (value!.isEmpty) return "Feedback required";
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Feedback",
                    suffixIcon: Icon(Icons.rate_review),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5, top: 10)),
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(onPressed: postHandler, child: const Text("Send"))
      ],
    );
  }
}
