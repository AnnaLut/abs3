begin
  bpa.alter_policy_info('V_BRATES_KF', 'FILIAL', null, null, null, null);
  bpa.alter_policy_info('V_BRATES_KF', 'WHOLE',  null, null, null, null); 
end;
/

CREATE OR REPLACE FORCE VIEW BARS.V_BRATES_KF
( BR_ID
, BR_NAME
, TYPE_ID
, TYPE_NAME
, INUSE
) AS
  SELECT br.br_id
       , br.name
       , bt.br_type
       , bt.name
       , br.INUSE
    FROM brates br
    JOIN br_types bt
      on ( bt.BR_TYPE = br.BR_TYPE );

begin
 bpa.alter_policies('V_BRATES_KF');
end;
/

COMMENT ON TABLE  BARS.V_BRATES_KF IS '����� �������� ������';

COMMENT ON COLUMN BARS.V_BRATES_KF.BR_ID   IS '���~������~������';
COMMENT ON COLUMN BARS.V_BRATES_KF.BR_NAME IS '�����~%% ������';
COMMENT ON COLUMN BARS.V_BRATES_KF.TYPE_ID IS '���~������~%% ������';
COMMENT ON COLUMN BARS.V_BRATES_KF.TYPE_ID IS '�����~������~%% ������';
COMMENT ON COLUMN BARS.V_BRATES_KF.INUSE   IS '1-����,~0-������';

grant select on v_brates_kf to bars_access_defrole;
