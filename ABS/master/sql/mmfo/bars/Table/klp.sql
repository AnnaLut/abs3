

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP 
   (	DOP NUMBER(*,0), 
	EOM NUMBER(*,0), 
	NAEX VARCHAR2(12), 
	VOB NUMBER(*,0), 
	ND VARCHAR2(10), 
	DATAD DATE DEFAULT SYSDATE, 
	NLS VARCHAR2(14), 
	MFO VARCHAR2(12), 
	NAIMP VARCHAR2(38), 
	NLSP VARCHAR2(14), 
	S NUMBER, 
	TEXT1 VARCHAR2(160), 
	ISP NUMBER(*,0), 
	KOKB VARCHAR2(14), 
	KOKA VARCHAR2(14), 
	KOKO VARCHAR2(14), 
	PRWO VARCHAR2(60), 
	PDP1 RAW(196), 
	FL NUMBER(*,0), 
	POND VARCHAR2(9), 
	ROWIDD VARCHAR2(10), 
	KV NUMBER(*,0), 
	REF NUMBER(*,0), 
	DAVAL DATE, 
	CL_TYPE NUMBER, 
	MFOA VARCHAR2(12), 
	DK NUMBER(1,0), 
	NAIMO VARCHAR2(38), 
	OPERID CHAR(6), 
	DREC VARCHAR2(60), 
	CODN VARCHAR2(3), 
	FILLT VARCHAR2(2), 
	RESERVE VARCHAR2(8), 
	DATEDOKKB DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NOAUTO VARCHAR2(1), 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP ***
 exec bpa.alter_policies('KLP');


COMMENT ON TABLE BARS.KLP IS '';
COMMENT ON COLUMN BARS.KLP.DOP IS '';
COMMENT ON COLUMN BARS.KLP.EOM IS '';
COMMENT ON COLUMN BARS.KLP.NAEX IS '';
COMMENT ON COLUMN BARS.KLP.VOB IS '';
COMMENT ON COLUMN BARS.KLP.ND IS '';
COMMENT ON COLUMN BARS.KLP.DATAD IS '';
COMMENT ON COLUMN BARS.KLP.NLS IS '';
COMMENT ON COLUMN BARS.KLP.MFO IS '';
COMMENT ON COLUMN BARS.KLP.NAIMP IS '';
COMMENT ON COLUMN BARS.KLP.NLSP IS '';
COMMENT ON COLUMN BARS.KLP.S IS '';
COMMENT ON COLUMN BARS.KLP.TEXT1 IS '';
COMMENT ON COLUMN BARS.KLP.ISP IS '';
COMMENT ON COLUMN BARS.KLP.KOKB IS '';
COMMENT ON COLUMN BARS.KLP.KOKA IS '';
COMMENT ON COLUMN BARS.KLP.KOKO IS '';
COMMENT ON COLUMN BARS.KLP.PRWO IS '';
COMMENT ON COLUMN BARS.KLP.PDP1 IS '';
COMMENT ON COLUMN BARS.KLP.FL IS '';
COMMENT ON COLUMN BARS.KLP.POND IS '';
COMMENT ON COLUMN BARS.KLP.ROWIDD IS '';
COMMENT ON COLUMN BARS.KLP.KV IS '';
COMMENT ON COLUMN BARS.KLP.REF IS '';
COMMENT ON COLUMN BARS.KLP.DAVAL IS '';
COMMENT ON COLUMN BARS.KLP.CL_TYPE IS '';
COMMENT ON COLUMN BARS.KLP.MFOA IS 'МФО                     банка А';
COMMENT ON COLUMN BARS.KLP.DK IS 'Флаг "дебет/кредит"     платежа';
COMMENT ON COLUMN BARS.KLP.NAIMO IS 'Наименование плательщика (клиента А)';
COMMENT ON COLUMN BARS.KLP.OPERID IS 'Идентификатор операциониста банка А';
COMMENT ON COLUMN BARS.KLP.DREC IS 'Вспомогательные реквизиты';
COMMENT ON COLUMN BARS.KLP.CODN IS 'Код назначения платежа';
COMMENT ON COLUMN BARS.KLP.FILLT IS 'Способ заполнения реквизитов 14-16';
COMMENT ON COLUMN BARS.KLP.RESERVE IS 'Резерв';
COMMENT ON COLUMN BARS.KLP.DATEDOKKB IS 'дата приема документа от КЛИЕНТ-БАНКА';
COMMENT ON COLUMN BARS.KLP.KF IS '';
COMMENT ON COLUMN BARS.KLP.NOAUTO IS '';
COMMENT ON COLUMN BARS.KLP.ID IS '';




PROMPT *** Create  constraint KLP_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT KLP_PK PRIMARY KEY (KF, NAEX, POND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_S_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP ADD CONSTRAINT CC_KLP_S_CC CHECK (s>0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (ID CONSTRAINT CC_KLP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_EOM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (EOM CONSTRAINT CC_KLP_EOM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_VOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (VOB CONSTRAINT CC_KLP_VOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (ND CONSTRAINT CC_KLP_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_DATAD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (DATAD CONSTRAINT CC_KLP_DATAD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (NLS CONSTRAINT CC_KLP_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (MFO CONSTRAINT CC_KLP_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_NAIMP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (NAIMP CONSTRAINT CC_KLP_NAIMP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_NLSP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (NLSP CONSTRAINT CC_KLP_NLSP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (S CONSTRAINT CC_KLP_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_TEXT1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (TEXT1 CONSTRAINT CC_KLP_TEXT1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (ISP CONSTRAINT CC_KLP_ISP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_KOKB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (KOKB CONSTRAINT CC_KLP_KOKB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_KOKA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (KOKA CONSTRAINT CC_KLP_KOKA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (KV CONSTRAINT CC_KLP_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP MODIFY (KF CONSTRAINT CC_KLP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_DATAD_KLP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_DATAD_KLP ON BARS.KLP (DATAD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_KLP_KFREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_KLP_KFREF ON BARS.KLP (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_KLP_DOP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_KLP_DOP ON BARS.KLP (DOP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_FL_KLP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_FL_KLP ON BARS.KLP (FL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_EOM_KLP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_EOM_KLP ON BARS.KLP (EOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_PK ON BARS.KLP (KF, NAEX, POND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KLP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KLP ON BARS.KLP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_DATEDOKKB_FL_KLP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_DATEDOKKB_FL_KLP ON BARS.KLP (DATEDOKKB, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP ***
grant SELECT,UPDATE                                                          on KLP             to BARS014;
grant SELECT                                                                 on KLP             to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on KLP             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP             to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on KLP             to OPERKKK;
grant SELECT,UPDATE                                                          on KLP             to START1;
grant INSERT,UPDATE                                                          on KLP             to TECH_MOM1;
grant SELECT                                                                 on KLP             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP             to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLP ***

  CREATE OR REPLACE PUBLIC SYNONYM KLP FOR BARS.KLP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP.sql =========*** End *** =========
PROMPT ===================================================================================== 
