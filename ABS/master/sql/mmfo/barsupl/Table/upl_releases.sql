

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_RELEASES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_RELEASES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_RELEASES 
   (	RELEASE_NUMBER NUMBER(10,2), 
	RELEASE_DATE DATE, 
	DESCRIPTION VARCHAR2(250), 
	EXPIRY_DATE DATE, 
	CHANGE_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_RELEASES IS '';
COMMENT ON COLUMN BARSUPL.UPL_RELEASES.KF IS '';
COMMENT ON COLUMN BARSUPL.UPL_RELEASES.RELEASE_NUMBER IS '';
COMMENT ON COLUMN BARSUPL.UPL_RELEASES.RELEASE_DATE IS '';
COMMENT ON COLUMN BARSUPL.UPL_RELEASES.DESCRIPTION IS '';
COMMENT ON COLUMN BARSUPL.UPL_RELEASES.EXPIRY_DATE IS '';
COMMENT ON COLUMN BARSUPL.UPL_RELEASES.CHANGE_DATE IS '';




PROMPT *** Create  constraint SYS_C0061194 ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_RELEASES MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLRELEASES ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_RELEASES ADD CONSTRAINT PK_UPLRELEASES PRIMARY KEY (KF, RELEASE_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLRELEASES_RELEASENUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_RELEASES MODIFY (RELEASE_NUMBER CONSTRAINT CC_UPLRELEASES_RELEASENUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLRELEASES_RELEASEDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_RELEASES MODIFY (RELEASE_DATE CONSTRAINT CC_UPLRELEASES_RELEASEDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLRELEASES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLRELEASES ON BARSUPL.UPL_RELEASES (KF, RELEASE_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_RELEASES ***
grant SELECT                                                                 on UPL_RELEASES    to BARS;
grant SELECT                                                                 on UPL_RELEASES    to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_RELEASES    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_RELEASES.sql =========*** End *
PROMPT ===================================================================================== 
