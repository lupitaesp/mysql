import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Student.dart';
import 'package:flutter/material.dart';
import 'bd_connections.dart';
import 'insert.dart';

class homepage extends StatefulWidget {
  homepage() : super();
  final String title = "MySQL BD Connection";

  @override
  homepageState createState() => homepageState();
}

class homepageState extends State<homepage> {
  List<Student> _Students;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstnameConroller;
  TextEditingController _lastname1Conroller;
  TextEditingController _lastname2Conroller;
  TextEditingController _emailConroller;
  TextEditingController _phoneConroller;
  TextEditingController _matriculaConroller;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

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
  void refreshList() {
    setState(() {
       BDConnections.selectData();
    });
  }

  //******************************************************************

  //************************Creating Body*****************************
  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Last Name 1')),
          DataColumn(label: Text('Last Name 2')),
          DataColumn(label: Text('E-mail')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Matricula')),
        ],
        rows: _Students.map((student) => DataRow(
            cells: [
              //COMO ESTA EN EL ARCHIVO STUDENT.DART
              DataCell(Text(student.id)),
              DataCell(Text(student.firstName.toUpperCase())),
              DataCell(Text(student.lastName1.toUpperCase())),
              DataCell(Text(student.lastName2.toUpperCase())),
              DataCell(Text(student.email.toUpperCase())),
              DataCell(Text(student.phone.toUpperCase())),
              DataCell(Text(student.matricula.toUpperCase())),
            ]),
        ).toList(),
      ),
    );
  }

  //******************************************************************
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
              refreshList();
            },)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Center(
                child: Text(
                  "MENU",
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            ListTile(
              leading: Icon(Icons.add, color: Colors.blue),
              title: Text('INSERTAR DATOS'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => insert()));
              },
            ),
            ListTile(
              leading: Icon(Icons.update, color: Colors.blue),
              title: Text('ACTUALIZAR DATOS'),
             /* onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Update()));
              },*/
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.blue),
              title: Text('BUSCAR DATOS'),
             /* onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Select()));
              },*/
            ),
            ListTile(
              leading: Icon(Icons.refresh, color: Colors.blue),
              title: Text('CONSULTAR REGISTROS'),
             /* onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => busqueda()));
              },*/
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.blue),
              title: Text('ELIMINAR DATOS'),
             /* onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => eliminar()));
              },*/
            ),
          ],
        ),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            _body(),
          ],
        ),
      ),
    );
  }

  _snack(BuildContext context, String texto) {
    final snackbar = SnackBar(
      content: new Text(texto),
      backgroundColor: Colors.deepPurple,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
