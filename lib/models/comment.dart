

class Comment{

  final String id_comment,id_employe,id_client,rating,reviwer,comment,image_client,creted_at;

 
    Comment({this.id_comment, this.id_employe,this.id_client,this.rating,this.reviwer,this.comment,this.image_client,this.creted_at});

  factory Comment.fromJSON( Map<String,dynamic> json){
         return Comment(
           id_comment:json["id"],
           id_employe:json["id_employe"],
           id_client: json["id_client"],
           rating: json["rating"],
           reviwer: json['reviwer'],
           comment: json['comment'],
           image_client: json['image_client'],
           creted_at: json['creted_at'],
         );
  }


}
