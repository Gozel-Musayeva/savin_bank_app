/// One label / value line on a receipt.
class ReceiptLine {
  const ReceiptLine(this.label, this.value);

  final String label;
  final String value;
}

/// What Payment Status shows after any completed (mock) payment — transfer,
/// bill… Each flow fills in its own [details]; the amount block is shared.
class ReceiptModel {
  const ReceiptModel({
    required this.title,
    required this.refNumber,
    required this.date,
    required this.details,
    required this.amount,
    required this.fee,
  });

  /// Headline under the check icon ("Transfer Success!", "Payment Success").
  final String title;
  final String refNumber;
  final DateTime date;

  /// Rows between the ref number and the amount block.
  final List<ReceiptLine> details;
  final int amount;
  final int fee;

  int get total => amount + fee;

  /// 14-digit reference number derived from [time].
  static String refFrom(DateTime time) {
    final ref = time.millisecondsSinceEpoch.toString().padLeft(14, '0');
    return ref.substring(ref.length - 14);
  }
}
