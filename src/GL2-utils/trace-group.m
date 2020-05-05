TraceOfGroup := function(G,m)
    Traces := {};
    for g in G do
        Traces := Traces join { Trace(g) };
        if #Traces eq m then
            break g;
        end if;
    end for;
    return Traces;
end function;

print "TraceOfGroup function loaded"