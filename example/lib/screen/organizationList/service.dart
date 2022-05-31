import 'dart:convert';

import 'package:browsr/browsr.dart';
import 'package:browsr_example/core/model/organizationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum OrganizationListStatus { loading, screen, error }

class OrganizationListService with ChangeNotifier {
  OrganizationListStatus _status = OrganizationListStatus.loading;
  OrganizationListStatus get status => _status;

  late SharedPreferences _preferences;

  final TextEditingController searchController = TextEditingController();

  bool _isAsc = false;

  String? _errorReason;
  String? get errorReason => _errorReason;

  final List<OrganizationModel> _organizationList = [];

  List<OrganizationModel> displayList = [];

  OrganizationListService() {
    init();
  }

  void _updateStatus(OrganizationListStatus s) {
    _status = s;
    notifyListeners();
  }

  void init() async {
    _updateStatus(OrganizationListStatus.loading);
    await Browsr.getOrgList
        .then((value) => verifyStatusCode(value))
        .catchError((onError) {
      _errorReason = onError.toString();
      _updateStatus(OrganizationListStatus.error);
    });
    await createFavList()
        .whenComplete(() => _updateStatus(OrganizationListStatus.screen));
  }

  Future<void> createFavList() async {
    _preferences = await SharedPreferences.getInstance();
    Set _keys = _preferences.getKeys();
    for (var key in _keys) {
      Iterable r = _organizationList.where((element) => element.name == key);
      if (r.isNotEmpty) {
        for (OrganizationModel o in r) {
          o.setIsFav(true);
        }
      } else {
        String res = _preferences.getString(key) ?? "{}";
        OrganizationModel om = OrganizationModel.fromJson(json.decode(res));
        _organizationList.add(om);
        displayList.add(om);
      }
    }
  }

  void verifyStatusCode(Map? data) {
    if (data!.isEmpty) {
      throw "No Data Found";
    } else {
      int _statusCode = data["status_code"];
      if (_statusCode == 200 || _statusCode == 304) {
        List result = json.decode(data["data"]);
        createList(result);
      } else {
        throw ("Invalid Status Code: $_statusCode");
      }
    }
  }

  Future<void> createList(List orgList) async {
    for (var org in orgList) {
      OrganizationModel _model = OrganizationModel.fromJson(org);
      _organizationList.add(_model);
      displayList.add(_model);
    }
  }

  void updateDisplayList() {
    displayList.clear();
    displayList.addAll(_organizationList
        .where((element) => element.name!.contains(searchController.text)));
    _updateStatus(OrganizationListStatus.screen);
  }

  void sortList() {
    if (_isAsc) {
      displayList.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      _organizationList.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    } else {
      displayList.sort(
          (a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()));

      _organizationList.sort(
          (a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()));
    }
    _isAsc = !_isAsc;
    _updateStatus(OrganizationListStatus.screen);
  }
}
