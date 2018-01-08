

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_RETEIL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_RETEIL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_RETEIL ("ID", "CP_ID", "KV", "R_NOM", "R_KUPON", "V_CENA", "KUPON", "RAZM", "RAZM_B", "VYKUP", "VYKUP_B", "POGK", "POGK_B", "POGN", "POGN_B") AS 
  SELECT k.id,
          k.cp_id,
          k.kv,
          r.nom,
          r.kupon,
          k.cena,
          k.cena_kup,
          CASE
             WHEN    n.NLS_29r IS NULL
                  OR NLS_98R IS NULL
                  OR SysDate < k.dat_em
                  OR SysDate >= k.datp or  SysDate > k.datzr --NVL(k.datzr, SysDate)
				  OR r.nom = 0
             THEN
                NULL
             ELSE
                make_docinput_url ('$RN',                                   'Розмiщ. гот.',
                                   'DisR',                                   '1',
				                   'SK',                                     '31',
								   'VOB',                                     220,
								   'Nls_A',                                   n.cash,
                                   'Nls_B',                                   n.NLS_29r,
                                   'Kv_A',                                    TO_CHAR (k.kv),
                                   'Kv_B',                                    TO_CHAR (k.kv),
                                   'reqv_S_NOM',                              TO_CHAR (r.nom),
                                   'reqv_S_KUT',                              TO_CHAR (r.kupon),
 								   'reqv_KODCP',                              k.id,
								   'reqv_O9819',                              NLS_98R)
          END
             RAZM,
			 CASE
             WHEN    n.NLS_29r IS NULL
                  OR NLS_98R IS NULL
                  OR SysDate < k.dat_em
                  OR SysDate >= k.datp or  SysDate > k.datzr --NVL(k.datzr, SysDate)
				  OR r.nom = 0
             THEN
                NULL
             ELSE
                make_docinput_url ('$RN',                                   'Розмiщ. безг.',
                                   'DisR',                                   '1',
                                   'Nls_B',                                   n.NLS_29r,
								   'VOB',                                     49,
                                   'Kv_A',                                    TO_CHAR (k.kv),
                                   'Kv_B',                                    TO_CHAR (k.kv),
                                   'reqv_S_NOM',                              TO_CHAR (r.nom),
                                   'reqv_S_KUT',                              TO_CHAR (r.kupon),
 								   'reqv_KODCP',                              k.id,
								   'reqv_O9819',                              NLS_98R)
          END
             RAZM_B,
          CASE
             WHEN    n.NLS_28v IS NULL
                  OR NLS_98v IS NULL
                  OR SysDate < k.dat_em
                  OR SysDate >= nvl(k.datp, SysDate+1)
             THEN
                NULL
             ELSE
                make_docinput_url ('$VN',                                   'Викуп готів.',
                                   'DisR',                                  '1',
				                   'SK',                                    '60',
								   'DK',                                     0,
								   'VOB',                                    220,
								   'Nls_A',                                  n.cash,
                                   'Nls_B',                                  n.NLS_28v,
                                   'Kv_A',                                   TO_CHAR (k.kv),
                                   'Kv_B',                                   TO_CHAR (k.kv),
                                   'reqv_S_NOM',                             TO_CHAR (k.cena),
                                   'reqv_S_KUT',                             TO_CHAR (0),
								   'reqv_KODCP',                             k.id,
								   'reqv_O9819',                             NLS_98v)
          END
             VYKUP,
		CASE
             WHEN  n.NLS_28v IS NULL
                  OR NLS_98v IS NULL
                  OR SysDate < k.dat_em
                  OR SysDate >= nvl(k.datp, SysDate+1)
             THEN
                NULL
             ELSE
                make_docinput_url ('$VN',                                   'Викуп безготів.',
                                   'DisR',                                  '1',
								   'DK',                                     0,
								   'VOB',                                    49,
								   'Nls_B',                                  n.NLS_28v,
                                   'Kv_A',                                   TO_CHAR (k.kv),
                                   'Kv_B',                                   TO_CHAR (k.kv),
                                   'reqv_S_NOM',                             TO_CHAR (k.cena),
                                   'reqv_S_KUT',                             TO_CHAR (0),
								   'reqv_KODCP',                             k.id,
								   'reqv_O9819',                             NLS_98v)
          END
             VYKUP_B,
          CASE
             WHEN  n.NLS_28k   IS NULL
                  OR NLS_98k   IS NULL
                  OR SysDate <= k.datvk --TO_DATE ('10.04.2013', 'dd.mm.yyyy')
                  --OR SysDate > k.datp --TO_DATE ('10.04.2014', 'dd.mm.yyyy')
				  OR SysDate >= ADD_MONTHS(k.datp,12)+1
             THEN
                NULL
             ELSE
                make_docinput_url ('$PK',                                   'Погаш.купону готівк.',
                                   'DisR',                                   '1',
								   'DK',                                     0,
								   'SK',                                    '60',
								   'VOB',                                    220,
								   'Nls_A',                                  n.cash,
                                   'Nls_B',                                   n.NLS_28k,
                                   'Kv_A',                                   TO_CHAR (k.kv),
                                   'Kv_B',                                   TO_CHAR (k.kv),
                                   'reqv_S_KUT',                             TO_CHAR (k.cena_kup),
								   'reqv_KODCP',                             k.id,
								   'reqv_O9819',                             NLS_98k)
          END
             POGK,
		 CASE
             WHEN  n.NLS_28k   IS NULL
                  OR NLS_98k   IS NULL
                  OR SysDate <= k.datvk --TO_DATE ('10.04.2013', 'dd.mm.yyyy')
                 -- OR SysDate > k.datp --TO_DATE ('10.04.2014', 'dd.mm.yyyy')
				  OR SysDate >= ADD_MONTHS(k.datp,12)+1
             THEN
                NULL
             ELSE
                make_docinput_url ('$PK',                                   'Погаш.купону безгот.',
                                   'DisR',                                   '1',
								   'DK',                                     0,
								   'VOB',                                    49,
                                   'Nls_B',                                   n.NLS_28k,
                                   'Kv_A',                                   TO_CHAR (k.kv),
                                   'Kv_B',                                   TO_CHAR (k.kv),
                                   'reqv_S_KUT',                             TO_CHAR (k.cena_kup),
								   'reqv_KODCP',                             k.id,
								   'reqv_O9819',                             NLS_98k)
          END
             POGK_B,
          CASE
             WHEN n.NLS_28n IS NULL OR NLS_98n IS NULL OR SysDate <= k.datp OR SysDate >= ADD_MONTHS(k.datp,12)+1
             THEN
                NULL
             ELSE
                make_docinput_url ('$00',                                   'Погаш.ном+ост.куп.',
                                   'DisR',                                   '1',
								   'SK',                                    '60',
								   'DK',                                     0,
								   'VOB',                                    220,
								   'Nls_A',                                  n.cash,
                                   'Nls_B',                                   n.NLS_28n,
                                   'Kv_A',                                   TO_CHAR (k.kv),
                                   'Kv_B',                                   TO_CHAR (k.kv),
                                   'reqv_S_NOM',                             TO_CHAR (k.cena + k.cena_kup),
								   'reqv_S_KUT',                             TO_CHAR (k.cena_kup),
								   'reqv_KODCP',                             k.id,
								   'reqv_O9819',                             NLS_98n)
          END
             POGN,
		  CASE
             WHEN n.NLS_28n IS NULL OR NLS_98n IS NULL OR SysDate <= k.datp OR SysDate >= ADD_MONTHS(k.datp,12)+1
             THEN
                NULL
             ELSE
                make_docinput_url ('$00',                                   'Погаш.ном+ост.куп.',
                                   'DisR',                                   '1',
								   'DK',                                     0,
								   'VOB',                                    49,
                                   'Nls_B',                                   n.NLS_28n,
                                   'Kv_A',                                   TO_CHAR (k.kv),
                                   'Kv_B',                                   TO_CHAR (k.kv),
                                   'reqv_S_NOM',                             TO_CHAR (k.cena + k.cena_kup),
								   'reqv_S_KUT',                             TO_CHAR (k.cena_kup),
								   'reqv_KODCP',                             k.id,
								   'reqv_O9819',                             NLS_98n)
          END
             POGN_B
     FROM cp_kaz k,
          cena_razm r,
  (SELECT p.id,   nbs_ob22_RAV ('9820', ob.NLS_98R, 980) NLS_98R,
                  nbs_ob22_RAV ('2901', ob.NLS_29r, kv) NLS_29r,
                  nbs_ob22_RAV ('9819', ob.NLS_98V, 980) NLS_98V,
                  nbs_ob22_RAV ('2801', ob.NLS_28V, kv) NLS_28V,
                  nbs_ob22_RAV ('9812', ob.NLS_98K, 980) NLS_98K,
                  nbs_ob22_RAV ('2801', ob.NLS_28K, kv) NLS_28K,
                  nbs_ob22_RAV ('9812', ob.NLS_98N, 980) NLS_98N,
                  nbs_ob22_RAV ('2801', ob.NLS_28N, kv) NLS_28N,
                  BRANCH_USR.GET_BRANCH_PARAM2('CASH',0) cash
             FROM cp_kaz p, CP_KAZ_OB ob where p.id = ob.id ) n
    WHERE      r.id = k.id and n.id = k.id
          --AND k.datp > SysDate
          AND trunc(SysDate) >= r.dat_beg
          AND trunc(SysDate) <= r.dat_end
          -- AND r.nom > 0
		  and sysdate < ADD_MONTHS(k.datp,12)+1
		  ;

PROMPT *** Create  grants  V_CP_RETEIL ***
grant FLASHBACK,SELECT                                                       on V_CP_RETEIL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_RETEIL     to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CP_RETEIL     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_CP_RETEIL     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_RETEIL.sql =========*** End *** ==
PROMPT ===================================================================================== 
