/// Mock list of saved recipients for the transfer flow.
class ContactModel {
  const ContactModel({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.avatarUrl,
  });

  final String id;
  final String name;
  final String cardNumber;
  final String avatarUrl;

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
  ];
}
