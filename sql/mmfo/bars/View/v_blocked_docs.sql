

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BLOCKED_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BLOCKED_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BLOCKED_DOCS ("VID_DOC", "KOL", "SUMMA") AS 
  select 'Начальные ГОУ', 
       count(*), 
       sum(s)/100
  from arc_rrp 
  where dat_a>=trunc(sysdate)
    and dk=1 
    and blk in (77,80,87,777,800)
    and mfoa='300465'
union all 
select 'Начальные ВПС', 
       count(*), 
       sum(s)/100
  from arc_rrp 
  where dat_a>=trunc(sysdate)
    and dk=1 
    and blk in (77,80,87,777,800)
    and mfoa not in ('300465','324805')
union all
select 'Всего :', 
       count(*), 
       sum(s)/100 
  from arc_rrp 
  where dat_a>=trunc(sysdate)
    and dk=1 
    and blk in (77,80,87,777,800)
union all
select 'Корpсчет 1200', 
       0,
       abs(ostb/100) 
  from accounts 
  where nls='1200401' 
    and kv=980
--union all
--select 'Вход.не сквит.', 
--       0,
--       abs(ostb/100) 
--  from accounts 
--  where nls='37396012';

PROMPT *** Create  grants  V_BLOCKED_DOCS ***
grant SELECT                                                                 on V_BLOCKED_DOCS  to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_BLOCKED_DOCS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BLOCKED_DOCS  to START1;
grant SELECT                                                                 on V_BLOCKED_DOCS  to UPLD;
grant FLASHBACK,SELECT                                                       on V_BLOCKED_DOCS  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BLOCKED_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
