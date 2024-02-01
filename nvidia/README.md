# GPUKILL
Kill GPU processes that you control.
<br>By Ian Maquignaz, Feb. 2024
## Install
1. Clone the repository
1.1 Check `gpukill.sh` has execution permission. If not, run:
    ```bash
        chmod u+x insert_your_path_to/bashtools/nvidia/gpukill.sh
    ```
2. Add the following line to your `.bashrc` file:
    ```bash
    alias gpukill='insert_your_path_to/bashtools/nvidia/gpukill.sh'
    ```
3. Run `source ~/.bashrc` to update the terminal

## Usage
```bash
gpukill # does nothing
gpukill 0 1 2 # kills processes on GPU 0, 1, and 2
gpukill 0 -s9 # kills all processes on GPU 0 with signal 9
gpukill -a # kills all processes on all GPUs
gpukill -a -s9 # kills all processes on all GPUs with signal 9
```