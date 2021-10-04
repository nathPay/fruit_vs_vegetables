# Fruit vs Vegetable

A cool afk fight game where you can smash vegetables!! 

## Skill points

**The player can distribute Skill Points to Health, Attack, Defense and Magik following the rules :**
- Health : increasing 1 Health Point costs 1 Skill Point regardless the Health Point amount

- Attack, Defense, Magik : increasing 1 Skill Point costs Skill's amount divided by 5 Skill Point, rounded at superior

    _**Example :**_ 

    - Health : 44, costs 1 Skill Point to increase to 45
    - Attack : 3, costs 1 Skill Point to increase to 4 
        _3 / 5 = 0.6 => 1 Skill Points_
    - Defense : 9, costs 2 Skill Points to increase to 10
        _9 / 5 = 1.8 => 2 Skill Points_
    - Magik : 32, costs 7 Skill Points to increase to 33
        _32 / 5 = 6.4 => 7 Skill Points_

- Skill Points can't be negative (minimum 0)
- Until validation a Skill Point assigned to a skill can be retrieved and reassigned.
- After validation, a Skill Point can't be retrieved

## Combat rules

**Fight are random turn based :**
- The player's character is the first character, the opponent is the second
- Each turn, both characters roll a dice with as many faces as the Attack's Skill Point amount, it's the Attack's value
    _**Example :**_
    - Gaston has 10 Skill Points in Attack
        - he launches a 1D10 dice (a.k.a. a dice with 10 faces : it results a number between 1 and 10)
    - Mathilda has 5 Skill Points in Attack
        - she launches a 1D5 dice (a.k.a. a dice with 5 faces : it results a number between 1 and 5)
    - _1D0 dice doesn't exist, result is always 0_
- The Attack's value are compared with Defense's Skill Point amount, if the difference is :
    - positive : Attack succeed
    - zero or negative : Attack failed
- When an Attack succeeds the difference is substracted from the opponent's Health Point
- If the difference equals Magik's Skill Point amount, this value is added to the difference
    _**Exemple :**
    - Player with Gaston launches the fight : Gaston will always play first
    - Gaston has 10 Skill Points in Attack, he launches 1D10 dice and obtains 10.
    - Gaston has 7 Skill Points in Magik.
    - Mathilda has 3 Skill Points in Defense, difference is 10 - 3 = 7, same value as Gaston's Magik Skill Points
    - Mathilda receives 7 + 7 = 14 damages, if she has 24 Health Skill Points : 24 - 14 = 10 remains
- Until a character's Health Point reaches 0 (or less), the fight continues.
- When a character has no more Health Point, fight is instantly finished.

## Fight result

**After each fight :**
- Health Points are restored
- when a character loses : it loose 1 rank
- when a character wins : it gains 1 Skill Point and 1 rank

## Getting Started

**Tested on Android only**

**init project with:** 
`flutter pub get`

**build with:**
`flutter build apk --split-per-abi`

apk output: `build/app/outputs/flutter-apk/`

**Firebase emulator (not mandatory, app is working in production)**

run:
`firebase emulators:start --import=./exports/`

## Technical Stack

Firebase:
- Auth
- Firestore
Flutter 2.5.1

## Feedback

### Change from the spec
- retrieve the list of fights ~~for a character~~ for all characters with the result (won/loose)
- No real lobby for the fight: 10 ennemies exists and they matchs with the same rank of the player. Player cannot pass rank 10.

### Issue with testing
I realized that I'm not experienced with testing in flutter at all, so it takes me a lot of time to produce test that are not working... 
Realizing that HookWidget doesn't work the way I tried to test them.
And realizing that Firebase emulators is not enough to test the app.