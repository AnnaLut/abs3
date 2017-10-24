

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STO_WEB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view STO_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.STO_WEB ("NMK", "NLSA", "ORD", "MFOB", "NLSB", "POLU", "OKPO", "DAT1", "DAT2", "NAZN", "FSUM", "IDD", "CALEND", "STMP") AS 
  SELECT c.NMK,
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
          d.idd,
             '<a href="'
          || '/barsroot/tools/sto/sto_calendar.aspx?IDD='
          || d.idd
          || '&'||'mode=RO'
          || '" onclick="window.open(this.href, '''', ''width=950, height=800, resizable=yes,scrollbars=yes,status=yes''); return false">'
          || 'Календар подій'
          || '</a>'
             calend,
          TO_CHAR(d.stmp,  'DD/MM/YYYY HH24:MI:SS')
     FROM STO_LST l,
          STO_DET d,
          customer c,
          accounts a
    WHERE     c.rnk = l.rnk
          AND l.ids = d.ids
          AND d.kva = a.kv
          AND a.nls = d.nlsa
          AND a.BRANCH LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  STO_WEB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_WEB         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_WEB         to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_WEB         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STO_WEB.sql =========*** End *** ======
PROMPT ===================================================================================== 
