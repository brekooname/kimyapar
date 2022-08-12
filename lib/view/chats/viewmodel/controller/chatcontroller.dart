import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../services/firebase/IFirebaseService.dart';
import '../../../map/model/UserModel.dart';

class ChatController extends GetxController {
  final IFirebaseService service;
  ChatController(this.service);
  var list = Rx<List<UserModel>>([]);
  var chatDocId = Object().obs;
  var friendUid = "".obs;
  var friendName = "".obs;
  @override
  void onReady() async {
    super.onReady();
     getChatUsers();
     //checkUser();
  }

  getChatUsers() async {
    var response = await service.getOtherUsers();
    list.value = response;
  }

  /*void sendMessage(String msg) {
    if (msg == '') return;
    service.db
        .collection('chats')
        .doc(chatDocId.value.toString())
        .collection('messages')
        .add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName': widget.friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }*/
  
  void bindFriend(int index) {
    friendUid.value = list.value[index].id!;
    friendName.value = list.value[index].name!;
    friendName.refresh();
    friendUid.refresh();
  }

  void checkUser() async {
    var response = await service.db
        .collection('chats')
        .where('users',
            isEqualTo: {friendUid.value: null, service.auth.currentUser!.uid: null})
        .limit(1)
        .get();
    if (response.docs.isNotEmpty) {}
    await service.db
        .collection('chats')
        .where('users',
            isEqualTo: {friendUid.value: null, service.auth.currentUser!.uid: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              chatDocId.value = querySnapshot.docs.single.id;
              chatDocId.refresh();
            } else {
              await service.db.collection('chats').add({
                'users': {service.auth.currentUser!.uid: null, friendUid.value: null},
                'names': {
                  service.auth.currentUser!.uid:
                      service.auth.currentUser!.displayName,
                  friendUid.value: friendName.value
                }
              }).then((value) => {
                    chatDocId.value = value,
                    chatDocId.refresh(),
                  });
            }
          },
        )
        .catchError((error) {});
  }
}
