

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LST_MESSAGES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LST_MESSAGES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LST_MESSAGES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_MESSAGES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBUR_LST_MESSAGES'', ''WHOLE'' , ''M'', ''M'', ''M'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LST_MESSAGES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LST_MESSAGES 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	REPORT_CODE CHAR(3), 
	VERSION_ID NUMBER(3,0), 
	MESSAGE_ID NUMBER(38,0), 
	MESSAGE_TXT VARCHAR2(2000), 
	USERID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LST_MESSAGES ***
 exec bpa.alter_policies('NBUR_LST_MESSAGES');


COMMENT ON TABLE BARS.NBUR_LST_MESSAGES IS 'Список повідомлень (контрольні точки)';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.REPORT_CODE IS 'Код файлу';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.VERSION_ID IS 'Ід. версії (для кожного фiлiалу своя)';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.MESSAGE_ID IS 'Iдентифiкатор повідомлення';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.MESSAGE_TXT IS 'Текст повыдомлення';
COMMENT ON COLUMN BARS.NBUR_LST_MESSAGES.USERID IS 'Ініціатор формування';




PROMPT *** Create  constraint CC_NBURLSTMESES_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_MESSAGES MODIFY (REPORT_DATE CONSTRAINT CC_NBURLSTMESES_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTMESES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_MESSAGES MODIFY (KF CONSTRAINT CC_NBURLSTMESES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTMESES_REPORTCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_MESSAGES MODIFY (REPORT_CODE CONSTRAINT CC_NBURLSTMESES_REPORTCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTMESES_VERSIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_MESSAGES MODIFY (VERSION_ID CONSTRAINT CC_NBURLSTMESES_VERSIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTMESES_MESSAGEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_MESSAGES MODIFY (MESSAGE_ID CONSTRAINT CC_NBURLSTMESES_MESSAGEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURLSTMESES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURLSTMESES ON BARS.NBUR_LST_MESSAGES (REPORT_DATE, KF, REPORT_CODE, VERSION_ID, MESSAGE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LST_MESSAGES ***
grant SELECT                                                                 on NBUR_LST_MESSAGES to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LST_MESSAGES to BARSUPL;
grant SELECT                                                                 on NBUR_LST_MESSAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LST_MESSAGES to BARS_DM;
grant SELECT                                                                 on NBUR_LST_MESSAGES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LST_MESSAGES.sql =========*** End
PROMPT ===================================================================================== 
