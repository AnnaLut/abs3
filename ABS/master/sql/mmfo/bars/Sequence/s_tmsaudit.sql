PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TMSAUDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TMSAUDIT ***
begin
   execute immediate 'CREATE SEQUENCE  BARS.S_TMSAUDIT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE';
   exception when others then 
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  S_TMSAUDIT ***
grant SELECT                                                                 on S_TMSAUDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_TMSAUDIT to START1;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TMSAUDIT.sql =========*** 
PROMPT ===================================================================================== 
/