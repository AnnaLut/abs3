

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPERAPP_UI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPERAPP_UI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPERAPP_UI ("CODEAPP", "APPNAME", "CODEOPER", "OPERNAME", "FUNCNAME", "DATE_FINISH", "TOP", "HITS", "LAST_HIT") AS 
  with t as (select *
           from   ui_func_hits h, v_operapp /*operlist*/ o
           where  h.func_id = o.codeoper and
                  h.staff_id = user_id and
                  o.runable <> 3 and
                  o.frontend = 1)
select codeapp,
       appname,
       codeoper,
       opername,
       case when funcname like '/barsroot/cbirep/rep_list.aspx?codeapp=%' then '/barsroot/cbirep/rep_list.aspx?codeapp=' || codeapp
            when funcname like '/barsroot/barsweb/references/reflist.aspx%' then '/barsroot/barsweb/references/reflist.aspx?app=' || codeapp
            when funcname like '/barsroot/referencebook/referencelist/%' then '/barsroot/ndi/referencebook/referencelist/?appid=' || codeapp
            else funcname
       end as funcname,
       null date_finish,
       top,
       hits,
       last_hit
from   (select distinct '~~1' codeapp,
               '5 останніх функцій' appname,
               codeoper,
               opername || ' <span style="font-size:6pt;"> (' || case when trunc (sysdate) = trunc (last_hit) then to_char (last_hit, 'hh24:mi')
                                                                  else to_char (last_hit, 'dd.mm.yyyy')
                                                             end || ')</span>' opername,
               funcname,
               null date_finish,
               1 top,
               0 hits,
               last_hit
        from   t
        order by last_hit desc)
where rownum <= 5
union all
select codeapp,
       appname,
       codeoper,
       opername,
       case when funcname like '/barsroot/cbirep/rep_list.aspx?codeapp=%' then '/barsroot/cbirep/rep_list.aspx?codeapp=' || codeapp
            when funcname like '/barsroot/barsweb/references/reflist.aspx%' then '/barsroot/barsweb/references/reflist.aspx?app=' || codeapp
            when funcname like '/barsroot/referencebook/referencelist/%' then '/barsroot/ndi/referencebook/referencelist/?appid=' || codeapp
            else funcname
       end as funcname,
       null as date_finish,
       top,
       hits,
       null as last_hit
  from (select distinct '~~2' codeapp,
                 '5 популярних функцій' appname,
                 codeoper,
                 opername || ' <span style="font-size:6pt;"> (' || hits || ')</span>' opername,
                 funcname,
                 null date_finish,
                 2 top,
                 hits
        from     t
        order by hits desc)
where rownum <= 5
union all
select codeapp,
       appname,
       codeoper,
       opername,
       case when funcname like '/barsroot/cbirep/rep_list.aspx?codeapp=%' then '/barsroot/cbirep/rep_list.aspx?codeapp=' || codeapp
            when funcname like '/barsroot/barsweb/references/reflist.aspx%' then '/barsroot/barsweb/references/reflist.aspx?app=' || codeapp
            when funcname like '/barsroot/referencebook/referencelist/%' then '/barsroot/ndi/referencebook/referencelist/?appid=' || codeapp
            else funcname
       end as funcname,
       null as date_finish,
       3 top,
       0 hits,
       null as last_hit
from   v_operapp o
where  frontend = 1 and
       runable <> 3 and
       codeapp <> 'WTOP'
order by top, hits desc, last_hit desc nulls last, appname, opername;

PROMPT *** Create  grants  V_OPERAPP_UI ***
grant SELECT                                                                 on V_OPERAPP_UI    to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPERAPP_UI    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPERAPP_UI    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPERAPP_UI.sql =========*** End *** =
PROMPT ===================================================================================== 
