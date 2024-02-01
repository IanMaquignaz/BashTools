#!/bin/bash

# Downloads & runs VScode
# See: https://code.visualstudio.com/docs/remote/tunnels

SESSION_NAME="VSCODE_TUNNEL"
FP_VSCODE_CLI="$HOME/vscode_cli_alpine_x64_cli.tar.gz"
URL_VSCODE_CLI='https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64'

# Kill Old vscode server(s)
tmux kill-session -t $SESSION_NAME

# Delete old version
rm -f $HOME/code

# Download
wget -N --content-disposition -O $FP_VSCODE_CLI $URL_VSCODE_CLI 
#curl -Lk $URL_VSCODE_CLI --output $FP_VSCODE_CLI

if [ -f "$FP_VSCODE_CLI" ]; then
    echo "Extracting..."
    # Extract
    tar -xvf $FP_VSCODE_CLI --directory $HOME
else
    echo "Failed find tarball at $FP_VSCODE_CLI. Skipping extraction."
fi

# Run
echo "Starting vsCode tunnel..."
tmux new-session -s $SESSION_NAME "$HOME/code tunnel"
tmux ls
