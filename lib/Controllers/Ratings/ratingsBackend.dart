import 'package:supabase_flutter/supabase_flutter.dart';

class RatingsAndComments {
  final supabase = Supabase.instance.client;

  Future<PostgrestResponse<dynamic>?> postComment(String comments, int ratings,
      String commentType, String placeComment) async {
    try {
      final response = await supabase.from("ratings_and_comments").insert({
        "comment": comments,
        "comment_type": commentType,
        "rating": ratings,
        "placeComment": placeComment
      });
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchComments(
      String commentType, String placeComment) async {
    final user = supabase.auth.currentUser!.id;
    final response = supabase
        .from("ratings_and_comments")
        .select("*")
        .eq("comment_type", commentType)
        .eq("placeComment", placeComment);
  }
}
