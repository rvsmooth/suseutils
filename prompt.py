#!/usr/bin/env python

from prompt_toolkit.formatted_text import HTML
from prompt_toolkit.shortcuts import checkboxlist_dialog, message_dialog
from prompt_toolkit.styles import Style

results = checkboxlist_dialog(
    title="Choose your window manager",
    text="What would you like in your breakfast ?",
    values=[
        ("hyprland", "Hyprland"),
        ("qtile", "QTile"),
        ("niri", "Niri"),
    ],
    style=Style.from_dict(
        {
            "dialog": "bg:#191724",
            "button": "bg:#bf99a4",
            "checkbox": "#dfdad9",
            "dialog.body": "bg:#b4637a",
            "dialog shadow": "bg:#c98982",
            "frame.label": "#dfdad9",
            "dialog.body label": "#dfdad9",
        }
    ),
).run()
if results:
    message_dialog(
        title="Room service",
        text="You selected: {}\nGreat choice sir !".format(",".join(results)),
    ).run()
else:
    message_dialog(
        title="You Haven't Selected Anything!!",
        text="Aborting!!"
    ).run()
    exit(0)

