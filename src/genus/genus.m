// finds genus of GL_2 subrroup

// H is a GL_2 subgroup
// S is the full SL_2 of level m
// m is a level
// f is the permuation representation of GL_2(m)
// Si := Set(Class(f(S),gi));
// Sp := Set(Class(f(S),gp));
// Gamma := MatrixGroup<2, IntegerRing(m) | [1,1,0,1] >;
// negI := Matrix(IntegerRing(m),2,2,[-1,0,0,-1]);

Genus := function(H,S,m,f,Si,Sp,Gamma,negI)
    Xenl := MatrixGroup<2, IntegerRing(m) | H, [-1,0,0,-1] >;
    XS := Xenl meet S;
    Ni := Si meet Set(f(XS));
    Np := Sp meet Set(f(XS));
    ri := #Ni / #Si;
    rp := #Np / #Sp;
    rinf := #DoubleCosetRepresentatives(f(S),f(Gamma),f(XS))*#XS/#S;
    genus := 1 + #S/12/#XS*(1 - 3*ri - 4*rp - 6*rinf);
    return <ri, rp, rinf, genus>;
end function;