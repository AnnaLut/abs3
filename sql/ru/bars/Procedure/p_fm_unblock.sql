

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_UNBLOCK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_UNBLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_UNBLOCK (
  p_ref number,
  p_rec number )
is
  l_fm_grp2 number;
begin

  if p_ref is not null then

     update fm_ref_que set otm = 0 where ref = p_ref;

     l_fm_grp2 := to_number(getglobaloption('FM_GRP2'));

     if l_fm_grp2 is not null then

        insert into oper_visa (ref, dat, userid, groupid, status)
        values (p_ref, sysdate, user_id, l_fm_grp2, 1);

     end if;

  elsif p_rec is not null then

     update fm_rec_que set otm = 0 where rec = p_rec;

     update arc_rrp set blk = 0 where rec = p_rec;

  end if;

end p_fm_unblock;
/
show err;

PROMPT *** Create  grants  P_FM_UNBLOCK ***
grant EXECUTE                                                                on P_FM_UNBLOCK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_UNBLOCK    to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_UNBLOCK.sql =========*** End 
PROMPT ===================================================================================== 
