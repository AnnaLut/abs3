

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIREWALL_JOB_MODULE_PARAMS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIREWALL_JOB_MODULE_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIREWALL_JOB_MODULE_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIREWALL_JOB_MODULE_PARAMS 
   (	JOB NUMBER, 
	SID NUMBER, 
	SERIAL# NUMBER, 
	U_ID NUMBER, 
	USERNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIREWALL_JOB_MODULE_PARAMS ***
 exec bpa.alter_policies('FIREWALL_JOB_MODULE_PARAMS');


COMMENT ON TABLE BARS.FIREWALL_JOB_MODULE_PARAMS IS 'FIREWALL: Параметры задания для контроля по имени модуля';
COMMENT ON COLUMN BARS.FIREWALL_JOB_MODULE_PARAMS.JOB IS 'Номер задания';
COMMENT ON COLUMN BARS.FIREWALL_JOB_MODULE_PARAMS.SID IS 'Session ID';
COMMENT ON COLUMN BARS.FIREWALL_JOB_MODULE_PARAMS.SERIAL# IS 'Serial Number';
COMMENT ON COLUMN BARS.FIREWALL_JOB_MODULE_PARAMS.U_ID IS 'User ID(staff.id)';
COMMENT ON COLUMN BARS.FIREWALL_JOB_MODULE_PARAMS.USERNAME IS 'User Name';




PROMPT *** Create  constraint XPK_FIREWALL_JOB_MODULE_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_JOB_MODULE_PARAMS ADD CONSTRAINT XPK_FIREWALL_JOB_MODULE_PARAMS PRIMARY KEY (JOB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FW_JOB_MOD_PAR_SID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_JOB_MODULE_PARAMS MODIFY (SID CONSTRAINT CC_FW_JOB_MOD_PAR_SID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FW_JOB_MOD_PAR_SERIAL# ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_JOB_MODULE_PARAMS MODIFY (SERIAL# CONSTRAINT CC_FW_JOB_MOD_PAR_SERIAL# NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FW_JOB_MOD_PAR_U_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_JOB_MODULE_PARAMS MODIFY (U_ID CONSTRAINT CC_FW_JOB_MOD_PAR_U_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FW_JOB_MOD_PAR_USERNAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_JOB_MODULE_PARAMS MODIFY (USERNAME CONSTRAINT CC_FW_JOB_MOD_PAR_USERNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIREWALL_JOB_MODULE_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIREWALL_JOB_MODULE_PARAMS ON BARS.FIREWALL_JOB_MODULE_PARAMS (JOB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIREWALL_JOB_MODULE_PARAMS ***
grant SELECT                                                                 on FIREWALL_JOB_MODULE_PARAMS to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_JOB_MODULE_PARAMS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIREWALL_JOB_MODULE_PARAMS.sql =======
PROMPT ===================================================================================== 
