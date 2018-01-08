

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_REGIONS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_REGIONS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_REGIONS 
   (	KF VARCHAR2(6), 
	REGION_NAME VARCHAR2(64), 
	CODE_NMBR NUMBER, 
	CODE_CHR CHAR(2), 
	FTP_UPL_FOLDER VARCHAR2(1000), 
	FTP_USER VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_REGIONS IS '';
COMMENT ON COLUMN BARSUPL.UPL_REGIONS.KF IS '';
COMMENT ON COLUMN BARSUPL.UPL_REGIONS.REGION_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_REGIONS.CODE_NMBR IS '';
COMMENT ON COLUMN BARSUPL.UPL_REGIONS.CODE_CHR IS '';
COMMENT ON COLUMN BARSUPL.UPL_REGIONS.FTP_UPL_FOLDER IS '';
COMMENT ON COLUMN BARSUPL.UPL_REGIONS.FTP_USER IS '';




PROMPT *** Create  constraint PK_UPLREGIONS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_REGIONS ADD CONSTRAINT PK_UPLREGIONS PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLREGIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLREGIONS ON BARSUPL.UPL_REGIONS (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_REGIONS ***
grant SELECT                                                                 on UPL_REGIONS     to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_REGIONS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_REGIONS.sql =========*** End **
PROMPT ===================================================================================== 
