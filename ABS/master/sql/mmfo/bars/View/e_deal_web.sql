

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/E_DEAL_WEB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view E_DEAL_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.E_DEAL_WEB ("RNK", "NAME", "ND", "WDATE", "NLS26", "NLS36", "NLS_D", "KV26", "SA", "T_ID", "T_NANE", "TARIF", "NLS_P", "BRANCH") AS 
  SELECT e.rnk,
            SUBSTR (c.nmk, 1, 20) nmk,
            e.nd,
            e.wdate,
            e.nls26,
            e.nls36,
            E.NLS_D,
            e.kv26,
            e.sa/100,
            n.id,
            t.name,
         --   f_tarif (n.id,980,e.nls26,0,1)/100 tarif,
            nvl(n.sumt,t.sumt)/100,
            e.nls_p,
            e.branch
       FROM e_deal e,
            e_tar_nd n,
            customer c,
            e_tarif t
      WHERE e.nd = n.nd AND e.sos != 15 AND e.rnk = c.rnk AND n.id = t.id
   ORDER BY e.rnk, id;

PROMPT *** Create  grants  E_DEAL_WEB ***
grant SELECT                                                                 on E_DEAL_WEB      to BARSREADER_ROLE;
grant SELECT                                                                 on E_DEAL_WEB      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on E_DEAL_WEB      to START1;
grant SELECT                                                                 on E_DEAL_WEB      to UPLD;
grant FLASHBACK,SELECT                                                       on E_DEAL_WEB      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/E_DEAL_WEB.sql =========*** End *** ===
PROMPT ===================================================================================== 
