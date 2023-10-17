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

String capitalize(String word) {
  if (word.isEmpty) {
    return '';
  }
  return word[0].toUpperCase() + word.substring(1);
}
