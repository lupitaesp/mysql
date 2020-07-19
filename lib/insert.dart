import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Student.dart';
import 'package:flutter/material.dart';
import 'bd_connections.dart';



class insert extends StatefulWidget{
  _insert createState() => _insert();
}

class _insert extends State<insert>{
  List<Student> _Students;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstnameConroller;
  TextEditingController _lastname1Conroller;
  TextEditingController _lastname2Conroller;
  TextEditingController _emailConroller;
  TextEditingController _phoneConroller;
  TextEditingController _matriculaConroller;

  @override
  void initState() {
    super.initState();
    _Students = [];
    _scaffoldKey = GlobalKey();
    _firstnameConroller = TextEditingController();
    _lastname1Conroller = TextEditingController();
    _lastname2Conroller = TextEditingController();
    _emailConroller = TextEditingController();
    _phoneConroller = TextEditingController();
    _matriculaConroller = TextEditingController();
    //Llamar al método que llena la DataTable
    _selectData();
  }



  //******************************************************************
  //Métodos de manejar de la BD

  //Desplegar la snackbar
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  //Crear table
  _createTable() {
    BDConnections.createTable().then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
      }
    });
  }

  //Add data
  _insertData() {
    if (_firstnameConroller.text.isEmpty || _lastname1Conroller.text.isEmpty || _lastname2Conroller.text.isEmpty || _emailConroller.text.isEmpty || _phoneConroller.text.isEmpty || _matriculaConroller.text.isEmpty) {
      print("Empy fields");
      return;
    }
    BDConnections.insertData(_firstnameConroller.text, _lastname1Conroller.text, _lastname2Conroller.text, _emailConroller.text, _phoneConroller.text, _matriculaConroller.text)
        .then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
        _firstnameConroller.text = "";
        _lastname1Conroller.text = "";
        _lastname2Conroller.text = "";
        _emailConroller.text = "";
        _phoneConroller.text = "";
        _matriculaConroller.text = "";
        //Llamar la consulta general
        _selectData();
      }
    });
  }

  _selectData() {
    BDConnections.selectData().then((students) {
      setState(() {
        _Students = students;
      });
      //Verificar si tenemos algo de retorno
      _showSnackBar(context, "Data Acquired");
      print("size of Students ${students.length}");
    });
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("MySQL remote BD Operations"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              BDConnections.createTable();
            },),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: (){
              BDConnections.selectData();
            },)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(controller: _firstnameConroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Student Name"),
                    )
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _lastname1Conroller,
                        decoration: InputDecoration.collapsed(hintText: "Last Name 1"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _lastname2Conroller,
                        decoration: InputDecoration.collapsed(hintText: "Last Name 2"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _emailConroller,
                        decoration: InputDecoration.collapsed(hintText: "E-mail"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _phoneConroller,
                        decoration: InputDecoration.collapsed(hintText: "Phone"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _matriculaConroller,
                        decoration: InputDecoration.collapsed(hintText: "Matricula"),)
                  ),
                ],),
              ),
            //  Expanded(
              //  child: _body(),
              //),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _insertData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}