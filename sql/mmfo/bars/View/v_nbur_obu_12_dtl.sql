

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_OBU_12_DTL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_OBU_12_DTL ***


CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_OBU_12_DTL
(
   "KF",
   "REPORT_DATE",
   "VERSION_ID",
   "NBUC",
   "FIELD_CODE",
   "FIELD_VALUE",
   "REFF",
   "NAZN",
   "ACC_NUM_DT",
   "ACC_NAME_DT",
   "ACC_NUM_KT",
   "ACC_NAME_KT",
   "DESCRIPTION" )
 AS
select u.kf
     , u.report_date
     , u.version_id
     , u.nbuc
     , u.field_code
     , u.field_value
     , u.reff
     , u.nazn
     , u.acc_num_dt, ad.nms acc_name_dt
     , u.acc_num_kt, ak.nms acc_name_kt
     , u.description
  from (
   select p.kf, p.report_date, p.version_id, p.nbuc,
          p.field_code, p.field_value , p.ref reff,
          (case when instr(description,'�� ���.')>0
                   then substr(description, regexp_instr(description,'[^[:digit:]]',instr(description,'�� ���.')+10)+1 )
                else null
            end) nazn,
          (case when p.field_code in ('35','70') 
                   then  acc_num
                when instr(description,'�� ���.')>0
                   then  substr(description,
                                 instr(description,'�� ���.')+10,
                                  regexp_instr(description,'[^[:digit:]]',instr(description,'�� ���.')+10)-
                                            instr(description,'�� ���.')-10)
                else null
            end) acc_num_dt,
          (case when instr(description,'�� ���.')>0
                   then  substr(description,
                                 instr(description,'�� ���.')+10,
                                  regexp_instr(description,'[^[:digit:]]',instr(description,'�� ���.')+10)-
                                            instr(description,'�� ���.')-10)
                else null
            end) acc_num_kt,
            p.description
     FROM NBUR_DETAIL_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN NBUR_LST_FILES v
                        ON (    v.REPORT_DATE = p.REPORT_DATE
                            AND v.KF = p.KF
                            AND v.VERSION_ID = p.VERSION_ID
                            AND v.FILE_ID = f.ID)
    WHERE p.REPORT_CODE = '@12' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
        ) u
  left outer join accounts ad on ( ad.kf = u.kf and
                                   ad.kv = 980  and
                                   ad.nls = u.acc_num_dt )
  left outer join accounts ak on (  ad.kf = u.kf and
                                    ak.kv = 980  and
                                   ak.nls = u.acc_num_kt );

COMMENT ON TABLE  BARS.V_NBUR_OBU_12_DTL IS '��������� �������� ����� @12';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.VERSION_ID IS '��. ���� �����';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.NBUC     IS '��� ������ �����';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.FIELD_CODE  IS '��� ���������';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.FIELD_VALUE IS '�������� ���������';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.REFF        IS '��������';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.NAZN        IS '����������� �������';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.ACC_NUM_DT  IS '������� ��';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.ACC_NAME_DT IS '����� ������� ��';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.ACC_NUM_KT  IS '������� ��';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.ACC_NAME_KT IS '����� ������� ��';
COMMENT ON COLUMN BARS.V_NBUR_OBU_12_DTL.DESCRIPTION IS '��������';

PROMPT *** Create  grants  V_NBUR_OBU_12_DTL ***
grant SELECT          on V_NBUR_OBU_12_DTL to BARSREADER_ROLE;
grant SELECT          on V_NBUR_OBU_12_DTL to BARS_ACCESS_DEFROLE;
grant SELECT          on V_NBUR_OBU_12_DTL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_OBU_12_DTL.sql =========*** End 
PROMPT ===================================================================================== 
