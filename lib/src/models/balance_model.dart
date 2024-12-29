class BalanceResponse {
  final int status;
  final String message;
  final BalanceData data;

  BalanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    return BalanceResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: BalanceData.fromJson(json['data']),
    );
  }
}

class BalanceData {
  final int balance;

  BalanceData({required this.balance});

  factory BalanceData.fromJson(Map<String, dynamic> json) {
    return BalanceData(
      balance: json['balance'] ?? 0,
    );
  }
}
