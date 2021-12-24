sources = main
# resources = main

assemble_flags = 
link_flags = /console

dlls = ucrtbase.dll user32.dll kernel32.dll gdi32.dll

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

run : link
	./$(current_dir).exe

link : compile
	@echo linking ...
	GoLink.exe $(sources:%=%.obj) $(dlls) $(link_flags) /fo $(current_dir).exe

compile : clean
	@echo compiling ...
	# GoRC.exe $(resources)
	GoAsm.exe $(assemble_flags) $(sources)

.PHONY : clean
clean :
	@echo cleaning ...
	rm -f *.res
	rm -f *.obj
	rm -f *.exe
