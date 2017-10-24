begin
  bpa.alter_policy_info('V_BRATES_VALUE_KF', 'FILIAL', 'M', null, null, null);
  bpa.alter_policy_info('V_BRATES_VALUE_KF', 'WHOLE', null, null, null, null);
end;
/

CREATE OR REPLACE FORCE VIEW BARS.V_BRATES_VALUE_KF
(
   BR_ID,
   BDATE,
   KV,
   S,
   RATE,
   KF
)
AS
   SELECT br_id,
          bdate,
          kv,
          s,
          rate,
          CASE branch WHEN  '/' THEN f_ourmfo
          ELSE SUBSTR (branch, 2, 6) END kf
     FROM BR_TIER_EDIT
   UNION ALL
   SELECT br_id,
          bdate,
          kv,
          0,
          rate,
          CASE branch WHEN  '/' THEN f_ourmfo
          ELSE SUBSTR (branch, 2, 6) END kf
     FROM BR_normal_EDIT;

begin
  bpa.alter_policies('V_BRATES_VALUE_KF');
end;
/	 

grant select on V_BRATES_VALUE_KF to bars_access_defrole;

COMMENT ON TABLE BARS.V_BRATES_VALUE_KF IS 'Значення базових процентних ставок';
COMMENT ON COLUMN BARS.V_BRATES_VALUE_KF.BR_ID IS 'Код базової ставки';
COMMENT ON COLUMN BARS.V_BRATES_VALUE_KF.BDATE IS 'Дата установки';
COMMENT ON COLUMN BARS.V_BRATES_VALUE_KF.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.V_BRATES_VALUE_KF.S IS 'Гранична сумма';
COMMENT ON COLUMN BARS.V_BRATES_VALUE_KF.RATE IS 'Ставка';
COMMENT ON COLUMN BARS.V_BRATES_VALUE_KF.KF IS 'Код філіалу';


begin
  bpa.alter_policies('V_BRATES_VALUE_KF');
end;
/
