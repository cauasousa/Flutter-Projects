import 'package:contact_agenda/src/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableContact = "TableContact";

class BdProvider {
  //  Declara uma variável estática chamada _instance que é inicializada
  //com uma instância de BdProvider usando um construtor interno.
  //Garantindo que apenas uma instância seja criada e retornada por meio do construtor de fábrica.
  static final BdProvider _instance = BdProvider.internal();
  //  Define um construtor de fábrica que retorna a instância _instance da classe BdProvider
  factory BdProvider() => _instance;
  // Define um construtor interno para a classe BdProvider.
  BdProvider.internal();

  Database? _db;

  Future<Database> get db async {
    if(_db == null){
      _db = await open();
      return _db!;
    }else{
      return _db!;
    }
    
  }
  
  set db  (value){
    _db = value;
  }


  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demos1.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      db.execute('''
        CREATE TABLE $tableContact( 
        $idContact INTEGER PRIMARY KEY, 
        $nameContact TEXT not null,
        $emailContact Text not null, 
        $numberContact Text not null,
        $imgContact Text
        )
        ''');
    });
  }

  // Future<Contact> insert(Contact cont) async {
  //   cont.id = await db.then(
  //     (value) async {
  //       return await value.insert(tableContact, cont.toMap());
  //     },
  //   );

  //   return cont;
  // }

  Future<Contact> insert(Contact cont) async {
    Database database = await db;
    cont.id = await database.insert(tableContact, cont.toMap());
    return cont;
  }

  Future<Contact?> getContact(int id) async {
    Database database = await db;
    List<Map> maps = await database.query(tableContact,
        columns: [
          idContact,
          nameContact,
          emailContact,
          numberContact,
          imgContact
        ],
        where: "$idContact = ?",
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database database = await db;
    return await database
        .delete(tableContact, where: "$idContact = ?", whereArgs: [id]);
  }

  Future<int> update(Contact cont) async {
    Database database = await db;
    return await database.update(tableContact, cont.toMap(),
        where: "$idContact = ?", whereArgs: [cont.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    

    Database database = await db.then((value) {
      return value;
    });
    

    
    return await database.rawQuery("SELECT * FROM $tableContact").then((value) async {
      List<Contact> allContacts = List.empty(growable: true);

      for (Map map in value) {
        allContacts.add(Contact.fromMap(map));
      }
      return allContacts;

    }).onError((error, stackTrace) {
      print("OPA $database");
      return [];
    });

  }

  Future<int> getNumber() async {
    Database database = await db;
    int? valor = Sqflite.firstIntValue(
        await database.rawQuery("SELECT COUNT(*) FROM $tableContact"));
    return valor ?? 0;
  }

  Future close() async {
    Database database = await db;
    database.close();
    
  }
}
