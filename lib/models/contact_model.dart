const String tableContact = 'tbl_contact';
const String tblContactId = 'id';
const String tblContactName = 'name';
const String tblContactMobile = 'mobile';
const String tblContactEmail = 'email';
const String tblContactAddress = 'address';
const String tblContactCompany = 'company';
const String tblContactDesignation = 'designation';
const String tblContactWebsite = 'website';
const String tblContactImage = 'image';
const String tblContactFavorite = 'favorite';

class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String address;
  String company;
  String designation;
  String website;
  String image;
  bool favorite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.email = '',
    this.address = '',
    this.company = '',
    this.designation = '',
    this.website = '',
    this.image = '',
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactName: name,
      tblContactMobile: mobile,
      tblContactEmail: email,
      tblContactAddress: address,
      tblContactCompany: company,
      tblContactDesignation: designation,
      tblContactWebsite: website,
      tblContactImage: image,
      tblContactFavorite: favorite ? 1 : 0,
    };

    if (id > 0) {
      map[tblContactId] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => 
  ContactModel(
    name: map[tblContactName], 
    mobile: map[tblContactMobile],
    email: map[tblContactEmail],
    address: map[tblContactAddress],
    company: map[tblContactCompany],
    designation: map[tblContactDesignation],
    website: map[tblContactWebsite],
    image: map[tblContactImage],
    favorite: map[tblContactFavorite] == 1 ? true : false,
    );
}
