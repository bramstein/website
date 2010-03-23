#!/bin/sh

rsync --verbose --progress -stats --compress --recursive -e ssh -a output/ nfs:/home/public/
