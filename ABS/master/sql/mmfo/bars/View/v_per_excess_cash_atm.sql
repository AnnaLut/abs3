

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PER_EXCESS_CASH_ATM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PER_EXCESS_CASH_ATM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PER_EXCESS_CASH_ATM ("REF", "NLSA", "S", "DATD", "NAZNO", "BPROC", "APROC", "ACC", "KVA", "TIP", "SO") AS 
  SELECT   REF,
            nlsa,
            s / 100 s,
            datd,
            nazno,
            utl_url.escape(url=> 'BEGIN NULL; END;@pack_nlk.NLK_REF_WEB('|| REF|| ',:REF,'||acc||',1);', url_charset=>'AL32UTF8') bproc,
            utl_url.escape(url=> 'BEGIN NULL; END;@pack_nlk.NLK_REF_WEB('|| REF|| ',:REF,'||acc||',3);', url_charset=>'AL32UTF8') APROC,
            ACC,
            KVA,
            TIP,
			so/100 so
       FROM (SELECT
	                a.nls nlsa,
                    a.kv kva,
                    p.datd,
                    nvl(n.amount,o.s) s,
                    p.nazn nazno,
                    o.REF,
                    n.acc,
                    a.tip,
					o.s so
               FROM opldok o, oper p,
                    nlk_ref n,
                    v_gl a
              WHERE n.acc = o.acc
                AND a.tip in ('NLY')
				and a.nls like '2924%' and a.ob22 = '07'
                AND n.REF1 = o.REF   and o.ref = p.ref
               -- AND (n.REF2 is null   or exists (select 1 from oper where ref = n.REF2 and sos = -1) )
			    and ref2 is null
                AND n.acc = a.acc and a.dazs is null
                AND o.sos = 5
                AND o.dk = 1)
   ORDER BY ref desc
  ;

PROMPT *** Create  grants  V_PER_EXCESS_CASH_ATM ***
grant SELECT                                                                 on V_PER_EXCESS_CASH_ATM to BARSREADER_ROLE;
grant DELETE,FLASHBACK,SELECT                                                on V_PER_EXCESS_CASH_ATM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PER_EXCESS_CASH_ATM to RCC_DEAL;
grant SELECT                                                                 on V_PER_EXCESS_CASH_ATM to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PER_EXCESS_CASH_ATM to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_PER_EXCESS_CASH_ATM to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PER_EXCESS_CASH_ATM.sql =========*** 
PROMPT ===================================================================================== 
