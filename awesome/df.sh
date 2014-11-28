#!/bin/bash

echo -e "Root:\t" $(df -h / | tail -n1 | awk '{print $4}')
echo -e "Home:\t" $(df -h /home| tail -n1 | awk '{print $4}')
