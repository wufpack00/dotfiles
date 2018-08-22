# this should be included in os-macosx.sh but overriding alias didn't work 
if is_mac ; then
    alias ll='ls -FlAhpG'
else
    alias ll='ls -FlAhp --color=always'
fi
