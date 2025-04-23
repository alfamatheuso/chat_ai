class ApiService {
  final Dio dio = Dio();

  Future<List<String>> fetchRepositories(String owner) async {
    final response = await dio.get(
      '${Constants.baseUrl}/respositories',
      data: {'owner': owner},
    );
    return List<String>.from(response.data);
  }

  Future<String> sendPrompt(String prompt, String owner, String repository) async {
    final response = await dio.post(
      '${Constants.baseUrl}/gen_app',
      data: {'prompt': prompt, 'owner': owner, 'repositorio': repository},
    );
    return response.data.toString();
  }
}