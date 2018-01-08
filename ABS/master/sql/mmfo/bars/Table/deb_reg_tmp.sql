

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_REG_TMP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_REG_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_REG_TMP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEB_REG_TMP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEB_REG_TMP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_REG_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_REG_TMP 
   (	EVENTTYPE NUMBER(38,0), 
	ACC NUMBER(38,0), 
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
	NLS VARCHAR2(15), 
	CCOLOR NUMBER(*,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_REG_TMP ***
 exec bpa.alter_policies('DEB_REG_TMP');


COMMENT ON TABLE BARS.DEB_REG_TMP IS 'Временная таблица для работы с задолженностью';
COMMENT ON COLUMN BARS.DEB_REG_TMP.EVENTTYPE IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.ACC IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.OKPO IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.NMK IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.ADR IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.PRINSIDER IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.KV IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.CRDAGRNUM IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.CRDDATE IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.SUM IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.DEBDATE IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.DAY IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.REZID IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.SUMD IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.OSN IS 'Данi про керiвникiв та засновникiв';
COMMENT ON COLUMN BARS.DEB_REG_TMP.EVENTDATE IS '';
COMMENT ON COLUMN BARS.DEB_REG_TMP.NLS IS 'Номер лицевого счета задолженности(если есть)';
COMMENT ON COLUMN BARS.DEB_REG_TMP.CCOLOR IS 'Колiр: 0-чорний,1-червоний,2-зелений,3-сiрий';
COMMENT ON COLUMN BARS.DEB_REG_TMP.KF IS '';




PROMPT *** Create  constraint CC_DEBREGTMP_CCOLOR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_TMP MODIFY (CCOLOR CONSTRAINT CC_DEBREGTMP_CCOLOR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBREGTMP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_TMP MODIFY (KF CONSTRAINT CC_DEBREGTMP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_REG_TMP ***
grant SELECT                                                                 on DEB_REG_TMP     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_TMP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEB_REG_TMP     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_TMP     to DEB_REG;
grant SELECT                                                                 on DEB_REG_TMP     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_REG_TMP.sql =========*** End *** =
PROMPT ===================================================================================== 
