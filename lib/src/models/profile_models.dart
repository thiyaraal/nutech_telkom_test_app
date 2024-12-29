class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String profileImage;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
  });

  String get fullName => "$firstName $lastName";
  // Membuat Profile dari JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }

  // Mengubah Profile menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_image': profileImage,
    };
  }
}
