

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PER_NL_.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PER_NL_ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PER_NL_ AS 
  SELECT   REF,
            nlsa,
            s / 100 s,
            datd,
            nazno,
            utl_url.escape(url=> 'BEGIN NULL; END;@NLK_REF_WEB('|| REF|| ',:REF,'||acc||',1);', url_charset=>'AL32UTF8') bproc,
            utl_url.escape(url=> 'BEGIN NULL; END;@NLK_REF_WEB('|| REF|| ',:REF,'||acc||',2);', url_charset=>'AL32UTF8') APROC,
            ACC,
            KVA,
            TIP,
            country
       FROM (SELECT a.nls nlsa,
                    a.kv kva,
                    (SELECT datd FROM oper WHERE REF = o.REF) datd,
                    o.s s,
                    (SELECT nazn FROM oper WHERE REF = o.REF) nazno,
                    o.REF,
                    n.acc,
                    a.tip,
                    (select substr(d_rec,instr(d_rec,'#n')+2,4) from oper where ref = o.ref) country
               FROM opldok o,
                   (select * from nlk_ref nn where REF2 IS NULL
                     or exists (select 1 from oper where ref = nn.REF2 and sos < 0)
                                                      )  n,
                    v_gl a
              WHERE a.acc = o.acc
                AND a.tip  like 'NL_'
                AND n.REF1 = o.REF  --AND n.REF2 is null
                AND n.acc = a.acc and a.dazs is null
                AND o.sos = 5
                AND o.dk = 1)
   ORDER BY ref desc
  ;

PROMPT *** Create  grants  V_PER_NLY ***
grant SELECT                                                                 on V_PER_NLY       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,SELECT                                                on V_PER_NLY       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PER_NLY       to RCC_DEAL;
grant SELECT                                                                 on V_PER_NLY       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PER_NLY       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_PER_NLY       to WR_REFREAD;

PROMPT *** Create  grants  V_PER_NL_ ***
grant SELECT                                                                 on V_PER_NL_       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,SELECT                                                on V_PER_NL_       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PER_NL_       to RCC_DEAL;
grant DELETE,FLASHBACK,SELECT                                                on V_PER_NL_       to START1;
grant SELECT                                                                 on V_PER_NL_       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PER_NL_       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_PER_NL_       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PER_NL_.sql =========*** End *** ====
PROMPT ===================================================================================== 
