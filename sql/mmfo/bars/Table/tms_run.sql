

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_RUN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_RUN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_RUN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_RUN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_RUN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_RUN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_RUN 
   (	ID NUMBER(38,0), 
	CURRENT_BANK_DATE DATE, 
	NEW_BANK_DATE DATE, 
	STATE_ID NUMBER(5,0), 
	USER_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_RUN ***
 exec bpa.alter_policies('TMS_RUN');


COMMENT ON TABLE BARS.TMS_RUN IS '';
COMMENT ON COLUMN BARS.TMS_RUN.ID IS '';
COMMENT ON COLUMN BARS.TMS_RUN.CURRENT_BANK_DATE IS '';
COMMENT ON COLUMN BARS.TMS_RUN.NEW_BANK_DATE IS '';
COMMENT ON COLUMN BARS.TMS_RUN.STATE_ID IS '';
COMMENT ON COLUMN BARS.TMS_RUN.USER_ID IS '';




PROMPT *** Create  constraint SYS_C0035447 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_RUN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035448 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_RUN MODIFY (CURRENT_BANK_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMS_RUN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_RUN ADD CONSTRAINT PK_TMS_RUN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035450 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_RUN MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035451 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_RUN MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035449 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_RUN MODIFY (NEW_BANK_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMS_RUN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMS_RUN ON BARS.TMS_RUN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_RUN.sql =========*** End *** =====
PROMPT ===================================================================================== 
