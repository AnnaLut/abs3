

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NOT_NLS98.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view NOT_NLS98 ***

  CREATE OR REPLACE FORCE VIEW BARS.NOT_NLS98 ("BRANCH", "NBSOB22", "NAME", "NLS_CENN", "NLS_DOR", "NLS_POGA", "NLS_DORP") AS 
  SELECT B.branch, v.ob22, v.name,
       SUBSTR (    nbs_ob22_null('9819',SUBSTR (ob22,5,2), b.branch), 1,14)  NLS_CENN,
       SUBSTR (NVL(nbs_ob22_null('9899',v.ob22_dor,        b.branch),
               DECODE (v.ob22_dor, NULL, '', '9899*' || v.ob22_dor)), 1,14)  NLS_DOR,
       SUBSTR (NVL(nbs_ob22_null('9812',v.ob22_spl,        b.branch),
               DECODE(v.ob22_spl, NULL,  '', '9812*' || v.ob22_spl)), 1,14)  NLS_POGA,
       SUBSTR (NVL(nbs_ob22_null('9899',v.ob22_dors,       b.branch),
               DECODE(v.ob22_dors,NULL,  '', '9899*' ||v.ob22_dors)), 1,14)  NLS_DORP
FROM branch b, valuables v
WHERE nbs_ob22_null ('9819', SUBSTR (ob22, 5, 2), b.branch) IS NOT NULL
  AND LENGTH (b.branch) = 15
  AND v.ob22 LIKE '9819%'
  AND
   (  v.ob22_dor  IS NOT NULL AND nbs_ob22_null('9899', v.ob22_dor, b.branch) IS NULL
   OR v.ob22_spl  IS NOT NULL AND nbs_ob22_null('9812', v.ob22_spl, b.branch) IS NULL
   OR v.ob22_dors IS NOT NULL AND nbs_ob22_null('9899', v.ob22_dors,b.branch) IS NULL
      )
UNION ALL
SELECT B.branch, v.ob22, v.name,
       substr (    nbs_ob22_null('9820',SUBSTR (ob22,5,2), b.branch), 1,14)  NLS_CENN,
       substr (NVL(nbs_ob22_null('9891', v.ob22_dor, b.branch),
               DECODE(v.ob22_dor, NULL, '',  '9891*' || v.ob22_dor)), 1,14)  NLS_DOR,
                                                         '' NLS_POGA,    ''  NLS_DORP
FROM branch b, valuables v
WHERE nbs_ob22_null ('9820', SUBSTR (ob22, 5, 2), b.branch) IS NOT NULL
  AND LENGTH (b.branch) = 15
  AND v.ob22 LIKE '9820%'
  AND v.ob22_dor  IS NOT NULL AND nbs_ob22_null('9891', v.ob22_dor, b.branch) IS NULL
UNION ALL
SELECT B.branch, v.ob22, v.name,
       substr (    nbs_ob22_null('9821',SUBSTR (ob22,5,2), b.branch) ,1,14)  NLS_CENN,
       substr (NVL(nbs_ob22_null('9893', v.ob22_dor, b.branch),
               DECODE(v.ob22_dor, NULL, '',  '9893*' || v.ob22_dor)) ,1,14)  NLS_DOR,
                                                         '' NLS_POGA,    ''  NLS_DORP
FROM branch b, valuables v
WHERE nbs_ob22_null ('9821', SUBSTR (ob22, 5, 2), b.branch) IS NOT NULL
  AND LENGTH (b.branch) = 15
  AND v.ob22 LIKE '9821%'
  AND v.ob22_dor  IS NOT NULL AND nbs_ob22_null('9893', v.ob22_dor, b.branch) IS NULL;

PROMPT *** Create  grants  NOT_NLS98 ***
grant SELECT                                                                 on NOT_NLS98       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOT_NLS98       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NOT_NLS98.sql =========*** End *** ====
PROMPT ===================================================================================== 
