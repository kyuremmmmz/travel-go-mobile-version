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
    String placeComment,
  ) async {
    final user = supabase.auth.currentUser;
    final response = await supabase
        .from("ratings_and_comments")
        .select("*")
        .eq("comment_type", commentType)
        .eq("placeComment", placeComment);
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      List<Map<String, dynamic>> map =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in map) {
        final comments = datas['comment'];
        final ratings = datas['rating'];
        final commentId = datas['comment_id'];

        final users = await supabase
            .from('profiles')
            .select('*')
            .eq('id', commentId)
            .single();
        if (users.isNotEmpty) {
          final pfp = datas['profiles']['full_name'];
          datas['full_name'] = pfp;
        }//IGONORE THIS ONE PUTANGINA KASI NETO
        datas['comment'] = comments;
        datas['rating'] = ratings;
      }
      return data;
    }
  }
}
