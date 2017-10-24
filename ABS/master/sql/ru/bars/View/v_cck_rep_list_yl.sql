

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_YL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_REP_LIST_YL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_REP_LIST_YL ("ID", "NAME", "FUNCNAME") AS 
  SELECT id,
          name,
          REPLACE (NVL (funcname, funcname2), 'DAT', 'GL.BD') funcname
     FROM (SELECT id,
                  name,
                  SUBSTR (funcname, 1, INSTR (funcname, ')')) funcname,
                  REPLACE (SUBSTR (funcname2, 1, INSTR (funcname2, ')')),
                           ':PARAM0',
                           'null')
                     funcname2
             FROM (SELECT codeoper id,
                          name,
                          (CASE
                              WHEN UPPER (funcname) LIKE 'F1_SELECT%'
                              THEN
                                 REPLACE (
                                    SUBSTR (UPPER (funcname),
                                            INSTR (funcname, '"') + 1),
                                    ',DAT,',
                                    ',GL.BD,')
                           END)
                             funcname,
                          (CASE
                              WHEN UPPER (funcname) LIKE 'FUNNSIEDIT(%'
                              THEN
                                 SUBSTR (UPPER (funcname),
                                         INSTR (funcname, '=>') + 2)
                           END)
                             funcname2
                     FROM operlist
                    WHERE     (   (    UPPER (funcname) LIKE 'F1_SELECT%'
                                   AND (   UPPER (funcname) LIKE '%CCK.CC%'
                                        OR UPPER (funcname) LIKE
                                              '%CCT.START%'))
                               OR (    UPPER (funcname) LIKE 'FUNNSIEDIT%'
                                   AND UPPER (funcname) LIKE '%CCK_SBER%')
                               OR (    UPPER (funcname) LIKE 'F1_SELECT%'
                                   AND UPPER (funcname) LIKE '%CC_RMANY_PET%'))
                          AND (   UPPER (semantic) = 'ASP_YL'
                               OR UPPER (semantic) = 'ASP')));

PROMPT *** Create  grants  V_CCK_REP_LIST_YL ***
grant SELECT                                                                 on V_CCK_REP_LIST_YL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_REP_LIST_YL to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_YL.sql =========*** End 
PROMPT ===================================================================================== 
