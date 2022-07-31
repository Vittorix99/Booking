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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Prenotazione type in your schema. */
@immutable
class Prenotazione extends Model {
  static const classType = const _PrenotazioneModelType();
  final String id;
   String? _name;
   String? _surname;
   String? _mail;
   TemporalDate? _date;
   int? _startTime;
   int? _endTime;
   String? _officeID;
   String? _salaID;
   Postazione? _postazione;
   String? _picture;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  set name(String? value) {
    _name = value;
  }

  String? _prenotazionePostazioneId;

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
  
  String? get mail {
    return _mail;
  }

  DateTime? get date {
    return _date?.getDateTime();
  }
  
  int? get startTime {
    return _startTime;
  }
  
  int? get endTime {
    return _endTime;
  }
  
  String? get officeID {
    return _officeID;
  }
  
  String? get salaID {
    return _salaID;
  }
  
  Postazione? get postazione {
    return _postazione;
  }
  
  String? get picture {
    return _picture;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get prenotazionePostazioneId {
    return _prenotazionePostazioneId;
  }
  
   Prenotazione._internal({required this.id, name, surname, mail, date, startTime, endTime, officeID, salaID, postazione, picture, createdAt, updatedAt, prenotazionePostazioneId}): _name = name, _surname = surname, _mail = mail, _date = date, _startTime = startTime, _endTime = endTime, _officeID = officeID, _salaID = salaID, _postazione = postazione, _picture = picture, _createdAt = createdAt, _updatedAt = updatedAt, _prenotazionePostazioneId = prenotazionePostazioneId;
  
  factory Prenotazione({String? id, String? name, String? surname, String? mail, TemporalDate? date, int? startTime, int? endTime, String? officeID, String? salaID, Postazione? postazione, String? picture, String? prenotazionePostazioneId}) {
    return Prenotazione._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      surname: surname,
      mail: mail,
      date: date,
      startTime: startTime,
      endTime: endTime,
      officeID: officeID,
      salaID: salaID,
      postazione: postazione,
      picture: picture,
      prenotazionePostazioneId: prenotazionePostazioneId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Prenotazione &&
      id == other.id &&
      _name == other._name &&
      _surname == other._surname &&
      _mail == other._mail &&
      _date == other._date &&
      _startTime == other._startTime &&
      _endTime == other._endTime &&
      _officeID == other._officeID &&
      _salaID == other._salaID &&
      _postazione == other._postazione &&
      _picture == other._picture &&
      _prenotazionePostazioneId == other._prenotazionePostazioneId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Prenotazione {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("surname=" + "$_surname" + ", ");
    buffer.write("mail=" + "$_mail" + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("startTime=" + (_startTime != null ? _startTime!.toString() : "null") + ", ");
    buffer.write("endTime=" + (_endTime != null ? _endTime!.toString() : "null") + ", ");
    buffer.write("officeID=" + "$_officeID" + ", ");
    buffer.write("salaID=" + "$_salaID" + ", ");
    buffer.write("picture=" + "$_picture" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("prenotazionePostazioneId=" + "$_prenotazionePostazioneId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Prenotazione copyWith({String? id, String? name, String? surname, String? mail, TemporalDate? date, int? startTime, int? endTime, String? officeID, String? salaID, Postazione? postazione, String? picture, String? prenotazionePostazioneId}) {
    return Prenotazione._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      mail: mail ?? this.mail,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      officeID: officeID ?? this.officeID,
      salaID: salaID ?? this.salaID,
      postazione: postazione ?? this.postazione,
      picture: picture ?? this.picture,
      prenotazionePostazioneId: prenotazionePostazioneId ?? this.prenotazionePostazioneId);
  }
  
  Prenotazione.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _surname = json['surname'],
      _mail = json['mail'],
      _date = json['date'] != null ? TemporalDate.fromString(json['date']) : null,
      _startTime = (json['startTime'] as num?)?.toInt(),
      _endTime = (json['endTime'] as num?)?.toInt(),
      _officeID = json['officeID'],
      _salaID = json['salaID'],
      _postazione = json['postazione']?['serializedData'] != null
        ? Postazione.fromJson(new Map<String, dynamic>.from(json['postazione']['serializedData']))
        : null,
      _picture = json['picture'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _prenotazionePostazioneId = json['prenotazionePostazioneId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'surname': _surname, 'mail': _mail, 'date': _date?.format(), 'startTime': _startTime, 'endTime': _endTime, 'officeID': _officeID, 'salaID': _salaID, 'postazione': _postazione?.toJson(), 'picture': _picture, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'prenotazionePostazioneId': _prenotazionePostazioneId
  };

  static final QueryField ID = QueryField(fieldName: "prenotazione.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SURNAME = QueryField(fieldName: "surname");
  static final QueryField MAIL = QueryField(fieldName: "mail");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField STARTTIME = QueryField(fieldName: "startTime");
  static final QueryField ENDTIME = QueryField(fieldName: "endTime");
  static final QueryField OFFICEID = QueryField(fieldName: "officeID");
  static final QueryField SALAID = QueryField(fieldName: "salaID");
  static final QueryField POSTAZIONE = QueryField(
    fieldName: "postazione",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Postazione).toString()));
  static final QueryField PICTURE = QueryField(fieldName: "picture");
  static final QueryField PRENOTAZIONEPOSTAZIONEID = QueryField(fieldName: "prenotazionePostazioneId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Prenotazione";
    modelSchemaDefinition.pluralName = "Prenotaziones";
    
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
      key: Prenotazione.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.SURNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.MAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.DATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.STARTTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.ENDTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.OFFICEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.SALAID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Prenotazione.POSTAZIONE,
      isRequired: false,
      ofModelName: (Postazione).toString(),
      associatedKey: Postazione.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.PICTURE,
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Prenotazione.PRENOTAZIONEPOSTAZIONEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });

  set surname(String? value) {
    _surname = value;
  }

  set mail(String? value) {
    _mail = value;
  }

  set date(DateTime? value) {
    _date = TemporalDate(value!);
  }
  set startTime(int? value) {
    _startTime = value;
  }

  set endTime(int? value) {
    _endTime = value;
  }

  set officeID(String? value) {
    _officeID = value;
  }

  set salaID(String? value) {
    _salaID = value;
  }

  set postazione(Postazione? value) {
    _postazione = value;
  }

  set picture(String? value) {
    _picture = value;
  }

  set prenotazionePostazioneId(String? value) {
    _prenotazionePostazioneId = value;
  }
}

class _PrenotazioneModelType extends ModelType<Prenotazione> {
  const _PrenotazioneModelType();
  
  @override
  Prenotazione fromJson(Map<String, dynamic> jsonData) {
    return Prenotazione.fromJson(jsonData);
  }
}