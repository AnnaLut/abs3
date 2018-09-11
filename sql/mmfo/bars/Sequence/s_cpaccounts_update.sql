PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/s_cpaccounts_update.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence s_cpaccounts_update ***
begin
   execute immediate 'CREATE SEQUENCE  BARS.s_cpaccounts_update  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE';
   exception when others then 
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  s_cpaccounts_update ***
grant SELECT                                                                 on s_cpaccounts_update to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on s_cpaccounts_update to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/s_cpaccounts_update.sql =========*** 
PROMPT ===================================================================================== 

