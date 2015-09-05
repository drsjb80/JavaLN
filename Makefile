BASE    = $*
TARGET  = $@
DEPENDS = $<
NEWER   = $?

VERSION = $(shell cat VERSION)
JAR = JavaLN-$(VERSION).jar

JAVALN = edu/mscd/cs/javaln
SYSLOG = edu/mscd/cs/javaln/syslog
SOURCES = $(shell ls $(JAVALN)/*.java $(SYSLOG)/*.java)
CLASSES = $(SOURCES:.java=.class)

OS	= $(shell java GetOS)

ifeq ($(OS),MacOSX-x86_64)
    LIBEXT=jnilib
    CCINC=-I/System/Library/Frameworks/JavaVM.framework/Headers
    CCARGS=-bundle -I$(SYSLOG) $(CCINC)
endif

ifeq ($(OS),MacOSX-i386)
    LIBEXT=jnilib
    CCINC=-I/System/Library/Frameworks/JavaVM.framework/Headers
    CCARGS=-bundle -I$(SYSLOG) $(CCINC)
endif

ifeq ($(OS),MacOS-Xppc)
    LIBEXT=jnilib
    CCINC=-I/System/Library/Frameworks/JavaVM.framework/Headers
    CCARGS=-bundle -I$(SYSLOG) $(CCINC)
endif

ifeq ($(OS),Linux-i386)
    LIBEXT=so
    CCARGS=-I$(SYSLOG) -I/usr/lib/jvm/default-java/include -I/usr/lib/jvm/default-java/include/linux -I/usr/java/default/include/linux -I/usr/java/default/include -shared
endif

JNILIB	= lib$(OS)DomainSocket.$(LIBEXT)

%.class : %.java
	javac $(DEPENDS)

$(JAR) : $(CLASSES) $(SYSLOG)/$(JNILIB) doc
	jar cMf $(TARGET) $(CLASSES) $(SYSLOG)/$(JNILIB) doc

$(SYSLOG)/$(JNILIB) : $(SYSLOG)/UNIXDomainHandler.h $(SYSLOG)/UNIXDomainSocket.c
	$(CC) $(CCARGS) $(SYSLOG)/UNIXDomainSocket.c -o $(SYSLOG)/$(JNILIB)

$(SYSLOG)/UNIXDomainHandler.h : $(SYSLOG)/UNIXDomainHandler.class
	javah edu.mscd.cs.javaln.syslog.UNIXDomainHandler
	mv edu_mscd_cs_javaln_syslog_UNIXDomainHandler.h $(TARGET)

clean : 
	rm -f $(CLASSES) $(SYSLOG)/$(JNILIB) $(SYSLOG)/UNIXDomainHandler.h
	rm -rf doc

doc :
	javadoc -quiet -d doc edu.mscd.cs.javaln edu.mscd.cs.javaln.syslog
	touch doc

FRC :
