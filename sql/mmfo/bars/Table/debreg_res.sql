

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_RES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_RES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_RES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEBREG_RES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEBREG_RES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_RES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_RES 
   (	REQUESTID NUMBER, 
	MFO VARCHAR2(6), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	CUSTTYPE NUMBER, 
	PRINSIDER NUMBER, 
	EVENTTYPE NUMBER, 
	EVENTDATE DATE, 
	DEBNUM NUMBER, 
	KV NUMBER, 
	CRDAGRNUM VARCHAR2(16), 
	CRDDATE DATE, 
	SUMM NUMBER, 
	DEBDATE DATE, 
	FILENAME CHAR(12), 
	ILNUM NUMBER, 
	DEBOFFDATE DATE, 
	REGDATETIME DATE, 
	REZID NUMBER(1,0), 
	OSN VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_RES ***
 exec bpa.alter_policies('DEBREG_RES');


COMMENT ON TABLE BARS.DEBREG_RES IS 'Ответы из Реестра должников';
COMMENT ON COLUMN BARS.DEBREG_RES.REQUESTID IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.MFO IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.OKPO IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.NMK IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.ADR IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.PRINSIDER IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.EVENTTYPE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.EVENTDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.DEBNUM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.KV IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.CRDAGRNUM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.CRDDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.SUMM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.DEBDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.FILENAME IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.ILNUM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.DEBOFFDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.REGDATETIME IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.REZID IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.OSN IS 'Данi про керiвникiв та засновникiв';
COMMENT ON COLUMN BARS.DEBREG_RES.KF IS '';
COMMENT ON COLUMN BARS.DEBREG_RES.RID IS '';




PROMPT *** Create  constraint CC_DEBREGRES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_RES MODIFY (KF CONSTRAINT CC_DEBREGRES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBREGRES_RID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_RES MODIFY (RID CONSTRAINT CC_DEBREGRES_RID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEBREGRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_RES ADD CONSTRAINT PK_DEBREGRES PRIMARY KEY (RID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEBREGRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEBREGRES ON BARS.DEBREG_RES (RID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DEBREGRES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DEBREGRES ON BARS.DEBREG_RES (REQUESTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEBREG_RES ***
grant SELECT                                                                 on DEBREG_RES      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_RES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_RES      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_RES      to DEB_REG;
grant SELECT                                                                 on DEBREG_RES      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_RES.sql =========*** End *** ==
PROMPT ===================================================================================== 
