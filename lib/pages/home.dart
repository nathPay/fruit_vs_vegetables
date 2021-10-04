import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../firebase/auth.dart';
import '../theme.dart';
import '../ui_components/@index.dart';

// Permit Sign in and Sign up
class Home extends HookWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final _mailController = useTextEditingController(text: '');
    final isMailValid = useState(true);
    final _passwordController = useTextEditingController(text: '');
    final isSomethingWrong = useState(false);
    final loading = useState(false);
    final emailRegex = RegExp(
      r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)',
    );

    return Scaffold(
      backgroundColor: mainTheme.colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Image.asset(
                      'assets/fruitvsvegetables.png',
                      semanticLabel: 'fruitvsvegetablesHome',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: mainTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Please sign in:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 15,
                                child: Container(
                                  child: TextField(
                                    controller: _mailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      border: OutlineInputBorder(),
                                      errorText: isMailValid.value ? null : '',
                                    ),
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (text) => {
                                      if (emailRegex.hasMatch(text) &&
                                          text.length > 5)
                                        {isMailValid.value = true}
                                      else
                                        {isMailValid.value = false}
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 15,
                                child: Container(
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      errorText:
                                          isSomethingWrong.value ? '' : null,
                                    ),
                                  ),
                                ),
                              ),
                              if (isSomethingWrong.value)
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Error on email or password',
                                    style: TextStyle(
                                      color: theme.error,
                                      fontSize: 10,
                                    ),
                                    semanticsLabel: 'somethingWrong',
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ActionButton(
                            label: 'SIGN IN',
                            disabled: loading.value && !isMailValid.value,
                            onTap: () => {
                              loading.value = true,
                              auth
                                  .signInWithEmailAndPassword(
                                    email: _mailController.text,
                                    password: _passwordController.text,
                                  )
                                  .then(
                                    (value) => Navigator.of(context)
                                        .pushReplacementNamed('/characterList'),
                                    onError: (e) => {
                                      debugPrint(e.toString()),
                                      isSomethingWrong.value = true,
                                      loading.value = false,
                                    },
                                  ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: ActionButton(
                      label: 'SIGN UP',
                      disabled: loading.value && !isMailValid.value,
                      onTap: () => {
                        loading.value = true,
                        auth
                            .createUserWithEmailAndPassword(
                              email: _mailController.text,
                              password: _passwordController.text,
                            )
                            .then(
                              (value) => Navigator.of(context)
                                  .pushReplacementNamed('/characterList'),
                              onError: (e) => {
                                debugPrint(e.toString()),
                                isSomethingWrong.value = true,
                                loading.value = false,
                              },
                            ),
                      },
                      state: ActionButtonState.NEUTRAL,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
