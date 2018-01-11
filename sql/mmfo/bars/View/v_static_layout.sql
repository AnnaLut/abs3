

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STATIC_LAYOUT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STATIC_LAYOUT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STATIC_LAYOUT ("ID", "DK", "NAME", "NLS", "BS", "OB", "NAZN", "DATP", "ALG", "GRP") AS 
  select id,
            nvl (dk, 1) dk,
            name,
            nls,
            bs1 bs,
            ob1 ob,
            nazn1 nazn,
            datp,
            alg,
            grp
       from ope_lot
      where ob22 != '~~' and (id < 0 or grp > 0)
   order by id desc;

PROMPT *** Create  grants  V_STATIC_LAYOUT ***
grant SELECT                                                                 on V_STATIC_LAYOUT to BARSREADER_ROLE;
grant SELECT                                                                 on V_STATIC_LAYOUT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STATIC_LAYOUT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STATIC_LAYOUT.sql =========*** End **
PROMPT ===================================================================================== 
