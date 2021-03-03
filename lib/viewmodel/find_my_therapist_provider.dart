import 'package:find_my_therapist/model/category.dart';
import 'package:find_my_therapist/model/problem.dart';
import 'package:find_my_therapist/model/recomended_therapy.dart';
import 'package:find_my_therapist/services/web_service.dart';
import 'package:flutter/material.dart';

class FindMyTherapistProvider extends ChangeNotifier {
  final WebService webService = WebService();

  Category _category;
  Problem _problem;
  RecomendedTherapy _recomendedTherapy;
  int _chosenClientCategory = 1;
  int _chosenProblem = 1;
  int _chosenIssue = 0;
  int _chosenParentsAnswer = 0;
  int _chosenDifficultyPeriod = 0;
  int _chosenSegmentedControl = 0;

  bool _isRequesting = true;

  Category get category => _category;
  Problem get problem => _problem;
  RecomendedTherapy get recomendedTherapy => _recomendedTherapy;

  int get chosenClientCategory => _chosenClientCategory;
  int get chosenProblem => _chosenProblem;
  int get chosenIssue => _chosenIssue;
  int get chosenParentsAnswer => _chosenParentsAnswer;
  int get chosenDifficultyPeriod => _chosenDifficultyPeriod;
  int get segmentedControlGroupValue => _chosenSegmentedControl;
  bool get isRequesting => _isRequesting;

  List<String> get parentsAnwers => ['No', 'Somewhat', 'Yes'];

  List<String> get difficultyPeriod =>
      ['More than 5 years', 'Less than 5 years'];

  Future<void> fetchAllData() async {
    _isRequesting = true;
    notifyListeners();
    try {
      _category = await webService.getCategories();
      _problem = await webService.getProblems();

      print(category);
      print(problem);

      notifyListeners();
    } on Exception catch (e) {
      _isRequesting = false;
    } finally {
      _isRequesting = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategory() async {
    try {
      _category = await webService.getCategories();
      notifyListeners();
    } on Exception catch (e) {}
  }

  Future<void> fetchProblem() async {
    try {
      _problem = await webService.getProblems();
      notifyListeners();
    } on Exception catch (e) {}
  }

  void changeProblem(int val) {
    if (val != chosenProblem) {
      _chosenProblem = val;
      notifyListeners();
    }
  }

  void changeCategory(int val) {
    if (val != chosenClientCategory) {
      _chosenClientCategory = val;
      notifyListeners();
    }
  }

  void changeIssue(int val) {
    if (val != chosenIssue) {
      _chosenIssue = val;
      notifyListeners();
    }
  }

  void changeParentsAnwer(int val) {
    if (val != chosenParentsAnswer) {
      _chosenParentsAnswer = val;
      notifyListeners();
    }
  }

  void changeDifficultyPeriod(int val) {
    if (val != chosenDifficultyPeriod) {
      _chosenDifficultyPeriod = val;
      notifyListeners();
    }
  }

  void changeSegmentedControl(int val) {
    if (val != segmentedControlGroupValue) {
      _chosenSegmentedControl = val;
      notifyListeners();
    }
  }

  void getRecomendation() async {
    if (chosenProblem != null && chosenClientCategory != null) {
      print('$chosenProblem $chosenClientCategory');
      _recomendedTherapy = await webService.findRecomenedTherapy(
          chosenProblem, chosenClientCategory);
      notifyListeners();
    }
  }
}
