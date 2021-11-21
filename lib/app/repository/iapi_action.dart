

abstract class IApiAction{

  Future<dynamic> index();
  Future<dynamic> store(data);
  Future<dynamic> show(id);
  Future<dynamic> update(data,id);
  Future<dynamic> destroy(id);

}