class Vaccination {
  final int id;
  final int nni;
  final String nomVaccination;
  final String centre;
  final int doseNumber;
  final int doseAdministre;
  final String dateDernierDose;
  final String status;
  final String wilaya;
  final String moughataa;

  Vaccination({
    required this.id,
    required this.nni,
    required this.nomVaccination,
    required this.centre,
    required this.doseNumber,
    required this.doseAdministre,
    required this.dateDernierDose,
    required this.status,
    required this.wilaya,
    required this.moughataa,
  });

  factory Vaccination.fromJson(Map<String, dynamic> json) {
    return Vaccination(
      id: json['id'],
      nni: json['nni'],
      nomVaccination: json['nom_vaccination'],
      centre: json['centre'],
      doseNumber: json['dose_number'],
      doseAdministre: json['dose_administre'],
      dateDernierDose: json['date_dernier_dose'],
      status: json['status'],
      wilaya: json['wilaya'],
      moughataa: json['moughataa'],
    );
  }
}

class Centre {
  final String nom;
  final String latitude;
  final String longitude;

  Centre({
    required this.nom,
    required this.latitude,
    required this.longitude,
  });

  factory Centre.fromJson(Map<String, dynamic> json) {
    return Centre(
      nom: json['nom'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class UserModel {
  final int id;
  final String nom;
  final String prenom;
  final int nni;
  UserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.nni,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      nni: json['nni'],
    );
  }
}
