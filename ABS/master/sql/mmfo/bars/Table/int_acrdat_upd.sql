

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_ACRDAT_UPD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_ACRDAT_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_ACRDAT_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_ACRDAT_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_ACRDAT_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_ACRDAT_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_ACRDAT_UPD 
   (	ACCID NUMBER(38,0), 
	INTID NUMBER(38,0), 
	ACRDAT DATE, 
	REC_ID NUMBER(38,0), 
	REC_TYPE CHAR(1), 
	REC_UID NUMBER(38,0), 
	REC_UNAME VARCHAR2(30), 
	REC_DATE DATE, 
	MACHINE VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_ACRDAT_UPD ***
 exec bpa.alter_policies('INT_ACRDAT_UPD');


COMMENT ON TABLE BARS.INT_ACRDAT_UPD IS 'История изменений процентных карточек счетов банка';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.REC_ID IS 'Идентификатор изменения';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.REC_TYPE IS 'Тип изменения';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.REC_UID IS 'Код пользователя';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.REC_UNAME IS 'Имя пользователя БД';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.REC_DATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.MACHINE IS 'machine';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.ACCID IS 'Номер счета';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.INTID IS 'ID';
COMMENT ON COLUMN BARS.INT_ACRDAT_UPD.ACRDAT IS 'Дата последнего начисления';




PROMPT *** Create  constraint PK_INTACRDATUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD ADD CONSTRAINT PK_INTACRDATUPD PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (ACCID CONSTRAINT CC_INTACRDATUPD_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_MACHINE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (MACHINE CONSTRAINT CC_INTACRDATUPD_MACHINE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_RECDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (REC_DATE CONSTRAINT CC_INTACRDATUPD_RECDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_RECUNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (REC_UNAME CONSTRAINT CC_INTACRDATUPD_RECUNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_RECUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (REC_UID CONSTRAINT CC_INTACRDATUPD_RECUID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_RECTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (REC_TYPE CONSTRAINT CC_INTACRDATUPD_RECTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (REC_ID CONSTRAINT CC_INTACRDATUPD_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACRDATUPD_INTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACRDAT_UPD MODIFY (INTID CONSTRAINT CC_INTACRDATUPD_INTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTACRDATUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTACRDATUPD ON BARS.INT_ACRDAT_UPD (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_ACRDAT_UPD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ACRDAT_UPD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_ACRDAT_UPD  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ACRDAT_UPD  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_ACRDAT_UPD.sql =========*** End **
PROMPT ===================================================================================== 
