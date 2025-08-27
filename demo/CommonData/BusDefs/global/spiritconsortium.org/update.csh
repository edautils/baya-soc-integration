#!/bin/csh -f

foreach f ( `cat x` )
sed -e 's/SPIRIT\/1.5/SPIRIT\/1685-2009/g' $f > $f.tmp
\mv -f $f.tmp $f
end
