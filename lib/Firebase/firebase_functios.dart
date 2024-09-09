import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kemo_todo_app_2/models/task_model.dart';

class FirebaseFunctions 
{
  static CollectionReference<TaskModel> getTaskCollection() 
  {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>
        (
          fromFirestore: (snapshot, _) 
          {
            return TaskModel.fromJson(snapshot.data()!);
          },

          toFirestore: (task, _) 
          {
            return task.toJson();
          },
        );
  }

  static Future<void> addTask(TaskModel task) 
  {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) 
  {
    var taskCollection = getTaskCollection();
    return taskCollection
        // .where("date",isEqualTo: DateUtils.dataOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) 
  {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) 
  {
    return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  static login (String eamil , String password) async
  {
    try 
    {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: eamil,
        password: password
      );
    } 

    on FirebaseAuthException catch (e) 
    {
      if (e.code == 'user-not-found') 
      {
        print('No user found for that email.');
      } 

      else if (e.code == 'wrong-password') 
      {
        print('Wrong password provided for that user.');
      }
    }
  }

  static create_acount (String email , String password) async
  {
    try 
    {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: email,
        password: password,
      );
      credential.user?.sendEmailVerification();
    } 
    on FirebaseAuthException catch (e) 

    {
      if (e.code == 'weak-password') 
      {
        print('The password provided is too weak.');
      } 

      else if (e.code == 'email-already-in-use') 
      {
        print('The account already exists for that email.');
      }
    }
    catch (e) 
    {
      print(e);
    }
  }

}