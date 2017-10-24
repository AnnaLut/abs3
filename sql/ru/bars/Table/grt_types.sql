

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_TYPES'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_TYPES 
   (	TYPE_ID NUMBER(10,0), 
	TYPE_NAME VARCHAR2(150), 
	GROUP_ID NUMBER(4,0), 
	NBS VARCHAR2(4), 
	S031 VARCHAR2(2), 
	DETAIL_TABLE_ID NUMBER(3,0), 
	KV NUMBER DEFAULT 0, 
	TP NUMBER DEFAULT 0, 
	KL NUMBER DEFAULT 0, 
	KZ NUMBER DEFAULT 0, 
	KN NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_TYPES ***
 exec bpa.alter_policies('GRT_TYPES');


COMMENT ON TABLE BARS.GRT_TYPES IS '������� ����� ����������� ';
COMMENT ON COLUMN BARS.GRT_TYPES.TYPE_ID IS '������������� ���� �����������';
COMMENT ON COLUMN BARS.GRT_TYPES.TYPE_NAME IS '������������ ���� �����������';
COMMENT ON COLUMN BARS.GRT_TYPES.GROUP_ID IS '������������� ������ �����������';
COMMENT ON COLUMN BARS.GRT_TYPES.NBS IS '';
COMMENT ON COLUMN BARS.GRT_TYPES.S031 IS '';
COMMENT ON COLUMN BARS.GRT_TYPES.DETAIL_TABLE_ID IS '';
COMMENT ON COLUMN BARS.GRT_TYPES.KV IS '������� ������ ������ ����������� ����������� (���������� ��� 10%, �������, ������, ���������� ���)';
COMMENT ON COLUMN BARS.GRT_TYPES.TP IS '����� ����, �� ���� ������� ��������� ������ ���� ����� �� ���������� �������';
COMMENT ON COLUMN BARS.GRT_TYPES.KL IS '���������� �������� (������������ ���������� � ������� �������)';
COMMENT ON COLUMN BARS.GRT_TYPES.KZ IS '���������� ����� �������� ������� �� ���� ��';
COMMENT ON COLUMN BARS.GRT_TYPES.KN IS '���������� �������� ������� (������ ������, ���������, ���������� ����)';




PROMPT *** Create  constraint FK_GRTTYPES_GRTDETTABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES ADD CONSTRAINT FK_GRTTYPES_GRTDETTABLES FOREIGN KEY (DETAIL_TABLE_ID)
	  REFERENCES BARS.GRT_DETAIL_TABLES (TABLE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTTYPES_GRTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES ADD CONSTRAINT FK_GRTTYPES_GRTGROUPS FOREIGN KEY (GROUP_ID)
	  REFERENCES BARS.GRT_GROUPS (GROUP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GRTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES ADD CONSTRAINT PK_GRTTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_KN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (KN CONSTRAINT CC_GRTTYPES_KN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_KZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (KZ CONSTRAINT CC_GRTTYPES_KZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_KL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (KL CONSTRAINT CC_GRTTYPES_KL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_TP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (TP CONSTRAINT CC_GRTTYPES_TP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (KV CONSTRAINT CC_GRTTYPES_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_DETTBLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (DETAIL_TABLE_ID CONSTRAINT CC_GRTTYPES_DETTBLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_S031_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (S031 CONSTRAINT CC_GRTTYPES_S031_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (NBS CONSTRAINT CC_GRTTYPES_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_GROUPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (GROUP_ID CONSTRAINT CC_GRTTYPES_GROUPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_GRTTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTTYPES ON BARS.GRT_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_TYPES ***
grant SELECT                                                                 on GRT_TYPES       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
