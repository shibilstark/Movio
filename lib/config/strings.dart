import 'package:movio/domain/movies/enums/movie_enums.dart';

class AppString {
  static const appName = "Movieo";
  static const lowInternet =
      "It seems like you don't have a proper internet connection";
  static const noInternet =
      "Can't find network, please check you network connection";
  static const somethingWentWrong =
      "Something went wrong, please try again later";
  static const serverFailure =
      "Something wrong in server, please try again later";
  static const unAuthorized =
      "Oops, Unauthorized access. please try again later";
  static const loading = "Loading";
  static const add = "Add";
  static const info = "Info";
  static const about = "About";
  static const trending = "Trending";
  static const latest = "Latest";
  static const upcoming = "Upcoming";
  static const popular = "Popular";
  static const similar = "Similar";
  static const movies = "Movies";
  static const bookMark = "Bookmark";
  static const bookMarks = "Bookmarks";
  static const knowMore = "Know more";
  static const retry = "Retry";
  static const description = "Description";
  static const seeAll = "See All";
  static const nowPlaying = "Now Playing";
  static const topRated = "Top Rated";
  static const searchResults = "Search Results";
  static const aboutMovie = "About Movie";
  static const releaseData = "Release Date";
  static const revenue = "Revenue";
  static const budget = "Budget";
  static const originalLanguage = "Original Language";
  static const popularity = "Popularity";
  static const similarMovies = "Similar Movies";
  static const moreSimilarMovies = "More Similar Movies..";
  static const nsfwContent = "18+ Content";
  static const darkMode = "Dark Mode";
  static const adultSymbol = "18+";

  static const titleClientError = "Error!";

  static const titleInternetError = "Check Your Connection";

  static const titleServerError = "Can't Process Request";

  static const titleCommontError = "Can't Process";

  static String getCollectionNameByType(MovieCollectionType type) {
    switch (type) {
      case MovieCollectionType.nowPlaying:
        return nowPlaying;
      case MovieCollectionType.popular:
        return popular;
      case MovieCollectionType.topRated:
        return topRated;
      case MovieCollectionType.upcoming:
        return upcoming;
      case MovieCollectionType.trending:
        return trending;

      default:
        return movies;
    }
  }
}
