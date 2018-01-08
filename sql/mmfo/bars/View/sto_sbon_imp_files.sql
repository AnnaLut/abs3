

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STO_SBON_IMP_FILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view STO_SBON_IMP_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.STO_SBON_IMP_FILES ("FN", "DAT", "BRANCH", "USERID", "KF", "DOCS_QTY", "DOCS_SUM", "OPL_NUM", "OPL_SUM", "OPL_PAY", "OPL_FEE", "DATP") AS 
  select x.fn
     , x.dat
	 , x.branch
     , x.userid
     , x.kf
     , x.docs_qty
     , x.docs_sum
     , sum(1) as opl_num
     , sum(o.s) as opl_sum
     , sum(case when substr(p.nlsa,1,4) in ('2902') or substr(p.nlsb,1,4) in ('2902') then o.s else 0 end) as opl_pay
     , sum(case when substr(p.nlsa,1,4) in ('6510') or substr(p.nlsb,1,4) in ('6510') then o.s else 0 end) as opl_fee
     , p.datp
from bars.opldok o, bars.xml_impfiles x, bars.accounts a, bars.xml_impdocs p
where o.ref=p.ref
  and x.dat>=trunc(sysdate) - 5
  and x.kf=o.kf
  and X.FN=p.fn
  and o.fdat=x.dat
  and o.acc=a.acc
  and a.nbs in ('1002','2924')
  and o.dk=0
  and o.sos=5
  and substr(p.nlsa,1,4) in ('2924','6510','2902','1002')
  and substr(p.nlsb,1,4) in ('2924','6510','2902','1002')
group by x.fn, x.dat, x.kf, x.docs_qty, x.docs_sum, x.branch, x.userid, p.datp;

PROMPT *** Create  grants  STO_SBON_IMP_FILES ***
grant SELECT                                                                 on STO_SBON_IMP_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_SBON_IMP_FILES to SBON;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STO_SBON_IMP_FILES.sql =========*** End
PROMPT ===================================================================================== 
