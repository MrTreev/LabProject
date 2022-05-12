#!/usr/bin/env python3
#
# Generated raw binary video.
#
import os
import shutil
import subprocess
import cv2 as cv
import numpy as np

if not os.path.exists('original.mp4'):
  exit(1)

if not os.path.exists('png'):
  os.mkdir('png')
  subprocess.call(['ffmpeg', '-i', 'original.mp4', '-an', '-r', '5', '-s', '160x120', '-vf', 'crop=640:480', 'png/%05d.png'])

if not os.path.exists('video.bin'):
  print('Generating concatenated binary')
  with open('video.bin', 'wb') as bin_file:
    for png_file in sorted(os.listdir('png')):
      img = cv.imread(os.path.join('png', png_file), cv.IMREAD_UNCHANGED)
      img_pad = np.pad(img, ((0, 0), (0, 0), (0, 1)), constant_values=255)
      bin_file.write(img_pad.tobytes())
