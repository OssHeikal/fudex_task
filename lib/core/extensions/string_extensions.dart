import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'all_extensions.dart';

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

extension StringExtension on String? {
  /// Check email validation
  bool validateEmail() => hasMatch(this, Patterns.email);

  /// Check password validation
  bool validatePassword() => hasMatch(this, Patterns.passwordPattern);

  /// Check saudi phone validation
  bool validateSaudiPhoneNumber() => hasMatch(this, Patterns.saudiPhoneNumber);

  /// Check phone validation
  bool validatePhone() => hasMatch(this, Patterns.phone);

  bool validateImage() => hasMatch(this, Patterns.image);

  bool validateName() => hasMatch(this, Patterns.name);

  bool validateSpecialCharacters() => hasMatch(this, Patterns.specialCharacters);

  /// Check URL validation
  bool validateURL() => hasMatch(this, Patterns.url);

  /// Returns true if given  is null
  bool get isNull => this == null;

  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull => this == null || (this != null && this!.isEmpty) || (this != null && this! == 'null');

  /// validate password
  bool get isValidPassword => this == null || (this != null && this!.length < 8) || (this != null && this! == 'null');

  /// validate url
  bool get isValidUrl => this == null || (this != null && !this!.validateURL()) || (this != null && this! == 'null');

  // Check null string, return given value if null
  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  String removeSpaces() {
    return this!.replaceAll(' ', '');
  }

  String removeSpecialCharacters() {
    return this!.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  String removeSpacesAndSpecialCharacters() {
    return this!.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '');
  }

  String remove(String value) {
    return this!.replaceAll(value, '');
  }

  SizedBox toSvg({double? height, double? width, ColorFilter? colorFilter, Color? color}) {
    if (color != null) colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
    return SizedBox(
      height: height ?? 24,
      width: width ?? 24,
      child: SvgPicture.asset(validate(), fit: BoxFit.fill, colorFilter: colorFilter).center(),
    );
  }

  String putDataIfEmpty({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  bool isDigit() {
    if (validate().isEmpty) {
      return false;
    }
    if (validate().length > 1) {
      for (var r in this!.runes) {
        if (r ^ 0x30 > 9) {
          return false;
        }
      }
      return true;
    } else {
      return this!.runes.first ^ 0x30 <= 9;
    }
  }

  /// Return int value of given string
  int toInt({int defaultValue = 0}) {
    if (this == null) return defaultValue;
    if (isDigit()) {
      return int.parse(this!);
    } else {
      return defaultValue;
    }
  }

  DateTime toDateTime({formate = 'dd/MM/yyyy'}) {
    DateFormat format = DateFormat(formate);
    if (isEmptyOrNull) {
      return DateTime.now();
    } else {
      return DateTime.tryParse(this!) ?? format.tryParse(this!) ?? DateTime.now();
    }
  }

  List<int> toIntList() {
    if (this == null || this!.isEmpty) return [];
    return this!.split(',').map((part) => int.tryParse(part.trim()) ?? 0).toList();
  }

  bool get isColor {
    final hexColorRegex = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
    return hexColorRegex.hasMatch(validate());
  }

  Color? toColor() {
    if (!isColor) return null;

    String hex = validate().replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';

    return Color(int.parse(hex, radix: 16));
  }

  /// Return double value of given string
  double toDouble({double defaultValue = 0.0}) {
    if (this == null) return defaultValue;
    try {
      return double.tryParse(this!) ?? 0;
    } catch (e) {
      return defaultValue;
    }
  }

  Uri toUri() {
    if (isEmptyOrNull) {
      return Uri.parse('');
    } else {
      return Uri.parse(validate());
    }
  }

  String get capitalize {
    if (isEmptyOrNull) {
      return '';
    }
    return '${this![0].toUpperCase()}${this!.substring(1)}';
  }

  String get capitalizeFirstOfEach {
    if (isEmptyOrNull) {
      return '';
    }
    return this!.split(' ').map((str) => str.capitalize).join(' ');
  }

  String getInitials() {
    if (isEmptyOrNull) {
      return '';
    }
    return this!.split(' ').map((e) => e[0]).join();
  }

  bool isArabicWord() {
    if (isEmptyOrNull) {
      return false;
    }
    return RegExp(r'[\u0621-\u064A]').hasMatch(this!);
  }

  String getInitial() {
    if (isEmptyOrNull) {
      return '';
    }
    return this![0];
  }

  // get first letter of first name and last name
  String getInitialsOfName() {
    if (isEmptyOrNull) {
      return '';
    }
    final List<String> names = this!.split(' ');
    if (isArabicWord()) {
      return names[0][0];
    } else {
      if (names.length == 1) {
        return names[0][0].toUpperCase();
      } else {
        if (names[1].isEmptyOrNull) {
          return names[0][0].toUpperCase();
        } else {
          return '${names[0][0]}${names[1][0]}'.toUpperCase();
        }
      }
    }
  }

  Future<bool> openUrl() async {
    final uri = Uri.parse(validate());
    if (await canLaunchUrl(uri)) {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableDomStorage: false,
          enableJavaScript: false,
        ),
      );
    } else {
      throw Exception('Unable to launch url');
    }
  }

  dynamic decode() {
    return jsonDecode(validate());
  }
}

class Patterns {
  static String url = r'^(https?:\/\/)?' // Optional scheme (http or https)
      r'([\w.-]+)' // Domain name or IP address
      r'(\.[a-zA-Z]{2,})' // Top-level domain
      r'(:\d+)?' // Optional port
      r'(\/[\w\.-]*)*\/?' // Optional path
      r'(\?[^\s#]*)?' // Optional query parameters
      r'(#\S*)?$'; // Optional fragment

  static String phone = r'(^(?:[+0]9)?[0-9]{10}$)';

  static String saudiPhoneNumber = r'^05[0-9]{8}$';

  static String passwordPattern =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,200}$';

  static String money = r'^\d{1,3}(,\d{3})*(\.\d+)?$';

  // and arabic letters
  static String specialCharacters = r'[!@#$%^&*(),.?":{}|<>]';

  static String email = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String image = r'.(jpeg|jpg|gif|png|bmp)$';

  // static String name = r'[!@#%^&*(),.?":{}|<>]';

  // english and arabic letters
  static String name = r'^[a-zA-Z\u0621-\u064A]+(?:[\s-][a-zA-Z\u0621-\u064A]+)*$';

  // static String name = r'^[a-zA-Z\u0621-\u064A]+(?:[\s-][a-zA-Z\u0621-\u064A]+)*$';

  // static String name = r'^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$';

  /// Excel regex
  static String excel = r'.(xls|xlsx)$';

  /// PDF regex
  static String pdf = r'.pdf$';

  /// Price regex
  static String price = r'(\d{1,3})(?=(\d{3})+(?!\d))';
}
