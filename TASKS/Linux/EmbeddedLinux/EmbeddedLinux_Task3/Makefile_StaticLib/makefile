CC=arm-cortexa9_neon-linux-musleabihf-
LibFlags=rcs
INCS=-I ./Includes
SRCDIR = Files.c
OBJDIR = Files.o
APPDIR = APP
StaticLibDir = StaticLib
SRC = $(wildcard $(SRCDIR)/*.c)
OBJ = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))
APP_NAME = main
LIB_NAME=TeraLib
ELF_NAME=mainstatic
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/eng-tera/x-tools/arm-cortexa9_neon-linux-musleabihf/bin

all: $(ELF_NAME).elf
	@echo "Build is done successfully [ Eng.TERA ]"
	
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(dir $@)
	$(CC)cc -c $(INCS) $< -o $@
	
StaticLib/$(LIB_NAME).a: $(OBJ)
	mkdir $(StaticLibDir)
	$(CC)ar $(LibFlags) $@ $(OBJ)
	
$(ELF_NAME).elf: $(StaticLibDir)/$(LIB_NAME).a
	$(CC)gcc -static $(APPDIR)/$(APP_NAME).c $(INCS) $(StaticLibDir)/$(LIB_NAME).a -o $@

clean:
	rm *.elf 
	rm -r $(StaticLibDir) $(OBJDIR)
	@echo "Directory is cleaned successfully [ Eng.TERA ]"
