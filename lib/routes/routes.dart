


import 'package:flutter/material.dart';

import '../pages/chat_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/usuarios_page.dart';

final Map<String, WidgetBuilder> appRoutes = {

  'usuarios': (_) => UsuariosPage(),
  'register': (_) => RegisterPage(),
  'login'   : (_) => LoginPage(),
  'chat'    : (_) => ChatPage(),
  'loading' : (_) => LoadingPage(),

};