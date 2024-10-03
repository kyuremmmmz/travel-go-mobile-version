import 'package:supabase_flutter/supabase_flutter.dart';

class RatingsAndComments {
  final supabase = Supabase.instance.client;

  Future<PostgrestResponse<dynamic>?> postComment(String comments, int ratings,
      String commentType, String placeComment) async {
    try {
      final user = supabase.auth.currentUser;
      final response = await supabase.from("ratings_and_comments").insert({
        "comment": comments,
        "comment_type": commentType,
        "rating": ratings,
        "placeComment": placeComment,
        "comment_id": user!.id
      });
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchComments(
    String commentType,
  ) async {
    final response = await supabase
        .from("ratings_and_comments")
        .select("*").eq('placeComment', commentType);
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      List<Map<String, dynamic>> map =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in map) {
        final comments = datas['comment'];
        final ratings = datas['rating'];
        datas['comment'] = comments;
        datas['rating'] = ratings;
        print(ratings);
      }
      return data;
    }
  }
}
