

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/PERIODS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table PERIODS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.PERIODS 
   (	ID NUMBER, 
	TYPE VARCHAR2(10), 
	SDATE DATE, 
	EDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.PERIODS IS '';
COMMENT ON COLUMN BARS_DM.PERIODS.ID IS '';
COMMENT ON COLUMN BARS_DM.PERIODS.TYPE IS '';
COMMENT ON COLUMN BARS_DM.PERIODS.SDATE IS '';
COMMENT ON COLUMN BARS_DM.PERIODS.EDATE IS '';




PROMPT *** Create  constraint PK_PERIODS ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.PERIODS ADD CONSTRAINT PK_PERIODS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERIODS_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.PERIODS MODIFY (TYPE CONSTRAINT CC_PERIODS_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.PERIODS MODIFY (SDATE CONSTRAINT CC_SDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.PERIODS MODIFY (EDATE CONSTRAINT CC_EDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PERIODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_PERIODS ON BARS_DM.PERIODS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PERIODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.I1_PERIODS ON BARS_DM.PERIODS (TYPE, SDATE, EDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERIODS ***
grant SELECT                                                                 on PERIODS         to BARSREADER_ROLE;
grant SELECT                                                                 on PERIODS         to BARSUPL;
grant SELECT                                                                 on PERIODS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/PERIODS.sql =========*** End *** ==
PROMPT ===================================================================================== 
