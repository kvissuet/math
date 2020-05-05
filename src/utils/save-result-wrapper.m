SaveResultWrapper := function(savefile, title,data, f)
  newF := function(arg)
    Write(saveFile,"***************************");
    Write(saveFile,Realtime());
    Write(saveFile,title);
    Write(saveFile,data);
    return f(arg)
  end function;
  return newF;
end function;

print "SaveResultWrapper function loaded";
