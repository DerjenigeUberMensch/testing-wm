# compiler 
# side note clang doesnt work with -flto for some reason
CC = cc

# paths
PREFIX = /usr/local/
MANPREFIX = ${PREFIX}/share/man

# includes and libs
INCS = `pkg-config --cflags --libs xcb` -lxcb-util -lxcb-icccm -lxcb-keysyms
LIBS =  ${INCS}

#X86 isnt explicitly supported and some code might need to be tweaked
# Mainly the lbmi2 thing where its only used for resizing an icon so you can just not resize icons and remove that
X86 = -m32
X32 = -m32
X64 = -march=x86-64 -mtune=generic
CCVERSION = -std=c99
XNATIVE = -march=native -mtune=native
# Some libraries dont have static linking for some reason??
STATICLINK = -static
DYNAMICLINK= -ldl
SECTIONCODE= -ffunction-sections -fdata-sections
DEBUGFLAGS = -ggdb -g -pg ${CCVERSION} ${WARNINGFLAGS} ${INCS} ${CPPFLAGS} ${BINARY} ${SECTIONCODE}

WARNINGFLAGS = -pedantic -Wall -Wno-deprecated-declarations -Wshadow -Wuninitialized
LINKTIMEOPTIMIZATIONS = -flto
PRELINKERFLAGS = -fprefetch-loop-arrays ${LINKTIMEOPTIMIZATIONS} -fstack-protector-strong -pie -Wl,-z,relro,-z,now,-z,noexecstack,-z,defs
# can set higher but function overhead is pretty small so meh
INLINELIMIT = 15
LINKERFLAGS = ${DYNAMICLINK} -Wl,--gc-sections,--as-needed,--relax,--strip-all -finline-functions -finline-limit=${INLINELIMIT}  ${LINKTIMEOPTIMIZATIONS} -fstack-protector-strong -pie -Wl,-z,relro,-z,now,-z,noexecstack,-z,defs

BINARY = ${X64}
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=200809L ${XINERAMAFLAGS}
CCFLAGS  = ${CCVERSION} ${WARNINGFLAGS} ${INCS} ${CPPFLAGS} ${BINARY} ${PRELINKERFLAGS} ${SECTIONCODE} 
RELEASEFLAGS = ${CCFLAGS} 

DEBUG 	= ${DEBUGFLAGS} -O0

SIZE  	= ${RELEASEFLAGS} -Os
# This rarely saves a substantial amount of instructions
SIZEONLY= ${RELEASEFLAGS} -Oz

# Release Stable (-O2)
RELEASE = ${RELEASEFLAGS} -O2
# Release Speed (-O3)
RELEASES= ${RELEASEFLAGS} -O3 

# Build using cpu specific instruction set for more performance (Optional)
BUILDSELF = ${RELEASEFLAGS} ${XNATIVE} -O3

# Set your options or presets (see above) ex: ${PRESETNAME} (Compiler used is on top)
CFLAGS = ${RELEASES}

CMACROS = 

ifeq ($(CFLAGS), $(DEBUG)) 
	LINKERFLAGS = ${DYNAMICLINK} -Wl,--gc-sections
	CMACROS += -DENABLE_DEBUG=\"\"
endif


# Linker flags
LDFLAGS =  ${LIBS} ${LINKERFLAGS} ${BINARY} 
# Solaris
#CFLAGS  = -fast ${INCS} -DVERSION=\"${VERSION}\"
