

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PER_NLY.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PER_NLY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PER_NLY ("REF", "NLSA", "S", "DATD", "NAZNO", "BPROC", "APROC", "ACC", "KVA", "TIP") AS 
  SELECT   REF,
            nlsa,
            s / 100 s,
            datd,
            nazno,
            utl_url.escape(url=> 'BEGIN NULL; END;@NLK_REF_WEB('|| REF|| ',:REF,'||acc||',1);', url_charset=>'AL32UTF8') bproc,
            utl_url.escape(url=> 'BEGIN NULL; END;@NLK_REF_WEB('|| REF|| ',:REF,'||acc||',2);', url_charset=>'AL32UTF8') APROC,
            ACC,
            KVA,
            TIP
       FROM (SELECT /*+ RESULT_CACHE */
	                a.nls nlsa,
                    a.kv kva,
                    p.datd,
                    o.s s,
                    p.nazn nazno,
                    o.REF,
                    n.acc,
                    a.tip--, test_pul(a.nbs)
               FROM opldok o, oper p,
                    nlk_ref n,
                    accounts a
              WHERE n.acc = o.acc
                AND a.tip in ('NLY')
				and a.nls like '2909%' --and a.ob22 = '08'
                AND n.REF1 = o.REF   and o.ref = p.ref
                AND (n.REF2 is null   or exists (select 1 from oper where ref = n.REF2 and sos = -1) )
                AND n.acc = a.acc and a.dazs is null
                AND o.sos = 5
                AND o.dk = 1
				and a.branch like substr(sys_context('bars_context','user_branch'),1,15)||'%')
   ORDER BY ref desc
  ;

PROMPT *** Create  grants  V_PER_NLY ***
grant SELECT                                                                 on V_PER_NLY       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,SELECT                                                on V_PER_NLY       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PER_NLY       to RCC_DEAL;
grant SELECT                                                                 on V_PER_NLY       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PER_NLY       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_PER_NLY       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PER_NLY.sql =========*** End *** ====
PROMPT ===================================================================================== 
