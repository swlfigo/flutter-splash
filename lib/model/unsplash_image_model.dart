// To parse this JSON data, do
//
//     final unSplashImageInfo = unSplashImageInfoFromJson(jsonString);

import 'dart:convert';

List<UnSplashImageInfo> unSplashImageInfoFromJson(String str) =>
    List<UnSplashImageInfo>.from(
        json.decode(str).map((x) => UnSplashImageInfo.fromJson(x)));

String unSplashImageInfoToJson(List<UnSplashImageInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnSplashImageInfo {
  String? id;
  String? slug;
  AlternativeSlugs? alternativeSlugs;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  List<dynamic>? breadcrumbs;
  Urls? urls;
  UnSplashImageInfoLinks? links;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions? topicSubmissions;
  String? assetType;
  User? user;
  Exif? exif;
  Location? location;
  int? views;
  int? downloads;

  UnSplashImageInfo({
    this.id,
    this.slug,
    this.alternativeSlugs,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.breadcrumbs,
    this.urls,
    this.links,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.assetType,
    this.user,
    this.exif,
    this.location,
    this.views,
    this.downloads,
  });

  factory UnSplashImageInfo.fromJson(Map<String, dynamic> json) =>
      UnSplashImageInfo(
        id: json["id"],
        slug: json["slug"],
        alternativeSlugs: json["alternative_slugs"] == null
            ? null
            : AlternativeSlugs.fromJson(json["alternative_slugs"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        blurHash: json["blur_hash"],
        description: json["description"],
        altDescription: json["alt_description"],
        breadcrumbs: json["breadcrumbs"] == null
            ? []
            : List<dynamic>.from(json["breadcrumbs"]!.map((x) => x)),
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? null
            : UnSplashImageInfoLinks.fromJson(json["links"]),
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        currentUserCollections: json["current_user_collections"] == null
            ? []
            : List<dynamic>.from(
                json["current_user_collections"]!.map((x) => x)),
        sponsorship: json["sponsorship"],
        topicSubmissions: json["topic_submissions"] == null
            ? null
            : TopicSubmissions.fromJson(json["topic_submissions"]),
        assetType: json["asset_type"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        exif: json["exif"] == null ? null : Exif.fromJson(json["exif"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        views: json["views"],
        downloads: json["downloads"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "alternative_slugs": alternativeSlugs?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "promoted_at": promotedAt?.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "blur_hash": blurHash,
        "description": description,
        "alt_description": altDescription,
        "breadcrumbs": breadcrumbs == null
            ? []
            : List<dynamic>.from(breadcrumbs!.map((x) => x)),
        "urls": urls?.toJson(),
        "links": links?.toJson(),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections": currentUserCollections == null
            ? []
            : List<dynamic>.from(currentUserCollections!.map((x) => x)),
        "sponsorship": sponsorship,
        "topic_submissions": topicSubmissions?.toJson(),
        "asset_type": assetType,
        "user": user?.toJson(),
        "exif": exif?.toJson(),
        "location": location?.toJson(),
        "views": views,
        "downloads": downloads,
      };
}

class AlternativeSlugs {
  String? en;
  String? es;
  String? ja;
  String? fr;
  String? it;
  String? ko;
  String? de;
  String? pt;

  AlternativeSlugs({
    this.en,
    this.es,
    this.ja,
    this.fr,
    this.it,
    this.ko,
    this.de,
    this.pt,
  });

  factory AlternativeSlugs.fromJson(Map<String, dynamic> json) =>
      AlternativeSlugs(
        en: json["en"],
        es: json["es"],
        ja: json["ja"],
        fr: json["fr"],
        it: json["it"],
        ko: json["ko"],
        de: json["de"],
        pt: json["pt"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "es": es,
        "ja": ja,
        "fr": fr,
        "it": it,
        "ko": ko,
        "de": de,
        "pt": pt,
      };
}

class Exif {
  dynamic make;
  dynamic model;
  dynamic name;
  dynamic exposureTime;
  dynamic aperture;
  dynamic focalLength;
  dynamic iso;

  Exif({
    this.make,
    this.model,
    this.name,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  factory Exif.fromJson(Map<String, dynamic> json) => Exif(
        make: json["make"],
        model: json["model"],
        name: json["name"],
        exposureTime: json["exposure_time"],
        aperture: json["aperture"],
        focalLength: json["focal_length"],
        iso: json["iso"],
      );

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "name": name,
        "exposure_time": exposureTime,
        "aperture": aperture,
        "focal_length": focalLength,
        "iso": iso,
      };
}

class UnSplashImageInfoLinks {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  UnSplashImageInfoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory UnSplashImageInfoLinks.fromJson(Map<String, dynamic> json) =>
      UnSplashImageInfoLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class Location {
  dynamic name;
  dynamic city;
  dynamic country;
  Position? position;

  Location({
    this.name,
    this.city,
    this.country,
    this.position,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        city: json["city"],
        country: json["country"],
        position: json["position"] == null
            ? null
            : Position.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "country": country,
        "position": position?.toJson(),
      };
}

class Position {
  double? latitude;
  double? longitude;

  Position({
    this.latitude,
    this.longitude,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class TopicSubmissions {
  The3DRenders? the3DRenders;

  TopicSubmissions({
    this.the3DRenders,
  });

  factory TopicSubmissions.fromJson(Map<String, dynamic> json) =>
      TopicSubmissions(
        the3DRenders: json["3d-renders"] == null
            ? null
            : The3DRenders.fromJson(json["3d-renders"]),
      );

  Map<String, dynamic> toJson() => {
        "3d-renders": the3DRenders?.toJson(),
      };
}

class The3DRenders {
  String? status;
  DateTime? approvedOn;

  The3DRenders({
    this.status,
    this.approvedOn,
  });

  factory The3DRenders.fromJson(Map<String, dynamic> json) => The3DRenders(
        status: json["status"],
        approvedOn: json["approved_on"] == null
            ? null
            : DateTime.parse(json["approved_on"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "approved_on": approvedOn?.toIso8601String(),
      };
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}

class User {
  String? id;
  DateTime? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  dynamic twitterUsername;
  dynamic portfolioUrl;
  String? bio;
  String? location;
  UserLinks? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  int? totalPromotedPhotos;
  int? totalIllustrations;
  int? totalPromotedIllustrations;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.totalPromotedPhotos,
    this.totalIllustrations,
    this.totalPromotedIllustrations,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        username: json["username"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        twitterUsername: json["twitter_username"],
        portfolioUrl: json["portfolio_url"],
        bio: json["bio"],
        location: json["location"],
        links: json["links"] == null ? null : UserLinks.fromJson(json["links"]),
        profileImage: json["profile_image"] == null
            ? null
            : ProfileImage.fromJson(json["profile_image"]),
        instagramUsername: json["instagram_username"],
        totalCollections: json["total_collections"],
        totalLikes: json["total_likes"],
        totalPhotos: json["total_photos"],
        totalPromotedPhotos: json["total_promoted_photos"],
        totalIllustrations: json["total_illustrations"],
        totalPromotedIllustrations: json["total_promoted_illustrations"],
        acceptedTos: json["accepted_tos"],
        forHire: json["for_hire"],
        social: json["social"] == null ? null : Social.fromJson(json["social"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "username": username,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "twitter_username": twitterUsername,
        "portfolio_url": portfolioUrl,
        "bio": bio,
        "location": location,
        "links": links?.toJson(),
        "profile_image": profileImage?.toJson(),
        "instagram_username": instagramUsername,
        "total_collections": totalCollections,
        "total_likes": totalLikes,
        "total_photos": totalPhotos,
        "total_promoted_photos": totalPromotedPhotos,
        "total_illustrations": totalIllustrations,
        "total_promoted_illustrations": totalPromotedIllustrations,
        "accepted_tos": acceptedTos,
        "for_hire": forHire,
        "social": social?.toJson(),
      };
}

class UserLinks {
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        likes: json["likes"],
        portfolio: json["portfolio"],
        following: json["following"],
        followers: json["followers"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "photos": photos,
        "likes": likes,
        "portfolio": portfolio,
        "following": following,
        "followers": followers,
      };
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}

class Social {
  String? instagramUsername;
  dynamic portfolioUrl;
  dynamic twitterUsername;
  dynamic paypalEmail;

  Social({
    this.instagramUsername,
    this.portfolioUrl,
    this.twitterUsername,
    this.paypalEmail,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        instagramUsername: json["instagram_username"],
        portfolioUrl: json["portfolio_url"],
        twitterUsername: json["twitter_username"],
        paypalEmail: json["paypal_email"],
      );

  Map<String, dynamic> toJson() => {
        "instagram_username": instagramUsername,
        "portfolio_url": portfolioUrl,
        "twitter_username": twitterUsername,
        "paypal_email": paypalEmail,
      };
}
