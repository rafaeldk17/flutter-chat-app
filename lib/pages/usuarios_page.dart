

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/usuario.dart';

class UsuariosPage extends StatelessWidget {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario( uid: '1', nombre: 'Maria',   email: 'test1"test.com', online: true ),
    Usuario( uid: '2', nombre: 'Jose',    email: 'test2"test.com', online: false ),
    Usuario( uid: '3', nombre: 'Antonio', email: 'test3"test.com', online: true ),
  ];
   
   UsuariosPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return  Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black87,), 
          onPressed: () {  
            //TODO: desconectarnos del socket server
            Navigator.pushReplacementNamed(context, 'login'); 
            AuthService.deleteToken();
          }, 
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only( right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400],),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        child: _listViewUsuarios(),
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
    physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_, i)=> Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}