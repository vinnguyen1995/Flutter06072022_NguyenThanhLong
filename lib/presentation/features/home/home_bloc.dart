import 'package:dio/dio.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_bloc.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_event.dart';
import 'package:flutter_app_sale_06072022/data/repositories/product_repository.dart';
import 'package:flutter_app_sale_06072022/presentation/features/home/home_event.dart';

import '../../../data/datasources/remote/app_response.dart';
import '../../../data/datasources/remote/dto/product_dto.dart';

class HomeBloc extends BaseBloc{
  late ProductRepository _repository;

  void updateProductRepository(ProductRepository productRepository) {
    _repository = productRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType) {
      case GetListProductEvent:
        _getListProduct();
        break;
    }
  }

  void _getListProduct() async{
    loadingSink.add(true);
    try {
      Response response = await _repository.getListProducts();
      // print(response.data);
      // print(response.data.runtimeType);
      AppResponse<List<ProductDto>> listProductResponse = AppResponse.fromJson(response.data, ProductDto.convertJson);
      print(listProductResponse.data?[0].gallery?[0]);
    } on DioError catch (e) {
      messageSink.add(e.response?.data["message"]);
    } catch (e) {
      messageSink.add(e.toString());
    }
    loadingSink.add(false);
  }

}