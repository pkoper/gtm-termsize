all:
	gcc -Wall -Werror -pedantic -fPIC -shared -o libtermsize.so termsize.c -I. -I$(gtm_dist)


install:
	chmod u+w -R $(gtm_dist)/plugin
	cp termsize.m $(gtm_dist)/plugin/r/
	cp libtermsize.so termsize.xc termsize.env $(gtm_dist)/plugin/
	sed -i "s|gtm_dist|$(gtm_dist)|" $(gtm_dist)/plugin/termsize.xc $(gtm_dist)/plugin/termsize.env
	echo ". $(gtm_dist)/plugin/termsize.env" >> ~/.profile

