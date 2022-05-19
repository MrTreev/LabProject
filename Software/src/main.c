#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/time.h>

#define FB_WIDTH 160
#define FB_HEIGHT 120

#define FPGA_ADDR_BASE 0x3F000000 // TODO
#define FB_ADDR_OFFSET 0x0 // TODO

// TODO
enum hdmi_i2c_reg {
  HDMI_I2C_CR = 0x00,
  HDMI_I2C_DR = 0x01,
};

int main(int argc, char** argv) {
  (void) argc;
  (void) argv;
  
  printf("Initializing...\n");

  char* video_file_name = NULL;

  int optc;
  while ((optc = getopt(argc, argv, "d:")) != -1) {
    switch (optc) {
      case 'd':
        video_file_name = optarg;
        break;
      case '?':
        exit(1);
        break;
      default:
        ;
    }
  }

  if (video_file_name == NULL) {
    fprintf(stderr, "Video file name unspecified\n");
    exit(1);
  }

  // Open video file
  FILE* video = fopen(video_file_name, "r");
  if (video == NULL) {
    fprintf(stderr, "fopen(\"%s\"): %s\n", video_file_name, strerror(errno));
    exit(1);
  }

  // Map memory from AXI
  int mem = open("/dev/mem", O_RDWR | O_SYNC);
  if (mem == -1) {
    fprintf(stderr, "open: %s\n", strerror(errno));
    exit(-1);
  }
  uint8_t* fpga_shmem = mmap(NULL, FB_WIDTH * FB_HEIGHT, PROT_READ | PROT_WRITE, MAP_SHARED, mem, FPGA_ADDR_BASE);
  if (fpga_shmem == MAP_FAILED) {
    fprintf(stderr, "mmap: %s\n", strerror(errno));
    exit(-1);
  }
  close(mem);

  // Setup HDMI via I2C
  // TODO

  // Front & back buffer
  uint8_t* fb_front = fpga_shmem + FB_ADDR_OFFSET;
  uint8_t* fb_back = malloc(FB_WIDTH * FB_HEIGHT);

  // SIGALRM every 40ms (25Hz)
  sigset_t sigset_alarm;
  sigemptyset(&sigset_alarm);
  sigaddset(&sigset_alarm, SIGALRM);
  sigprocmask(SIG_BLOCK, &sigset_alarm, NULL);
  ualarm(40000, 40000);
  
  // Main loop
  while (true) {
    if (fread(fb_back, 1, FB_WIDTH * FB_HEIGHT, video) != FB_WIDTH * FB_HEIGHT) {
      if (feof(video)) {
        // Loop video
        clearerr(video);
        rewind(video);
        continue;
      } else {
        fprintf(stderr, "File read error\n");
        exit(-1);
      }
    }

    // Wait for time for next frame
    sigwaitinfo(&sigset_alarm, NULL);

    printf("Displaying a frame\n");
    //memcpy(fb_front, fb_back, FB_WIDTH * FB_HEIGHT);
  }
}
