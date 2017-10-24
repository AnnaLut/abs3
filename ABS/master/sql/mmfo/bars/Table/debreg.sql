

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEBREG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEBREG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG 
   (	DEBNUM NUMBER, 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	CUSTTYPE NUMBER, 
	PRINSIDER NUMBER, 
	KV NUMBER, 
	CRDAGRNUM VARCHAR2(16), 
	CRDDATE DATE, 
	SUMM NUMBER, 
	DEBDATE DATE, 
	REGDATETIME CHAR(10), 
	DEBOFFDATE DATE, 
	FILENAME CHAR(12), 
	ILNUM NUMBER, 
	REGSOS NUMBER, 
	ERRORCODE CHAR(4) DEFAULT 0000, 
	ERRORCOMMENT VARCHAR2(255), 
	FL_NBU NUMBER, 
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




PROMPT *** ALTER_POLICIES to DEBREG ***
 exec bpa.alter_policies('DEBREG');


COMMENT ON TABLE BARS.DEBREG IS 'Основная таблица для работы с задолженностью';
COMMENT ON COLUMN BARS.DEBREG.DEBNUM IS '';
COMMENT ON COLUMN BARS.DEBREG.OKPO IS '';
COMMENT ON COLUMN BARS.DEBREG.NMK IS '';
COMMENT ON COLUMN BARS.DEBREG.ADR IS '';
COMMENT ON COLUMN BARS.DEBREG.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.DEBREG.PRINSIDER IS '';
COMMENT ON COLUMN BARS.DEBREG.KV IS '';
COMMENT ON COLUMN BARS.DEBREG.CRDAGRNUM IS '';
COMMENT ON COLUMN BARS.DEBREG.CRDDATE IS '';
COMMENT ON COLUMN BARS.DEBREG.SUMM IS '';
COMMENT ON COLUMN BARS.DEBREG.DEBDATE IS '';
COMMENT ON COLUMN BARS.DEBREG.REGDATETIME IS '';
COMMENT ON COLUMN BARS.DEBREG.DEBOFFDATE IS '';
COMMENT ON COLUMN BARS.DEBREG.FILENAME IS '';
COMMENT ON COLUMN BARS.DEBREG.ILNUM IS '';
COMMENT ON COLUMN BARS.DEBREG.REGSOS IS '';
COMMENT ON COLUMN BARS.DEBREG.ERRORCODE IS '';
COMMENT ON COLUMN BARS.DEBREG.ERRORCOMMENT IS '';
COMMENT ON COLUMN BARS.DEBREG.FL_NBU IS '';
COMMENT ON COLUMN BARS.DEBREG.REZID IS '';
COMMENT ON COLUMN BARS.DEBREG.OSN IS 'Данi про керiвникiв та засновникiв';
COMMENT ON COLUMN BARS.DEBREG.KF IS '';




PROMPT *** Create  constraint FK_DEBREG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG ADD CONSTRAINT FK_DEBREG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_OKPO ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (OKPO CONSTRAINT NK_DEBREG_OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DEBREG_DEBNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG ADD CONSTRAINT XPK_DEBREG_DEBNUM PRIMARY KEY (DEBNUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBREG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (KF CONSTRAINT CC_DEBREG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_REZID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (REZID CONSTRAINT NK_DEBREG_REZID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_DEBDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (DEBDATE CONSTRAINT NK_DEBREG_DEBDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_SUMM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (SUMM CONSTRAINT NK_DEBREG_SUMM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_CRDDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (CRDDATE CONSTRAINT NK_DEBREG_CRDDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_CRDAGRNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (CRDAGRNUM CONSTRAINT NK_DEBREG_CRDAGRNUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (KV CONSTRAINT NK_DEBREG_KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_PRINSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (PRINSIDER CONSTRAINT NK_DEBREG_PRINSIDER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (CUSTTYPE CONSTRAINT NK_DEBREG_CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_ADR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (ADR CONSTRAINT NK_DEBREG_ADR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_NMK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG MODIFY (NMK CONSTRAINT NK_DEBREG_NMK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DEBREG_DEBNUM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DEBREG_DEBNUM ON BARS.DEBREG (DEBNUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEBREG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG          to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG.sql =========*** End *** ======
PROMPT ===================================================================================== 
