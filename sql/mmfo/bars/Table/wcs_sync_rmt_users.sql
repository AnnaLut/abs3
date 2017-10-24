

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_RMT_USERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SYNC_RMT_USERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SYNC_RMT_USERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_RMT_USERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_RMT_USERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SYNC_RMT_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SYNC_RMT_USERS 
   (	LCL_ID NUMBER, 
	DS_ID VARCHAR2(6), 
	RMT_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SYNC_RMT_USERS ***
 exec bpa.alter_policies('WCS_SYNC_RMT_USERS');


COMMENT ON TABLE BARS.WCS_SYNC_RMT_USERS IS 'ользователи внешних источников для синхронизации';
COMMENT ON COLUMN BARS.WCS_SYNC_RMT_USERS.LCL_ID IS 'Ид. в локальном источнике';
COMMENT ON COLUMN BARS.WCS_SYNC_RMT_USERS.DS_ID IS 'Ид. источника';
COMMENT ON COLUMN BARS.WCS_SYNC_RMT_USERS.RMT_ID IS 'Ид. в удаленом источнике';




PROMPT *** Create  constraint UK_WCSSYNCRMTUS_DSID_RMTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_RMT_USERS ADD CONSTRAINT UK_WCSSYNCRMTUS_DSID_RMTID UNIQUE (DS_ID, RMT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSSYNCRMTUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_RMT_USERS ADD CONSTRAINT PK_WCSSYNCRMTUS PRIMARY KEY (LCL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCRMTUS_DSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_RMT_USERS MODIFY (DS_ID CONSTRAINT CC_WCSSYNCRMTUS_DSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCRMTUS_RMTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_RMT_USERS MODIFY (RMT_ID CONSTRAINT CC_WCSSYNCRMTUS_RMTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSYNCRMTUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSYNCRMTUS ON BARS.WCS_SYNC_RMT_USERS (LCL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_WCSSYNCRMTUS_DSID_RMTID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_WCSSYNCRMTUS_DSID_RMTID ON BARS.WCS_SYNC_RMT_USERS (DS_ID, RMT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SYNC_RMT_USERS ***
grant INSERT,SELECT,UPDATE                                                   on WCS_SYNC_RMT_USERS to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_SYNC_RMT_USERS ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_SYNC_RMT_USERS FOR BARS.WCS_SYNC_RMT_USERS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_RMT_USERS.sql =========*** En
PROMPT ===================================================================================== 
