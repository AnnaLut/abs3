PROMPT *** ALTER_POLICY_INFO to XML_IMPDOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_IMPDOCS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_IMPDOCS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_IMPDOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_IMPDOCS 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SEQ NUMBER, 
	IMPREF NUMBER, 
	MFOA VARCHAR2(6), 
	NLSA VARCHAR2(14), 
	ID_A VARCHAR2(19), 
	NAM_A VARCHAR2(38), 
	MFOB VARCHAR2(6), 
	NLSB VARCHAR2(14), 
	ID_B VARCHAR2(19), 
	NAM_B VARCHAR2(38), 
	S NUMBER, 
	S2 NUMBER, 
	KV NUMBER, 
	KV2 NUMBER, 
	DK NUMBER, 
	ND VARCHAR2(10), 
	TT CHAR(3), 
	SK NUMBER, 
	NAZN VARCHAR2(160), 
	DATD DATE, 
	DATP DATE, 
	VDAT DATE, 
	VOB NUMBER, 
	BIS NUMBER(*,0), 
	D_REC VARCHAR2(60), 
	REF NUMBER, 
	ERRCODE VARCHAR2(4), 
	ERRMSG VARCHAR2(1000), 
	STATUS NUMBER(*,0), 
	REF_A NUMBER, 
	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_IMPDOCS ***
 exec bpa.alter_policies('XML_IMPDOCS');


COMMENT ON TABLE BARS.XML_IMPDOCS IS 'Импортированные документы';
COMMENT ON COLUMN BARS.XML_IMPDOCS.REF_A IS 'Унiкальний номер системи, що породила документ';
COMMENT ON COLUMN BARS.XML_IMPDOCS.USERID IS 'Код исполнителя';
COMMENT ON COLUMN BARS.XML_IMPDOCS.FN IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.DAT IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.KF IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.SEQ IS 'Последовательность в файле (не учитывая бисы)';
COMMENT ON COLUMN BARS.XML_IMPDOCS.IMPREF IS 'Уникальн. номер для импорта';
COMMENT ON COLUMN BARS.XML_IMPDOCS.MFOA IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.NLSA IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.ID_A IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.NAM_A IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.MFOB IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.NLSB IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.ID_B IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.NAM_B IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.S IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.S2 IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.KV IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.KV2 IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.DK IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.ND IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.TT IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.SK IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.NAZN IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.DATD IS 'Дата документа';
COMMENT ON COLUMN BARS.XML_IMPDOCS.DATP IS 'Дата поступления в банк(дата импорта)';
COMMENT ON COLUMN BARS.XML_IMPDOCS.VDAT IS 'Дата валютирования (может быть заказана в файле)';
COMMENT ON COLUMN BARS.XML_IMPDOCS.VOB IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.BIS IS 'Признак наличия bis строк';
COMMENT ON COLUMN BARS.XML_IMPDOCS.D_REC IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.REF IS 'Если док-т оплачен  - содержит реф из oper';
COMMENT ON COLUMN BARS.XML_IMPDOCS.ERRCODE IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.ERRMSG IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCS.STATUS IS '';




PROMPT *** Create  constraint XFK_XMLIMPDOCS_STAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCS ADD CONSTRAINT XFK_XMLIMPDOCS_STAT FOREIGN KEY (STATUS)
	  REFERENCES BARS.XML_IMPSTATUS (STATUS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_XMLIMPDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCS ADD CONSTRAINT XFK_XMLIMPDOCS FOREIGN KEY (KF, DAT, FN)
	  REFERENCES BARS.XML_IMPFILES (KF, DAT, FN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_XMLIMPDOCS_IMPREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCS ADD CONSTRAINT XPK_XMLIMPDOCS_IMPREF PRIMARY KEY (IMPREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPDOCS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCS MODIFY (KF CONSTRAINT CC_XMLIMPDOCS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_IMPDOCS ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_IMPDOCS ON BARS.XML_IMPDOCS (KF, DAT, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLIMPDOCS_IMPREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLIMPDOCS_IMPREF ON BARS.XML_IMPDOCS (IMPREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I_XMLIMPDOCS_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_XMLIMPDOCS_REF ON BARS.XML_IMPDOCS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  XML_IMPDOCS ***
grant SELECT                                                                 on XML_IMPDOCS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML_IMPDOCS     to OPER000;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_IMPDOCS     to WR_ALL_RIGHTS;