#!/bin/sh
# Base16 material - Shell color setup script
# Sean Washington (http://seanwash.com)

set color00 "263238" # Base 00 - Black
set color01 "cc6666" # Base 08 - Red
set color02 "b5bd68" # Base 0B - Green
set color03 "f0c674" # Base 0A - Yellow
set color04 "81a2be" # Base 0D - Blue
set color05 "b294bb" # Base 0E - Magenta
set color06 "8abeb7" # Base 0C - Cyan
set color07 "ecefef" # Base 05 - White
set color08 "707880" # Base 03 - Bright Black
set color09 $color01 # Base 08 - Bright Red
set color10 $color02 # Base 0B - Bright Green
set color11 $color03 # Base 0A - Bright Yellow
set color12 $color04 # Base 0D - Bright Blue
set color13 $color05 # Base 0E - Bright Magenta
set color14 $color06 # Base 0C - Bright Cyan
set color15 "ffffff" # Base 07 - Bright White
set color16 "cc6666" # Base 09
set color17 "cc6666" # Base 0F
set color18 "263238" # Base 01
set color19 "37474f" # Base 02
set color20 "b5bd68" # Base 04
set color21 "ecefef" # Base 06

# 16 color space
printf "\e]P0$color00\e\\"
printf "\e]P1$color01\e\\"
printf "\e]P2$color02\e\\"
printf "\e]P3$color03\e\\"
printf "\e]P4$color04\e\\"
printf "\e]P5$color05\e\\"
printf "\e]P6$color06\e\\"
printf "\e]P7$color07\e\\"
printf "\e]P8$color08\e\\"
printf "\e]P9$color09\e\\"
printf "\e]PA$color10\e\\"
printf "\e]PB$color11\e\\"
printf "\e]PC$color12\e\\"
printf "\e]PD$color13\e\\"
printf "\e]PE$color14\e\\"
printf "\e]PF$color15\e\\"

# 256 color space
if [ "$TERM" != "linux" ]
  printf "\e]4;16;rgb:$color16\e\\"
  printf "\e]4;17;rgb:$color17\e\\"
  printf "\e]4;18;rgb:$color18\e\\"
  printf "\e]4;19;rgb:$color19\e\\"
  printf "\e]4;20;rgb:$color20\e\\"
  printf "\e]4;21;rgb:$color21\e\\"
end
