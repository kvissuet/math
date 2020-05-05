load './genus/index.m';
load './GL2-utils/index';
load './utils/index.m';

ThinDownToSurjectiveDet := function(L,m)
    List := [];
    for x := 1 to #L do
        if #DetOfGroup(L[x,1],m) eq EulerPhi(m) then
            Append(~List,L[x]);
        end if;
    end for;
    return List;
end function;

IsMinimalMissingTraceGroup := function(G,m)
    hasmissingtrace := false;
    if #TraceOfGroup(G,m) lt m then
        hasmissingtrace := true;
    end if;
    isminimalmissingtracegroup := true;
    for p in PrimeDivisors(m) do
        if p lt m then
            Gmodmoverp := MatrixGroup<2, Integers(Floor(m/p))   | Generators(G) >;
            if #TraceOfGroup(Gmodmoverp,Floor(m/p)) lt Floor(m/p) then
                isminimalmissingtracegroup := false;
                break p;
            end if;
        end if;
    end for;
    answer := hasmissingtrace and isminimalmissingtracegroup;
    return answer;
end function;

ThinDownToMinimalMissingTraceGroups := function(L,m)
    List := [];
    for x := 1 to #L do
        if IsMinimalMissingTraceGroup(L[x,1],m) then
            Append(~List,L[x]);
        end if;
    end for;
    return List;
end function;

ThinDownToNonMissingTraceGroups := function(L,m)
    List := [];
    for x := 1 to #L do
        if #TraceOfGroup(L[x,1],m) eq m then
            Append(~List,L[x]);
        end if;
    end for;
    return List;
end function;

IsCongruentToImod := function(g,d)
    iscongruent := false;
    if RTI(g[1,1]) mod d eq 1 mod d and RTI(g[1,2]) mod d eq 0 mod d and RTI(g[2,1]) mod d eq 0 mod d and RTI(g[2,2]) mod d eq 1 mod d then
        iscongruent := true;
    end if;
    return iscongruent;
end function;

IsAdmissible := function(G,m)
    isadmissible := false;
    for t := 1 to m do
        tisgood := true;
        for g in G do
            if RTI(Trace(g)) mod m eq t mod m and not IsCongruentToImod(g,2) then
                tisgood := false;
            end if;
        end for;
        if tisgood eq true then
            isadmissible := true;
        end if;
    end for;
    return isadmissible;
end function;

ThinDownToAdmissibleGroups := function(L,m)
    List := [];
    for x := 1 to #L do
        if IsAdmissible(L[x,1],m) then
            Append(~List,L[x]);
        end if;
    end for;
    return List;
end function;

FigureOutTheGroups := function(L,m1,m2);
    List := [];
    for x := 1 to #L do
        G1 := MatrixGroup<2, Integers(m1) | Generators(L[x,1]) >;
        G2 := MatrixGroup<2, Integers(m2) | Generators(L[x,1]) >;
        S1 := MatrixGroup<2, Integers(m1) | Generators(L[x,2]) >;
        S2 := MatrixGroup<2, Integers(m2) | Generators(L[x,2]) >;
        Append(~List,<L[x,1],G1,Factorization(#G1),G2,Factorization(#G2),L[x,2],S1,Factorization(#S1),S2,Factorization(#S2),L[x,3],L[x,4]>);
    end for;
    return List;
end function;

ThinDownByConjugation := function(L,m);
    List := [];
    for x := 1 to #L do
        isconjugate := false;
        for y := 1 to #List do
            if IsConjugate(GL(2,Integers(m)),List[y,4],L[x,4]) then
                isconjugate := true;
                break y;
            end if;
        end for;
        if isconjugate eq false then
            Append(~List,L[x]);
        end if;
    end for;
    return List;
end function;

IsConjugateToSubgroup := function(G1,G2,m)
    answer := false;
    for H2 in Subgroups(G2 : OrderEqual := #G1) do
        if IsConjugate(GL(2,Integers(m)),G1,H2`subgroup) then
            answer := true;
            break H2;
        end if;
    end for;
    return answer;
end function;

ThinDownByMaximality := function(L,m);
    List := [];
    for x := 1 to #L do
        ismaximal := true;
        for y := 1 to #L do
            if y ne x then
                if IsConjugateToSubgroup(L[x,1],L[y,1],m) then
                    ismaximal := false;
                    break y;
                end if;
            end if;
        end for;
        if ismaximal eq true then
            Append(~List,L[x]);
        end if;
    end for;
    return List;
end function;

DoesSL2levelDivided := function(G,m,d)
    answer := true;
    S := SL(2,Integers(m)) meet G;
    for p in PrimeDivisors(Floor(m/d)) do
        Smodpd := MatrixGroup<2, Integers(p*d) | Generators(S) >;
        Smodd := MatrixGroup<2, Integers(d) | Generators(S) >;
        if not #Smodpd/#Smodd eq #SL(2,Integers(p*d))/#SL(2,Integers(d)) then
            answer := false;
            break p;
        end if;
        if not IsDivisibleBy(d,p) and IsDivisibleBy(Floor(m/d),p^2) then
            Smodp2d := MatrixGroup<2, Integers(p^2*d) | Generators(S) >;
            if not #Smodp2d/#Smodpd eq #SL(2,Integers(p^2*d))/#SL(2,Integers(p*d)) then
                answer := false;
                break p;
            end if;
        end if;
        if IsEven(p) and IsOdd(d) and IsDivisibleBy(Floor(m/d),8) then
            Smod4d := MatrixGroup<2, Integers(4*d) | Generators(S) >;
            Smod8d := MatrixGroup<2, Integers(8*d) | Generators(S) >;
            if not #Smod8d/#Smod4d eq #SL(2,Integers(8*d))/#SL(2,Integers(4*d)) then
                answer := false;
                break p;
            end if;
        end if;
    end for;
    return answer;
end function;

TwoadicValuation := function(n)
    v := 0;
    if Factorization(n)[1,1] eq 2 then
        v := Factorization(n)[1,2];
    end if;
    return v;
end function;

FullPreImage := function(G,m,p,k)
    PreG := G;
    level := m;
    for j := 1 to k do
        PreG := MatrixGroup<2, IntegerRing(level*p) | Generators(PreG), [1+level,0,0,1], [1,level,0,1], [1,0,level,1], [1,0,0,1+level] >;
        level := p*level;
    end for;
    return PreG;
end function;

OuterAutomorphismRepresentatives := function(A)
    List := [];
    f,G := PermutationRepresentation(A);
    for N in Reverse(NormalSubgroups(G)) do
        if #N`subgroup eq #A/OuterOrder(A) then
            dummy := true;
            for x in SetToSequence(Set(N`subgroup)) do
                if IsInnerAutomorphism(x@@f) eq false then
                    dummy := false;
                end if;
            end for;
            if dummy eq true then
                Ans := N`subgroup;
            break N;
            end if;
        end if;
    end for;
    Triv := NormalSubgroups(G)[1]`subgroup;
    L := DoubleCosetRepresentatives(G,Ans,Triv);
    for x in L do
        Append(~List,x@@f);
    end for;
    return List;
end function;

FormingHigherLevelMTGroups := function(L,m)
    List := [];
    for x := 1 to #L do
        Gm := L[x,1];
        Sm := Gm meet SL(2,Integers(m));
        n := TwoadicValuation(Floor(#Sm/#CommutatorSubgroup(Sm,Sm)));
        for k := 1 to n do
            for H in Subgroups(Sm : IndexEqual := 2^k) do
                if IsNormal(Gm,H`subgroup) then
                    GmmodHfromGm, pimodH := Gm/H`subgroup;
                    isrightquotient, delta := IsIsomorphic(Gm/H`subgroup,GL(1,Integers(2^k*m)));
                    red := hom< GL(1,Integers(2^k*m)) -> GL(1,Integers(m)) | x :-> RTI(x[1,1]) mod m >;
                    if isrightquotient eq true then
                        G2km := FullPreImage(Gm,m,2,k);
                        S2km := G2km meet SL(2,Integers(2^k*m));
                        quotientG2km, piG2km := G2km/S2km;
                        mult, deter := IsIsomorphic(G2km/S2km,GL(1,Integers(2^k*m)));
                        Ker := MatrixGroup<2, Integers(2^k*m) | [m+1,0,0,1], [1,m,0,1], [1,0,m,1], [1,0,0,m+1], [2*m+1,0,0,1], [1,2*m,0,1], [1,0,2*m,1], [1,0,0,1+2*m] >;
                        levelmfrom2km, pilevellowering := G2km/Ker;
                        GmfromG2km, isomto := IsIsomorphic(pilevellowering(G2km),Gm);
                        Group2km := MatrixGroup<2, Integers(2^k*m) | [1,0,0,1] >;
                        for alpha in OuterAutomorphismRepresentatives(AutomorphismGroup(GL(1,Integers(2^k*m)))) do
                            for g in G2km do
                                if not g in Group2km and alpha(deter(piG2km(g))) eq delta(pimodH(isomto(pilevellowering(g)))) then
                                    Group2km := MatrixGroup<2, Integers(2^k*m) | Generators(Group2km), g >;
                                end if;
                            end for;
                            if #TraceOfGroup(Group2km,2^k*m) lt 2^k*m and #pilevellowering(Group2km) eq #Gm then
                                Append(~List,<L[x,1],L[x,2],L[x,3],Group2km,2^k*m>);
                            end if;
                        end for;
                    end if;
                end if;
            end for;
        end for;
    end for;
    return List;
end function;
