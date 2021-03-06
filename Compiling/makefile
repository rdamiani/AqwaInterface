#================================================================================#
# This makefile created by B. Jonkman on 1-Jul-2014,                             #
# adapted from FAST (M. Buhl on 25-Jan-2013).                                    #
# (c) 2014 National Renewable Energy Laboratory                                  #
#                                                                                #
#                                                                                #
#================================================================================#

   # 32-bit or 64-bit?
BITS = 32
#BITS = 64

#OS=lin


   # Name of compiler to use and flags to use.
FC      = gfortran

FFLAGS  = -O2 -m$(BITS) -fbacktrace -ffree-line-length-none -x f95-cpp-input -C -DNO_LibLoad -DMESH_DEBUG
LDFLAGS = -O2 -m$(BITS) -fbacktrace -g -fno-inline
# some useful gfortran options:
#  -DFPE_TRAP_ENABLED
#  -Wl,--large-address-aware   # not necessary when $(BITS) is 64 (64-bit target)
#  -Wl,--stack=999999999       # not necessary when $(BITS) is 64
#  -Wconversion-extra -Wconversion
#  -fdefault-real-8 -fcheck=bounds,do,mem,pointer -std=f2003 -O0 -v -Wall
# http://gcc.gnu.org/onlinedocs/gfortran/Option-Index.html#Option-Index
#
# makefile:
# --warn-undefined-variables



   # Location of source files for AqwaInterface, NWTC Library, and the FAST Registry.
   # You will probably need to change these for your system.


ifeq ($(OS),Windows_NT)
# anything used in the "del_cmd" on clean cannot have the back slash:
   RegistryProgram   = C:/Users/bjonkman/Documents/DATA/DesignCodes/simulators/FAST/SVNdirectory/branches/BJonkman/bin/Registry_win32.exe
   NWTC_Lib_DIR      = ../Source/dependencies/NWTC_Library
   NETLIB_DIR        = $(NWTC_Lib_DIR)/dependencies/lapack
   Aqwa_DIR           = ../Source
   LDFLAGS          := $(LDFLAGS) -llapack -lblas -LC:/LAPACK/win32
   DEST_DIR          = ../bin

else
   DEST_DIR          = ../bin

#   ifeq ($(HOSTNAME), aplatt-21809s)
      SoftwareDir       = /Users/aplatt/software-development/windsvn
      RegistryProgram   = $(SoftwareDir)/FAST/branches/FAST_Registry/registry.exe
      NWTC_Lib_DIR      = $(SoftwareDir)/NWTC_Library/trunk/source/
      Aqwa_DIR           = /Users/aplatt/software-development/wind-dev/AqwaInterface/trunk/Source
		NETLIB_DIR 			:= \
			$(SoftwareDir)/NWTC_Library/branches/NetLib/NWTC_Source/                    	\
			$(SoftwareDir)/NWTC_Library/branches/NetLib/scalapack/scalapack-2.0.2/SRC/    \
			$(SoftwareDir)/NWTC_Library/branches/NetLib/fftpack
			# Mac flag requirement
	# Mac needs some additional flags prepended for linking to get lapack working, hence the funny notation here.
		LDFLAGS := -framework Accelerate $(LDFLAGS)


#   else
#      RegistryProgram   = registry.exe
#      NWTC_Lib_DIR      = $(FAST_DIR)/dependencies/NWTC_Library
#      Aqwa_DIR           = $(FAST_DIR)/dependencies/AqwaInterface
#   endif
endif

RegistryNWTC      = $(NWTC_Lib_DIR)         # Location of the Registry_NWTC_Library.txt file
RegistryDIR       = $(Aqwa_DIR)/Registry
Driver_DIR        = $(Aqwa_DIR)/Driver
OUTPUT_NAME       = AqwaDriver



   #==========================================================#
   # You should not need to change anything beyond this point #
   #==========================================================#

   # System-specific settings.

ifeq ($(OS),Windows_NT)
      # Windows
   DEL_CMD   = del
   EXE_EXT   = _gwin$(BITS).exe
   INTER_DIR = Obj_win$(BITS)
   MD_CMD    = @mkdir
   CP_CMD    = copy
   OBJ_EXT   = .obj
   PATH_SEP  = \\
   SYS_FILE  = SysGnuWin
else
      # Linux or Mac
   DEL_CMD   = rm -f
   EXE_EXT   = _glin$(BITS)
   INTER_DIR = Obj_lin$(BITS)
   MD_CMD    = @mkdir -p
   CP_CMD    = cp
   OBJ_EXT   = .o
   PATH_SEP  = /
   SYS_FILE  = SysGnuLinux
endif


   # Source files (by module)

LIB_SOURCES =           	\
	SingPrec.f90        	   \
	NWTC_Base.f90        	\
	$(SYS_FILE).f90      	\
	NWTC_Library_Types.f90 	\
	NWTC_IO.f90          	\
	NWTC_Num.f90         	\
	ModMesh_Types.f90    	\
	ModMesh.f90          	\
	ModMesh_Mapping.f90  	\
	NWTC_Library.f90

NETLIB_SOURCES :=          \
	NWTC_LAPACK.f90

Aqwa_SOURCES =              \
	AqwaInterface_Types.f90    \
	AqwaInterface.F90



Driver_SOURCES =                 \
	AqwaDriver.f90         \
	AqwaDriver_Types.f90   \
	AqwaDriver_Subs.f90



vpath %.f90 $(NWTC_Lib_DIR) $(Aqwa_DIR) $(Driver_DIR) $(RegistryDIR) $(NETLIB_DIR)
vpath %.f 	$(NETLIB_DIR)
vpath %.mod $(INTER_DIR)
vpath %$(OBJ_EXT) $(INTER_DIR)
vpath %.txt $(RegistryDIR)
# this should just be for .F90 (uppercase required for Doxygen preprocessing)
vpath % 	$(Aqwa_DIR)



	# complete object list
ALL_SOURCES = $(LIB_SOURCES) $(Aqwa_SOURCES) $(Driver_SOURCES) $(NETLIB_SOURCES)
ALL_OBJS    = $(ALL_SOURCES:.f90=$(OBJ_EXT))
ALL_OBJS    := $(ALL_OBJS:.F90=$(OBJ_EXT))
ALL_OBJS    := $(ALL_OBJS:.f=$(OBJ_EXT))


   # Rule to do everything.

all:     default
# use this for "all" for debugging: print variables:
#all:     ; $(info $$NWTC_Lib_DIR is [${NWTC_Lib_DIR}]) echo debugging

default: $(INTER_DIR) $(ALL_OBJS) $(DEST_DIR)/$(OUTPUT_NAME)$(EXE_EXT)


###   # General rules for compliling the files.
###%.obj: %.f90
###	$(FC) -I $(INTER_DIR) $(FFLAGS) -c $< -o $(INTER_DIR)/$@ -J $(INTER_DIR) -B $(INTER_DIR)


   ### general rules for making the files ###

   # Making .o or .obj files from .f90 files
%$(OBJ_EXT): %.f90
	$(FC) -I $(INTER_DIR) $(FFLAGS) \
	-c $< \
	-o $(INTER_DIR)/$@ \
	-I $(NWTC_Lib_DIR) -J $(INTER_DIR) -B $(INTER_DIR)


   # Making .o or .obj files from .f files
%$(OBJ_EXT): %.f
	$(FC) $(FFLAGS) \
	-c $< \
	-o $(INTER_DIR)/$@ \
	-I $(NWTC_Lib_DIR) -J $(INTER_DIR)

   # Making _Types.f90 files from .txt registry files.   These registries need the extra flag.
AqwaInterFace%_Types.f90: $(RegistryDIR)/AqwaInterFace%.txt
	$(RegistryProgram) $< -I $(RegistryNWTC) -noextrap
	$(CP_CMD) $@ "$(Aqwa_DIR)$(PATH_SEP)"

   # Making _Types.f90 files from .txt registry files.
%_Types.f90: $(RegistryDIR)/%.txt
	$(RegistryProgram) $< -I $(RegistryNWTC)
	$(CP_CMD) $@ "$(Aqwa_DIR)$(PATH_SEP)"




   #  Dependency rules.
#NWTC Library dependency rules:
NWTC_Base$(OBJ_EXT):                SingPrec$(OBJ_EXT)
$(SYS_FILE)$(OBJ_EXT):              NWTC_Base$(OBJ_EXT) SingPrec$(OBJ_EXT)
NWTC_Library_Types$(OBJ_EXT):       $(SYS_FILE)$(OBJ_EXT) NWTC_Base$(OBJ_EXT)
NWTC_IO$(OBJ_EXT):                  NWTC_Library_Types$(OBJ_EXT) $(SYS_FILE)$(OBJ_EXT)
NWTC_Num$(OBJ_EXT):                 NWTC_IO$(OBJ_EXT)
ModMesh_Types$(OBJ_EXT):            NWTC_Num$(OBJ_EXT)
ModMesh$(OBJ_EXT):                  ModMesh_Types$(OBJ_EXT) NWTC_Num$(OBJ_EXT) ModMesh_Types$(OBJ_EXT)
ModMesh_Mapping$(OBJ_EXT):          ModMesh$(OBJ_EXT)  NWTC_LAPACK$(OBJ_EXT)
NWTC_LAPACK$(OBJ_EXT):              NWTC_Base$(OBJ_EXT)
NWTC_Library$(OBJ_EXT):             ModMesh$(OBJ_EXT)  ModMesh_Mapping$(OBJ_EXT) NWTC_Num$(OBJ_EXT) NWTC_IO$(OBJ_EXT) NWTC_LAPACK$(OBJ_EXT)

#AqwaInterface dependency rules:
AqwaInterface_Types$(OBJ_EXT):         NWTC_Library$(OBJ_EXT)
AqwaInterface$(OBJ_EXT):               NWTC_Library$(OBJ_EXT)  AqwaInterface_Types$(OBJ_EXT)

#Driver dependency rules:
AqwaDriver_Types$(OBJ_EXT):         AqwaInterface_Types$(OBJ_EXT)
AqwaDriver_Subs$(OBJ_EXT):          AqwaDriver_Types$(OBJ_EXT)
AqwaDriver$(OBJ_EXT):               AqwaInterface$(OBJ_EXT)  AqwaDriver_Types$(OBJ_EXT)  AqwaDriver_Subs$(OBJ_EXT)



   # Make sure the destination directory for the intermediate files exist.

$(INTER_DIR):
	$(MD_CMD) $(INTER_DIR)


   # For linking driver code.

$(DEST_DIR)/$(OUTPUT_NAME)$(EXE_EXT): $(ALL_OBJS) | $(INTER_DIR)
	$(FC) $(LDFLAGS) -I $(INTER_DIR) -o $(DEST_DIR)/$(OUTPUT_NAME)$(EXE_EXT) \
	$(foreach src, $(ALL_OBJS), $(addprefix $(INTER_DIR)/,$(src)))


   # Cleanup afterwards.
clean:
	$(DEL_CMD) $(INTER_DIR)$(PATH_SEP)*.mod $(INTER_DIR)$(PATH_SEP)*$(OBJ_EXT)
	$(DEL_CMD) "$(DEST_DIR)$(PATH_SEP)$(OUTPUT_NAME)$(EXE_EXT)"
	$(DEL_CMD) *_Types.f90

#	$(DEL_CMD) "$(Aqwa_DIR)$(PATH_SEP)*_Types.f90
#	$(DEL_CMD) $(DEST_DIR)$(PATH_SEP)*_Types.f90
