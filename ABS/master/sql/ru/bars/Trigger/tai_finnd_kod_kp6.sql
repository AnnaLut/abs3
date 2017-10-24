

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_FINND_KOD_KP6.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_FINND_KOD_KP6 ***

  CREATE OR REPLACE TRIGGER BARS.TAI_FINND_KOD_KP6 
after insert or update  ON BARS.FIN_ND for each row
 WHEN (
new.kod = 'KP6' and  nvl(new.s, 0) in (1,2) and  nvl(old.s, 0) != nvl(new.s, 0)
      ) declare
  istval_ number;
begin

 for k in (
 select a.acc
from cc_deal c, nd_acc ac, accounts a
where c.nd = ac.nd
    and a.acc = ac.acc
    and (a.dazs is null or a.dazs > gl.bd-31)
    and c.rnk = :new.rnk
    and c.nd = :new.nd
  )
LOOP

case when :new.s = 1 then istval_ := 1;
       when :new.s = 2 then istval_ := 0;
       else return;
end case;

update  specparam
    set istval = istval_
    where  acc = k.acc;

END LOOP;


end;
/
ALTER TRIGGER BARS.TAI_FINND_KOD_KP6 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_FINND_KOD_KP6.sql =========*** E
PROMPT ===================================================================================== 
