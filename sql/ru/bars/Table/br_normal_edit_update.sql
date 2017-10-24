

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_NORMAL_EDIT_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_NORMAL_EDIT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_NORMAL_EDIT_UPDATE'', ''FILIAL'' , null, ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''BR_NORMAL_EDIT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BR_NORMAL_EDIT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BR_NORMAL_EDIT_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	BR_ID NUMBER(38,0), 
	BDATE DATE, 
	KV NUMBER(3,0), 
	RATE NUMBER(30,8), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BR_NORMAL_EDIT_UPDATE ***
 exec bpa.alter_policies('BR_NORMAL_EDIT_UPDATE');


COMMENT ON TABLE BARS.BR_NORMAL_EDIT_UPDATE IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.BR_ID IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.RATE IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT_UPDATE.BRANCH IS '';




PROMPT *** Create  constraint PK_BRNORMALEDIT_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT_UPDATE ADD CONSTRAINT PK_BRNORMALEDIT_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955641 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT_UPDATE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955640 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT_UPDATE MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955639 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT_UPDATE MODIFY (BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955638 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT_UPDATE MODIFY (BR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRNORMALEDIT_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRNORMALEDIT_UPDATE ON BARS.BR_NORMAL_EDIT_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BRNORMALEDIT_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BRNORMALEDIT_UPDATEEFFDAT ON BARS.BR_NORMAL_EDIT_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BRNORMALEDIT_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BRNORMALEDIT_UPDATEPK ON BARS.BR_NORMAL_EDIT_UPDATE (BRANCH, BR_ID, BDATE, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_NORMAL_EDIT_UPDATE ***
grant SELECT                                                                 on BR_NORMAL_EDIT_UPDATE to BARSUPL;
grant SELECT                                                                 on BR_NORMAL_EDIT_UPDATE to BARS_SUP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_NORMAL_EDIT_UPDATE.sql =========***
PROMPT ===================================================================================== 
