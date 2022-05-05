#!/usr/bin/env python3
#
# Generated images encoded in R3G3B2 format.
#
import os
import shutil
import subprocess
import cv2 as cv

if not os.path.exists('original.mp4'):
  exit(1)

if not os.path.exists('encoded'):
  os.mkdir('png')
  subprocess.call(['ffmpeg', '-i', 'original.mp4', '-an', '-r', '60', '-vf', 'crop=640:480', 'png/%05d.png'])

  os.mkdir('encoded')
  with os.scandir('png') as png_files:
    for png_file in png_files:
      img = cv.imread(png_file.path)
      encoded = (img[:, :, 2] >> 5 << 5) | (img[:, :, 1] >> 5 << 2) & 0b00011100 | (img[:, :, 0] >> 6) & 0b00000011
      cv.imwrite(os.path.join('encoded', png_file.name), encoded)

  shutil.rmtree('png')
