#!/bin/bash
CLASS_PATH=.:../jpf-core/build/jpf.jar:$env{JUNIT_HOME}/junit.jar

#BUILD OBJECTS
javac -cp ${CLASS_PATH} LL*java

#RUN JUNIT TESTS



#RUN JPF 
java -jar ../jpf-core/build/RunJPF.jar ./probSet3.2.b.jpf | \
 tee jUnitTest.jpf_generated
 
