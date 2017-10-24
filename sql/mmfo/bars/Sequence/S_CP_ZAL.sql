PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CP_ZAL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CP_ZAL ***

  -- Create sequence 
begin   
 execute immediate 'create sequence S_CP_ZAL
minvalue 0
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 5';

exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  S_CP_ZAL ***
grant SELECT                                                                 on S_CP_ZAL to ABS_ADMIN;
grant SELECT                                                                 on S_CP_ZAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CP_ZAL to TOSS;
grant SELECT                                                                 on S_CP_ZAL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CP_ZAL.sql =========***
PROMPT ===================================================================================== 
