

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_RES_S.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_RES_S ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_RES_S'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEBREG_RES_S'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEBREG_RES_S'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_RES_S ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_RES_S 
   (	REQUESTID NUMBER, 
	MFO VARCHAR2(6), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	CUSTTYPE NUMBER, 
	PRINSIDER NUMBER DEFAULT 99, 
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
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_RES_S ***
 exec bpa.alter_policies('DEBREG_RES_S');


COMMENT ON TABLE BARS.DEBREG_RES_S IS 'Зеркало Реестра должников';
COMMENT ON COLUMN BARS.DEBREG_RES_S.REQUESTID IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.MFO IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.OKPO IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.NMK IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.ADR IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.PRINSIDER IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.EVENTTYPE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.EVENTDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.DEBNUM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.KV IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.CRDAGRNUM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.CRDDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.SUMM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.DEBDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.FILENAME IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.ILNUM IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.DEBOFFDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.REGDATETIME IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.REZID IS '';
COMMENT ON COLUMN BARS.DEBREG_RES_S.OSN IS 'Данi про керiвникiв та засновникiв';
COMMENT ON COLUMN BARS.DEBREG_RES_S.KF IS '';




PROMPT *** Create  constraint FK_DEBREGRESS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_RES_S ADD CONSTRAINT FK_DEBREGRESS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBREGRESS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_RES_S MODIFY (KF CONSTRAINT CC_DEBREGRESS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_DEBNUM_DEBREG_RES_S ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_DEBNUM_DEBREG_RES_S ON BARS.DEBREG_RES_S (DEBNUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEBREG_RES_S ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_RES_S    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_RES_S    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_RES_S    to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_RES_S.sql =========*** End *** 
PROMPT ===================================================================================== 
