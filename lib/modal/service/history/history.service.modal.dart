// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:quiz/modal/data/data.dart';
import 'package:quiz/modal/utils/utils.dart';

class HistoryServiceModal {
  late final String _serverUrl;
  late final Logger _logger;
  late final FirebaseFirestore _firebaseFirestore;

  HistoryServiceModal(String serverUrl,
      [Logger? logger, FirebaseFirestore? firebaseFirestore]) {
    if (Uri.parse(serverUrl).isAbsolute) {
      _serverUrl = serverUrl;
    } else {
      throw InvalidServerUrlException();
    }
    if (logger == null) {
      _logger = Logger();
    } else {
      _logger = logger;
    }
    if (firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    } else {
      _firebaseFirestore = firebaseFirestore; //instance assigned
    }
  }

  Future<List<HistoryDataModal>> getList(String uid) async {
    final historyRef = getCollection(uid);

    var queryHistoryList = await historyRef
        .orderBy('timestamp', descending: true)
        .limit(5)
        .get()
        .then((value) => value.docs);

    List<HistoryDataModal> historyList = [];

    for (var element in queryHistoryList) {
      historyList.add(HistoryDataModal(
        score: element.data().score,
        timestamp: element.data().timestamp,
      ));
    }
    return historyList;
  }

  Future<void> uploadScore(String uid, String score) async {
    _logger.i('uploadScore called');
    var timestamp = Timestamp.now().toDate().toIso8601String();

    final historyRef = getCollection(uid);
    await historyRef
        .add(HistoryDataModal(score: score, timestamp: timestamp))
        .then((value) => debugPrint('User Added'))
        .catchError((e) => throw FireStoreScoreUploadException(e));
  }

  CollectionReference<HistoryDataModal> getCollection(String uid) {
    return _firebaseFirestore
        .collection('quiz')
        .doc('user-$uid')
        .collection('history')
        .withConverter<HistoryDataModal>(
            fromFirestore: (snapshot, _) {
              try {
                return HistoryDataModal.fromJson(snapshot.data()!);
              } catch (e) {
                _logger.e("Error during fetching data :-" + e.toString());
                throw FirebaseException(plugin: 'FirebaseFireStore error');
              }
            },
            toFirestore: (data, _) => data.toJson());
  }
}
