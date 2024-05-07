import 'package:contact_agenda/src/models/contact.dart';
import 'package:contact_agenda/src/services/bdprovider.dart';

class ControllersContacts{

  BdProvider db =  BdProvider();

  Future<Contact> add (Contact cont) async{
    
    return await db.insert(cont);

  }

  Future<List<Contact>> readALL () async{
    
    return await db.getAllContacts();
  }

  Future<Contact?> read (int id) async{
    
    return await db.getContact(id);
    
  }

  Future<int> update (Contact cont) async{
    
    return await db.update(cont);

  }

  Future<int> delete (int id) async{
    
    return await db.deleteContact(id);
    
  }

  Future close () async {
    await db.close();
  }

}