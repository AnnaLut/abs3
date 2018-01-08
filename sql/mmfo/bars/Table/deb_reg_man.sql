

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_REG_MAN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_REG_MAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_REG_MAN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEB_REG_MAN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEB_REG_MAN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_REG_MAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_REG_MAN 
   (	EVENTTYPE NUMBER(*,0), 
	ACC NUMBER(*,0), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	CUSTTYPE NUMBER, 
	PRINSIDER NUMBER, 
	KV NUMBER, 
	CRDAGRNUM VARCHAR2(16), 
	CRDDATE DATE, 
	SUM NUMBER, 
	DEBDATE DATE, 
	DAY NUMBER(38,0), 
	REZID NUMBER(1,0), 
	SUMD NUMBER, 
	OSN VARCHAR2(250), 
	EVENTDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_REG_MAN ***
 exec bpa.alter_policies('DEB_REG_MAN');


COMMENT ON TABLE BARS.DEB_REG_MAN IS 'Введенные вручную задолженности';
COMMENT ON COLUMN BARS.DEB_REG_MAN.EVENTTYPE IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.ACC IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.OKPO IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.NMK IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.ADR IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.PRINSIDER IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.KV IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.CRDAGRNUM IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.CRDDATE IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.SUM IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.DEBDATE IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.DAY IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.REZID IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.SUMD IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.OSN IS 'Данi про керiвникiв та засновникiв';
COMMENT ON COLUMN BARS.DEB_REG_MAN.EVENTDATE IS '';
COMMENT ON COLUMN BARS.DEB_REG_MAN.KF IS '';




PROMPT *** Create  constraint XPK_DEB_REG_MAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_MAN ADD CONSTRAINT XPK_DEB_REG_MAN PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBREGMAN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_MAN MODIFY (KF CONSTRAINT CC_DEBREGMAN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DEB_REG_MAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DEB_REG_MAN ON BARS.DEB_REG_MAN (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_REG_MAN ***
grant SELECT                                                                 on DEB_REG_MAN     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_MAN     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEB_REG_MAN     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_MAN     to DEB_REG;
grant SELECT                                                                 on DEB_REG_MAN     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_REG_MAN.sql =========*** End *** =
PROMPT ===================================================================================== 
