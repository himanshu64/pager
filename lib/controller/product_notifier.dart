import 'package:flutter/material.dart';
import 'package:pager/services/api_service.dart';
import 'package:pager/model/product_model.dart';



class ProductNotifier extends ChangeNotifier {
  late APIService _apiService;
  List<ProductModel> _productData = [];

  int pageSize = 25;

  List<ProductModel> get productList => _productData;
  bool isLoading = false;
  bool isEmpty = false;

  ProductNotifier() {
    _initStreams();
  }

  void _initStreams() {
    _apiService = APIService();
  }

  void resetStreams() {
    _initStreams();
  }

  fetchProductList(pageNumber) async {
    
    
    var listModels = await _apiService.getData(pageNumber);
    List<ProductModel> itemModel = listModels
        .map<ProductModel>((element) => ProductModel.fromJson(element))
        .toList();

    if (_productData == null) {
      _productData = itemModel;
    } else {
      if(itemModel.isNotEmpty){
        _productData.addAll(itemModel);
      }
    }
    setLoadingStatus(false);
    notifyListeners();
  }
  setLoadingStatus(bool status){
    isLoading = status;
     notifyListeners();
  }


}
