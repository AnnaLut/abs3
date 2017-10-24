

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_9819.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_9819 ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_9819 ("OPER", "VIDD", "ND", "CC_ID", "RNK", "DSDATE", "SOS", "NAMK", "BRANCH") AS 
  SELECT make_url ('/barsroot/docinput/depository.aspx', 'Виконати') oper,
/*make_url('/barsroot/docinput/depository.aspx', 'Виконати', 'param_name', 'param_value');*/
          iif_n (d.vidd, 10, 'ЮЛ', '', 'ФЛ') vidd, d.nd, d.cc_id, d.rnk,
          d.sdate, d.sos, c.nmk, d.branch
     FROM cc_deal d, customer c
    WHERE c.rnk = d.rnk AND d.sos < 15
 ;

PROMPT *** Create  grants  CC_9819 ***
grant FLASHBACK,SELECT                                                       on CC_9819         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_9819         to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CC_9819         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_9819.sql =========*** End *** ======
PROMPT ===================================================================================== 
