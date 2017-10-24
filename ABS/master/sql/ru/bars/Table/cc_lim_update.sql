

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_LIM_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(10,0), 
	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	ACC NUMBER(*,0), 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0), 
	OTM NUMBER(*,0), 
	KF VARCHAR2(6), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_UPDATE ***
 exec bpa.alter_policies('CC_LIM_UPDATE');


COMMENT ON TABLE BARS.CC_LIM_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.LIM2 IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.NOT_9129 IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.SUMG IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.SUMO IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.OTM IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.SUMK IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.NOT_SN IS '';




PROMPT *** Create  constraint PK_CCLIM_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_UPDATE ADD CONSTRAINT PK_CCLIM_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955664 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_UPDATE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCLIM_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCLIM_UPDATE ON BARS.CC_LIM_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCLIM_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCLIM_UPDATEEFFDAT ON BARS.CC_LIM_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCLIM_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCLIM_UPDATEPK ON BARS.CC_LIM_UPDATE (ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM_UPDATE ***
grant SELECT                                                                 on CC_LIM_UPDATE   to BARSUPL;
grant SELECT                                                                 on CC_LIM_UPDATE   to BARS_SUP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
