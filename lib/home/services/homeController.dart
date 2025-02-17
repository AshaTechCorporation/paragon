import 'package:flutter/material.dart';
import 'package:paragon/home/services/homeApi.dart';
import 'package:paragon/models/user.dart';

class HomeController extends ChangeNotifier {
  HomeController({this.api = const HomeApi()});
  HomeApi api;

  // List<News> news = [];
  // List<Promotion> promotions = [];
  // News? newsDetail;

  User? user;

  getProfileUser() async {
    user = await HomeApi.getProfile();
    notifyListeners();
  }

  // getListNews() async {
  //   news.clear();
  //   news = await HomeApi.getNews();
  //   notifyListeners();
  // }

  // getNewsDetail(int id) async {
  //   newsDetail = await HomeApi.getNewsId(id);
  //   notifyListeners();
  // }

  // getListPromotions() async {
  //   promotions.clear();
  //   promotions = await HomeApi.getPromotions();
  //   notifyListeners();
  // }
}