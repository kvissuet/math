RTI:= function(x)
    for a in [0..100000] do
        if a eq x then
            return a;
            break a;
        end if;
    end for;
end function;

print "RTI function loaded";