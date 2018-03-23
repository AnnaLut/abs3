create or replace view v_staff_chk_xrm
as
select ad.ad_login logname, ch.idchk, ch.name , s.logname logname_abs
  from staff_chk t,
       staff$base s,
       staff_ad_user_mapping ad,
       chklist ch
 where t.id = s.id and 'OSCHADBANK\' || s.logname = ad.ad_login and ch.idchk = t.chkid;
/
grant select on bars.v_staff_chk_xrm to bars_access_defrole;
grant select on bars.v_staff_chk_xrm to bars_intgr; 