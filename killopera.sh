#!/bin/bash
kill `ps -ef | grep -v grep | grep opera | awk '{print $2}'`
