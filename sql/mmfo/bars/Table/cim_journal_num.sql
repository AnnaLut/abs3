

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_JOURNAL_NUM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_JOURNAL_NUM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_JOURNAL_NUM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_JOURNAL_NUM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_JOURNAL_NUM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_JOURNAL_NUM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_JOURNAL_NUM 
   (	BRANCH VARCHAR2(30), 
	N1 NUMBER DEFAULT 0, 
	N2 NUMBER DEFAULT 0, 
	N3 NUMBER DEFAULT 0, 
	N4 NUMBER DEFAULT 0, 
	NAME VARCHAR2(256), 
	NAME_OV VARCHAR2(256), 
	ADR VARCHAR2(256), 
	PHONE VARCHAR2(256) DEFAULT ''Заповніть номер телефону в cim_journal_num''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_JOURNAL_NUM ***
 exec bpa.alter_policies('CIM_JOURNAL_NUM');


COMMENT ON TABLE BARS.CIM_JOURNAL_NUM IS 'Номери записів у журиалах в розрізі відділень';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.BRANCH IS 'Branch відділення';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.N1 IS 'Останній використаний номер у 1 журналі';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.N2 IS 'Останній використаний номер у 2 журналі';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.N3 IS 'Останній використаний номер у 3 журналі';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.N4 IS 'Останній використаний номер у 4 журналі';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.NAME IS 'Назва підрозділу';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.NAME_OV IS 'Назва підрозділу (в орудному відмінку)';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.ADR IS 'Адреса підрозділу';
COMMENT ON COLUMN BARS.CIM_JOURNAL_NUM.PHONE IS 'Номер контактного телефону';




PROMPT *** Create  constraint CC_CIMJOURNALNUM_N1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (N1 CONSTRAINT CC_CIMJOURNALNUM_N1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (BRANCH CONSTRAINT CC_CIMJOURNALNUM_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_BRANCH_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM ADD CONSTRAINT CC_CIMJOURNALNUM_BRANCH_UK UNIQUE (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_N2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (N2 CONSTRAINT CC_CIMJOURNALNUM_N2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005578 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (PHONE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_N4_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (N4 CONSTRAINT CC_CIMJOURNALNUM_N4_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (NAME CONSTRAINT CC_CIMJOURNALNUM_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_NAMEOV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (NAME_OV CONSTRAINT CC_CIMJOURNALNUM_NAMEOV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_ADR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (ADR CONSTRAINT CC_CIMJOURNALNUM_ADR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMJOURNALNUM_N3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_JOURNAL_NUM MODIFY (N3 CONSTRAINT CC_CIMJOURNALNUM_N3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_CIMJOURNALNUM_BRANCH_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_CIMJOURNALNUM_BRANCH_UK ON BARS.CIM_JOURNAL_NUM (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_JOURNAL_NUM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_JOURNAL_NUM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_JOURNAL_NUM to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_JOURNAL_NUM to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_JOURNAL_NUM.sql =========*** End *
PROMPT ===================================================================================== 
