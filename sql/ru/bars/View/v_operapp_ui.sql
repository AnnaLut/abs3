

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPERAPP_UI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPERAPP_UI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPERAPP_UI ("CODEAPP", "APPNAME", "CODEOPER", "OPERNAME", "FUNCNAME", "DATE_FINISH", "TOP", "HITS", "LAST_HIT") AS 
  WITH t
        AS (SELECT *
              FROM ui_func_hits h, operlist o
             WHERE     h.func_id = o.codeoper
                   AND h.staff_id = user_id
                   AND o.runable <> 3
                   AND o.frontend = 1)
   SELECT codeapp,
          appname,
          codeoper,
          opername,
          case
            when funcname like '/barsroot/cbirep/rep_list.aspx?codeapp=%' then '/barsroot/cbirep/rep_list.aspx?codeapp=' || codeapp
            when funcname like '/barsroot/barsweb/references/reflist.aspx%' then '/barsroot/barsweb/references/reflist.aspx?app=' || codeapp
            when funcname like '/barsroot/referencebook/referencelist/%' then '/barsroot/ndi/referencebook/referencelist/?appid=' || codeapp
		  else funcname
          end as funcname,
          NULL date_finish,
          top,
          hits,
          last_hit
     FROM (  SELECT '~~1' codeapp,
                    '5 останніх функцій' appname,
                    codeoper,
                       name
                    || ' <span style="font-size:6pt;"> ('
                    || CASE
                          WHEN TRUNC (SYSDATE) = TRUNC (last_hit)
                          THEN
                             TO_CHAR (last_hit, 'hh24:mi')
                          ELSE
                             TO_CHAR (last_hit, 'dd.mm.yyyy')
                       END
                    || ')</span>'
                       opername,
                    funcname,
                    NULL date_finish,
                    1 top,
                    0 hits,
                    last_hit
               FROM t
           ORDER BY last_hit DESC)
    WHERE ROWNUM <= 5
   UNION ALL
   SELECT codeapp,
          appname,
          codeoper,
          opername,
          case
            when funcname like '/barsroot/cbirep/rep_list.aspx?codeapp=%' then '/barsroot/cbirep/rep_list.aspx?codeapp=' || codeapp
            when funcname like '/barsroot/barsweb/references/reflist.aspx%' then '/barsroot/barsweb/references/reflist.aspx?app=' || codeapp
            when funcname like '/barsroot/referencebook/referencelist/%' then '/barsroot/ndi/referencebook/referencelist/?appid=' || codeapp
		  else funcname
          end as funcname,
          NULL AS date_finish,
          top,
          hits,
          NULL AS last_hit
     FROM (  SELECT '~~2' codeapp,
                    '5 популярних функцій' appname,
                    codeoper,
                       name
                    || ' <span style="font-size:6pt;"> ('
                    || hits
                    || ')</span>'
                       opername,
                    funcname,
                    NULL date_finish,
                    2 top,
                    hits
               FROM t
           ORDER BY hits DESC)
    WHERE ROWNUM <= 5
   UNION ALL
   SELECT codeapp,
          appname,
          codeoper,
          opername,
          case
            when funcname like '/barsroot/cbirep/rep_list.aspx?codeapp=%' then '/barsroot/cbirep/rep_list.aspx?codeapp=' || codeapp
            when funcname like '/barsroot/barsweb/references/reflist.aspx%' then '/barsroot/barsweb/references/reflist.aspx?app=' || codeapp
            when funcname like '/barsroot/referencebook/referencelist/%' then '/barsroot/ndi/referencebook/referencelist/?appid=' || codeapp
		  else funcname
          end as funcname,
          NULL AS date_finish,
          3 top,
          0 hits,
          NULL AS last_hit
     FROM v_operapp o
    WHERE frontend = 1 AND runable <> 3 AND codeapp <> 'WTOP'
   ORDER BY top,
            hits DESC,
            last_hit DESC NULLS LAST,
            appname,
            opername;

PROMPT *** Create  grants  V_OPERAPP_UI ***
grant SELECT                                                                 on V_OPERAPP_UI    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPERAPP_UI.sql =========*** End *** =
PROMPT ===================================================================================== 
