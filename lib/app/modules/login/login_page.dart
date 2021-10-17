import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testeframework/app/modules/home/home_page.dart';
import 'package:testeframework/app/shared/widgets/container_text_field.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            
            Positioned(
              left: 20,
              top: 100,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 200),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(52),
                  topRight: Radius.circular(52)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ContainerTextField(
                    padding: 15,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'e-mail',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(Icons.email)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ContainerTextField(
                    padding: 15,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'senha',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CupertinoButton(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(32),
                      child: Text('Entrar'), 
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => HomePage())
                        );
                      }
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}