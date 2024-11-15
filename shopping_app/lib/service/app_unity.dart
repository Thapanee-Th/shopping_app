import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TypeMath { mathRound, mathCeil, mathFloor }

enum TypeDialog { error, warning, success, questions }

enum TypeSizedBod { width, high }

class AppUnity {
  static String urlNoImage = 'https://gbhcenter.com/attachfile/images/img_not_available.jpeg';
  static String urlGetString = 'https://api-globalsoft.gbhcenter.com/img?url=';
  static Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  static String dateFormat({required DateTime? date, bool? isTime, int? digitY, String? format}) => date == null
      ? ''
      : DateFormat(format ?? 'dd/MM/${'y' * (digitY ?? 4)}${(isTime ?? false) ? ' HH:mm น.' : ''}').format(date);

  static String dateFormatSend({required String date}) =>
      '${date.split('/')[2]}-${date.split('/')[1]}-${date.split('/')[0]}';

  static String f({required double text, int digit = 2, TypeMath typeMath = TypeMath.mathRound}) {
    String srtDecimal = digit == 0 ? '' : '.${'0' * digit}';
    final format = NumberFormat("#,##0$srtDecimal", "en_US");
    switch (typeMath) {
      case TypeMath.mathCeil:
        final s = format.format(mathCeil(num: text, digit: digit));
        return s;
      case TypeMath.mathFloor:
        final s = format.format(mathFloor(num: text, digit: digit));
        return s;
      default:
        final s = format.format(mathRound(num: text, digit: digit));
        return s;
    }
  }

  static double mathRound({required double num, required int digit}) {
    var pows = pow(10, digit);
    return (num * pows).round() / pows;
  }

  static double mathCeil({required double num, required int digit}) {
    var pows = pow(10, digit);
    return (num * pows).ceil() / pows;
  }

  static double mathFloor({required double num, required int digit}) {
    var pows = pow(10, digit);
    return (num * pows).floor() / pows;
  }

  static NumberFormat fomateNumber({int digit = 2}) {
    String srtDecimal = digit == 0 ? '' : '.${'0' * digit}';
    return NumberFormat("#,##0$srtDecimal", "en_US");
  }

  static String formatPhoneNumber(String phoneNumber) {
    final RegExp regExp = RegExp(r'(\d{3})(\d{3})(\d{4})');
    final String formatted = phoneNumber.replaceAllMapped(regExp, (Match match) {
      return '${match[1]}-${match[2]}-${match[3]}';
    });
    return formatted;
  }

  static Divider buildDivider({Color? color, double? height}) => Divider(
        color: color ?? Colors.black45,
        height: height,
      );

  static SizedBox mySizedBox({required double size, required TypeSizedBod type}) {
    if (type == TypeSizedBod.high) {
      return SizedBox(height: size);
    } else {
      return SizedBox(width: size);
    }
  }

  // Future<String?> scanQR(BuildContext context) async {
  //   bool isweb = false;

  //   try {
  //     if (Platform.isAndroid) {
  //       isweb = false;
  //     }
  //   } catch (e) {
  //     isweb = true;
  //   }
  //   String? barcodeScanRes;
  //   // var barcode
  //   if (isweb) {
  //     barcodeScanRes = await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const ScanQrPage(),
  //         ));
  //   } else {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         "", "Close", true, ScanMode.DEFAULT);
  //   }
  //   if (barcodeScanRes != '-1') {
  //     barcodeScanRes = replaceUrl(barcodeScanRes!);
  //     return barcodeScanRes;
  //   } else {
  //     barcodeScanRes = null;
  //   }
  //   return barcodeScanRes;
  // }

  static String replaceUrl(String url) {
    String path = Uri.parse(url).pathSegments.last;
    return path;
  }

  // static GridColumn gridColumn(
  //         {double? minimumWidth,
  //         required String columnName,
  //         ColumnWidthMode? columnWidthMode,
  //         double maximumWidth = double.nan,
  //         double width = double.nan,
  //         bool allowSorting = false,
  //         required Widget label}) =>
  //     GridColumn(
  //       minimumWidth: minimumWidth ?? double.nan,
  //       columnName: columnName,
  //       maximumWidth: maximumWidth,
  //       width: width,
  //       allowSorting: allowSorting,
  //       columnWidthMode: columnWidthMode ?? ColumnWidthMode.fill,
  //       label: label,
  //     );

  // static Color? setColorOutOf(String assortment, double qtyStock) {
  //   return assortment == 'A' && (qtyStock) <= 0 ? Colors.red[100] : null;
  // }
  static myShowSnackBar({required BuildContext context, required String text, required TypeDialog typeDialog}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            buildIcon(typeDialog),
            mySizedBox(size: 10, type: TypeSizedBod.width),
            Expanded(
              child: Text(
                // AppLocalizations.of(context)!.trans(text),
                text,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: buildColor(typeDialog),
        action: SnackBarAction(label: 'Close', onPressed: () {}, textColor: Colors.white),
      ),
    );
  }

  // static Future<void> launchMapUrl(String address) async {
  //   String encodedAddress = Uri.encodeComponent(address);
  //   String googleMapUrl =
  //       "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
  //   if (kIsWeb) {
  //     try {
  //       if (await canLaunchUrl(Uri.tryParse(googleMapUrl) ?? Uri.parse(''))) {
  //         await launchUrlString(googleMapUrl);
  //       }
  //     } catch (error) {
  //       throw ("Cannot launch Google map");
  //     }
  //   } else {
  //     if (Platform.isAndroid) {
  //       try {
  //         if (await canLaunchUrl(Uri.tryParse(googleMapUrl) ?? Uri.parse(''))) {
  //           await launchUrlString(googleMapUrl);
  //         }
  //       } catch (error) {
  //         throw ("Cannot launch Google map");
  //       }
  //     }
  //   }
  // }

  static Widget buildIcon(TypeDialog typeDialog) {
    switch (typeDialog) {
      case TypeDialog.error:
        return Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: const Icon(
              Icons.close,
              color: Colors.redAccent,
              size: 15,
            ));

      case TypeDialog.warning:
        return Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.orangeAccent),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 17,
            ));
      // const Icon(
      //   Icons.warning_amber_sharp,
      //   size: 20,
      //   color: Colors.white,
      // );
      // case TypeDialog.questions:
      //   return const Icon(
      //     Icons.question_mark_outlined,
      //     size: 20,
      //     color: Colors.white,
      //   );

      default:
        return Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.green),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 17,
            ));
      //     const Icon(
      //   Icons.check_circle_outline_sharp,
      //   size: 20,
      //   color: Colors.white,
      // );
    }
  }

  static Color? buildColor(TypeDialog typeDialog) {
    switch (typeDialog) {
      case TypeDialog.error:
        return Colors.redAccent;
      case TypeDialog.warning:
        return null;
      case TypeDialog.questions:
        return null;
      default:
        return null;
    }
  }

  static Future<XFile?> getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image;
    if (kIsWeb) {
      image = await picker.pickImage(source: ImageSource.gallery);
      // = XFile.fromData(byImg);
    } else if (Platform.isAndroid) {
      if(imageSource == ImageSource.camera){
        return await picker.pickImage(
          source: imageSource,
          maxHeight: 500,
          maxWidth: 500,
          imageQuality: 100,
        );
      }else{
        // Request permission specifically for photos on Android 13+
        bool permissionsGranted = await requestPhotoPermission();
        if (!permissionsGranted) {
          print('Permission denied for photo access');
          await openAppSettings();
          return null;
        }
        
        // If permissions are granted, pick the image
        return await picker.pickImage(
          source: imageSource,
          maxHeight: 500,
          maxWidth: 500,
          imageQuality: 100,
        );
      }
    }else{
      return await picker.pickImage(
        source: imageSource,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 100,
      );
    }
    return image;
    // if (image != null) {
    //   CroppedFile? croppedFile = await ImageCropper().cropImage(
    //     sourcePath: image.path,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //     uiSettings: [
    //       AndroidUiSettings(
    //           toolbarTitle: 'Cropper',
    //           toolbarColor: Palette.kToDark,
    //           toolbarWidgetColor: Colors.white,
    //           initAspectRatio: CropAspectRatioPreset.original,
    //           lockAspectRatio: false),
    //       IOSUiSettings(
    //         title: 'Cropper',
    //       ),
    //     ],
    //   );
    //   if (croppedFile != null) {
    //     flie = XFile(croppedFile.path);
    //   }
    // }
  }

  static Future<bool> requestPhotoPermission() async {
    // Request permission for accessing photos on Android 13+
    var photoPermissionStatus = await Permission.photos.request();

    if (photoPermissionStatus.isGranted) {
      return true;
    } else if (photoPermissionStatus.isDenied) {
      // Permission was denied, you could show a message to the user here
      print('Photo permission denied. Please grant access.');
      return false;
    } else if (photoPermissionStatus.isPermanentlyDenied) {
      // Permission is permanently denied, direct user to settings
      print('Permission permanently denied. Please enable it in app settings.');
      await openAppSettings();
      return false;
    }
    return false;
  }

  static Color buildColors(int statusId) {
    switch (statusId) {
      case 1:
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  static Future<DateTimeRange?> showDatePickerRang(
      {required BuildContext context,
      required DateTime? currentDate,
      DateTime? lastDate,
      DateTime? firstDate,
      DateTimeRange? dateTimeRange}) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: firstDate ??
          DateTime(
            DateTime.now().year - 100,
          ),
      lastDate: lastDate ?? DateTime.now(),
      currentDate: currentDate ?? DateTime.now(),
      initialDateRange: dateTimeRange,
      saveText: 'Done',
    );
    return result;
  }

  static Future<DateTime?> myShowDatePicker(
      {required BuildContext context,
      required DateTime? currentDate,
      DateTime? lastDate,
      DateTime? initialDate,
      DateTime? firstDate}) async {
    final DateTime? result = await showDatePicker(
      firstDate: firstDate ??
          DateTime(
            DateTime.now().year - 100,
          ),
      context: context,
      lastDate: lastDate ?? DateTime.now(),
      currentDate: currentDate ?? DateTime.now(),
      initialDate: initialDate ?? DateTime.now(),
    );
    return result;
  }

  static double getBaseVat(double number, double vatReat) {
    return mathRound(num: number, digit: 2) / (100 + vatReat) * 100;
  }
}

class TitleText extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color? color;
  const TitleText({
    super.key,
    required this.title,
    required this.iconData,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        AppUnity.mySizedBox(size: 5, type: TypeSizedBod.width),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: color ?? Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class MyDialog extends StatelessWidget {
  final Widget body;
  const MyDialog({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body:
              GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => Navigator.of(context).pop(), child: body),
        ),
      ),
    );
  }
}

class MyItems extends StatelessWidget {
  const MyItems({
    super.key,
    required this.title,
    required this.detail,
    this.alignment,
    this.maxLine,
  });

  final String title;
  final String detail;
  final MainAxisAlignment? alignment;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //"${AppLocalizations.of(context)!.trans(title)} : ",
          "$title : ",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: alignment ?? MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  detail,
                  maxLines: maxLine,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({
    super.key,
    required this.body,
    this.removeBg = false,
    this.padding,
    this.radius,
  });
  final Widget body;
  final bool removeBg;
  final EdgeInsetsGeometry? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 0),
        ),
        color: removeBg ? null : Colors.white,
      ),
      alignment: Alignment.centerLeft,
      // margin: const EdgeInsets.symmetric(vertical: 15),
      child: body,
    );
  }
}
