class Genre {
  final String? name;
  final int id;

  Genre({
    this.name,
    required this.id,
  });

  factory Genre.fromId(int id) {
    return Genre(name: _movieGenreData[id], id: id);
  }

  static final Map<int, String> _movieGenreData = {
    28: "adventure",
    12: "action",
    16: "animation",
    35: "comedy",
    80: "crime",
    99: "documentary",
    18: "drama",
    10751: "family",
    14: "fantasy",
    36: "history",
    27: "horror",
    10402: "music",
    9648: "mystery",
    10749: "romance",
    878: "scienceFiction",
    10770: "tvMovie",
    53: "thriller",
    10752: "war",
    37: "western",
  };
}
