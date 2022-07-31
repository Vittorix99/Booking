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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Office type in your schema. */
@immutable
class Office extends Model {
  static const classType = const _OfficeModelType();
  final String id;

  set name(String? value) {
    _name = value;
  }

   String? _name;
   String? _indirizzo;
   String? _immagine;
   String? _city;
   int? _capienza;
   List<Postazione>? _postazioni;
   List<Prenotazione>? _prenotazioni;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get indirizzo {
    try {
      return _indirizzo!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get immagine {
    return _immagine;
  }

  
  String get city {
    try {
      return _city!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get capienza {
    try {
      return _capienza!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Postazione>? get postazioni {
    return _postazioni;
  }
  
  List<Prenotazione>? get prenotazioni {
    return _prenotazioni;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
   Office._internal({required this.id, required name, required indirizzo, immagine, required city, required capienza, postazioni, prenotazioni, createdAt, updatedAt}): _name = name, _indirizzo = indirizzo, _immagine = immagine, _city = city, _capienza = capienza, _postazioni = postazioni, _prenotazioni = prenotazioni, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Office({String? id, required String name, required String indirizzo, String? immagine, required String city, required int capienza, List<Postazione>? postazioni, List<Prenotazione>? prenotazioni}) {
    return Office._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      indirizzo: indirizzo,
      immagine: immagine,
      city: city,
      capienza: capienza,
      postazioni: postazioni != null ? List<Postazione>.unmodifiable(postazioni) : postazioni,
      prenotazioni: prenotazioni != null ? List<Prenotazione>.unmodifiable(prenotazioni) : prenotazioni);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Office &&
      id == other.id &&
      _name == other._name &&
      _indirizzo == other._indirizzo &&
      _immagine == other._immagine &&
      _city == other._city &&
      _capienza == other._capienza &&
      DeepCollectionEquality().equals(_postazioni, other._postazioni) &&
      DeepCollectionEquality().equals(_prenotazioni, other._prenotazioni);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Office {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("indirizzo=" + "$_indirizzo" + ", ");
    buffer.write("immagine=" + "$_immagine" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("capienza=" + (_capienza != null ? _capienza!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Office copyWith({String? id, String? name, String? indirizzo, String? immagine, String? city, int? capienza, List<Postazione>? postazioni, List<Prenotazione>? prenotazioni}) {
    return Office._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      indirizzo: indirizzo ?? this.indirizzo,
      immagine: immagine ?? this.immagine,
      city: city ?? this.city,
      capienza: capienza ?? this.capienza,
      postazioni: postazioni ?? this.postazioni,
      prenotazioni: prenotazioni ?? this.prenotazioni);
  }
  
  Office.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _indirizzo = json['indirizzo'],
      _immagine = json['immagine'],
      _city = json['city'],
      _capienza = (json['capienza'] as num?)?.toInt(),
      _postazioni = json['postazioni'] is List
        ? (json['postazioni'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Postazione.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _prenotazioni = json['prenotazioni'] is List
        ? (json['prenotazioni'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Prenotazione.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'indirizzo': _indirizzo, 'immagine': _immagine, 'city': _city, 'capienza': _capienza, 'postazioni': _postazioni?.map((Postazione? e) => e?.toJson()).toList(), 'prenotazioni': _prenotazioni?.map((Prenotazione? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "office.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField INDIRIZZO = QueryField(fieldName: "indirizzo");
  static final QueryField IMMAGINE = QueryField(fieldName: "immagine");
  static final QueryField CITY = QueryField(fieldName: "city");
  static final QueryField CAPIENZA = QueryField(fieldName: "capienza");
  static final QueryField POSTAZIONI = QueryField(
    fieldName: "postazioni",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Postazione).toString()));
  static final QueryField PRENOTAZIONI = QueryField(
    fieldName: "prenotazioni",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Prenotazione).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Office";
    modelSchemaDefinition.pluralName = "Offices";
    
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
      key: Office.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Office.INDIRIZZO,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Office.IMMAGINE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Office.CITY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Office.CAPIENZA,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Office.POSTAZIONI,
      isRequired: false,
      ofModelName: (Postazione).toString(),
      associatedKey: Postazione.OFFICEID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Office.PRENOTAZIONI,
      isRequired: false,
      ofModelName: (Prenotazione).toString(),
      associatedKey: Prenotazione.OFFICEID
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

  set indirizzo(String? value) {
    _indirizzo = value;
  }

  set immagine(String? value) {
    _immagine = value;
  }

  set city(String? value) {
    _city = value;
  }

  set capienza(int? value) {
    _capienza = value;
  }

  set postazioni(List<Postazione>? value) {
    _postazioni = value;
  }

  set prenotazioni(List<Prenotazione>? value) {
    _prenotazioni = value;
  }
}

class _OfficeModelType extends ModelType<Office> {
  const _OfficeModelType();
  
  @override
  Office fromJson(Map<String, dynamic> jsonData) {
    return Office.fromJson(jsonData);
  }
}