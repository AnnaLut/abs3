

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DPUNBS4CUST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DPUNBS4CUST ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DPUNBS4CUST 
before insert or update on BARS.DPU_NBS4CUST
for each row
declare
  l_tmp varchar2(1);
begin
  -- перевірка правильності заповнення параметра K013
  begin
    select K013
      into l_tmp
      from KL_K013
     where K013 = :new.K013
       and D_CLOSE is null;
  exception
    when no_data_found then
      bars_error.raise_nerror ('DPU', 'INVALID_K013', :new.K013);
  end;

  -- перевірка правильності заповнення параметра S181
  If :new.S181 = '0' then
    Null;  -- для поточних рахунків комбінованих договорів
    -- додати перевірку на належ. рах. до поточ.
  Else
    begin
      select s181
        into l_tmp
        from KL_S181
       where S181 = :new.S181;
    exception
      when no_data_found then
        bars_error.raise_nerror ('DPU', 'INVALID_S181', :new.S181);
    end;
  End If;
end TIU_DPUNBS4CUST;
/
ALTER TRIGGER BARS.TIU_DPUNBS4CUST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DPUNBS4CUST.sql =========*** End
PROMPT ===================================================================================== 
