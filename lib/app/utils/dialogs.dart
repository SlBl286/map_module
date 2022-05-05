import 'package:flutter/material.dart';

class DialogUtils {
  static void notiDialog(BuildContext context, {IconData? icon, String? text}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                width: 150,
                height: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Thông báo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Icon(icon ?? Icons.info),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(fit: BoxFit.contain, child: Text(text ?? "")),
                    const SizedBox(
                      height: 7,
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 35,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade700,
                                    Colors.red.shade600
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(0.6, 0.6),
                                  stops: const [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Đồng ý",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ))),
                  ],
                )),
          );
        });
  }

  static void optionDialog(BuildContext context,
      {IconData? icon,
      String? text,
      String? content,
      String? okText,
      String? cancelText,
      Function? onOk,
      Function? onCancel}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                width: 160,
                height: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Thông báo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Icon(icon ?? Icons.info),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: FittedBox(
                            fit: BoxFit.contain, child: Text(text ?? ""))),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            if (onOk != null) onOk();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 35,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade700,
                                    Colors.red.shade600
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(0.6, 0.6),
                                  stops: const [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              okText ?? "Đồng bộ",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              if (onCancel != null) onCancel();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 35,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  cancelText ?? "Hủy bỏ",
                                  style: TextStyle(fontSize: 15),
                                ))),
                      ],
                    )
                  ],
                )),
          );
        });
  }

  static void progessDialog(BuildContext context, {String? text}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text ?? "Đang thực hiện"),
                    const SizedBox(height: 20),
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  static void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
