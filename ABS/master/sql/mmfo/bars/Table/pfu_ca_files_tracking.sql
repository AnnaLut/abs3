

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PFU_CA_FILES_TRACKING.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PFU_CA_FILES_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PFU_CA_FILES_TRACKING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PFU_CA_FILES_TRACKING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PFU_CA_FILES_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.PFU_CA_FILES_TRACKING 
   (	ID NUMBER, 
	FILE_ID NUMBER, 
	STATE NUMBER(2,0) DEFAULT 0, 
	MESSAGE VARCHAR2(4000), 
	SYS_TIME DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PFU_CA_FILES_TRACKING ***
 exec bpa.alter_policies('PFU_CA_FILES_TRACKING');


COMMENT ON TABLE BARS.PFU_CA_FILES_TRACKING IS '';
COMMENT ON COLUMN BARS.PFU_CA_FILES_TRACKING.ID IS '';
COMMENT ON COLUMN BARS.PFU_CA_FILES_TRACKING.FILE_ID IS '';
COMMENT ON COLUMN BARS.PFU_CA_FILES_TRACKING.STATE IS '';
COMMENT ON COLUMN BARS.PFU_CA_FILES_TRACKING.MESSAGE IS '';
COMMENT ON COLUMN BARS.PFU_CA_FILES_TRACKING.SYS_TIME IS '';




PROMPT *** Create  constraint SYS_C00109492 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES_TRACKING MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109493 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES_TRACKING MODIFY (FILE_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109494 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES_TRACKING MODIFY (STATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109495 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_CA_FILES_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES_TRACKING ADD CONSTRAINT PK_PFU_CA_FILES_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_CA_FILES_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PFU_CA_FILES_TRACKING ON BARS.PFU_CA_FILES_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_CA_FILES_TRACKING ***
grant SELECT                                                                 on PFU_CA_FILES_TRACKING to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_CA_FILES_TRACKING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_CA_FILES_TRACKING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PFU_CA_FILES_TRACKING.sql =========***
PROMPT ===================================================================================== 
