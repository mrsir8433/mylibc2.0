########################################################################
####################### Makefile Template ##############################
########################################################################

# Compiler settings - Can be customized.
CC = gcc
CXXFLAGS = -std=c11 -Wall -g
LDFLAGS = -lm

# Makefile settings - Can be customized.
APPNAME = main
EXT = .c
SRCDIR = ./src
OBJDIR = ./obj
DEPDIR = ./dep

############## Do not change anything from here downwards! #############
SRC = $(shell find $(SRCDIR) -name *$(EXT))
OBJ = $(SRC:$(SRCDIR)/%$(EXT)=$(OBJDIR)/%.o)
DEP = $(OBJ:$(OBJDIR)/%.o=$(DEPDIR)/%.d)
# UNIX-based OS variables & settings
RM = rm
DELOBJ = $(OBJ)
MKDIR_P = mkdir -p
# Windows OS variables & settings
DEL = del
EXE = .exe
WDELOBJ = $(SRC:$(SRCDIR)/%$(EXT)=$(OBJDIR)\\%.o)

########################################################################
####################### Targets beginning here #########################
########################################################################

.PHONY:all run clean fullclean cleandep cleanw cleandepw


all: $(APPNAME)

run: all
	./$(APPNAME).exe


# Builds the app
$(APPNAME): $(OBJ)
	$(CC) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# Creates the dependecy rules
$(DEPDIR)/%.d: $(SRCDIR)/%$(EXT)
	@$(MKDIR_P) $(dir $@)
	@$(CPP) $(CFLAGS) $< -MM -MT $(@:%.d=%.o) >$@

# Includes all .h files
-include $(DEP)

# Building rule for .o files and its .c/.cpp in combination with all .h
$(OBJDIR)/%.o: $(SRCDIR)/%$(EXT)
	@$(MKDIR_P) $(dir $@)
	$(CC) $(CXXFLAGS) -o $@ -c $<

################### Cleaning rules for Unix-based OS ###################
# Cleans complete project
clean:
	@$(RM) -f $(DELOBJ) $(DEP) $(APPNAME)

fullclean:
	@$(RM) -f $(DELOBJ) $(DEP) $(APPNAME)
	@$(RM) -r ./dep ./obj

# Cleans only all files with the extension .d
cleandep:
	$(RM)  -f $(DEP)

#################### Cleaning rules for Windows OS #####################
# Cleans complete project
cleanw:
	$(DEL) $(WDELOBJ) $(DEP) $(APPNAME)$(EXE)

# Cleans only all files with the extension .d
cleandepw:
	$(DEL) $(DEP)