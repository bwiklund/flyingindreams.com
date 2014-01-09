#!/bin/bash
cd mm && middleman build && \
rsync -avz --del -e ssh build/ root@flyingindreams.com:/var/deploy/flyingindreams.com/
