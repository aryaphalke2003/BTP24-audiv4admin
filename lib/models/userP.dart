class userP{
  late String displayName;
  late String uid;
  late String photoURL;
  late String token;
  late String organization;

  userP({required this.uid}){
    displayName = 'Anonymous';
    organization = 'Anonymous';
    photoURL = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  }

  String get _displayName => displayName;
  String get _uid => uid;
  String get _photoURL => photoURL;
  String get _token => token;
  String get _organization => organization;

  void setDisplayName(String displayName){
    this.displayName = displayName;
  }

  void setUid(String uid){
    this.uid = uid;
  }

  void setPhotoURL(String photoURL){
    this.photoURL = photoURL;
  }

  void setToken(String token){
    this.token = token;
  }

  void setOrganization(String organization){
    this.organization = organization;
  }

  void deleteUser(){
    this.displayName = 'Anonymous';
    this.photoURL = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    this.uid = '';
    this.token = '';
  }
}