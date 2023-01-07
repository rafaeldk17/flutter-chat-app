

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_input.dart';
import '../widgets/labels_input.dart';
import '../widgets/logo_input.dart';

class LoginPage extends StatelessWidget {
   
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body:SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height+0.9,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
               
                const LogoInput(titulo: 'Messenger',),
                _Form(),
                const LabelsInput(
                  ruta: 'register', 
                  text1: '¿No tienes cuenta?', 
                  text2: 'Crea una ahora'
                ),
                const Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
        
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

        //TODO: Crear un boton
          BotonAzul(
            textBoton: 'Ingresar', 
            onPressed: authService.autenticando ? null : () async { 

              FocusScope.of(context).unfocus();

              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if (loginOk) {
                //TODO: conectar a nuestro socket server
                //Navegar a otra pantalla
                Navigator.pushReplacementNamed(context, 'usuarios');

              }else{
                //Mostrar alerta 
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales');
              }
            },
          ),
        ]
      ),
    );
  }
}
