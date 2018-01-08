

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_DOCS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_DOCS ("ID", "NAME", "TIP", "TEMPLATE", "PRINT_ON_BLANK", "FR") AS 
  SELECT d.id,
         d.name,
         v.custtype,
         d.template,
         d.print_on_blank,
         d.fr
    FROM doc_scheme d,
         doc_root   r,
         cc_vidd    v
   WHERE r.vidd = v.vidd
     AND r.id = d.id
     AND v.custtype IN (2, 3)
     AND v.tipd = 2
     AND v.sps IS NULL;

PROMPT *** Create  grants  DPT_DOCS ***
grant SELECT                                                                 on DPT_DOCS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DOCS        to DPT_ADMIN;
grant SELECT                                                                 on DPT_DOCS        to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DOCS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_DOCS.sql =========*** End *** =====
PROMPT ===================================================================================== 
