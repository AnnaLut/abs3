

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARAMS_INTG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARAMS_INTG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARAMS_INTG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_PARAMS_INTG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARAMS_INTG ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARAMS_INTG 
   (	ID NUMBER(*,0), 
	KF VARCHAR2(12), 
	NB VARCHAR2(4000), 
	URLAPI VARCHAR2(4000), 
	USERNAME VARCHAR2(30), 
	HPASSWORD VARCHAR2(60), 
	IS_ACTIVE NUMBER(*,0), 
	STATUS VARCHAR2(7), 
	STATUS_MESSAGE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARAMS_INTG ***
 exec bpa.alter_policies('INS_PARAMS_INTG');


COMMENT ON TABLE BARS.INS_PARAMS_INTG IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.USERNAME IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.HPASSWORD IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.IS_ACTIVE IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.STATUS IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.STATUS_MESSAGE IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.URLAPI IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.NB IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.ID IS '';
COMMENT ON COLUMN BARS.INS_PARAMS_INTG.KF IS '';




PROMPT *** Create  constraint SYS_C0033466 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARAMS_INTG MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033467 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARAMS_INTG MODIFY (URLAPI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033468 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARAMS_INTG MODIFY (USERNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033469 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARAMS_INTG MODIFY (HPASSWORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033470 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARAMS_INTG ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0033470 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0033470 ON BARS.INS_PARAMS_INTG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_PARAMS_INTG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INS_PARAMS_INTG to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARAMS_INTG.sql =========*** End *
PROMPT ===================================================================================== 
