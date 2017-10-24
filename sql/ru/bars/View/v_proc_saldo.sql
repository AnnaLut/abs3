

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PROC_SALDO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROC_SALDO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PROC_SALDO ("ORD", "TIP", "OST") AS 
  SELECT 1, 'MAX', ostf-lim FROM lkl_rrp
				  WHERE lkl_rrp.mfo=(select val from params where par='MFOP') AND lkl_rrp.kv  = 980
        UNION ALL SELECT 2, 'L00', ostf FROM lkl_rrp
				  WHERE lkl_rrp.mfo=(select val from params where par='MFOP') AND lkl_rrp.kv  = 980
        UNION ALL SELECT 3, 'LIM', lim FROM lkl_rrp
				  WHERE lkl_rrp.mfo=(select val from params where par='MFOP') AND lkl_rrp.kv  = 980
		UNION ALL SELECT 4, 'N00', -ostc FROM accounts WHERE
			case when tip in ('N00','L00','L01','T00','T0D','TNB','TND','L99','N99','TUR','TUD','902','90D') then tip else null end = 'N00'
			AND kv = 980
        UNION ALL SELECT 5, 'TNB', -ostc FROM accounts WHERE
			case when tip in ('N00','L00','L01','T00','T0D','TNB','TND','L99','N99','TUR','TUD','902','90D') then tip else null end = 'TNB'
			AND kv = 980
        UNION ALL SELECT 6, 'T00', ostc FROM accounts WHERE
			case when tip in ('N00','L00','L01','T00','T0D','TNB','TND','L99','N99','TUR','TUD','902','90D') then tip else null end = 'T00'
			AND kv = 980
		UNION ALL SELECT 7, 'T0D', -ostc FROM accounts WHERE
			case when tip in ('N00','L00','L01','T00','T0D','TNB','TND','L99','N99','TUR','TUD','902','90D') then tip else null end = 'T0D'
			AND kv = 980
        UNION ALL SELECT 8, 'L99', ostc FROM accounts WHERE
			case when tip in ('N00','L00','L01','T00','T0D','TNB','TND','L99','N99','TUR','TUD','902','90D') then tip else null end = 'L99'
			AND kv = 980;

PROMPT *** Create  grants  V_PROC_SALDO ***
grant SELECT                                                                 on V_PROC_SALDO    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PROC_SALDO    to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PROC_SALDO    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PROC_SALDO.sql =========*** End *** =
PROMPT ===================================================================================== 
