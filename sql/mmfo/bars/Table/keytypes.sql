

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KEYTYPES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KEYTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KEYTYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KEYTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KEYTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.KEYTYPES 
   (	ID NUMBER, 
	NAME VARCHAR2(200), 
	CODE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KEYTYPES ***
 exec bpa.alter_policies('KEYTYPES');


COMMENT ON TABLE BARS.KEYTYPES IS '';
COMMENT ON COLUMN BARS.KEYTYPES.ID IS 'Ідентифікатор ключа';
COMMENT ON COLUMN BARS.KEYTYPES.NAME IS 'Назва ключа';
COMMENT ON COLUMN BARS.KEYTYPES.CODE IS '';




PROMPT *** Create  constraint SYS_C0033914 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEYTYPES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033915 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEYTYPES MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KEYTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEYTYPES ADD CONSTRAINT PK_KEYTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_KEYTYPES_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEYTYPES ADD CONSTRAINT UK_KEYTYPES_CODE UNIQUE (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KEYTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KEYTYPES ON BARS.KEYTYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KEYTYPES_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KEYTYPES_CODE ON BARS.KEYTYPES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KEYTYPES.sql =========*** End *** ====
PROMPT ===================================================================================== 
