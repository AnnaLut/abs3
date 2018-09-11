--поле KF заполнялось регионом пользователя, но не записи

PROMPT =====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Script/upd_kf_vip_flags_arc.sql =========***
PROMPT =====================================================================================

declare
  l_kf             varchar2(6);
begin --создание job-а
    for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
    loop
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);

        update BARS.VIP_FLAGS_ARC
           set kf = mfo
         where kf != mfo;

        dbms_output.put_line ('for ' || l_kf || ' update ' || SQL%ROWCOUNT || ' rows.' );

        commit;
    end loop;
end;
/

PROMPT =====================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/Script/upd_kf_vip_flags_arc.sql =========***
PROMPT =====================================================================================