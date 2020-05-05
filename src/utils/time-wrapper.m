// f is the function you want to wrap
// f must only take in 1 arg... blame magma for not having a way to spread an array or tuple

TimeWrapper := function(f)
    newF := function(arg)
        t1 := Realtime();
        print "function started running at: ",t2;
        result := f(arg);
        t2:= Realtime();
        print "function finished running at: ",t2;
        print "total runtime: ", t2-t1;
        return result;
    end function;
    return newF;
end function;

print "loaded TimeWrapper function";