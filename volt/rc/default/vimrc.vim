if exists('$SUDO_USER')
  finish
endif

call my#rc#load()
