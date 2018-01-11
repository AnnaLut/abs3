

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_87_NEW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_87_NEW ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_87_NEW ("SOS", "R020", "P080", "R020_FA", "OB22", "NAME", "NLS", "NMSN", "D_OPEN") AS 
  select 0 sos,
       p.r020 r020,
       p.p080 p080,
       p.r020_fa r020_fa,
       p.ob22 ob22,
       substr(p.txt,1,35) name,
       R020||'_'||'11'||R020_FA||
     decode(substr(OB22,1,1),'A','10',
                             'B','11','C','12','D','13',
                             'E','14','F','15','G','16',
                             'H','17','I','18','J','19',
                             'K','20','L','21','M','22',
                             'N','23','O','24','P','25',
							 'Q','26','R','27','S','28',
							 'T','29','U','30','V','31',
							 substr(OB22,1,1))||
                             substr(OB22,2,1)   nls,
       substr(p.txt,1,70) nmsn,
       p.d_open
     from   sb_p0853 p
     where (p.d_close is null or p.d_close>gl.bd)
           and p.r020_fa<>'0000' and ob22<>'00' and  not exists
           (select 1 from  accounts a,specparam_int s
                     where  a.nbs=p.r020 and a.kv=980
                       and  a.acc=s.acc
                       and  s.p080=p.p080
                       and  s.r020_fa=p.r020_fa
                       and  s.ob22=p.ob22
                       and  a.dazs is null)
union all
select 0 sos,
       p.r020 r020,
       p.p080 p080,
       p.r020_fa r020_fa,
       p.ob22 ob22,
       substr(p.txt,1,35) name,
       R020||'_'||'11'||P080 nls,
       substr(p.txt,1,70) nmsn,
       p.d_open
     from   sb_p0853 p
     where (p.d_close is null or p.d_close>gl.bd)
           and p.r020_fa='0000' and p.ob22='00' and
           not exists
           (select 1 from  accounts a,specparam_int s
                     where  a.nbs=p.r020 and a.kv=980
                       and  a.acc=s.acc
                       and  s.p080=p.p080
                       and  s.r020_fa=p.r020_fa
                       and  s.ob22=p.ob22
                       and  a.dazs is null);

PROMPT *** Create  grants  ACC_87_NEW ***
grant SELECT                                                                 on ACC_87_NEW      to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on ACC_87_NEW      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on ACC_87_NEW      to NALOG;
grant SELECT                                                                 on ACC_87_NEW      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_87_NEW.sql =========*** End *** ===
PROMPT ===================================================================================== 
