PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_DESC_EKP2.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_DESC_EKP2 ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_DESC_EKP2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_DESC_EKP2 ***
begin 
  execute immediate 'CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_DESC_EKP2
(
  EKP        VARCHAR2(6 BYTE), 
  SEG        VARCHAR2(3 BYTE),
  R020       CHAR(4 BYTE)
)
ON COMMIT PRESERVE ROWS';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_TMP_DESC_EKP2 ***
 exec bpa.alter_policies('NBUR_TMP_DESC_EKP2');

COMMENT ON TABLE BARS.NBUR_TMP_DESC_EKP2 IS 'Тимчасова таблиця для формування показників';
COMMENT ON COLUMN BARS.NBUR_TMP_DESC_EKP2.EKP IS 'Код код показника';
COMMENT ON COLUMN BARS.NBUR_TMP_DESC_EKP2.SEG IS 'Код сегменту з №';
COMMENT ON COLUMN BARS.NBUR_TMP_DESC_EKP2.R020 IS 'Балансовий рахунок';



PROMPT *** Create  grants  NBUR_TMP_DESC_EKP2 ***
grant SELECT                                                                 on NBUR_TMP_DESC_EKP2 to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_DESC_EKP2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_TMP_DESC_EKP2 to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_DESC_EKP2.sql =========*** End
PROMPT ===================================================================================== 

