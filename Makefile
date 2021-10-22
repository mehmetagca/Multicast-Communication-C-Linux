
# source, executable, includes, library defines
SRC		= $(wildcard *.c)
OBJ		:= $(SRC:.c=.o)
LIBS		= 
INC		= 
EXE_CLIENT	= mcast_client
EXE_SERVER	= mcast_server
RM		= /bin/rm

# compiler, linker defines
CCARCH		:= #arm-hisiv500-linux-# toolchain
CC		:= $(CCARCH)gcc
#AR		:= $(CCARCH)ar
CFLAGS		+= $(foreach dir, $(INC), -I$(dir))
LDFLAGS		+= -L. $(LIBS)

all: $(EXE_CLIENT) $(EXE_SERVER)

# link all object files with external libraries into binaries
$(EXE_CLIENT): $(OBJ)
	$(CC) $(findstring $@.o,$(OBJ)) $(LDFLAGS) -o $(EXE_CLIENT)

$(EXE_SERVER): $(OBJ)
	$(CC) $(findstring $@.o, $<) $(LDFLAGS) -o $(EXE_SERVER)


# compile and assemble C source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# create library file
# $(ARLIB): $(OBJ)
#		$(AR) -rc $@ $(OBJ)


# clean up objects, executables, dumps out of source directory
clean:
	$(RM) $(OBJ) $(EXE_CLIENT) $(EXE_SERVER) -f
