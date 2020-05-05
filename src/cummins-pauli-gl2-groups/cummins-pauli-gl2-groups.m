// m is GL 2 level
// g is genus
// duplicates work of "Congruence Subgroups of PSL(2, Z) of Genus Less
// than or Equal to 24" by C. J. Cummins and S. Pauli

load "./GL2-utils/index.m";

CumminsPauliGL2Groups := function(m,g)
    G := GL(2,IntegerRing(m));
    S := SL(2,IntegerRing(m));
    f, GPerm := PermutationRepresentation(G);
    gi := f([0,-1,1,0]);
    gp := f([1,1,-1,0]);
    Si := Set(Class(f(S),gi));
    Sp := Set(Class(f(S),gp));
    Gamma := MatrixGroup<2, IntegerRing(m) | [1,1,0,1] >;
    negI := Matrix(IntegerRing(m),2,2,[-1,0,0,-1]);
    List := [];
    for d in Divisors(#GL(2,IntegerRing(m))) do
        print <d,#GL(2,IntegerRing(m))/d>;
        if d ne 1 then
            for H in Subgroups(G:IndexEqual := d) do
                if IsNewGL2(H`subgroup,m) and Genus(H`subgroup,S,m,f,Si,Sp,Gamma,negI)[4] eq g then
                    Append(~List,<H`subgroup,H`subgroup meet S,Genus(H`subgroup,S,m,f,Si,Sp,Gamma,negI),m>);
                end if;
            end for;
        end if;
    end for;
    return List;
end function;