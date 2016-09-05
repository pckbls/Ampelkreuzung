#!/bin/bash

fpc -Fu'/usr/lib/lazarus/lcl/units/x86_64-linux;/usr/lib/lazarus/lcl/units/x86_64-linux/gtk2;/usr/lib/lazarus/packager/units/x86_64-linux;/usr/lib/lazarus/components/lazutils/lib/x86_64-linux;entities' \
	-dLCL -dLCLgtk2 main.pas || exit 1

./main
