

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBD_K_FI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view MBD_K_FI ***

  CREATE OR REPLACE FORCE VIEW BARS.MBD_K_FI ("ACC", "CC_ID", "ND", "NBS", "NLS", "KV", "NMS", "BRANCH", "TAG", "VALUE", "SEMANTIC") AS 
  select a.acc,p.cc_id, p.nd, a.nbs,a.nls,a.kv,a.nms,a.branch,w.tag ,w.value,s.semantic
from
(select * from accounts where nbs in ('1623','1624','1627','1324','1327')) a,
(select * from accountsw where tag='FI_ND') w,
(select * from  sparam_list where tag='FI_ND')s,
 mbd_k p
where a.acc=w.acc(+)
 and w.tag = 'FI_ND'
 and w.tag=s.tag
 and w.value  is not null
 and a.acc=p.acc;

PROMPT *** Create  grants  MBD_K_FI ***
grant SELECT                                                                 on MBD_K_FI        to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBD_K_FI.sql =========*** End *** =====
PROMPT ===================================================================================== 
