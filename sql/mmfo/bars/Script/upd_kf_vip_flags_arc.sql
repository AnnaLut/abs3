--поле KF заполнялось регионом пользователя, но не записи

PROMPT =====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Script/upd_kf_vip_flags_arc.sql =========***
PROMPT =====================================================================================

begin --создание job-а

        update BARS.VIP_FLAGS_ARC
           set kf = mfo
         where kf != mfo;

        dbms_output.put_line ('VIP_FLAGS_ARC updated ' || SQL%ROWCOUNT || ' rows.' );

        commit;
end;
/

PROMPT =====================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/Script/upd_kf_vip_flags_arc.sql =========***
PROMPT =====================================================================================