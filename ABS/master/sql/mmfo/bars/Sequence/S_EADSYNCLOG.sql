

PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Sequence/S_EADSYNCLOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_EADSYNCLOG ***

begin 
  execute immediate 'CREATE SEQUENCE BARS.S_EADSYNCLOG';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  S_EADSYNCLOG ***
grant SELECT on S_EADSYNCLOG to WR_ALL_RIGHTS;
grant SELECT on S_EADSYNCLOG to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Sequence/S_EADSYNCLOG.sql =========*** End *** =
PROMPT ===================================================================================== 
