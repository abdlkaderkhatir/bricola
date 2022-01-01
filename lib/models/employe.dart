

class Employe{

 
  final String nom,telephone,nbtravaille,id,willaya,commune,cat,image;

  Employe({this.id, this.nom, this.telephone, this.nbtravaille, this.willaya, this.commune,this.cat,this.image,});

  factory Employe.fromJSON( Map<String,dynamic> json){
         return Employe(
           id:json["id"],
           nom:json["nom"],
           telephone: json["telephone"],
           nbtravaille: json["nbtravaille"],
           commune: json["commune"],
           willaya: json['willaya'],
           cat: json['cat'],
           image: json['image'],
         );
  }


}

//List of Users

// List<Employe> employes=[
//      Employe(id: 1,
//           price: 50,
//           title: "KHATIR",
//           description: "AZERTY"
//         ),
//      Employe(id: 2,
//           price: 51,
//           title: "ABDELREZZAK",
//           description: "AZERTY"
//         ),
//      Employe(id: 3,
//           price: 52,
//           title: "ABDO",
//           description: "AZERTY"
//         ),
//      Employe(id: 4,
//           price: 50,
//           title: "AYMEN",
//           description: "AZERTY"
//         ),
//      Employe(id: 5,
//           price: 50,
//           title: "AMIN",
//           description: "AZERTY"
//         ),
//      Employe(id: 6,
//           price: 50,
//           title: "KHATIR",
//           description: "AZERTY"
//         ),
// ];