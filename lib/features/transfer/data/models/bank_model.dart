/// Banks offered by the "Bank Name" picker on Transfer to New Receiver.
class BankModel {
  const BankModel({required this.id, required this.name});

  final String id;
  final String name;

  static const banks = [
    BankModel(id: 'b1', name: 'Happy Bank'),
    BankModel(id: 'b2', name: 'Savin Bank'),
    BankModel(id: 'b3', name: 'Bright Bank'),
    BankModel(id: 'b4', name: 'Unity Bank'),
    BankModel(id: 'b5', name: 'Capital Trust Bank'),
  ];
}
