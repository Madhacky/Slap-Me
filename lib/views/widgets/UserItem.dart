import 'package:flutter/material.dart';
import 'package:slap_me/models/user.dart';
import 'package:slap_me/views/chatScreen.dart';
import 'package:slap_me/views/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
class UserItem extends StatefulWidget {
  final UserModel user;
  const UserItem({super.key,required this.user});

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(userId: widget.user.uid,)));
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            widget.user.image==''?
               CircleAvatar(
              radius: 30,
              child: Icon(Icons.person),
              backgroundColor: Colors.blue.shade200,
            ):
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.user.image),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:5.0),
              child: CircleAvatar(backgroundColor:widget.user.isOnline?Colors.greenAccent:Colors.grey,radius: 5,),
            ),
            
          ],
        ),
        title: Text(widget.user.name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
        subtitle: Text("Last active : ${timeago.format(widget.user.lastActive.toDate())}",maxLines:2 ,style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis,color: mainColor),),
      ),
    );
  }
}