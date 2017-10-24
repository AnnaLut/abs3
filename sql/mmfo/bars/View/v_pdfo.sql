

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PDFO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PDFO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PDFO ("BRANCH", "NLS6", "T6", "Z6", "ACC6", "O6", "NLS5", "T5", "Z5", "ACC5", "O5", "V", "V100", "P", "P100", "MFOB", "NLSB", "NAMB", "ID_B") AS 
  select a6.branch, a6.nls NLS6,  a6.ostb /100 T6, a6.z/100 z6, a6.acc acc6, a6.ob22 o6,
                  a5.nls NLS5, -a5.ostb /100 T5, a5.z/100 z5, a5.acc acc5, a5.ob22 o5,
                  least   (a6.z, a5.z)  /100 V ,
                  least   (a6.z, a5.z)  V100   ,
                  greatest(a6.z-a5.z,0) /100 P ,
                  greatest(a6.z-a5.z,0) P100   ,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFOMFO'),1,06) MFOB,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = decode( a6.ob22, '36', 'PDFOVZB', 'PDFONLS') ),1,14) NLSB,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFONAM'),1,38) NAMB,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFOID' ),1,08) ID_B
from (select acc, branch,nls,ob22, ostb, least( ost_korr(acc,z23.E,z23.di,nbs), ostb) z
      from v_gl where kv = 980 and nbs = '3622' and ob22 in ('36','37') and (dazs is null or dazs > z23.E)
      ) a6,
     (select acc, branch,nls,ob22, ostb, least(-ost_korr(acc,z23.E,z23.di,nbs),-ostb) z
      from v_gl where kv = 980 and nbs = '3522' and ob22 in ('30','29') and (dazs is null or dazs > z23.E)
     ) a5
where a6.branch = a5.branch and (a6.ob22 = '36' and a5.ob22 ='30' or a6.ob22 = '37' and a5.ob22 ='29')
union all
select a6.branch, a6.nls NLS6,  a6.ostb/100 T6, a6.z/100 z6,         a6.acc  acc6, a6.ob22 o6,
                  ''     NLS5,            0 T5,        0 z5, to_number(null) acc5, ''      o5,
                  0 V, 0 V100,      a6.z/100 P, a6.z P100  ,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFOMFO'),1,06) MFOB,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFOVZB'),1,14) NLSB,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFONAM'),1,38) NAMB,
       substr( (select val from BRANCH_PARAMETERS where branch = a6.branch and tag = 'PDFOID' ),1,08) ID_B
from (select acc, branch,nls,ob22, ostb, least( ost_korr(acc,z23.E,z23.di,nbs), ostb) z
      from v_gl where kv = 980 and nbs = '3622' and ob22 ='38' and (dazs is null or dazs > z23.E)
      ) a6;

PROMPT *** Create  grants  V_PDFO ***
grant SELECT                                                                 on V_PDFO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PDFO          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PDFO.sql =========*** End *** =======
PROMPT ===================================================================================== 
