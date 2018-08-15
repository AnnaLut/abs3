create or replace force view v_staff_tts_xrm
as
select ad.ACTIVE_DIRECTORY_NAME logname, t.tt, s.logname logname_abs
  from bars.staff_tts t, bars.staff$base s, bars.staff_ad_user ad
 where t.id = s.id and s.id = ad.user_id;
/
grant select,delete,update,insert on bars.v_staff_tts_xrm to bars_access_defrole;
/                
