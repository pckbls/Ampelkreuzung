#!/bin/bash

fpc -Fu'/usr/lib/lazarus/lcl/units/i386-linux;/usr/lib/lazarus/lcl/units/i386-linux/gtk2;/usr/lib/lazarus/packager/units/i386-linux;entities' \
	-dLCL -dLCLgtk2 main.pas || exit 1

./main
