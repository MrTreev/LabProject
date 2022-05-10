#!/usr/bin/env python3
#
# Generated raw binary video.
#
import os
import shutil
import subprocess
import cv2 as cv

if not os.path.exists('original.mp4'):
  exit(1)

if not os.path.exists('png'):
  os.mkdir('png')
  subprocess.call(['ffmpeg', '-i', 'original.mp4', '-an', '-r', '5', '-s', '160x120', '-vf', 'crop=640:480', 'png/%05d.png'])

if not os.path.exists('video.bin'):
  print('Generating concatenated binary')
  with open('video.bin', 'wb') as bin_file:
    with os.scandir('png') as png_files:
      for png_file in png_files:
        img = cv.imread(png_file.path, cv.IMREAD_UNCHANGED)
        bin_file.write(img.tobytes())
