

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPTADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPTADD ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPTADD 
   BEFORE UPDATE OF OSTB, OSTC
   ON BARS.ACCOUNTS
   REFERENCING FOR EACH ROW
 WHEN (
OLD.NBS in ('2630','2635') AND ((NEW.ostb > OLD.ostb) or (NEW.ostc > OLD.ostc))
      ) DECLARE
 ern   CONSTANT POSITIVE := 803;
 err            EXCEPTION;
 erm            VARCHAR2 (1024);
 l_sum number;
 l_res number;
 l_kv           varchar2(3);
BEGIN
  if (:NEW.ostb > :OLD.ostb)
  then l_sum := (:NEW.ostb - :OLD.ostb);
  elsif(:NEW.ostc > :OLD.ostc)
  then l_sum := (:NEW.ostc - :OLD.ostc);
  end if;
  l_kv := :OLD.kv;
  begin
  l_res := dpt_web.forbidden_amount(:OLD.acc,l_sum);
  if (l_res = 0)
  then return;
  elsif (l_res = 1)
  then erm :='******Вклад не передбачає поповнення!';
       RAISE err;
  else erm :='******Cума зарахування на депозитний рахунок менша за мінімальну суму поповнення вкладу ('|| to_char(l_res/100) ||' '|| l_kv || ')';
       RAISE err;
  end if;
  EXCEPTION
   WHEN err
   THEN raise_application_error (- (20000 + ern), '\' || erm, TRUE);
  end;
 return;
END TU_DPTADD;
/
ALTER TRIGGER BARS.TU_DPTADD DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPTADD.sql =========*** End *** =
PROMPT ===================================================================================== 
