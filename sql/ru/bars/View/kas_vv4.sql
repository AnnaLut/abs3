

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_VV4.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_VV4 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_VV4 ("KODV", "NAME", "NAME1", "KV", "BRANCH", "DAT2", "S") AS 
  select m.KOD, m.name, m.name1, a2.kv, a2.branch,
       to_char(a2.DAzs,'dd/mm/yyyy') DAT2, a2.pos-1 S
from accounts a2, specparam_int s2 ,
     (select OB22 kod, substr(ob22,1,4) NBS1, substr(ob22,5,2) ob1,
             decode(substr(ob22,1,4),'9821','9893','9820','9891','9899') NBS7,
             ob22_dor Ob7,
             name,
             decode(OB22_205,null,'','Для розповсюдж.') name1
      from valuables where OB22_DOR  is not null ) m
where a2.nbs=m.NBS1 and a2.dazs is null and a2.acc=s2.acc and s2.ob22=m.ob1
  and a2.branch like sys_context('bars_context','user_branch')||'%'
  and a2.kv=980
  and exists (select 1
              from accounts a7,specparam_int s7
              where a7.nbs=m.NBS7 and a7.dazs is null and a7.kv=a2.kv
                and a7.acc=s7.acc and s7.ob22=m.ob7
                and a7.branch = substr(a2.branch,1,15)
               )
  and exists (select 1
              from accounts a1,specparam_int s1
              where a1.nbs=m.NBS1 and a1.dazs is null and a1.kv=a2.kv
                and a1.acc=s1.acc and s1.ob22=m.ob1
                and a1.branch = kasz.SX('BRN')
                and a1.ostb <>0
              );

PROMPT *** Create  grants  KAS_VV4 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV4         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VV4         to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_VV4.sql =========*** End *** ======
PROMPT ===================================================================================== 
