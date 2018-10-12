PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/View/v_transform_le_report.sql ======*** Run *** 
PROMPT ===================================================================================== 

create or replace view v_transform_le_report as
select bl.name ctype
       , a.tobo
       , c.nmkk
       , c.okpo
       , t.nls
       , t.new_nls
       , c.rnk
from accounts a
join customer c on c.rnk = a.rnk
left join customerw cw on cw.rnk = c.rnk and cw.tag = 'BUSSL'
left join CUST_BUSINESS_LINE bl on bl.id = cw.value
join transform_2017_forecast t on t.acc = a.acc
where t.nbs in ('2605', '2655');

grant SELECT on v_transform_le_report to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/View/v_transform_le_report.sql ======*** End *** 
PROMPT ===================================================================================== 
