CC=arm-cortexa9_neon-linux-musleabihf-
LibFlags=-Wall -fPIC 
INCS=-I ./Includes
SRCDIR = Files.c
OBJDIR = Files.o
APPDIR = APP
DynamicLibDir = DynamicLib
SRC = $(wildcard $(SRCDIR)/*.c)
OBJ = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))
APP_NAME = main
LIB_NAME=libTERA
ELF_NAME=maindynamic
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/eng-tera/x-tools/arm-cortexa9_neon-linux-musleabihf/bin

all: $(ELF_NAME).elf
	@echo "Build is done successfully [ Eng.TERA ]"
	
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(dir $@)
	$(CC)cc -c $(INCS) $(LibFlags) $< -o $@
	
DynamicLib/$(LIB_NAME).so: $(OBJ)
	mkdir $(DynamicLibDir)
	$(CC)cc -shared $(OBJ) -o $@ 
	
$(ELF_NAME).elf: $(DynamicLibDir)/$(LIB_NAME).so
	$(CC)gcc $(APPDIR)/$(APP_NAME).c $(INCS) -L./$(DynamicLibDir) -lTERA -o $@

clean:
	rm *.elf 
	rm -r $(DynamicLibDir) $(OBJDIR)
	@echo "Directory is cleaned successfully [ Eng.TERA ]"
