

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_COMPEN9760.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_COMPEN9760 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_COMPEN9760 
before insert or update on compen9760 for each row
declare
  i  number;
begin
  :new.kv := 980;
  begin
    select 1
    into   i
    from   accounts
    where  nls=:new.nls and
           kv=:new.kv   and
           dazs is null;
  exception when no_data_found then
    raise_application_error(-20037,'Рахунок не існує або закритий');
  end;
end TBIU_compen9760;
/
ALTER TRIGGER BARS.TBIU_COMPEN9760 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_COMPEN9760.sql =========*** End
PROMPT ===================================================================================== 
