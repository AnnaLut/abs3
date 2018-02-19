PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/zp_acc_migr.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** zp_acc_migr ***

begin
  for i in(select * from mv_kf)
  loop
    bc.go(i.kf);
    for i in (select d.id, d.branch 
              from bars.v_zp_deals d 
              where d.sos in (0,5))-- діючий
    loop
      bc.go(p_branch => i.branch);
      bars.zp.zp_acc_migr(p_id => i.id);
    end loop;
  end loop;
bc.home;
end;
/
commit;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/zp_acc_migr.sql =========*** End *** ===
PROMPT ===================================================================================== 
