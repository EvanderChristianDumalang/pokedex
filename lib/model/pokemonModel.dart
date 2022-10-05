class Pokemon {
  String name;
  String image;
  int height;
  int weight;
  List<String> abilities;
  List<String> types;

  Pokemon(
      {required this.name,
      required this.height,
      required this.weight,
      required this.abilities,
      required this.types,
      required this.image});

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['sprites']['other']['official-artwork']['front_default'],
        height = json['height'],
        weight = json['weight'],
        abilities = (json['abilities'] as List)
            .map((data) => data['ability']['name'].toString())
            .toList(),
        types = (json['types'] as List)
            .map((data) => data['type']['name'].toString())
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'height': height,
        'weight': weight,
        'abilities': abilities,
        'types': types
      };

}
