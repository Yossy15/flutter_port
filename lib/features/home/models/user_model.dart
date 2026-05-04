class UserModel {
  final String name;
  final String title;
  final String bio;
  final String profileImageUrl;
  final Map<String, String> socialLinks;
  final Map<String, String> documentsLinks;

  const UserModel({
    required this.name,
    required this.title,
    required this.bio,
    required this.profileImageUrl,
    required this.socialLinks,
    required this.documentsLinks,
  });
}
