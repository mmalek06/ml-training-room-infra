#!/bin/bash
IP=$(curl -s https://ifconfig.me)

echo "{\"ip\":\"$IP\"}"
