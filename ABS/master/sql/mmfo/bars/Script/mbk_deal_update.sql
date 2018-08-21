-- Created on 21-Aug-18 by VOLODYMYR.POHODA 
declare 
  -- Local variables here
  i integer;
begin
  -- Test statements here
  for r in (select kf from mv_kf) loop
    bc.go(r.kf);
      
    update cc_deal d
      set sos = 10
    --select * from cc_deal d
      where vidd in (3902,3903)
        and sos = 15
        and d.wdate>trunc(sysdate)
        and exists (select 1 from accounts a, nd_acc n where n.nd = d.nd and n.acc = a.acc and a.dazs is null and nvl(a.ostc,0) != 0);
    commit;
  end loop;
  bc.home;

end;
/
