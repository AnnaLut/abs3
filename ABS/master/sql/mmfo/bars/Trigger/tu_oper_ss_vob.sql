--
-- Create Schema Script
--   Database Version            : 11.2.0.4.0
--   Database Compatible Level   : 11.2.0.4.0
--   Script Compatible Level     : 11.2.0.4.0
--   Toad Version                : 13.0.0.80
--   DB Connect String           : OBMMFO6
--   Schema                      : BARS
--   Script Created by           : BARSAQ
--   Script Created at           : 13/08/2018 13:19:50
--   Notes                       : 
--
-- 13.08.2018 COBUMMFO-8319 Реалізація взаємодії між Банком, Біржою та Учасниками біржі при 
--здійснені розрахунків відповідно до умов Договору Ескроу - в рамках заявки додано операції 'IBP','IBL','IBE'
--
-- Object Counts: 
--   Triggers: 1 


CREATE OR REPLACE TRIGGER BARS."TU_OPER_SS_VOB"
BEFORE INSERT ON BARS.OPER for each row follows TIU_OPER_CHK
WHEN (
(new.tt in ('KL1','KL2','IB1','IB2','IBB','IBO','IBS','IB5')
and   ( new.dk = 1 and substr(new.nlsa,1,2) in ('20','21','22','29')
        or
        new.dk = 0 and substr(new.nlsb,1,2) in ('20','21','22','29')
       )) or 
 --COBUMMFO-8319
 new.tt in ('IBP','IBL','IBE')       
      )
begin
  If :new.vob in ( 1,2) then  :new.vob := 6 ; end if;
end;
/
SHOW ERRORS;
/