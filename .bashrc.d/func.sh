# List user defined functions (similar to alias command for listing aliases)
function func ()
{
    local F=`for i in $(declare -F | sed -e 's/declare -f //g'); do echo $i; done| sed -e :a -e 's/^.\{1,25\}$/& /;ta'|tr ' ' '\032'`;
    i=1;
    for f in ${F};
    do
        echo -en "$f";
        echo -en "\n";
    done | tr '\032' " "
}
