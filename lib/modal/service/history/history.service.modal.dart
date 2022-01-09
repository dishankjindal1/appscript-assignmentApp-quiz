import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:quiz/modal/data/data.dart';
import 'package:quiz/modal/utils/utils.dart';

class HistoryServiceModal {
  final _logger = Logger();
  Future<List<HistoryDataModal>> getList(String uid) async {
    _logger.i('getList called');

    final historyRef = getCollection(uid);

    var queryHistoryList =
        await historyRef.orderBy('timestamp').get().then((value) => value.docs);

    List<HistoryDataModal> historyList = [];

    for (var element in queryHistoryList) {
      historyList.add(HistoryDataModal(
        score: element.data().score,
        timestamp: element.data().timestamp,
      ));
    }
    return historyList;
  }

  uploadScore(String uid, String score) {
    _logger.i('uploadScore called');
    var timestamp = Timestamp.now().toDate().toIso8601String();

    final historyRef = getCollection(uid);
    historyRef
        .add(
          HistoryDataModal(score: score, timestamp: timestamp),
        )
        .then((value) => debugPrint('User Added'))
        .catchError((e) => throw FireStoreScoreUploadException(e));
  }

  CollectionReference<HistoryDataModal> getCollection(String uid) {
    return FirebaseFirestore.instance
        .collection('quiz')
        .doc('user-$uid')
        .collection('history')
        .withConverter<HistoryDataModal>(
            fromFirestore: (snapshot, _) =>
                HistoryDataModal.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson());
  }
}
