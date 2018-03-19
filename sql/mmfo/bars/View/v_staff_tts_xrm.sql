create or replace view v_staff_tts_xrm
as
select ad.ad_login logname, t.tt, s.logname logname_abs
  from staff_tts t, staff$base s, staff_ad_user_mapping ad
 where t.id = s.id and 'OSCHADBANK\' || s.logname = ad.ad_login;
/
grant select,delete,update,insert on bars.v_staff_tts_xrm to bars_access_defrole;
/                
