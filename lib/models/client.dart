
class Client{


  final String id,nom,telephone,willaya,commune,image;

  Client({this.id, this.nom, this.telephone,this.willaya, this.commune,this.image,});

  factory Client.fromJSON( Map<String,dynamic> json){
         return Client(
           id:json["id"],
           nom:json["nom"],
           telephone: json["telephone"],
           commune: json["commune"],
           willaya: json['willaya'],
           image: json['image'],
         );
  }


}