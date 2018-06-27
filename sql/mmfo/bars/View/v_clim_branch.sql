

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CLIM_BRANCH.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CLIM_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CLIM_BRANCH ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB", "OBL") AS 
  SELECT bra.branch,
          COALESCE (
             SUBSTR (
                (SELECT val
                   FROM branch_parameters bp
                  WHERE tag = 'NAME_BRANCH' AND bp.branch = bra.branch),
                1,
                70),
             bra.name)
             as name,
          bra.b040,
          bra.description,
          bra.idpdr,
          bra.date_opened,
          bra.date_closed,
          bra.deleted,
          bra.sab,
          bra.obl
     FROM bars.branch bra
    WHERE LENGTH (branch) > 1
          AND branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');
		  
PROMPT *** Create  grants  V_CLIM_BRANCH ***
grant SELECT                                                                 on V_CLIM_BRANCH   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CLIM_BRANCH   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CLIM_BRANCH   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CLIM_BRANCH.sql =========*** End *** 
PROMPT ===================================================================================== 
