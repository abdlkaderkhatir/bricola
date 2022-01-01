class Embouche{
    final String id_embouche,id_employe,id_client,nom_client,willaya,commune,titre,discription,image,status;
 
  Embouche({this.id_embouche, this.id_employe, this.id_client, this.nom_client, this.willaya, this.commune, this.titre, this.discription, this.image,this.status});
   

  factory Embouche.fromJSON( Map<String,dynamic> json){

         return Embouche(
           id_embouche:json["id"],
           id_employe:json["id_employe"],
           id_client: json["id_client"],
           nom_client: json["nom_client"],
           willaya: json['willaya'],
           commune: json['commune'],
           titre: json['titre'],
           discription: json['description'],
           image: json['image'],
           status: json['status'],
         );
  }


}