
### CMakeAndroidFetchJbr 
* download and extract jetbrain runtime.


```cmake
CMakeAndroidFetchJbr( jbr
    JBR_ID 17.0.8.1-windows-x64-b1059.3
    SOURCE https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-17.0.8.1-windows-x64-b1059.3.tar.gz)

include(CMakePrintHelpers)
cmake_print_variables(jbr.dir) # path to jbr, use as jdk dir along with other programs 
cmake_print_variables(jbr.javac) # path to javac  
cmake_print_variables(jbr.id) # given JBR_ID. this is because including unzip. the extracted content is renamed internally.

``` 
