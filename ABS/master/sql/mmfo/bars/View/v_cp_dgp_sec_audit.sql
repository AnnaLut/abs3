CREATE OR REPLACE FORCE VIEW BARS.v_cp_dgp_sec_audit as
select a.rec_uname, a.rec_date, a.rec_bdate, a.rec_type, a.rec_message from sec_audit a where a.rec_date > trunc(sysdate) and a.rec_message like 'CP_REP_DGP%' order by a.rec_id desc;

comment on table v_cp_dgp_sec_audit is 'ƒл€ в≥дладки зв≥т≥в DGP (виб≥рка з sec_audit за поточний день)';

grant SELECT                                                          on v_cp_dgp_sec_audit       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on v_cp_dgp_sec_audit       to CP_ROLE;
grant SELECT                                                          on v_cp_dgp_sec_audit       to START1;
