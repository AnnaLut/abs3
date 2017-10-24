

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_REBRANCH_DATA.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_REBRANCH_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_REBRANCH_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_REBRANCH_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_REBRANCH_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_REBRANCH_DATA 
   (	ID NUMBER, 
	FILEID NUMBER, 
	IDN NUMBER, 
	RNK NUMBER, 
	NLS VARCHAR2(15), 
	BRANCH VARCHAR2(30), 
	STATE NUMBER(*,0), 
	MSG VARCHAR2(4000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_REBRANCH_DATA ***
 exec bpa.alter_policies('OW_REBRANCH_DATA');


COMMENT ON TABLE BARS.OW_REBRANCH_DATA IS '';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.ID IS '���������� ����� ������';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.FILEID IS '������������� �����';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.IDN IS '����� ����� � ����';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.RNK IS '������������ ����� �볺���';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.NLS IS '�������';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.BRANCH IS '����� ����� �������';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.STATE IS '������ (0-����� �����, 1-  ������, 10 - �������)';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.MSG IS '�����������';
COMMENT ON COLUMN BARS.OW_REBRANCH_DATA.KF IS '';




PROMPT *** Create  constraint OW_REBRANCH_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA ADD CONSTRAINT OW_REBRANCH_DATA PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149193 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149192 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149191 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149190 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149189 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149188 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (IDN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149187 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (FILEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003149186 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REBRANCH_DATA MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OW_REBRANCH_FILEID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OW_REBRANCH_FILEID ON BARS.OW_REBRANCH_DATA (FILEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OW_REBRANCH_RNK_NLS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OW_REBRANCH_RNK_NLS ON BARS.OW_REBRANCH_DATA (RNK, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OW_REBRANCH_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OW_REBRANCH_DATA ON BARS.OW_REBRANCH_DATA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_REBRANCH_DATA ***
grant INSERT,SELECT,UPDATE                                                   on OW_REBRANCH_DATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_REBRANCH_DATA.sql =========*** End 
PROMPT ===================================================================================== 
