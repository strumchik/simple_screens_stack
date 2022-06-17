import 'package:flutter/material.dart';
import 'package:layouts_and_ui/db_driver.dart';
import 'package:layouts_and_ui/user.dart';
import 'second_route.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  String _gender = "male";
  DateTime _selectedDate = DateTime(2000);
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isSaveEnable = false;
  final List<String> _genders = [
    "male",
    "female"
  ];

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
                controller: _nameController,
                maxLength: 40,
                decoration: const InputDecoration(hintText: "Name"),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                onChanged: (String? s) {
                  _validateButton();
                },
                textInputAction: TextInputAction.next,
                obscureText: false,
              ),
              TextFormField(
                controller: _surnameController,
                maxLength: 40,
                decoration: const InputDecoration(hintText: "Surname"),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                onChanged: (String? s) {
                  _validateButton();
                },
                textInputAction: TextInputAction.next,
                obscureText: false,
              ),
              TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  String email = value ?? "";
                  bool isValid = _validateEmail(email);
                  if (email != "" && !isValid) {
                    return "Email not correct";
                  } else {
                    return null;
                  }
                },
                onChanged: (String? s) {
                  _validateButton();
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
                          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                          style: const TextStyle(
                            fontSize: 20.0,
                          )),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  _isSaveEnable
                      ? _saveUserToDB()
                      : _infoPopup("Fill the form!");
                },
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
            MaterialPageRoute(builder: (context) => SecondRoute()),
          );
        },
        child: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  void _validateButton() {
    bool isValid = true;
    isValid = _nameController.text.isNotEmpty &&
        _surnameController.text.isNotEmpty &&
        _validateEmail(_emailController.text);
    setState(() {
      _isSaveEnable = isValid;
    });
    debugPrint("$_isSaveEnable");
  }

  bool _validateEmail(String email) {
    bool isValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_"
            r"`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return isValid;
  }

  _saveUserToDB() {
    DBDriver().insertUser(User(
        id: 0,
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        gender: _genders.indexOf(_gender),
        birthdate: _selectedDate));

    _nameController.clear();
    _surnameController.clear();
    _emailController.clear();
    setState(() {
      _gender = "male";
    });
    _selectedDate = DateTime(2000);
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
      });
    }
  }

  _infoPopup(String? info) {
    final snackBar = SnackBar(
      content: Text(info!,
        style: TextStyle(
          fontSize: 28.0,
          color: Colors.blue[800],
        ),
      ),
      backgroundColor: Colors.amber,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
