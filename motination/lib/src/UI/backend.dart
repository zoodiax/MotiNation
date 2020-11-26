/* 

Widget build(BuildContext context) {
    BackendClass class = Provider.of<BackendClass>(context);

    return StreamBuilder<BackendClassData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
          }}

*/