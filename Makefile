# Kolby Kiesling
# 07 / 16 / 2019
# kjk15b@acu.edu

DEBUGFLAGS=-g -fpermissive
#DEBUGFLAGS=
CFLAGS=$(DEBUGFLAGS) -Wall -Os -I$(MIDASSYS)/include -I$(MIDASSYS)/mscb/include -I$(MIDASSYS)/drivers/class -I$(MIDASSYS)/drivers/device -I$(MIDASSYS)/drivers/bus -fpermissive -std=c++11
CXXFLAGS=$(CFLAGS)
LDFLAGS=$(MIDASSYS)/linux/lib/mfe.o  -L$(MIDASSYS)/linux/lib -lmidas -lpthread -lutil -lrt -lz -lnetsnmp 


all: feMPODC

tcpip.o: $(MIDASSYS)/drivers/bus/tcpip.cxx $(MIDASSYS)/drivers/bus/tcpip.h
	g++ -c $(CFLAGS) $(MIDASSYS)/drivers/bus/tcpip.cxx

hv.o: $(MIDASSYS)/drivers/class/hv.cxx $(MIDASSYS)/drivers/class/hv.h
	g++ -c $(CFLAGS) $(MIDASSYS)/drivers/class/hv.cxx
	
iseg_hv_mpod.o: $(MIDASSYS)/drivers/device/iseg_hv_mpod.cxx $(MIDASSYS)/drivers/device/iseg_hv_mpod.h
	g++ $(CXXFLAGS) -c $(MIDASSYS)/drivers/device/iseg_hv_mpod.cxx
	
WIENER_SNMP.o: $(MIDASSYS)/drivers/device/WIENER_SNMP.cpp $(MIDASSYS)/drivers/device/WIENER_SNMP.h
	g++ $(CXXFLAGS) -c $(MIDASSYS)/drivers/device/WIENER_SNMP.cpp
	
feMPODC: WIENER_SNMP.o iseg_hv_mpod.o tcpip.o hv.o feMPODC.cc
	g++ -o $@ $(CXXFLAGS) $^ $(LDFLAGS)

clean:
	rm -f feMPODC *.o

