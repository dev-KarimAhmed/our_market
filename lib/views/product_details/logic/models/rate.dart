class Rate {
  String? id;
  DateTime? createdAt;
  int? rate;
  String? forUser;
  String? forProduct;

  Rate({this.id, this.createdAt, this.rate, this.forUser, this.forProduct});

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json['id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        rate: json['rate'] as int?,
        forUser: json['for_user'] as String?,
        forProduct: json['for_product'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'rate': rate,
        'for_user': forUser,
        'for_product': forProduct,
      };
}
