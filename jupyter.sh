#!/usr/bin/env bash

jupass=`python -c 'import IPython; import sys; print IPython.lib.passwd("'$1'")'`
echo "\"jupyter notebook\" will start Jupyter on port 8888"
echo "If you get an error instead, try restarting your session so your $PATH is updated"
jupyter notebook --notebook-dir=/root/ --allow-root --ip 0.0.0.0 --port 8888 --NotebookApp.ip='*' --no-browser --NotebookApp.password=$jupass
