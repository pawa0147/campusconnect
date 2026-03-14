class PostModel {
  final String postId;

  ///Author Details
  final String authorId;
  final String authorDisplayName;
  final String authorCollege;
  final String authorDepartment;
  final int authorGraduationYear;

  ///Post Content
  final String postTitle;
  final String? postDescription;
  final String contentType;
  final List<String>? mediaURLs;
  final String? videoURL;

  final String visibility;
  final bool isBubbleMessage;

  ///Post Timings
  final String createdAt;
  final String updatedAt;

  ///Post Interaction Counters
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int saveCount;
  final int reportCount;
  final int isDeleted;

  const PostModel({
    required this.postId,
    required this.authorId,
    required this.authorDisplayName,
    required this.authorCollege,
    required this.authorDepartment,
    required this.authorGraduationYear,
    required this.contentType,
    required this.postTitle,
    this.postDescription,
    this.mediaURLs,
    this.videoURL,
    required this.visibility,
    required this.isBubbleMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.saveCount,
    required this.reportCount,
    required this.isDeleted
  });
}