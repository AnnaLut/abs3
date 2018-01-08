

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_86_NEW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_86_NEW ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_86_NEW ("SOS", "R020", "P080", "OB88", "NLS", "NMSN", "D_OPEN") AS 
  select 0 sos,
       p.r020 r020,
       p.p080 p080,
       z.ob88 ob88,
       rtrim(rpad(p.R020||'_'||p.P080||substr(z.OB88,1,4),14))  nls,
       substr('('||p.R020||'/'||z.OB88||')'||z.txt,1,70)   nmsn,
       z.d_open
     from  (select * from  sb_p086 where (d_close is null or d_close>gl.bd) ) p,
           (select * from  sb_ob88 where (d_close is null or d_close>gl.bd)
                   )   z
     where (p.d_close is null or p.d_close>gl.bd)
           and    p.r020=z.r020
           and    not exists
           (select 1 from  accounts a,specparam_int s
                     where  a.nbs=p.r020 and a.kv=980 and a.nbs=z.r020
                       and  a.acc=s.acc(+)
                       and  s.p080=p.p080
                       and  s.ob88=z.ob88
                       and  substr(a.nls,-4,2) = substr(z.ob88,1,2)
                       and  substr(a.nls,6,4)  = p.p080
                       and  a.dazs is null)
                       order by ob88,p080;

PROMPT *** Create  grants  ACC_86_NEW ***
grant SELECT,UPDATE                                                          on ACC_86_NEW      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on ACC_86_NEW      to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_86_NEW.sql =========*** End *** ===
PROMPT ===================================================================================== 
