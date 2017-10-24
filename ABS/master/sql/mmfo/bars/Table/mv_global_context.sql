

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MV_GLOBAL_CONTEXT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MV_GLOBAL_CONTEXT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MV_GLOBAL_CONTEXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.MV_GLOBAL_CONTEXT 
   (	CLIENT_IDENTIFIER VARCHAR2(65), 
	LAST_ACTIVITY_AT VARCHAR2(4000), 
	CURRENT_BRANCH VARCHAR2(4000), 
	CURRENT_BANK_DATE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MV_GLOBAL_CONTEXT ***
 exec bpa.alter_policies('MV_GLOBAL_CONTEXT');


COMMENT ON COLUMN BARS.MV_GLOBAL_CONTEXT.CLIENT_IDENTIFIER IS '';
COMMENT ON COLUMN BARS.MV_GLOBAL_CONTEXT.LAST_ACTIVITY_AT IS '';
COMMENT ON COLUMN BARS.MV_GLOBAL_CONTEXT.CURRENT_BRANCH IS '';
COMMENT ON COLUMN BARS.MV_GLOBAL_CONTEXT.CURRENT_BANK_DATE IS '';




PROMPT *** Create  index I_MV_GLOBAL_CONTEXT_CLIENTID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_MV_GLOBAL_CONTEXT_CLIENTID ON BARS.MV_GLOBAL_CONTEXT (CLIENT_IDENTIFIER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MV_GLOBAL_CONTEXT.sql =========*** End
PROMPT ===================================================================================== 
