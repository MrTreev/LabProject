#!/usr/bin/env python3

import sys
import cv2 as cv

if len(sys.argv) != 3:
  print("png2bin.py <in file> <out file>")
  exit(1)

img = cv.imread(sys.argv[1], cv.IMREAD_UNCHANGED)
img = img[:, :, [2, 1, 0]] # convert BGR to RGB
with open(sys.argv[2], 'wb') as bin_file:
  bin_file.write(img.tobytes())
