class GithubRepo {
  String? name;
  String? url;
  String? description;
  String? color;
  String? lang;
  String? fork;
  String? stars;
  String? starsToday;
  List<String>? contributors;
  bool? bookmarked;

  GithubRepo({
    this.name,
    this.url,
    this.description,
    this.color,
    this.lang,
    this.fork,
    this.stars,
    this.starsToday,
    this.contributors,
    this.bookmarked,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    String buildBy = json['buildBy'] ?? '';
    List<String>? listContributor = buildBy.split(',');
    bool bookmarked = bool.parse(json['bookmarked']);
    return GithubRepo(
      name: json['name'] ??'',
      url: json['url'] ??'',
      description: json['description'] ??'',
      color: json['color'] ??'',
      lang: json['lang'] ??'',
      fork: json['fork'] ??'',
      stars: json['stars'] ??'',
      starsToday: json['starsToday'] ??'',
      contributors: listContributor,
      bookmarked: bookmarked,
    );
  }

  static List<GithubRepo> parseRepoList(map) {
    var list = map['data'] as List<dynamic>;
    return list.map((repo) => GithubRepo.fromJson(repo)).toList();
  }

  @override
  String toString() {
    return 'GithubRepo{name: $name, url: $url, description: $description, color: $color, lang: $lang, fork: $fork, stars: $stars, starsToday: $starsToday, contributors: $contributors, bookmarked: $bookmarked}';
  }
}
