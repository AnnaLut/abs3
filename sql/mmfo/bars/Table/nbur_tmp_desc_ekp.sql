PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_DESC_EKP.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_DESC_EKP ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_DESC_EKP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_DESC_EKP ***
begin 
  execute immediate 'CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_DESC_EKP
(
  EKP        VARCHAR2(6 BYTE), 
  I010       VARCHAR2(2 BYTE),
  T020       VARCHAR2(1 BYTE),
  R020       CHAR(4 BYTE)
)
ON COMMIT PRESERVE ROWS';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_TMP_DESC_EKP ***
 exec bpa.alter_policies('NBUR_TMP_DESC_EKP');

COMMENT ON TABLE BARS.NBUR_TMP_DESC_EKP IS '“имчасова таблиц€ дл€ формуванн€ показник≥в';
COMMENT ON COLUMN BARS.NBUR_TMP_DESC_EKP.R020 IS '';


PROMPT *** Create  grants  NBUR_TMP_DESC_EKP ***
grant SELECT                                                                 on NBUR_TMP_DESC_EKP to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_DESC_EKP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_TMP_DESC_EKP to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_DESC_EKP.sql =========*** End
PROMPT ===================================================================================== 

