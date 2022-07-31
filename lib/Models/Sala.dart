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


/** This is an auto generated class representing the Sala type in your schema. */
@immutable
class Sala extends Model {
  static const classType = const _SalaModelType();
  final String id;
  final String? _name;
  final Office? _office;
  final List<Prenotazione>? _prenotazioni;
  final String? _immagine;
  final int? _capienza;
  final int? _piano;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _salaOfficeId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  Office? get office {
    return _office;
  }
  
  List<Prenotazione>? get prenotazioni {
    return _prenotazioni;
  }
  
  String? get immagine {
    return _immagine;
  }
  
  int? get capienza {
    return _capienza;
  }
  
  int? get piano {
    return _piano;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get salaOfficeId {
    return _salaOfficeId;
  }
  
  const Sala._internal({required this.id, name, office, prenotazioni, immagine, capienza, piano, createdAt, updatedAt, salaOfficeId}): _name = name, _office = office, _prenotazioni = prenotazioni, _immagine = immagine, _capienza = capienza, _piano = piano, _createdAt = createdAt, _updatedAt = updatedAt, _salaOfficeId = salaOfficeId;
  
  factory Sala({String? id, String? name, Office? office, List<Prenotazione>? prenotazioni, String? immagine, int? capienza, int? piano, String? salaOfficeId}) {
    return Sala._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      office: office,
      prenotazioni: prenotazioni != null ? List<Prenotazione>.unmodifiable(prenotazioni) : prenotazioni,
      immagine: immagine,
      capienza: capienza,
      piano: piano,
      salaOfficeId: salaOfficeId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sala &&
      id == other.id &&
      _name == other._name &&
      _office == other._office &&
      DeepCollectionEquality().equals(_prenotazioni, other._prenotazioni) &&
      _immagine == other._immagine &&
      _capienza == other._capienza &&
      _piano == other._piano &&
      _salaOfficeId == other._salaOfficeId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Sala {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("immagine=" + "$_immagine" + ", ");
    buffer.write("capienza=" + (_capienza != null ? _capienza!.toString() : "null") + ", ");
    buffer.write("piano=" + (_piano != null ? _piano!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("salaOfficeId=" + "$_salaOfficeId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Sala copyWith({String? id, String? name, Office? office, List<Prenotazione>? prenotazioni, String? immagine, int? capienza, int? piano, String? salaOfficeId}) {
    return Sala._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      office: office ?? this.office,
      prenotazioni: prenotazioni ?? this.prenotazioni,
      immagine: immagine ?? this.immagine,
      capienza: capienza ?? this.capienza,
      piano: piano ?? this.piano,
      salaOfficeId: salaOfficeId ?? this.salaOfficeId);
  }
  
  Sala.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _office = json['office']?['serializedData'] != null
        ? Office.fromJson(new Map<String, dynamic>.from(json['office']['serializedData']))
        : null,
      _prenotazioni = json['prenotazioni'] is List
        ? (json['prenotazioni'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Prenotazione.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _immagine = json['immagine'],
      _capienza = (json['capienza'] as num?)?.toInt(),
      _piano = (json['piano'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _salaOfficeId = json['salaOfficeId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'office': _office?.toJson(), 'prenotazioni': _prenotazioni?.map((Prenotazione? e) => e?.toJson()).toList(), 'immagine': _immagine, 'capienza': _capienza, 'piano': _piano, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'salaOfficeId': _salaOfficeId
  };

  static final QueryField ID = QueryField(fieldName: "sala.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField OFFICE = QueryField(
    fieldName: "office",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Office).toString()));
  static final QueryField PRENOTAZIONI = QueryField(
    fieldName: "prenotazioni",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Prenotazione).toString()));
  static final QueryField IMMAGINE = QueryField(fieldName: "immagine");
  static final QueryField CAPIENZA = QueryField(fieldName: "capienza");
  static final QueryField PIANO = QueryField(fieldName: "piano");
  static final QueryField SALAOFFICEID = QueryField(fieldName: "salaOfficeId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Sala";
    modelSchemaDefinition.pluralName = "Salas";
    
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
      key: Sala.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Sala.OFFICE,
      isRequired: false,
      ofModelName: (Office).toString(),
      associatedKey: Office.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Sala.PRENOTAZIONI,
      isRequired: false,
      ofModelName: (Prenotazione).toString(),
      associatedKey: Prenotazione.SALAID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Sala.IMMAGINE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Sala.CAPIENZA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Sala.PIANO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Sala.SALAOFFICEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _SalaModelType extends ModelType<Sala> {
  const _SalaModelType();
  
  @override
  Sala fromJson(Map<String, dynamic> jsonData) {
    return Sala.fromJson(jsonData);
  }
}