// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gorev_yap_kazan_app/app/ui/pages/followus_page/storageService.dart';

import '../../../../core/init/theme/color_manager.dart';
import '../market_page/market_page.dart';

class GetUser extends StatelessWidget {
  const GetUser({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('task').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map(
            (document) {
              return Card(
                  child: Column(
                children: [
                  ListTile(
                    isThreeLine: false,
                    title: Text(document["Görev"]),
                    subtitle: Row(
                      children: [
                        Text("Kazanç ${document["Kazanç"]}"),
                        Padding(
                          padding: EdgeInsets.only(left: 6.0.w),
                          child: Image.asset(
                            "assets/images/bills.png",
                            width: 18.w,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.instance.fourth),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Container(
                                height: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Görev Yönelgesi:"),
                                    SizedBox(height: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(document["Görev Yönelgesi"]),
                                      ],
                                    ),
                                    Spacer(),
                                    _imageUpload(),
                                  ],
                                )),
                          ),
                        );
                      },
                      child: Text(
                        "Detay",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ));
            },
          ).toList(),
        );
      },
    );
  }
}

class _imageUpload extends StatefulWidget {
  const _imageUpload({
    super.key,
  });

  @override
  State<_imageUpload> createState() => __imageUploadState();
}

class __imageUploadState extends State<_imageUpload> {
  final Storage storage = Storage();
  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);

    final path = result!.files.single.path!;
    final fileName = result.files.single.name;

    storage.uploadFile(path, fileName).then(
          (value) => print("Done"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        selectFile();
      },
      child: Container(
        margin: PaddingUtility().defaultButtonMargin,
        padding: PaddingUtility().defaultButtonPadding,
        decoration: BoxDecoration(
            color: ColorManager.instance.fourth,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kanıtla",
              style: TextStyle(color: ColorManager.instance.white),
            ),
          ],
        ),
      ),
    );
  }
}
