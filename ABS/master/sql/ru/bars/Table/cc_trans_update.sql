

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TRANS_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TRANS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TRANS_UPDATE'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CC_TRANS_UPDATE'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
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
	ID0 NUMBER
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
COMMENT ON COLUMN BARS.CC_TRANS_UPDATE.ID0 IS 'Iд.Поч.Траншу(Ід.)';
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



PROMPT *** Create  grants  CC_TRANS_UPDATE ***
grant SELECT                                                                 on CC_TRANS_UPDATE to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on CC_TRANS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TRANS_UPDATE to BARS_SUP;
grant INSERT,SELECT,UPDATE                                                   on CC_TRANS_UPDATE to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TRANS_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
