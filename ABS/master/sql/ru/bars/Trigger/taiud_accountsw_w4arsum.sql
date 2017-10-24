

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOUNTSW_W4ARSUM.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_ACCOUNTSW_W4ARSUM ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_ACCOUNTSW_W4ARSUM 
after insert or update or delete on accountsw
for each row
declare

procedure add (p_acc number, p_value varchar2)
is
  l_s number;
begin
  l_s := to_number(nvl(p_value,0)) * 100;
  insert into ow_acc_que (acc, s, sos)
  values (p_acc, l_s, 0);
exception
  when dup_val_on_index then
     update ow_acc_que set s = l_s, dat = sysdate where acc = p_acc and sos = 0;
  when others then
     if sqlcode = -06502 then
        raise_application_error(-20000, 'Невірне значення параметру <Арештована сума>');
     else raise;
     end if;
end;

begin

   if    deleting  then
      if :old.tag = 'W4_ARSUM'  then
         add(:old.acc, null);
      end if;

   elsif inserting then
      if :new.tag = 'W4_ARSUM'  then
         add(:new.acc, :new.value);
      end if;

   else
      if :new.tag = 'W4_ARSUM' and :new.value <> :old.value then
         add(:new.acc, :new.value);
      end if;
   end if;

end;
/
ALTER TRIGGER BARS.TAIUD_ACCOUNTSW_W4ARSUM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOUNTSW_W4ARSUM.sql ========
PROMPT ===================================================================================== 
