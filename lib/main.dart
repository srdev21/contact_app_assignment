import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  List<Map<String, String>> contacts = [];

  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'number': number});
      });

      nameController.clear();
      numberController.clear();
    }
  }

  void deleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure for Delete?'),
          actions: [
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {

                setState(() {
                  contacts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  MySnackBar(message,context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

// Define a reusable button style
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar:
      AppBar(
        title: Text("Contact List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
        foregroundColor: Colors.white,

        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Name",
                border: OutlineInputBorder()
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: numberController,

                decoration: InputDecoration(
                    labelText: "Number",
                border: OutlineInputBorder()
                ),


                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 10,width: 200),
            SizedBox(
              width: 370,
              child: ElevatedButton(
                onPressed: addContact,
                child: Text("Add"),

                style: buttonStyle,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index)

                {

                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 4), // Adds spacing between items
                  decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Light grey background for each item
                borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: Text(
                contacts[index]['name']!,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                ),
                subtitle: Text(contacts[index]['number']!),
                trailing: Icon(Icons.phone, color: Colors.blue),
                onLongPress: () => deleteContact(index),
                ) );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
