

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_OPERW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_OPERW ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_OPERW 
before insert or update ON BARS.OPERW for each row
declare
  l_type op_field.type%type;
  l_name op_field.name%type;
  n      number;
  d      date;
  de number(9,2);

begin

  select name, nvl(type,'C') into l_name, l_type
    from op_field
   where tag = :new.tag;

  if l_type = 'N' then

     begin
        execute immediate 'select to_number(''' || :new.value || ''') from dual' into n;
     exception when others then
        if sqlcode = -01722 then
           bars_error.raise_nerror('DOC', 'VALUE_NOT_NUMBER', '''' || l_name || '''');
        else
           raise;
        end if;
     end;

  elsif l_type = 'D' then

     begin
        execute immediate 'select to_date(''' || :new.value || ''',''dd.mm.yyyy'') from dual' into d;
     exception when others then
        if sqlcode in (-01840, -01858, -01861) then
           bars_error.raise_nerror('DOC', 'VALUE_NOT_DATE', '''' || l_name || '''');
        else
           raise;
        end if;
     end;

  elsif l_type = 'E' then
        begin

  execute immediate ' select to_number(trim(to_char(replace('''||:new.value||''', '','', ''.''), ''9999999999999.99'')), ''999999999.99'') from dual' into de;
--         execute immediate 'select to_number(replace('''||:new.value||''', ''.'', '',''), ''999999999,99'') from dual' into de;
         exception when others then
                   bars_error.raise_nerror('DOC', 'VALUE_NOT_DECIMAL', '''' || l_name || '''');
        end;
  end if;

exception when no_data_found then null;
end;


/
ALTER TRIGGER BARS.TBIU_OPERW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_OPERW.sql =========*** End *** 
PROMPT ===================================================================================== 
