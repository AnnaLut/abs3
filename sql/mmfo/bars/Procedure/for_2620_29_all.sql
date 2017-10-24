

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FOR_2620_29_ALL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FOR_2620_29_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.FOR_2620_29_ALL (p_TIP accounts.tip%type) Is
begin
  for k in (select n.acc, n.ref1
            from accounts a, nlk_ref n
            where a.acc  = n.acc
              and a.tip  = p_TiP
              and a.ostc > 0
              and n.ref1 is not null
              and n.ref2 is null
          FOR UPDATE OF n.REF2 NOWAIT)
  loop
      for_2620_29 ( k.acc, k.REF1);
  end loop;

  commit;
end for_2620_29_ALL;
/
show err;

PROMPT *** Create  grants  FOR_2620_29_ALL ***
grant EXECUTE                                                                on FOR_2620_29_ALL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOR_2620_29_ALL to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FOR_2620_29_ALL.sql =========*** E
PROMPT ===================================================================================== 
