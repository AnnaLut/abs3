--
-- Create Schema Script
--   Database Version            : 11.2.0.4.0
--   Database Compatible Level   : 11.2.0.4.0
--   Script Compatible Level     : 11.2.0.4.0
--   Toad Version                : 13.0.0.80
--   DB Connect String           : OBMMFO6
--   Schema                      : BARS
--   Script Created by           : BARSAQ
--   Script Created at           : 13/08/2018 13:19:45
--   Notes                       : 
--
-- 13.08.2018 COBUMMFO-8319 Реалізація взаємодії між Банком, Біржою та Учасниками біржі при 
--здійснені розрахунків відповідно до умов Договору Ескроу - в рамках заявки додано операції 'IBP','IBL','IBE'
--

-- Object Counts: 
--   Triggers: 1 


CREATE OR REPLACE TRIGGER BARS.TAI_OPER_TT_IB
before insert  ON BARS.OPER
 for each row
 FOLLOWS TIU_OPER_CHK
WHEN (
 new.tt in ('IB1','IB2','IB3','IB4','IB5','IB6','IBB','IBO','IBS','IBP','IBL','IBE')
      )
begin
  
  if :new.NEXTVISAGRP  = '19' 
    then  :new.userid := 20002;
  end if;
  
end TAI_OPER_TT_IB;
/
SHOW ERRORS;
/