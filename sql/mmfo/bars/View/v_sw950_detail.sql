

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW950_DETAIL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW950_DETAIL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW950_DETAIL ("NUMROW", "VDATE", "DEBIT_SUM", "CREDIT_SUM", "SWTT", "MT", "THEIR_REF", "DETAIL", "SRC_SWREF", "PROCESSED", "SW950REF", "THEIR2_REF", "STMT_DK") AS 
  select
       d.n,
       d.vdate,
       decode(sign(d.s),-1,-d.s,to_number(null))/100,
       decode(sign(d.s), 1, d.s,to_number(null))/100,
       d.swtt,
       d.mt,
       d.their_ref,
       d.detail,
       d.src_swref,
       nvl(d.checked_ind, 'N'),
       d.swref,
	   d.their2_ref,
	   d.stmt_dk
  from sw_950d d
with read only;

PROMPT *** Create  grants  V_SW950_DETAIL ***
grant SELECT                                                                 on V_SW950_DETAIL  to BARS013;
grant SELECT                                                                 on V_SW950_DETAIL  to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW950_DETAIL  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW950_DETAIL.sql =========*** End ***
PROMPT ===================================================================================== 
