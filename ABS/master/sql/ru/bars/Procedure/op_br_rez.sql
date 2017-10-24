

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BR_REZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BR_REZ ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BR_REZ 
 (P_branch accounts.branch%type ,
  p_kv     accounts.KV%type
 )
is

-- 18.10.2011 Sta
-- процедура для открытия всех счетов по учету рез для 1-го бранча по 1-й вал

BEGIN
 If length(p_branch) <> 15 then
    raise_application_error(-20100,
    '     OP_BR_REZ:Бранч '|| p_branch ||' не є бранчем другого рiвня');
 end if;

  for k in (select * from srezerv_ob22 where p_kv = decode (kv, 0, 980, kv) )
  loop
     If k.pr =       9  or k.nbs_rez = '3599' then
        OP_BR_REZ1 ( p_kv, p_branch, k.nbs_rez, k.ob22_rez, '9' );

     elsIf k.s080 = '1' OR k.nbs_rez = '2401' then
        OP_BR_REZ1 ( p_kv, p_branch, k.nbs_rez, k.ob22_rez, '1' );
     else
        OP_BR_REZ1 ( p_kv, p_branch, k.nbs_rez, k.ob22_rez, '2' );
        OP_BR_REZ1 ( p_kv, p_branch, k.nbs_rez, k.ob22_rez, '3' );
        OP_BR_REZ1 ( p_kv, p_branch, k.nbs_rez, k.ob22_rez, '4' );
        OP_BR_REZ1 ( p_kv, p_branch, k.nbs_rez, k.ob22_rez, '5' );
     end if;

     OP_BS_OB1 (p_BRANCH, k.NBS_7F || k.OB22_7F );
     OP_BS_OB1 (p_BRANCH, k.NBS_7r || k.OB22_7r );

   end loop;

end OP_BR_REZ;
/
show err;

PROMPT *** Create  grants  OP_BR_REZ ***
grant EXECUTE                                                                on OP_BR_REZ       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BR_REZ       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BR_REZ.sql =========*** End ***
PROMPT ===================================================================================== 
