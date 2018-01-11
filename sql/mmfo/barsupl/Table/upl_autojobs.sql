

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_AUTOJOBS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_AUTOJOBS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_AUTOJOBS 
   (	JOB_NAME VARCHAR2(200), 
	DESCRIPT VARCHAR2(500), 
	IS_ACTIVE NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_AUTOJOBS IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOBS.JOB_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOBS.DESCRIPT IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOBS.IS_ACTIVE IS '';
COMMENT ON COLUMN BARSUPL.UPL_AUTOJOBS.KF IS '';




PROMPT *** Create  constraint PK_UPLAUTOJOBS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_AUTOJOBS ADD CONSTRAINT PK_UPLAUTOJOBS PRIMARY KEY (KF, JOB_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033142 ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_AUTOJOBS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLAUTOJOBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLAUTOJOBS ON BARSUPL.UPL_AUTOJOBS (KF, JOB_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_AUTOJOBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_AUTOJOBS    to BARS;
grant SELECT                                                                 on UPL_AUTOJOBS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_AUTOJOBS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_AUTOJOBS.sql =========*** End *
PROMPT ===================================================================================== 
