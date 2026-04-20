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

# Download
wget -N --content-disposition -O $FP_VSCODE_CLI $URL_VSCODE_CLI
#curl -Lk $URL_VSCODE_CLI --output $FP_VSCODE_CLI

if [ $? -ne 0 ]; then
    echo "Failed to download vscode CLI from $URL_VSCODE_CLI. Skipping download."
else
    echo "Download complete."
    tar -ztvf "$FP_VSCODE_CLI" > /dev/null 2>&1
    if [ $? -eq 0 -a -f "$FP_VSCODE_CLI" ]; then
        # Backup old version
        echo "Backing up old version to $HOME/code_old"
        rm -f $HOME/code_old
        mv $HOME/code $HOME/code_old

        # Extract new version
        echo "Extracting $(tar -xvf $FP_VSCODE_CLI --directory $HOME) to $HOME/code"
        echo "Done!"
    else
        echo "Failed to find or verify the tarball at $FP_VSCODE_CLI. Skipping extraction."
        echo "Will attempt to run old version if it exists."
    fi
fi

# Run
echo "Starting vsCode tunnel..."
tmux new-session -s $SESSION_NAME "$HOME/code tunnel --cli-data-dir .vscode_cli_data_dir_$(hostname)"
tmux ls
