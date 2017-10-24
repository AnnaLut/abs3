

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_OPER_VISA_CHECK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OPER_VISA_CHECK ***

  CREATE OR REPLACE TRIGGER BARS.TI_OPER_VISA_CHECK 
before insert ON BARS.OPER_VISA for each row
declare
  tt_   tts.tt%type;
  l_tmp number;
begin

  begin
    select tt
    into tt_
    from oper
    where ref=:new.ref;
  exception when no_data_found then
    tt_ := '';
  end;

  if tt_ in('TOK','TOL') and :new.groupid in('1','4') then
      select count(*) into l_tmp
       from oper_visa
       where userid=:new.userid
         and groupid = case
                        when :new.groupid='1' then '4'
                        when :new.groupid='4' then '1' end
         and ref=:new.ref               ;

  else l_tmp:=0;

  end if;

  if l_tmp>0 then
    raise_application_error(-20000, 'Одному користувачу заборонено накладати 1 та 4 візи на операцію '||tt_||'!!!');
  end if;

/*  if tt_ = 'GO8' and :new.groupid = '7' then
    if bars_zay.get_support_document(:new.ref, tt_) = 0 then
      bars_error.raise_nerror('ZAY', 'ERROR_SUP_DOCS');
    end if;
  end if;*/
end;
/
ALTER TRIGGER BARS.TI_OPER_VISA_CHECK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_OPER_VISA_CHECK.sql =========*** 
PROMPT ===================================================================================== 
