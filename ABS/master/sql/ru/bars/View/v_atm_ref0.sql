prompt ####################################################################################
prompt ... Вюшки-гляделки  D:\K\MMFO\kwt_2924\Sql\View\ATM_vie.sql 
prompt ..........................................

create or replace view v_ATMREF0 as 
select a.acc, a.kv, a.nls, a.nms, a.branch, a.tip, a.ob22, a.ostc/100 OSTC , a.pap-1 DK, 
       (select count(*) from atm_ref1  where acc = a.acc) kol 
from accounts a     where  a.tip in ('AT7', 'AT8') and a.dazs is null;

grant select  on bars.v_ATMREF0  TO BARS_ACCESS_DEFROLE;
-----------------------------------------------------------
