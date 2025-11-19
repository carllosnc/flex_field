import 'package:flutter/material.dart';
import 'package:flex_field/flex_field.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flex Field"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 40,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("This is a simple item"),

            TextFormField(
              maxLength: 20,
              controller: controller1,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Ex: John Doe',
                suffixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                controller1.text = value;
              },
            ).flex(
              name: "Name",
              context: context,
              label: () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Enter your name"),
              ),
              filled: (value) {
                return Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            TextFormField(
              controller: controller2,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Ex: John Doe',
                suffixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                controller2.text = value;
              },
            ).flex(
              name: "Name",
              context: context,
              label: () => Text("Enter your name"),
              filled: (value) {
                return Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
