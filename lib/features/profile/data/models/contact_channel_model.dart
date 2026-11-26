import '../../../../core/constants/app_texts.dart';

/// One way to reach the bank (Account → Contact Us). Mock values.
class ContactChannelModel {
  const ContactChannelModel({required this.label, required this.value});

  final String label;
  final String value;

  static const channels = [
    ContactChannelModel(
      label: AppTexts.contactEmail,
      value: 'callsavinbank.com',
    ),
    ContactChannelModel(label: AppTexts.contactCenter, value: '12098'),
    ContactChannelModel(
      label: AppTexts.contactWebsite,
      value: 'www.savinbank.com',
    ),
    ContactChannelModel(
      label: AppTexts.contactWhatsapp,
      value: '0891827346712',
    ),
    ContactChannelModel(label: AppTexts.contactTwitter, value: '@contactsavin'),
  ];
}
