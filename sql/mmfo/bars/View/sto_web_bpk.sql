

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STO_WEB_BPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view STO_WEB_BPK ***

  CREATE OR REPLACE FORCE VIEW BARS.STO_WEB_BPK ("NMK", "NLSA", "ORD", "MFOB", "NLSB", "POLU", "OKPO", "DAT1", "DAT2", "NAZN", "FSUM", "IDD") AS 
  SELECT /*+ USE_NL(A) */
          c.NMK,
          d.NLSA,
          d.ORD,
          d.MFOB,
          d.NLSB,
          d.POLU,
          d.OKPO,
          TO_CHAR (D.DAT1, 'DD.MM.YYYY'),
          TO_CHAR (D.DAT2, 'DD.MM.YYYY'),
          d.NAZN,
          d.FSUM,
          d.idd
     FROM STO_LST l,
          STO_DET d,
          customer c,
          accounts a
    WHERE     c.rnk = l.rnk
          AND l.ids = d.ids
          AND d.kva = a.kv and a.nbs = '2625' and substr(d.nlsa,1,4) = '2625'
          AND a.nls = d.nlsa
          AND a.BRANCH LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
		  order by stmp desc;

PROMPT *** Create  grants  STO_WEB_BPK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_WEB_BPK     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_WEB_BPK     to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_WEB_BPK     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STO_WEB_BPK.sql =========*** End *** ==
PROMPT ===================================================================================== 
