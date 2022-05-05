#!/usr/bin/env python3
#
# Preview what an R3G3B2 encoded image is going to look like once restored.
#
import sys
import cv2 as cv
import numpy as np

encoded = cv.imread(sys.argv[1], cv.IMREAD_UNCHANGED)

decoded = np.ndarray((480, 640, 3), dtype = np.uint8)
decoded[:, :, 2] = encoded & 0b11100000
decoded[:, :, 1] = (encoded & 0b00011100) << 3
decoded[:, :, 0] = (encoded & 0b00000011) << 6

cv.imshow('Test', decoded)
cv.waitKey(0)
cv.destroyWindow('Test')
