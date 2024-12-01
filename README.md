# Raphael's python virtual environment managing

First, choose a destination where all the python venvs will be located. In my case it is:
    /home/rapha/Downloads/Packages/python-venvs

I created a shell variable for it, called PYTHON_VENV_LOCATION, defined in the file my-pyenvs-config.sh

Then, create a base python environment. This will be the one for all your basic programming needs, so that it won't touch your system's python (which can break everything !). I created mine to be called "base", do what you want :D
    python -m venv base

    *ps: this was inside the python-venvs folder

### my-pyenvs-list.sh

In the way my script works, each environment will be defined by a string which is its own folder name. Running the my-pyenvs-list.sh script will list them all in alphabetical order, in addition to the system's python, which should always be the first.

ATTENTION: This command will not work if there are spaces in the folder names!!

This command will export a shell variable called ALL_PYTHON_ENVS_STR that can be used by the next script, that selects a python environment to use.

### my-pyenvs-select.sh

Takes the value from the MY_PYENV variable to select one of the environments found by the list command. If the variable is not defined, say an error, asking the user to define it first.
