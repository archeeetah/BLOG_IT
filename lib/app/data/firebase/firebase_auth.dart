import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createAccount(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e);
    }
  }

  Future<void> login(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e){
      print(e);
    }
  }

  Future<void> logOut() async{
    try{
      await _auth.signOut();
    }
    catch(e){
      print(e);
    }
  }
}