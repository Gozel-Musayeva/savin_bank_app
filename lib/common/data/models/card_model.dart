import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

enum CardBrand { visa, mastercard }

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
    required this.gradient,
    this.isFrozen = false,
  });

  final String id;
  final String holderName;
  final String number;
  final String expiry;
  final String cvv;
  final double balance;
  final CardBrand brand;
  final CardType type;
  final Gradient gradient;
  final bool isFrozen;

  String get last4 => number.substring(number.length - 4);

  static const cards = [
    CardModel(
      id: 'c1',
      holderName: 'GOZAL MUSAYEVA',
      number: '4532123456781234',
      expiry: '08/29',
      cvv: '123',
      balance: 12450.30,
      brand: CardBrand.visa,
      type: CardType.debit,
      gradient: AppColors.cardGradientBlue,
    ),
    CardModel(
      id: 'c2',
      holderName: 'GOZAL MUSAYEVA',
      number: '5412758934125678',
      expiry: '11/28',
      cvv: '456',
      balance: 8200.45,
      brand: CardBrand.mastercard,
      type: CardType.credit,
      gradient: AppColors.cardGradientDark,
    ),
    CardModel(
      id: 'c3',
      holderName: 'GOZAL MUSAYEVA',
      number: '4716998812349012',
      expiry: '03/30',
      cvv: '789',
      balance: 4200.00,
      brand: CardBrand.visa,
      type: CardType.debit,
      gradient: AppColors.cardGradientPurple,
      isFrozen: true,
    ),
  ];
}
