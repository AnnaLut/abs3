

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_TABLES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_TABLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_TABLES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_TABLES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_TABLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_TABLES 
   (	TABID NUMBER(38,0), 
	TABNAME VARCHAR2(30), 
	SEMANTIC VARCHAR2(80), 
	TABRELATION NUMBER(1,0) DEFAULT 0, 
	TABLDEL NUMBER(1,0), 
	LINESDEF NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''bars_context'',''user_branch''),
        select_statement CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
  execute immediate q'[ALTER TABLE BARS.META_TABLES ADD select_statement CLOB]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "select_statement" already exists in table.');
    else raise;
    end if;
end;
/



PROMPT *** ALTER_POLICIES to META_TABLES ***
 exec bpa.alter_policies('META_TABLES');


COMMENT ON TABLE BARS.META_TABLES IS '������������. ������� �������';
COMMENT ON COLUMN BARS.META_TABLES.LINESDEF IS '������������� �������� ���������� ���������� �����';
COMMENT ON COLUMN BARS.META_TABLES.BRANCH IS '';
COMMENT ON COLUMN BARS.META_TABLES.TABID IS '��� �������';
COMMENT ON COLUMN BARS.META_TABLES.TABNAME IS '��� �������';
COMMENT ON COLUMN BARS.META_TABLES.SEMANTIC IS '������������ �������';
COMMENT ON COLUMN BARS.META_TABLES.TABRELATION IS '������� �������, ����������� ��������� ����� ��������� (0/1)';
COMMENT ON COLUMN BARS.META_TABLES.TABLDEL IS '������� ����������� ��������';
comment on column META_TABLES.select_statement is '����� SQL-������, �� ���� ����������������� � ���� FROM ������ ����� ������������� (TABNAME)';




PROMPT *** Create  constraint CC_METATABLES_TABREL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES ADD CONSTRAINT CC_METATABLES_TABREL CHECK (tabrelation in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES ADD CONSTRAINT PK_METATABLES PRIMARY KEY (TABID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATABLES_TABREL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES MODIFY (TABRELATION CONSTRAINT CC_METATABLES_TABREL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATABLES_SEMANTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES MODIFY (SEMANTIC CONSTRAINT CC_METATABLES_SEMANTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATABLES_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES MODIFY (TABNAME CONSTRAINT CC_METATABLES_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATABLES_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES MODIFY (TABID CONSTRAINT CC_METATABLES_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_META_TABLES_TABNAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES ADD CONSTRAINT UK_META_TABLES_TABNAME UNIQUE (TABNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATABLES_TABLDEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TABLES ADD CONSTRAINT CC_METATABLES_TABLDEL CHECK (tabldel in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METATABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METATABLES ON BARS.META_TABLES (TABID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_METATABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_METATABLES ON BARS.META_TABLES (TABNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_TABLES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_TABLES     to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_TABLES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_TABLES     to CUST001;
grant SELECT                                                                 on META_TABLES     to REF0000;
grant SELECT                                                                 on META_TABLES     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_TABLES     to WR_ALL_RIGHTS;
grant SELECT                                                                 on META_TABLES     to WR_CBIREP;
grant SELECT                                                                 on META_TABLES     to WR_CREDIT;
grant SELECT                                                                 on META_TABLES     to WR_CUSTLIST;
grant SELECT                                                                 on META_TABLES     to WR_CUSTREG;
grant SELECT                                                                 on META_TABLES     to WR_DOC_INPUT;
grant SELECT                                                                 on META_TABLES     to WR_FILTER;
grant SELECT                                                                 on META_TABLES     to WR_METATAB;
grant SELECT                                                                 on META_TABLES     to WR_ND_ACCOUNTS;
grant SELECT                                                                 on META_TABLES     to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_TABLES.sql =========*** End *** =
PROMPT ===================================================================================== 
