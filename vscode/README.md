# Start VSCode
Download and start VsCode CLI in a tmux shell.
<br>By Ian Maquignaz, Feb. 2024

## Install
1. Clone the repository
1.1 Check `start_vscode.sh` has execution permission. If not, run:
    ```bash
        chmod u+x insert_your_path_to/bashtools/vscode/start_vscode.sh
    ```
2. [OPTIONAL] Create an alias
    1. Add the following line to your `.bashrc` file:
    ```bash
    alias code='insert_your_path_to/bashtools/vscode/start_vscode.sh'
    ```
    2. Run `source ~/.bashrc` to update the terminal

## Usage
```bash
bash start_vscode.sh # starts vscode CLI
./start_vscode.sh # starts vscode CLI

# [OPTIONAL] If you created an alias, you can run:
code # starts vscode CLI from ANY directory
```

