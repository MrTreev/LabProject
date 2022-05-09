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
  subprocess.call(['ffmpeg', '-i', 'original.mp4', '-an', '-r', '25', '-vf', 'crop=640:480', 'png/%05d.png'])

  print('Generating encoded files')
  os.mkdir('encoded')
  with os.scandir('png') as png_files:
    for png_file in png_files:
      img = cv.imread(png_file.path)
      encoded = (img[:, :, 2] >> 5 << 5) | (img[:, :, 1] >> 5 << 2) & 0b00011100 | (img[:, :, 0] >> 6) & 0b00000011
      cv.imwrite(os.path.join('encoded', png_file.name), encoded)

  shutil.rmtree('png')

if not os.path.exists('video.bin'):
  print('Generated concatenated binary')
  with open('video.bin', 'wb') as bin_file:
    with os.scandir('encoded') as encoded_files:
      for encoded_file in encoded_files:
        img = cv.imread(encoded_file.path, cv.IMREAD_UNCHANGED)
        bin_file.write(img.tobytes())
