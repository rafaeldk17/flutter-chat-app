


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/widgets/boton_azul.dart';
import '../widgets/custom_input.dart';
import '../widgets/labels_input.dart';
import '../widgets/logo_input.dart';

class RegisterPage extends StatelessWidget {
   
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body:SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height+0.9,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
               
                const LogoInput(titulo: 'Registro'),
                _Form(),
                const LabelsInput(
                  ruta: 'login', 
                  text1: '¿Tienes cuenta?', 
                  text2: 'Ingrasar con ella ahora'
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

  final nameCtrl  = TextEditingController();
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
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),


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
           BotonAzul(textBoton: 'Crear cuenta', onPressed: authService.autenticando ? null : () async { 
            print(nameCtrl.text);
            print(emailCtrl.text);
            print(passCtrl.text);

            final registroOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());

            if( registroOk == true) {
              Navigator.pushReplacementNamed(context, 'usuarios');
             

            }else {
              mostrarAlerta(context,'Registro incorrecto', registroOk.toString());
            }
          },),
        ]
      ),
    );
  }
}
