

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKR_IMPORT_SAFES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKR_IMPORT_SAFES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKR_IMPORT_SAFES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKR_IMPORT_SAFES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKR_IMPORT_SAFES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKR_IMPORT_SAFES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKR_IMPORT_SAFES 
   (	SNUM VARCHAR2(64 CHAR), 
	O_SK NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ERROR VARCHAR2(1024 CHAR), 
	IMPORTED NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKR_IMPORT_SAFES ***
 exec bpa.alter_policies('SKR_IMPORT_SAFES');


COMMENT ON TABLE BARS.SKR_IMPORT_SAFES IS '';
COMMENT ON COLUMN BARS.SKR_IMPORT_SAFES.SNUM IS '';
COMMENT ON COLUMN BARS.SKR_IMPORT_SAFES.O_SK IS '';
COMMENT ON COLUMN BARS.SKR_IMPORT_SAFES.BRANCH IS '';
COMMENT ON COLUMN BARS.SKR_IMPORT_SAFES.ERROR IS '';
COMMENT ON COLUMN BARS.SKR_IMPORT_SAFES.IMPORTED IS '';




PROMPT *** Create  constraint PK_SKRIMPORTSAFES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKR_IMPORT_SAFES ADD CONSTRAINT PK_SKRIMPORTSAFES PRIMARY KEY (SNUM, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRIMPORTSAFES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRIMPORTSAFES ON BARS.SKR_IMPORT_SAFES (SNUM, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKR_IMPORT_SAFES ***
grant SELECT                                                                 on SKR_IMPORT_SAFES to BARSREADER_ROLE;
grant SELECT                                                                 on SKR_IMPORT_SAFES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKR_IMPORT_SAFES.sql =========*** End 
PROMPT ===================================================================================== 
