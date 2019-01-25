
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_tts_4_input.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TTS_4_INPUT ("FOLDER_NAME", "TT", "TT_NAME", "TT_FLAG") AS 
  SELECT DISTINCT REPLACE(NVL(f.name,'...'),'""','''') folder_name,
                t.tt,
                REPLACE(t.tt||'-'||t.name,'""','''') tt_name,
                decode(substr(t.flags,38,1),'0','RO','RW') tt_flag
  FROM tts t, folders f, folders_tts ft, staff_tts s
  where ft.tt(+)=t.tt
    and ft.idfo=f.idfo(+)
    and s.tt=t.tt
    and s.id in (select bars.user_id
                   from dual
                 union all
                 select id_whom
                   from staff_substitute
                     where id_who=user_id
                       and date_is_valid(date_start, date_finish, null, null)=1
                )
    and t.fli<3
    and substr(flags,1,1)='1'
    and substr(flags, 63, 1)='0'
    and exists (select 1 from dual where not exists (select 1 from teller_state where user_ref = user_id and work_date = gl.bd and status = 'A'))
union
SELECT DISTINCT REPLACE(NVL(f.name,'...'),'""','''') folder_name,
                t.tt,
                REPLACE(t.tt||'-'||t.name,'""','''') tt_name,
                decode(substr(t.flags,38,1),'0','RO','RW') tt_flag
  FROM tts t, folders f, folders_tts ft, teller_oper_define od, teller_state ts, teller_stations st
  where ft.tt(+)=t.tt
    and ft.idfo=f.idfo(+)
    and ts.work_date = gl.bd and ts.status = 'A'
    and st.station_name = sys_context('bars_global','host_name')
    and st.equip_ref = od.equip_ref
    and od.oper_code=t.tt
    and ts.user_ref in (select bars.user_id
                         from dual
                       union all
                       select id_whom
                         from staff_substitute
                           where id_who=user_id
                             and date_is_valid(date_start, date_finish, null, null)=1
                      )
/*    and t.fli<3
    and substr(flags,1,1)='1'
    and substr(flags, 63, 1)='0' */
  order by 1,2
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_tts_4_input.sql =========*** End *** 
 PROMPT ===================================================================================== 
 