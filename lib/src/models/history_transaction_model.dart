
import 'dart:convert';

HistoryTransactionModel historyTransactionModelFromMap(String str) => HistoryTransactionModel.fromMap(json.decode(str));

String historyTransactionModelToMap(HistoryTransactionModel data) => json.encode(data.toMap());

class HistoryTransactionModel {
    int? status;
    String? message;
    DataHistory? data;

    HistoryTransactionModel({
        this.status,
        this.message,
        this.data,
    });

    factory HistoryTransactionModel.fromMap(Map<String, dynamic> json) => HistoryTransactionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataHistory.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class DataHistory {
    int? offset;
    int? limit;
    List<TransactionRecord>? records;

    DataHistory({
        this.offset,
        this.limit,
        this.records,
    });

    factory DataHistory.fromMap(Map<String, dynamic> json) => DataHistory(
        offset: json["offset"],
        limit: json["limit"],
        records: json["records"] == null ? [] : List<TransactionRecord>.from(json["records"]!.map((x) => TransactionRecord.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "offset": offset,
        "limit": limit,
        "records": records == null ? [] : List<dynamic>.from(records!.map((x) => x.toMap())),
    };
}

class TransactionRecord {
    String? invoiceNumber;
    String? transactionType;
    String? description;
    int? totalAmount;
    String? createdOn;

    TransactionRecord({
        this.invoiceNumber,
        this.transactionType,
        this.description,
        this.totalAmount,
        this.createdOn,
    });

    factory TransactionRecord.fromMap(Map<String, dynamic> json) => TransactionRecord(
        invoiceNumber: json["invoice_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdOn: json["created_on"],
    );

    Map<String, dynamic> toMap() => {
        "invoice_number": invoiceNumber,
        "transaction_type": transactionType,
        "description": description,
        "total_amount": totalAmount,
        "created_on": createdOn,
    };
}
