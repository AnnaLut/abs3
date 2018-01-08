

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPARAM_LIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPARAM_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPARAM_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPARAM_LIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPARAM_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPARAM_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPARAM_LIST 
   (	SPID NUMBER(38,0), 
	NAME VARCHAR2(30), 
	SEMANTIC VARCHAR2(60), 
	TABNAME VARCHAR2(30), 
	TYPE CHAR(1), 
	NSINAME VARCHAR2(60), 
	INUSE NUMBER(1,0), 
	PKNAME VARCHAR2(60), 
	DELONNULL NUMBER(1,0), 
	NSISQLWHERE VARCHAR2(250), 
	SQLCONDITION VARCHAR2(250), 
	TAG VARCHAR2(8), 
	TABCOLUMN_CHECK VARCHAR2(30), 
	CODE VARCHAR2(30) DEFAULT ''OTHERS'', 
	HIST NUMBER(1,0), 
	MAX_CHAR NUMBER(10,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPARAM_LIST ***
 exec bpa.alter_policies('SPARAM_LIST');


COMMENT ON TABLE BARS.SPARAM_LIST IS '������� �������� �������������� ����� � �������';
COMMENT ON COLUMN BARS.SPARAM_LIST.SPID IS '������������� ���������';
COMMENT ON COLUMN BARS.SPARAM_LIST.NAME IS '������������';
COMMENT ON COLUMN BARS.SPARAM_LIST.SEMANTIC IS '��������';
COMMENT ON COLUMN BARS.SPARAM_LIST.TABNAME IS '��� ������� ��������� ���������';
COMMENT ON COLUMN BARS.SPARAM_LIST.TYPE IS '��� ���������';
COMMENT ON COLUMN BARS.SPARAM_LIST.NSINAME IS '��� ������� �����������';
COMMENT ON COLUMN BARS.SPARAM_LIST.INUSE IS '� �������������';
COMMENT ON COLUMN BARS.SPARAM_LIST.PKNAME IS '����';
COMMENT ON COLUMN BARS.SPARAM_LIST.DELONNULL IS '����: ������� ������ �� ����������� ���� �������� �������-�� is null';
COMMENT ON COLUMN BARS.SPARAM_LIST.NSISQLWHERE IS '������� ������� ��� �����������';
COMMENT ON COLUMN BARS.SPARAM_LIST.SQLCONDITION IS '������� ��� ������ ���������';
COMMENT ON COLUMN BARS.SPARAM_LIST.TAG IS '������������ ����';
COMMENT ON COLUMN BARS.SPARAM_LIST.TABCOLUMN_CHECK IS '�������� �������� �� ����';
COMMENT ON COLUMN BARS.SPARAM_LIST.CODE IS '';
COMMENT ON COLUMN BARS.SPARAM_LIST.HIST IS '�������: ������������ � ���������������� ������� ����������';
COMMENT ON COLUMN BARS.SPARAM_LIST.MAX_CHAR IS 'Max ���-�� ��������';
COMMENT ON COLUMN BARS.SPARAM_LIST.BRANCH IS 'Hierarchical Branch Code';




PROMPT *** Create  constraint CC_SPARAMLIST_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT CC_SPARAMLIST_TYPE CHECK (type in (''S'',''N'',''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPARAMLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT PK_SPARAMLIST PRIMARY KEY (SPID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (BRANCH CONSTRAINT CC_SPARAMLIST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (CODE CONSTRAINT CC_SPARAMLIST_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_INUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (INUSE CONSTRAINT CC_SPARAMLIST_INUSE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (TYPE CONSTRAINT CC_SPARAMLIST_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (TABNAME CONSTRAINT CC_SPARAMLIST_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_SEMANTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (SEMANTIC CONSTRAINT CC_SPARAMLIST_SEMANTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (NAME CONSTRAINT CC_SPARAMLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_SPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (SPID CONSTRAINT CC_SPARAMLIST_SPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.SPARAM_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_METACOLTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_DELONNULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT CC_SPARAMLIST_DELONNULL CHECK (delonnull in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_INUSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT CC_SPARAMLIST_INUSE CHECK (inuse in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPARAMLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPARAMLIST ON BARS.SPARAM_LIST (SPID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPARAM_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPARAM_LIST     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPARAM_LIST     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPARAM_LIST     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPARAM_LIST     to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPARAM_LIST     to SPARAM;
grant SELECT                                                                 on SPARAM_LIST     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPARAM_LIST     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SPARAM_LIST     to WR_REFREAD;
grant SELECT                                                                 on SPARAM_LIST     to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPARAM_LIST.sql =========*** End *** =
PROMPT ===================================================================================== 
