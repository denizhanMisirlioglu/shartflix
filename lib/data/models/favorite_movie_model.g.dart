// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMovieModel _$FavoriteMovieModelFromJson(Map<String, dynamic> json) =>
    FavoriteMovieModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      posterUrl: json['posterUrl'] as String,
    );

Map<String, dynamic> _$FavoriteMovieModelToJson(FavoriteMovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'posterUrl': instance.posterUrl,
    };
