class Post {
  final String id, name, author, title, description, url, image, publishedAt, documentID;

  Post({
    this.id,
    this.name,
    this.author,
    this.title,
    this.description,
    this.image,
    this.url,
    this.publishedAt,
    this.documentID,
  });

  factory Post.fromJSON(Map<String, dynamic> json, String lang) {
    if (lang == "English") {
      return Post(
          id: json["source"]["id"],
          name: json["source"]["name"],
          author: json["author"],
          title: json["title"],
          description: json["description"],
          image: json["urlToImage"],
          url: json["url"],
          publishedAt: json["publishedAt"].toString().replaceAll("T", " ").replaceAll("Z", " "));
    } else {
      return Post(
          id: json["source"]["id"],
          name: json["source"]["name"],
          author: json["author"],
          title: json["title"],
          description: json["snippet"],
          image: json["primary_image_link"],
          url: json["link"],
          publishedAt: json["date_published"].toString().replaceAll("T", " ").replaceAll("Z", " "));
    }
  }
}
