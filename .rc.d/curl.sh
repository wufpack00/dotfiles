# Show headers from http request
function httpHeaders () { /usr/bin/curl -I -L $@ ; }   

# Download a web page and show info on what took time
function httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }
