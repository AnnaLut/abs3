

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_TT_IB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPER_TT_IB ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPER_TT_IB 
before insert  on oper
 for each row
 FOLLOWS TIU_OPER_CHK
 WHEN (
 new.tt in ('IB1','IB2','IB3','IB4','IB5','IB6','IBB','IBO','IBS')
      ) begin
  
  if :new.NEXTVISAGRP  = '19' 
    then  :new.userid := 20002;
  end if;
  
end TAI_OPER_TT_IB;
/
ALTER TRIGGER BARS.TAI_OPER_TT_IB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_TT_IB.sql =========*** End 
PROMPT ===================================================================================== 
