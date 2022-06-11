import 'package:flutter/material.dart';
import 'second_route.dart';


class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  String? _gender;
  DateTime selectedDate = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
            children: [
              const Text(
                "Fill the form",
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: "Name"),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                textInputAction: TextInputAction.next,
                obscureText: false,
              ),
              TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: "Surname"),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                textInputAction: TextInputAction.next,
                obscureText: false,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  String email = value ?? "";
                  bool isValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_"
                  r"`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email);
                  if (!isValid) {
                    return "Email not correct";
                  } else {
                    return null;
                  }
                },
                maxLength: 250,
                decoration: const InputDecoration(hintText: "Email"),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                textInputAction: TextInputAction.next,
                obscureText: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Gender:",
                    style: TextStyle(fontSize: 24),
                  ),
                  Radio(
                    value: "male",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const Text(
                    "Male",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Radio(
                    value: "female",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const Text(
                    "Female",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Date of birth:",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3)),
                    child: InkWell(
                      child: Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          style: const TextStyle(
                            fontSize: 20.0,
                          )),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     _selectDate(context);
                  //   },
                  //   child: const Text("Change Date"),
                  // ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                style: const ButtonStyle(),
                label: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blue[800],
                  ),
                ),
                icon: Icon(
                  Icons.save,
                  size: 28,
                  color: Colors.blue[800],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondRoute()),
          );
        },
        child: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}
