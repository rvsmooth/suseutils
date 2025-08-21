#!/usr/bin/env python
from questionary import prompt
from sys import exit

question = [
    {
        "type": "checkbox",
        "name": "wm",
        "message": "What do you want?",
        "choices": ["hyprland", "niri", "qtile"],
    }
]

answers = prompt(question)

selection = list(answers["wm"])

if selection:
    print("You have selected", selection)
else:
    print("You haven't selected any WM")
    print("Aborting")
    exit(0)
