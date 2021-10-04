import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import '../firebase/@index.dart';
import '@index.dart';
import 'package:provider/provider.dart';

// Interface for creating New character
class CharacterBuilder extends HookWidget {
  const CharacterBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final _nameController = useTextEditingController(text: '');
    final isNameFilled = useState(false);
    final carouselPage = useState(0);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 5.0,
              blurRadius: 40.0,
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: CharacterSelector(
                  page: carouselPage,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        maxLength: 12,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Character name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (text) => {
                          isNameFilled.value = text.length != 0,
                        },
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children:
                                    ['Health:', 'Attack:', 'Defense:', 'Magik:']
                                        .map(
                                          (item) => Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: theme.onPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: ['10', '0', '0', '0']
                                    .map(
                                      (item) => Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              color: theme.onPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ActionButton(
                  label: 'create',
                  disabled: _nameController.value.text == '' ? true : false,
                  onTap: () => {
                    Provider.of<CharacterNotifier>(context, listen: false)
                        .createCharacter(
                          auth.currentUser!.uid,
                          _nameController.value.text,
                          carouselPage.value + 1,
                        )
                        .then(
                          (value) => Navigator.of(context).pop(),
                        ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
