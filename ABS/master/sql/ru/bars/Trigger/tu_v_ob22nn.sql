

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_OB22NN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_OB22NN ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_OB22NN 
instead of update ON BARS.V_OB22_NN for each row
declare
  l_msg    varchar2(4000):=null;
begin
      if :old.vidf=1 and :new.vidf=0 and :old.acc=:new.acc then
          update   accounts
             set   vid = 0
           where   acc =:new.acc;
          l_msg:='���i�� �� ������� '||:old.nls||' � accounts.vid ����� � 89 �� 0 (��� � ��)';
      end if;
      if :old.ob22<>:new.ob22 and :old.acc=:new.acc then
      update   specparam_int
          set ob22=:new.ob22
        where   acc=:new.acc;
      l_msg:='���i�� ������� ��22 �� ������� '||:old.nls||
              ' � '||:old.ob22||' �� '||:new.ob22;
      end if;
      if l_msg is not null then
         bars_audit.info(l_msg);
      end if;
end;
/
ALTER TRIGGER BARS.TU_V_OB22NN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_OB22NN.sql =========*** End ***
PROMPT ===================================================================================== 
