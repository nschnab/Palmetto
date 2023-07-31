#!/bin/bash

source var.txt

find "$path0" -mindepth 1 -delete
find "$path1" -mindepth 1 -delete  
find "$path2" -mindepth 1 -delete
find "$path3" -mindepth 1 -delete
