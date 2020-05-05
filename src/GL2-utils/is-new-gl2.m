IsNewGL2 := function(H,m)
    Answer := true;
    if IsPrime(m) and #H eq (m-1)^2*m*(m+1) then
        Answer := false;
    end if;
    if not IsPrime(m) then
        for p in PrimeDivisors(m) do
            Hmodmoverp := MatrixGroup<2, IntegerRing(Floor(m/p)) | Generators(H) >;
            if IsDivisibleBy(m,p^2) and #H eq p^4*#Hmodmoverp then
                Answer := false;
                break p;
            end if;
            if not IsDivisibleBy(m,p^2) and #H eq (p-1)^2*p*(p+1)*#Hmodmoverp then
                Answer := false;
                break p;
            end if;
        end for;
    end if;
    return Answer;
end function;