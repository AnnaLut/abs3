

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_MANY_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_MANY_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_MANY_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_MANY_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_MANY_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_MANY_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_MANY_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER(38,0), 
	REF NUMBER(38,0), 
	FDAT DATE, 
	SS1 NUMBER, 
	SDP NUMBER, 
	SN2 NUMBER, 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_MANY_UPDATE ***
 exec bpa.alter_policies('CP_MANY_UPDATE');


COMMENT ON TABLE BARS.CP_MANY_UPDATE IS '_стор_я зм_н грошових поток_в по договорам ЦП';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.IDUPD IS '_дентиф_катор зм_ни';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.CHGACTION IS 'Код типу зм_ни';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.EFFECTDATE IS 'Банк_вська дата зм_ни параметр_в';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.CHGDATE IS 'Календарна дата зм_ни параметр_в';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.DONEBY IS '_дентиф_катор користувача, що виконав зм_ни';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.REF IS 'Реф. договору';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.FDAT IS 'Дата потоку';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.SS1 IS 'Сума ном_налу';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.SDP IS 'Сума Диск/Прем';
COMMENT ON COLUMN BARS.CP_MANY_UPDATE.SN2 IS 'Сума купона';




PROMPT *** Create  constraint PK_CPMANYUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE ADD CONSTRAINT PK_CPMANYUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (KF CONSTRAINT CC_CPMANYUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPMANYUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE ADD CONSTRAINT FK_CPMANYUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (IDUPD CONSTRAINT CC_CPMANYUPDATE_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (FDAT CONSTRAINT CC_CPMANYUPDATE_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_CPMANYUPDATE_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CPMANYUPDATE_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (DONEBY CONSTRAINT CC_CPMANYUPDATE_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (REF CONSTRAINT CC_CPMANYUPDATE_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPMANYUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CPMANYUPDATE_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPMANYUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPMANYUPDATE ON BARS.CP_MANY_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CPMANYUPDATE_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPMANYUPDATE_EFFECTDATE ON BARS.CP_MANY_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CPMANYUPDATE_REF_FDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPMANYUPDATE_REF_FDAT ON BARS.CP_MANY_UPDATE (REF, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_MANY_UPDATE ***
grant SELECT                                                                 on CP_MANY_UPDATE  to BARSUPL;
grant SELECT                                                                 on CP_MANY_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_MANY_UPDATE  to BARS_DM;
grant SELECT                                                                 on CP_MANY_UPDATE  to START1;
grant SELECT                                                                 on CP_MANY_UPDATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_MANY_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
