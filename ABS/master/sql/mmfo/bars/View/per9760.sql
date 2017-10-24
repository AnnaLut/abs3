

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PER9760.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view PER9760 ***

  CREATE OR REPLACE FORCE VIEW BARS.PER9760 ("PROSM", "S", "VDAT", "TOBO", "NAZN", "REFF", "SS", "VDAT1", "NAZN1") AS 
  SELECT DECODE (
            a.sos,
            5,    '<a href="'|| '/barsroot/documentview/default.aspx?ref='|| a.REF|| '" onclick="window.open(this.href, '''', ''width=900, height=600, resizable=yes,scrollbars=yes,status=yes''); return false">'|| a.REF|| '</a>',
                  '<a href="'|| '/barsroot/documentview/default.aspx?ref='|| a.REF|| '" onclick="window.open(this.href, '''', ''width=900, height=600, resizable=yes,scrollbars=yes,status=yes''); return false">'|| a.REF|| '</a>'|| ' - незавiзовано') prosm,
			 a.s / 100,
			 a.vdat,
			 a.tobo,
             SUBSTR (a.nazn, 11, 95) nazn,
					 DECODE (b.REF, NULL,
									DECODE ( a.sos, 5, make_docinput_url (
									   '976',                          'Зарахувати переказ',
									   'DisR',                         '1',
									   'SumC_t',                       a.s,
									   'reqv_FIO',                     a.fio,
									   'reqv_REF92',                   a.REF,
									   'reqv_P9760',                   '9910/03 - Внутрiш-регiон. переказ',
									   'reqv_D9760',                   'Зарахування переказу',
									   'reqv_TOBO3',                   a.tobo3,
									   'Nls_B',                        a.nlsb,
									   'Nls_A',                        nbs_ob22_null ('9760',DECODE (a.ob22, '23', '01', a.ob22),SUBSTR (a.bro, 1, 22)))),
						DECODE (
						   b.sos1,
						   0,    '<a href="'|| '/barsroot/documentview/default.aspx?ref='|| b.REF|| '" onclick="window.open(this.href, '''', ''width=900, height=600, resizable=yes,scrollbars=yes,status=yes''); return false">'|| b.REF|| '</a>'|| ' - незавiзовано',
						   5,    '<a href="'|| '/barsroot/documentview/default.aspx?ref='|| b.REF|| '" onclick="window.open(this.href, '''', ''width=900, height=600, resizable=yes,scrollbars=yes,status=yes''); return false">'|| b.REF|| '</a>',
						   1,    '<a href="'|| '/barsroot/documentview/default.aspx?ref='|| b.REF|| '" onclick="window.open(this.href, '''', ''width=900, height=600, resizable=yes,scrollbars=yes,status=yes''); return false">'|| b.REF|| '</a>'|| ' - незавiзовано')) reff,
			 b.s / 100 ss,
			 b.vdat vdat1,
			 SUBSTR (b.nazn, 1, 22) || SUBSTR (b.nazn, 46, 60) nazn1
    FROM (SELECT O1.REF,
                 O1.s,
                 O1.sos,
                 O1.vdat,
                 O1.nazn,
                 w.VALUE bro,
                 O1.nlsb,
                 a1.ob22,
                 (SELECT VALUE FROM operw WHERE tag = 'A9760' AND REF = O1.REF) a9760,
                 (SELECT VALUE FROM operw WHERE tag = 'FIO' AND REF = O1.REF)   fio,
                 w.VALUE tobo3,
                 O1.tobo
            FROM oper O1, accounts a1, operw w
           WHERE w.VALUE LIKE SYS_CONTEXT ('bars_context', 'user_branch') || '%'
                 AND EXISTS(SELECT 1  FROM accounts ACCOUNTS1 WHERE O1.nlsb = nls AND nbs = '9910' AND ob22 = '03' AND kv = 980 AND kf = f_ourmfo AND branch LIKE SUBSTR (SYS_CONTEXT ('bars_context','user_branch'),1,15)|| '%')
                 AND O1.nlsa = a1.nls
                 AND a1.nbs = '9760'
                 AND O1.pdat BETWEEN TRUNC (SYSDATE - 21) AND SYSDATE
                 AND O1.dk = 0
                 AND O1.sos = 5
                 AND w.tag = 'TOBO3'
                 AND O1.REF = w.REF) a,
         (SELECT O2.REF,
                 O2.s,
                 O2.vdat,
                 O2.nazn,
                 NULL bro,
                 O2.sos sos1,
                 O2.nd,
                 (SELECT VALUE FROM operw  WHERE tag = 'REF92' AND REF = O2.REF) ref92
            FROM oper O2, opldok k, opldok k1
           WHERE     O2.REF = k.REF
                 AND k.tt = '976'
                 AND k1.tt = '976'
                 AND k.stmt = k1.stmt
                 AND k.REF = k1.REF
                 AND (k1.acc, k1.dk) IN
                        (SELECT NVL (acc, acc), NVL (1, UID)
                           FROM accounts ACCOUNTS2
                          WHERE     nbs = '9910'  AND ob22 = '03'
                                     AND kv = 980 AND kf = f_ourmfo
                                AND branch LIKE SUBSTR (SYS_CONTEXT ('bars_context','user_branch'),1, 15)|| '%')
                 AND EXISTS
                        (SELECT 1 FROM v_gl WHERE     nbs = '9760' AND k.acc = acc AND kv = 980 AND kf = f_ourmfo AND k.dk = 0)
                 AND k.fdat BETWEEN SYSDATE - 21 AND SYSDATE
                 AND k1.fdat BETWEEN SYSDATE - 21 AND SYSDATE) b
   WHERE a.REF = b.ref92(+)
ORDER BY a.REF DESC;

PROMPT *** Create  grants  PER9760 ***
grant FLASHBACK,SELECT                                                       on PER9760         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PER9760         to PYOD001;
grant FLASHBACK,SELECT                                                       on PER9760         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PER9760         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PER9760.sql =========*** End *** ======
PROMPT ===================================================================================== 
