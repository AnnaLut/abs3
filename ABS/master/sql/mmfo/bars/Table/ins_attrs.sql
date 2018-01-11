

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_ATTRS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_ATTRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_ATTRS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_ATTRS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_ATTRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_ATTRS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	TYPE_ID VARCHAR2(1) DEFAULT ''S''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_ATTRS ***
 exec bpa.alter_policies('INS_ATTRS');


COMMENT ON TABLE BARS.INS_ATTRS IS 'Атрибути страхового договору';
COMMENT ON COLUMN BARS.INS_ATTRS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_ATTRS.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.INS_ATTRS.TYPE_ID IS 'Тип (S - строка, N - число, D - дата)';




PROMPT *** Create  constraint SYS_C0033269 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTRS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSATTRS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTRS MODIFY (NAME CONSTRAINT CC_INSATTRS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSATTRS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTRS MODIFY (TYPE_ID CONSTRAINT CC_INSATTRS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTRS ADD CONSTRAINT PK_INSATTRS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSATTRS_TYPEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTRS ADD CONSTRAINT CC_INSATTRS_TYPEID CHECK (type_id in (''S'', ''N'', ''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSATTRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSATTRS ON BARS.INS_ATTRS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_ATTRS ***
grant SELECT                                                                 on INS_ATTRS       to BARSREADER_ROLE;
grant SELECT                                                                 on INS_ATTRS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_ATTRS.sql =========*** End *** ===
PROMPT ===================================================================================== 
