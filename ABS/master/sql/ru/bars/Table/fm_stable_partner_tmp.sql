begin
  execute immediate 'drop table BARS.FM_STABLE_PARTNER_TMP';
exception when others then null;
end;
/
begin
  bpa.alter_policy_info('FM_STABLE_PARTNER_TMP', 'WHOLE', null, null, null, null); 
  bpa.alter_policy_info('FM_STABLE_PARTNER_TMP', 'FILIAL', null, null, null, null);
end;
/
begin
  execute immediate 'CREATE GLOBAL TEMPORARY TABLE "BARS"."FM_STABLE_PARTNER_TMP" 
   (  "RNK_A" VARCHAR2(128), 
  "RNK_B" VARCHAR2(128), 
  "CNT" NUMBER, 
  "REF" NUMBER,
  KF VARCHAR2(6)
   ) ON COMMIT DELETE ROWS ';
end;
/
grant select on BARS.FM_STABLE_PARTNER_TMP to BARS_ACCESS_DEFROLE;
grant select on BARS.FM_STABLE_PARTNER_TMP to BARS_DM;
grant select on BARS.FM_STABLE_PARTNER_TMP to START1;
/
