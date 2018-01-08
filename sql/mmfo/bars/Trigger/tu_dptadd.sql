

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPTADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPTADD ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPTADD 
before update of OSTB, OSTC
on ACCOUNTS
for each row
 WHEN ( old.NBS in ('2630','2635')
       AND
       ( ( nvl(old.OSTB,0) > 0 and new.OSTB > old.OSTB )
        or
         ( nvl(old.OSTC,0) > 0 and new.OSTC > old.OSTC )
       )
     ) declare
  l_res   integer;
begin

  if ( gl.aTT in ( 'DP5', 'DPL' ) )
  then -- виплата відсотків (капіталізація)
    l_res := 0;
  else
    case
    when ( :new.OSTB > :old.OSTB )
    then l_res := DPT_WEB.FORBIDDEN_AMOUNT( :old.ACC, ( :new.OSTB - :old.OSTB ) );
    when ( :new.OSTC > :old.OSTC )
    then l_res := DPT_WEB.FORBIDDEN_AMOUNT( :old.ACC, ( :new.OSTC - :old.OSTC ) );
    else l_res := 0;
    end case;
  end if;

  case
  when ( l_res = 0 )
  then null;
  when ( l_res = 1 )
  then raise_application_error( -20803, '\******Вклад не передбачає поповнення!', TRUE );
  else raise_application_error( -20803, '\******Cума зарахування на депозитний рахунок менша за мінімальну суму поповнення вкладу ('
                                     || to_char(l_res/100) ||' '|| to_char(:old.KV) || ')', TRUE );
  end case;

end TU_DPTADD;
/
ALTER TRIGGER BARS.TU_DPTADD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPTADD.sql =========*** End *** =
PROMPT ===================================================================================== 
