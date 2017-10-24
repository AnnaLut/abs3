

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_FL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_REP_LIST_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_REP_LIST_FL ("ID", "NAME", "FUNCNAME") AS 
  SELECT id, name, REPLACE( NVL (funcname, funcname2),'DAT','GL.BD') funcname
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
                                 SUBSTR (UPPER (funcname),
                                         INSTR (funcname, '"') + 1)
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
                                   AND UPPER (funcname) LIKE '%CCK_SBER%'))
                          AND (   UPPER (semantic) = 'ASP_FL'
                               --OR UPPER (semantic) = 'ASP'
                               )
                               ));

PROMPT *** Create  grants  V_CCK_REP_LIST_FL ***
grant SELECT                                                                 on V_CCK_REP_LIST_FL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_REP_LIST_FL to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_FL.sql =========*** End 
PROMPT ===================================================================================== 
