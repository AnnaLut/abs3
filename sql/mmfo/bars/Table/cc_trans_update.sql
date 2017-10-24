

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TRANS_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TRANS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TRANS_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_TRANS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_TRANS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TRANS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TRANS_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	NPP NUMBER(*,0), 
	REF NUMBER(*,0), 
	ACC NUMBER(*,0), 
	FDAT DATE, 
	SV NUMBER, 
	SZ NUMBER, 
	D_PLAN DATE, 
	D_FAKT DATE, 
	DAPP DATE, 
	REFP NUMBER(*,0), 
	COMM VARCHAR2(100), 
	ID0 NUMBER, 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TRANS_UPDATE ***
 exec bpa.alter_policies('CC_TRANS_UPDATE');


COMMENT ON TABLE BARS.CC_TRANS_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.NPP IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.REF IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.SV IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.SZ IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.D_PLAN IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.D_FAKT IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.DAPP IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.REFP IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.COMM IS '';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.ID0 IS 'Iд.Поч.Траншу(Ід.)';
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_CCTRANS_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_UPDATE ADD CONSTRAINT PK_CCTRANS_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCTRANSUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_UPDATE MODIFY (KF CONSTRAINT CC_CCTRANSUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCTRANSUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_UPDATE ADD CONSTRAINT FK_CCTRANSUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCTRANS_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCTRANS_UPDATEEFFDAT ON BARS.CC_TRANS_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCTRANS_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCTRANS_UPDATEPK ON BARS.CC_TRANS_UPDATE (NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCTRANS_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCTRANS_ACC ON BARS.CC_TRANS_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTRANS_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTRANS_UPDATE ON BARS.CC_TRANS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TRANS_UPDATE ***
grant SELECT                                                                 on CC_TRANS_UPDATE to BARSUPL;
grant SELECT                                                                 on CC_TRANS_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TRANS_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
