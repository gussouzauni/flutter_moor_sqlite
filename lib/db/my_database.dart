import 'package:moor_flutter/moor_flutter.dart';

part 'my_database.g.dart'; ///notação que diz que vai gerar um arquivo para ser utilizado
//Utilizo classes e objetos para gerar essa tabela com o moor;

class Todos extends Table {
//Criar colunas através dos elementos que ja vem dentro do flutter
  IntColumn get id => integer().autoIncrement()(); //Já executo o método com esse ();
  TextColumn get description => text().withLength(min: 3, max: 50)(); //min 3 caracters, max 50 caracters
  BoolColumn get completed => boolean()();
}

class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idTodo => integer()();
}

//Base de dados
@UseMoor(tables: [Todos, Favorites]) ///Usa uma anotação para dizer que se trata da uma base de dados
class MyDatabase extends _$MyDatabase {

  static final MyDatabase instance   = MyDatabase._internal(); //Instância única do BD
  MyDatabase._internal() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite')); //Iniciando a base de dados, to acessando o construtor da classe MyDatabase

  //Métodos para acessar meus dados dentro da minha tabela

  Stream<List<Todo>> getAllTodos() { //Stream é reativo, toda vez que a base de dados for alterada, ele altera automaticamente
    return select(todos).watch();
  }

  Future addTodo(Todo todo) {
    return into(todos).insert(todo);
  }

  Future deleteTodo(id) {
    //Quero deletar a tabela todos na colunatodo, quando id dele for igual ao id passado por parametro, ele apaga
    var query = delete(todos);
    query.where((todo) => todo.id.equals(id));
    return query.go();
  }

  @override
  // TODO: implement schemaVersion
  // Version banco de dados
  int get schemaVersion => 1;
}