prompt bars_intgr.VW_REF_USER2GROUPS

create or replace force view bars_intgr.VW_REF_USER2GROUPS
as
select t.logname, t.idchk, t.name from bars.v_staff_chk_xrm t;

comment on table bars_intgr.VW_REF_USER2GROUPS is 'Групи візування доступні користувачеві(USER2GROUPS)';