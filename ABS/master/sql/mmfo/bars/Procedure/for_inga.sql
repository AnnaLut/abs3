

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FOR_INGA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FOR_INGA ***

  CREATE OR REPLACE PROCEDURE BARS.FOR_INGA 

is
begin

bpa.disable_policies(p_table_name => 'CUSTOMERW_UPDATE');

merge into customerw_update t
using
(select t.idupd, substr(a.ad_login, 12,300) as ad_login
from customerw_update t--230194--212850
left join staff$base s
on t.doneby = s.logname
join kf_ru k
on t.kf = k.kf
left join staff_ad_user_mapping a
on t.doneby = concat(a.bars_login, k.ru)
where s.logname is null
and a.bars_login is not null
and k.kf = substr(a.branch, 2, 6)) a
on (t.idupd = a.idupd)

when matched then update set t.doneby = a.ad_login
  ;
commit;

bpa.enable_policies(p_table_name => 'CUSTOMERW_UPDATE');

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FOR_INGA.sql =========*** End *** 
PROMPT ===================================================================================== 
