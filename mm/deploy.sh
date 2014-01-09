#!/bin/bash
rsync -avz --del -e ssh build/ root@flyingindreams.com:/var/deploy/flyingindreams.com/
