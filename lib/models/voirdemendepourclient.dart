class Demmande{
                      
    final String id_demmande,id_employe,id_client,nom_employe,telephone_employe,willaya_employe,commune_employe,cat_employe,titre,discription,image,status;
 
  Demmande({this.id_demmande, this.id_employe, this.id_client, this.nom_employe, this.telephone_employe, this.willaya_employe, this.commune_employe, this.cat_employe, this.titre, this.discription, this.image, this.status,});
   

  factory Demmande.fromJSON( Map<String,dynamic> json){

         return Demmande(
           id_demmande:json["id_demmande"],
           id_employe:json["id_employe"],
           id_client: json["id_client"],
           nom_employe: json["nom"],
           telephone_employe:json["telephone"],
           willaya_employe: json['willaya'],
           commune_employe: json['commune'],
           cat_employe:json["cat"],
           titre: json['titre'],
           discription: json['description'],
           image: json['image'],
           status: json['status'],
         );
  }


}