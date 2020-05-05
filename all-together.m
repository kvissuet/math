Load 'nathans-code.m';

monitoring := function(savefile, title,info)
  Write(saveFile,"***************************");
  Write(saveFile,Cputime());
  Write(saveFile,title);
  Write(saveFile,info);
  return 0;
end function;

allTogether := function(level, saveFile)
  allCPGL2Groups := CumminsPauliGL2Groups(level, 0);
  monitoring(savefile, 'CP GL2 Groups Done', '');
  thinnedDownBySurjectiveDet := ThinDownToSurjectiveDet(allCPGL2Groups, level);
  monitoring(savefile, 'Thinned Down By Surjective Det', '');
  thinedDownToNonMissingTraceGroups := ThinDownToNonMissingTraceGroups(thinnedDownBySurjectiveDet, level);
  monitoring(savefile, 'Thinned Down By Missing Trace', '');
  thinedDownToAdmissibleGroups := ThinDownToAdmissibleGroups(thinedDownToNonMissingTraceGroups, level);
  monitoring(savefile, 'Thinned Down By Admissible Groups', '');
  // projectionsToLowerLevels := FigureOutTheGroups(thinedDownToAdmissibleGroups, level1, level2 );
  thinedDownByMaximality := ThinDownByMaximality(thinedDownToAdmissibleGroups, level);
  monitoring(savefile, 'Thinned Down By Maximality', '');
  formingHigherLevelMTGroups := FormingHigherLevelMTGroups(thinedDownByMaximality, level);
  monitoring(savefile, 'Resu;ts', formingHigherLevelMTGroups);
  print(formingHigherLevelMTGroups);
  return formingHigherLevelMTGroups;
end function;
