class UserModel {

  ///Contact details
  final String uid;
  final String mobileNumber;
  final String? email;

  ///College details
  final String? profilePicUrl;
  final String displayName;
  final String college;
  final String department;
  final int graduationYear;
  
  ///Personal details
  final String? realName;
  final String? dateOfBirth;
  final String gender;
  final String? bio;
  final List? hobbies;
  
  ///Verification details
  final bool isLoggedIn;
  final bool? isVerified;
  final String? verificationStatus;
  final String? verifiedAt;
  final String? lastActive;
  final String? verificationdocUrl;
  

  const UserModel({
    required this.uid,
    required this.displayName,
    this.email,
    this.profilePicUrl,
    this.verificationStatus,
    this.verifiedAt,
    this.bio,
    this.isVerified = false,
    this.lastActive,
    this.realName,
    required this.college,
    required this.department,
    required this.graduationYear,
    this.dateOfBirth,
    required this.gender,
    this.verificationdocUrl,
    required this.mobileNumber,
    required this.isLoggedIn,
    this.hobbies,
  });
}