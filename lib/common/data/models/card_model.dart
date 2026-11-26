import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

enum CardBrand {
  visa('VISA'),
  mastercard('Mastercard');

  const CardBrand(this.label);

  final String label;
}

enum CardType { debit, credit }

class CardModel {
  const CardModel({
    required this.id,
    required this.holderName,
    required this.number,
    required this.expiry,
    required this.cvv,
    required this.balance,
    required this.brand,
    required this.type,
    required this.color,
    required this.patternColor,
    this.isFrozen = false,
    this.brandArt,
  });

  final String id;
  final String holderName;
  final String number;
  final String expiry;
  final String cvv;
  final double balance;
  final CardBrand brand;
  final CardType type;

  /// Flat card fill and the lighter squares drawn over it.
  final Color color;
  final Color patternColor;
  final bool isFrozen;

  /// Card artwork asset shown on funding tiles; null → card colour + brand.
  final String? brandArt;

  String get last4 => number.substring(number.length - 4);

  static const cards = [
    CardModel(
      id: 'c1',
      holderName: 'Gozal Musayeva',
      number: '3296154708008739',
      expiry: '08/29',
      cvv: '123',
      balance: 25475500,
      brand: CardBrand.visa,
      type: CardType.debit,
      color: AppColors.cardBlue,
      patternColor: AppColors.cardBluePattern,
      brandArt: AppAssets.cardVisaBlue,
    ),
    CardModel(
      id: 'c2',
      holderName: 'Gozal Musayeva',
      number: '1547329687390800',
      expiry: '11/28',
      cvv: '456',
      balance: 47567500,
      brand: CardBrand.visa,
      type: CardType.credit,
      color: AppColors.cardTeal,
      patternColor: AppColors.cardTealPattern,
    ),
    CardModel(
      id: 'c3',
      holderName: 'Gozal Musayeva',
      number: '4716998812349012',
      expiry: '03/30',
      cvv: '789',
      balance: 4200000,
      brand: CardBrand.visa,
      type: CardType.debit,
      color: AppColors.cardPurple,
      patternColor: AppColors.cardPurplePattern,
      isFrozen: true,
    ),
  ];
}
