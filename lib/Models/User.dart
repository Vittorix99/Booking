/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
   String? _name;
   String? _surname;
   String? _avatarKey;
   List<String>? _favorites;
   List<String>? _prenotazioni;
   String _mail;
   String? _role;

  set name(String? value) {
    _name = value;
  }

  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get surname {
return _surname;
  }
  
  String? get avatarKey {
    return _avatarKey;
  }
  
  List<String>? get favorites {
    return _favorites;
  }
  
  List<String>? get prenotazioni {
    return _prenotazioni;
  }
  
  String? get mail {
    return _mail;
  }
  
  String? get role {
    return _role;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
   User._internal({required this.id, name,  surname, avatarKey, favorites, prenotazioni, mail, role, createdAt, updatedAt}): _name = name, _surname = surname, _avatarKey = avatarKey, _favorites = favorites, _prenotazioni = prenotazioni, _mail = mail, _role = role, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? name,  String? surname, String? avatarKey, List<String>? favorites, List<String>? prenotazioni, String? mail, String? role}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      surname: surname,
      avatarKey: avatarKey,
      favorites: favorites != null ? List<String>.unmodifiable(favorites) : favorites,
      prenotazioni: prenotazioni != null ? List<String>.unmodifiable(prenotazioni) : prenotazioni,
      mail: mail,
      role: role);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _name == other._name &&
      _surname == other._surname &&
      _avatarKey == other._avatarKey &&
      DeepCollectionEquality().equals(_favorites, other._favorites) &&
      DeepCollectionEquality().equals(_prenotazioni, other._prenotazioni) &&
      _mail == other._mail &&
      _role == other._role;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("surname=" + "$_surname" + ", ");
    buffer.write("avatarKey=" + "$_avatarKey" + ", ");
    buffer.write("favorites=" + (_favorites != null ? _favorites!.toString() : "null") + ", ");
    buffer.write("prenotazioni=" + (_prenotazioni != null ? _prenotazioni!.toString() : "null") + ", ");
    buffer.write("mail=" + "$_mail" + ", ");
    buffer.write("role=" + "$_role" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? name, String? surname, String? avatarKey, List<String>? favorites, List<String>? prenotazioni, String? mail, String? role}) {
    return User._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatarKey: avatarKey ?? this.avatarKey,
      favorites: favorites ?? this.favorites,
      prenotazioni: prenotazioni ?? this.prenotazioni,
      mail: mail ?? this.mail,
      role: role ?? this.role);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _surname = json['surname'],
      _avatarKey = json['avatarKey'],
        _favorites = List.of(json['favorites'].cast<String>()),
        _prenotazioni = List.of(json['prenotazioni'].cast<String>()),
      _mail = json['mail'],
      _role = json['role'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'surname': _surname, 'avatarKey': _avatarKey, 'favorites': _favorites, 'prenotazioni': _prenotazioni, 'mail': _mail, 'role': _role, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SURNAME = QueryField(fieldName: "surname");
  static final QueryField AVATARKEY = QueryField(fieldName: "avatarKey");
  static final QueryField FAVORITES = QueryField(fieldName: "favorites");
  static final QueryField PRENOTAZIONI = QueryField(fieldName: "prenotazioni");
  static final QueryField MAIL = QueryField(fieldName: "mail");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SURNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.AVATARKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FAVORITES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PRENOTAZIONI,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.MAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ROLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });

  set surname(String? value) {
    _surname = value;
  }

  set avatarKey(String? value) {
    _avatarKey = value;
  }

  set favorites(List<String>? value) {
    _favorites = value;
  }

  set prenotazioni(List<String>? value) {
    _prenotazioni = value;
  }


}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}