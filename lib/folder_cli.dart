import 'dart:io';

int calculate() {
  return 6 * 7;
}

void createFolderStructureAndFiles(String moduleTitle) {
  ///This line defines the module directory
  var rootDir = Directory('lib/${moduleTitle.toLowerCase()}');
  print(moduleTitle);

  ///Creation of the module directory
  if (!rootDir.existsSync()) {
    rootDir.createSync();
  }

  ///We then create subdirectories
  var infrastructureDir = Directory('${rootDir.path}/infrastructure');
  var serviceDir = Directory('${rootDir.path}/infrastructure/service');
  var repoDir = Directory('${rootDir.path}/infrastructure/repository');
  var modelDir = Directory('${rootDir.path}/infrastructure/models');
  var domainDir = Directory('${rootDir.path}/domain');
  var datasourceDir = Directory('${rootDir.path}/domain/datasource');
  var presenterDir = Directory("${rootDir.path}/presenter");

  if (!infrastructureDir.existsSync()) {
    print("+Creating infrastructure directory........");
    infrastructureDir.createSync();
  }

  if (!serviceDir.existsSync()) {
    print("-Creating service directory........");
    serviceDir.createSync();
    createServiceWithTemplate(moduleTitle, serviceDir);
  }

  if (!repoDir.existsSync()) {
    print("-Creating repository directory........");
    repoDir.createSync();
    createAbstractRepo(moduleTitle, repoDir);
    createRepoImpl(moduleTitle, repoDir);
  }

  if (!modelDir.existsSync()) {
    print("-Creating model directory........");
    modelDir.createSync();
  }

  if (!domainDir.existsSync()) {
    print("+Creating domain directory........");
    domainDir.createSync();
  }

  if (!datasourceDir.existsSync()) {
    print("-Creating datasource directory........");
    datasourceDir.createSync();
    createAbstractDataSource(moduleTitle, datasourceDir);
    createDataSourceImpl(moduleTitle, datasourceDir);
  }

  if (!presenterDir.existsSync()) {
    print("+Creating presenter directory........");
    presenterDir.createSync();
  }
}

void createServiceWithTemplate(String title, dir) {
  title = capitalize(title);
  print("--Writing $title service........");
  String serviceTemplate = '''
  class ${title}Service {

    late final NetworkProvider _networkProvider;

    ${title}Service({NetworkProvider? networkProvider}) : _networkProvider ?? NetworkProvider();    
  }
  ''';

  File("${dir.path}/${title.toLowerCase()}_service.dart")
      .writeAsStringSync(serviceTemplate);
}

void createAbstractRepo(String title, dir) {
  String newTitle = capitalize(title);
  print("--Writing $newTitle abstract repository......");
  String abstractRepoTemplate = '''
  abstract class ${newTitle}Repository {

  }
  ''';

  File("${dir.path}/${title.toLowerCase()}_repository.dart")
      .writeAsStringSync(abstractRepoTemplate);
}

void createRepoImpl(String title, dir) {
  String newTitle = capitalize(title);
  print("--Writing $newTitle repository implement......");
  String repoImplTemplate = '''
  import '${title.toLowerCase()}_repository.dart';
  import '../service/${title.toLowerCase()}_service.dart';

  class ${newTitle}RepositoryImpl implements ${newTitle}Repository {

    final ${newTitle}Service _service;

    ${newTitle}RepositoryImpl({${newTitle}Service? service}) : _service = service ?? ${newTitle}Service();
  }
  ''';

  File("${dir.path}/${title.toLowerCase()}_repository_impl.dart")
      .writeAsStringSync(repoImplTemplate);
}

void createAbstractDataSource(String title, dir) {
  String newTitle = capitalize(title);
  print("--Writing $newTitle abstract datasource......");
  String abstractDataSourceTemplate = '''
  abstract class ${newTitle}DataSource {

  }
  ''';

  File("${dir.path}/${title.toLowerCase()}_datasource.dart")
      .writeAsStringSync(abstractDataSourceTemplate);
}

void createDataSourceImpl(String title, dir) {
  String newTitle = capitalize(title);
  print("--Writing $newTitle datasource implement......");
  String dataSourceImplTemplate = '''
  import '${title.toLowerCase()}_datasource.dart';
  import '../../infrastructure/repository/${title.toLowerCase()}_repository.dart';
  import '../../infrastructure/repository/${title.toLowerCase()}_repository_impl.dart';

  class ${newTitle}DataSourceImpl implements ${newTitle}DataSource {

    final ${newTitle}Repository repository = ${newTitle}RepositoryImpl();
  }
  ''';

  File("${dir.path}/${title.toLowerCase()}_datasource_impl.dart")
      .writeAsStringSync(dataSourceImplTemplate);
}

String capitalize(String word) {
  if (word.isEmpty) {
    return '';
  }
  return word[0].toUpperCase() + word.substring(1);
}
