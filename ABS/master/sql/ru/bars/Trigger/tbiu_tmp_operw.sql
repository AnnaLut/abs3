

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_TMP_OPERW.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_TMP_OPERW ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_TMP_OPERW 
before insert or update ON BARS.OPERW for each row
declare
  l_type op_field.type%type;
  l_name op_field.name%type;
l_tag op_field.tag%type;

begin
l_tag:=:new.tag;
  select name, nvl(type,'C') into l_name, l_type
    from op_field
   where tag = l_tag;

exception when no_data_found then 
insert into tmp_operw_1  select l_tag from dual;



end; 
/
ALTER TRIGGER BARS.TBIU_TMP_OPERW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_TMP_OPERW.sql =========*** End 
PROMPT ===================================================================================== 
