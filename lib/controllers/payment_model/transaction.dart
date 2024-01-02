
class Transaction{
  final String amount;
  final String reference;
  final String currency;
  final String email;

  Transaction({
    required this.amount,
    required this.reference,
    required this.currency,
    required this.email
  });


  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        amount: json['amount'],
        reference: json['reference'],
        currency: json['currency'],
        email: json['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'reference': reference,
      'currency': currency,
      'email': email,
    };
  }
}

