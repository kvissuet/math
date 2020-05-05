DetOfGroup := function(G,m)
    D := MatrixGroup<1, IntegerRing(m) | [1] >;
    for X in Generators(G) do
        D := MatrixGroup<1, IntegerRing(m) | Generators(D), [Determinant(X)] >;
    end for;
    return D;
end function;

print "DetOfGroup function loaded";