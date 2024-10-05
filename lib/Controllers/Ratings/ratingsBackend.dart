import 'package:supabase_flutter/supabase_flutter.dart';

class RatingsAndComments {
  final supabase = Supabase.instance.client;

  Future<PostgrestResponse<dynamic>?> postComment(String comments, int ratings,
      String commentType, String placeComment, int id) async {
    try {
      final user = supabase.auth.currentUser;
      final response = await supabase.from("ratings_and_comments").insert({
        "comment": comments,
        "comment_type": commentType,
        "rating": ratings,
        "placeComment": placeComment,
        "comment_id": user!.id,
        "comment_id_places": id
      });
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchComments(
    int commentType,
  ) async {
    final response = await supabase
        .from("ratings_and_comments")
        .select("*")
        .eq('comment_id_places', commentType);
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
      }
      return data;
    }
  }

  Future<int> fetchRatingsAsSum() async {
    final response = await supabase.rpc('getsum');
    if (response != null) {
      return response;
    }
    return 0;
  }
}
