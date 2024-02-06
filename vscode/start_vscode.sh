#!/bin/bash

# Downloads & runs VScode
# See: https://code.visualstudio.com/docs/remote/tunnels

SESSION_NAME="VSCODE_TUNNEL"
FP_VSCODE_CLI="$HOME/vscode_x64_cli.tar.gz"

# Previous vscode CLI release
#URL_VSCODE_CLI='https://update.code.visualstudio.com/1.85.2/cli-linux-x64/stable'

# Latest vscode CLI release
URL_VSCODE_CLI='https://update.code.visualstudio.com/latest/cli-linux-x64/stable'


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
