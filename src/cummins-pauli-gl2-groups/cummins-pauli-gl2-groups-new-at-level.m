// m is GL2 level 
// g is genus 

load './GL2-utils/index.m'

CumminsPauliGL2GroupsNewAtLevel := function(m,g)
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
                if IsNewSL2(H`subgroup meet S,m) and Genus(H`subgroup,S,m,f,Si,Sp,Gamma,negI)[4] eq g then
                    Append(~List,<H`subgroup,H`subgroup meet S,Genus(H`subgroup,S,m,f,Si,Sp,Gamma,negI),m>);
                end if;
            end for;
        end if;
    end for;
    return List;
end function;