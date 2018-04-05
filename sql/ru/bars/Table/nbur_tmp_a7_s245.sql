PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_A7_S245.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_A7_S245 *** 

exec bpa.remove_policies('NBUR_TMP_A7_S245');

exec bpa.refresh_policies('NBUR_TMP_A7_S245');

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_A7_S245'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_TMP_A7_S245'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_A7_S245 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_TMP_A7_S245 
   (REPORT_DATE DATE, 
    KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
    ACC_ID NUMBER, 
    S245  CHAR(1 BYTE),
    OST   NUMBER
   ) 
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_TMP_A7_S245 ***
 exec bpa.alter_policies('NBUR_TMP_A7_S245');


COMMENT ON TABLE BARS.NBUR_TMP_A7_S245 IS 'Таблиця для використання при формуванні С5';

COMMENT ON COLUMN BARS.NBUR_TMP_A7_S245.REPORT_DATE IS 'Звітна дата (дата переходу на нові БР)';
COMMENT ON COLUMN BARS.NBUR_TMP_A7_S245.KF IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_TMP_A7_S245.ACC_ID IS 'Ід. рахунку';
COMMENT ON COLUMN BARS.NBUR_TMP_A7_S245.S245 IS 'Параметр S245';
COMMENT ON COLUMN BARS.NBUR_TMP_A7_S245.OST IS 'Залишок (ном) в день переходу';

PROMPT *** Create  constraint CC_TMPA7S245_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_A7_S245 MODIFY (REPORT_DATE CONSTRAINT CC_TMPA7S245_DATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_TMPA7S245_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_A7_S245 MODIFY (KF CONSTRAINT CC_TMPA7S245_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_TMPA7S245_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_A7_S245 MODIFY (ACC_ID CONSTRAINT CC_TMPA7S245_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_TMPA7S245 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TMPA7S245 ON BARS.NBUR_TMP_A7_S245 (REPORT_DATE, KF, ACC_ID)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBUR_TMP_A7_S245 ***
grant SELECT                                                                 on NBUR_TMP_A7_S245 to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBUR_TMP_A7_S245 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_TMP_A7_S245 to RPBN002;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_A7_S245.sql =========*** End
PROMPT ===================================================================================== 
