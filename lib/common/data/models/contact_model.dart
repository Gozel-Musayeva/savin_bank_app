import '../../../core/constants/app_texts.dart';

/// Mock list of saved recipients (Home "Send Money" row, transfer flow).
class ContactModel {
  const ContactModel({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.avatarUrl,
    this.bankName = AppTexts.appName,
  });

  final String id;
  final String name;
  final String cardNumber;
  final String avatarUrl;
  final String bankName;

  String get firstName => name.split(' ').first;

  ContactModel copyWith({String? cardNumber, String? bankName}) => ContactModel(
    id: id,
    name: name,
    cardNumber: cardNumber ?? this.cardNumber,
    avatarUrl: avatarUrl,
    bankName: bankName ?? this.bankName,
  );

  static const contacts = [
    ContactModel(
      id: 'p1',
      name: 'Aysel Mammadova',
      cardNumber: '4169738812345521',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
    ),
    ContactModel(
      id: 'p2',
      name: 'Huseyn Aliyev',
      cardNumber: '5239104455667788',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    ),
    ContactModel(
      id: 'p3',
      name: 'Nargiz Hasanova',
      cardNumber: '4098776655443322',
      avatarUrl: 'https://i.pravatar.cc/150?img=44',
    ),
    ContactModel(
      id: 'p4',
      name: 'Emil Quliyev',
      cardNumber: '5412000011112222',
      avatarUrl: 'https://i.pravatar.cc/150?img=15',
    ),
    ContactModel(
      id: 'p5',
      name: 'James Carter',
      cardNumber: '4532887766554433',
      avatarUrl: 'https://i.pravatar.cc/150?img=53',
    ),
  ];

  /// Account holder "found" for any number typed on Transfer to New Receiver
  /// (no backend lookup — the real number replaces [cardNumber]).
  static const lookupResult = ContactModel(
    id: 'r-new',
    name: 'Anastasia Huzhie',
    cardNumber: '',
    avatarUrl: 'https://i.pravatar.cc/150?img=45',
  );

  /// Saved receivers — Transfer Money "Transfer List".
  static const receivers = [
    ContactModel(
      id: 'r1',
      name: 'Dania',
      cardNumber: '3209120234345678',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
    ContactModel(
      id: 'r2',
      name: 'Reynard',
      cardNumber: '3120978623234567',
      avatarUrl: 'https://i.pravatar.cc/150?img=59',
    ),
  ];
}
