prompt create view v_staff_chk_xrm
create or replace force view v_staff_chk_xrm as
select ad.active_directory_name logname, ch.idchk, ch.name , s.logname logname_abs
  from staff_chk t,
       staff$base s,
       staff_ad_user ad,
       chklist ch
 where t.id = s.id and s.id = ad.user_id and ch.idchk = t.chkid;

/
grant select,delete,update,insert on bars.v_staff_chk_xrm to bars_access_defrole;
/                