

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DYN_FILTER.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DYN_FILTER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DYN_FILTER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DYN_FILTER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DYN_FILTER ***
begin 
  execute immediate '
  CREATE TABLE BARS.DYN_FILTER 
   (	FILTER_ID NUMBER(38,0), 
	TABID NUMBER(38,0), 
	USERID NUMBER(38,0), 
	SEMANTIC VARCHAR2(70), 
	FROM_CLAUSE VARCHAR2(210), 
	WHERE_CLAUSE VARCHAR2(2000), 
	PKEY VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	CONDITION_LIST CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DYN_FILTER ***
 exec bpa.alter_policies('DYN_FILTER');


COMMENT ON TABLE BARS.DYN_FILTER IS '���������� ����������� ������������ ��������';
COMMENT ON COLUMN BARS.DYN_FILTER.PKEY IS '���� ��� ����������� ���������';
COMMENT ON COLUMN BARS.DYN_FILTER.BRANCH IS '';
COMMENT ON COLUMN BARS.DYN_FILTER.FILTER_ID IS 'ID ������� (� �/�)';
COMMENT ON COLUMN BARS.DYN_FILTER.TABID IS '��������� �������������';
COMMENT ON COLUMN BARS.DYN_FILTER.USERID IS '������������� ������������';
COMMENT ON COLUMN BARS.DYN_FILTER.SEMANTIC IS '';
COMMENT ON COLUMN BARS.DYN_FILTER.FROM_CLAUSE IS '������ ������';
COMMENT ON COLUMN BARS.DYN_FILTER.WHERE_CLAUSE IS '���� ������';




PROMPT *** Create  constraint FK_DYNFILTER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER ADD CONSTRAINT FK_DYNFILTER_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DYNFILTER_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER ADD CONSTRAINT FK_DYNFILTER_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DYNFILTER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER ADD CONSTRAINT PK_DYNFILTER PRIMARY KEY (FILTER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DYNFILTER_WHERECLAUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER MODIFY (WHERE_CLAUSE CONSTRAINT CC_DYNFILTER_WHERECLAUSE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DYNFILTER_SEMANTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER MODIFY (SEMANTIC CONSTRAINT CC_DYNFILTER_SEMANTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DYNFILTER_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER MODIFY (TABID CONSTRAINT CC_DYNFILTER_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DYNFILTER_FILTERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER MODIFY (FILTER_ID CONSTRAINT CC_DYNFILTER_FILTERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DYNFILTER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DYNFILTER ON BARS.DYN_FILTER (FILTER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DYNFILTER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DYNFILTER ON BARS.DYN_FILTER (TABID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table DYN_FILTER add condition_list clob';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  grants  DYN_FILTER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DYN_FILTER      to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DYN_FILTER      to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DYN_FILTER      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DYN_FILTER      to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on DYN_FILTER      to WR_FILTER;
grant SELECT                                                                 on DYN_FILTER      to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on DYN_FILTER      to WR_USER_ACCOUNTS_LIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DYN_FILTER.sql =========*** End *** ==
PROMPT ===================================================================================== 
