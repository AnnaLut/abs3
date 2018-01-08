

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PERSON_VALID_DOCUMENT_UPDATE.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PERSON_VALID_DOCUMENT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PERSON_VALID_DOCUMENT_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON_VALID_DOCUMENT_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON_VALID_DOCUMENT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PERSON_VALID_DOCUMENT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE 
   (	RNK NUMBER(38,0), 
	CHGDATE DATE, 
	DOC_STATE NUMBER(1,0), 
	USERID NUMBER(38,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PERSON_VALID_DOCUMENT_UPDATE ***
 exec bpa.alter_policies('PERSON_VALID_DOCUMENT_UPDATE');


COMMENT ON TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE IS 'Архів станів актуальності ідентифікуючих документів клієнтів';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT_UPDATE.RNK IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT_UPDATE.CHGDATE IS 'Календарна дата зміни статусу документу';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT_UPDATE.DOC_STATE IS 'Стан актуальності ідентифікуючого документу';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT_UPDATE.USERID IS 'Ідентифікатор користувача, що виконав зміни';




PROMPT *** Create  constraint PK_PERSVALIDDOCUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE ADD CONSTRAINT PK_PERSVALIDDOCUPD PRIMARY KEY (RNK, CHGDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSVALIDDOCUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE MODIFY (RNK CONSTRAINT CC_PERSVALIDDOCUPD_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSVALIDDOCUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE MODIFY (CHGDATE CONSTRAINT CC_PERSVALIDDOCUPD_CHGDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSVALIDDOCUPD_DOCSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE MODIFY (DOC_STATE CONSTRAINT CC_PERSVALIDDOCUPD_DOCSTATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSVALIDDOCUPD_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT_UPDATE MODIFY (USERID CONSTRAINT CC_PERSVALIDDOCUPD_USERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PERSVALIDDOCUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PERSVALIDDOCUPD ON BARS.PERSON_VALID_DOCUMENT_UPDATE (RNK, CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PERSVALIDDOCUPD_BDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PERSVALIDDOCUPD_BDATE ON BARS.PERSON_VALID_DOCUMENT_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON_VALID_DOCUMENT_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON_VALID_DOCUMENT_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PERSON_VALID_DOCUMENT_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON_VALID_DOCUMENT_UPDATE to DPT_ADMIN;
grant SELECT                                                                 on PERSON_VALID_DOCUMENT_UPDATE to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PERSON_VALID_DOCUMENT_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PERSON_VALID_DOCUMENT_UPDATE.sql =====
PROMPT ===================================================================================== 
