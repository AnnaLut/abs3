

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SS_VOB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_SS_VOB ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_SS_VOB 
BEFORE INSERT ON BARS.OPER for each row follows TIU_OPER_CHK
 WHEN (
new.tt in ('KL1','KL2','IB1','IB2','IBB','IBO','IBS','IB5')
and   ( new.dk = 1 and substr(new.nlsa,1,2) in ('20','21','22','29')
        or
        new.dk = 0 and substr(new.nlsb,1,2) in ('20','21','22','29')
       )
      ) begin
  If :new.vob in ( 1,2) then  :new.vob := 6 ; end if;
end;
/
ALTER TRIGGER BARS.TU_OPER_SS_VOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SS_VOB.sql =========*** End 
PROMPT ===================================================================================== 
