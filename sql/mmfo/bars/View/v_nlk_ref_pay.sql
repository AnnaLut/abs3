 

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NLK_REF_PAY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NLK_REF_PAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NLK_REF_PAY ("ACC", "REF", "VDAT", "MFOA", "NLSA", "TT", "REF2", "VDAT2", "MFOB", "NLSB", "TT2", "NAZN", "FIO", "SOS", "PDAT", "PDAT2") AS 
  select a.acc, o.ref, o.vdat, o.mfoa, o.nlsa, o.tt, o2.ref ref2, o2.vdat vdat2, o2.mfob, o2.nlsb, o2.tt tt2, o2. nazn, s.fio, o2.sos, o.pdat, o2.pdat as pdat2 
  from NLK_REF_UPDATE a, oper o, oper o2, staff$base s, v_gl aa   
 where a.rowid in (select max(rowid)
                   from NLK_REF_UPDATE
                  where acc = a.acc
                    and ref1 = a.ref1    
                   group by ref1)
 --and a.acc = pul.get_mas_ini_val ('nly_acc')                    
 and a.acc = aa.acc
 and o.ref = a.ref1
 and o2.ref = a.ref2
 and nvl(ref2,0)> 0-- is not null
 and o2.userid = s.id
 union all
 select a.acc, o.ref, o.vdat, o.mfoa, o.nlsa, o.tt, a.ref1 ref2, trunc(a.CHGDATE) vdat2, null mfob, null nlsb, null  tt2, 'Видалено з картотеки' nazn, s.fio fio, -1 sos, o.pdat, a.CHGDATE as pdat2 
  from NLK_REF_UPDATE a, oper o, v_gl aa, staff$base s   
 where a.rowid in (select max(rowid)
                   from NLK_REF_UPDATE
                  where acc = a.acc
                    and ref1 = a.ref1
                    and chgaction = 3    
                   group by ref1)
 and a.acc = aa.acc
 and o.ref = a.ref1
 and a.DONEBY = s.LOGNAME
 and a.ref2  is null
 order by 3;

PROMPT *** Create  grants  V_NLK_REF_PAY ***
grant DELETE,SELECT,UPDATE                                                   on V_NLK_REF_PAY   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NLK_REF_PAY.sql =========*** End *** 
PROMPT ===================================================================================== 
