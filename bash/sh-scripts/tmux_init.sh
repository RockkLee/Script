#!/bin/bash
# Create a new tmux session "terminal" in detached mode and add a new window
tmux new-session -d -s terminal
tmux new-window -t terminal

# Create a new tmux session "note" in detached mode and add a new window
tmux new-session -d -s note
tmux new-window -t note

# Create a new tmux session "ngrok" in detached mode
tmux new-session -d -s ngrok

# Optionally, attach to the "terminal" session
tmux attach-session -t terminal
