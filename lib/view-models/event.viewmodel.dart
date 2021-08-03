class EventViewModel {
    String id = "";
    double latitude = 0;
    double longitude = 0;
    String title = "";

  EventViewModel(
    this.id,
    this.latitude,
    this.longitude,
    this.title,
  );

  EventViewModel.fromMap(Map<String,dynamic> data){
    this.id = data['id'];
    this.latitude = data['latitude'];
    this.longitude = data['longitude'];
    this.title = data['title'];
  }
}
