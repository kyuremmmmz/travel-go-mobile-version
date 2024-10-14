import 'package:supabase_flutter/supabase_flutter.dart';

class RatingsAndComments {
  final supabase = Supabase.instance.client;

  Future<PostgrestResponse<dynamic>?> postComment(
      String comments,
      int ratings,
      String commentType,
      String placeComment,
      int id,
      String name,
      String imgUrl) async {
    try {
      final user = supabase.auth.currentUser;
      final response = await supabase.from("ratings_and_comments").insert({
        "comment": comments,
        "comment_type": commentType,
        "rating": ratings,
        "placeComment": placeComment,
        "comment_id": user!.id,
        "comment_id_places": id,
        "full_name": name,
        "avatar_url": imgUrl,
      });
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchComments(
    int commentType, String comment
  ) async {
    final response = await supabase
        .from("ratings_and_comments")
        .select("*")
        .eq('comment_id_places', commentType).eq('comment_type', comment);
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
        final imgUrl = datas['avatar_url'];
        final images = await getter(imgUrl);
        datas['avatar_url'] = images;
        datas['comment'] = comments;
        datas['comment_id'] = commentId;
        datas['rating'] = ratings;
      }
      return data;
    }
  }

  Future<String?> getter(String name) async {
    final img = supabase.storage.from('avatars').getPublicUrl(name);
    if (img.isEmpty) {
      return null;
    } else {
      return img;
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
