

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RESTR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RESTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RESTR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_RESTR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_RESTR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RESTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RESTR 
   (	ND NUMBER, 
	FDAT DATE, 
	VID_RESTR NUMBER, 
	TXT VARCHAR2(250), 
	SUMR NUMBER DEFAULT 0, 
	FDAT_END DATE, 
	PR_NO NUMBER DEFAULT 1, 
	RESTR_ID NUMBER(38,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(70), 
	S_RESTR VARCHAR2(250), 
	N_DODATOK VARCHAR2(50), 
	CUSTTYPE NUMBER(1,0), 
	QTY_PAY NUMBER, 
	DEL_PV NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RESTR ***
 exec bpa.alter_policies('CCK_RESTR');


COMMENT ON TABLE BARS.CCK_RESTR IS 'Даты и виды реструктуризации для КД из КП';
COMMENT ON COLUMN BARS.CCK_RESTR.ND IS 'Референс КД';
COMMENT ON COLUMN BARS.CCK_RESTR.FDAT IS 'Дата реструктуризации';
COMMENT ON COLUMN BARS.CCK_RESTR.VID_RESTR IS 'Вид реструктуризации';
COMMENT ON COLUMN BARS.CCK_RESTR.TXT IS 'Коментар';
COMMENT ON COLUMN BARS.CCK_RESTR.SUMR IS 'Сума реструктуризованої заборгованості';
COMMENT ON COLUMN BARS.CCK_RESTR.FDAT_END IS 'Дата закінчення реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR.PR_NO IS 'Ознака включення в файл #F8 (0 - не включати, 1 - включати)';
COMMENT ON COLUMN BARS.CCK_RESTR.RESTR_ID IS '';
COMMENT ON COLUMN BARS.CCK_RESTR.CC_ID IS 'Номер кред. договору';
COMMENT ON COLUMN BARS.CCK_RESTR.SDATE IS 'Дата початку кред. договору';
COMMENT ON COLUMN BARS.CCK_RESTR.WDATE IS 'Дата початку кред. договору';
COMMENT ON COLUMN BARS.CCK_RESTR.RNK IS 'РНК позичальника';
COMMENT ON COLUMN BARS.CCK_RESTR.NMK IS 'Назва позичальника';
COMMENT ON COLUMN BARS.CCK_RESTR.S_RESTR IS 'Суть реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR.N_DODATOK IS 'Номер додаткової угоди';
COMMENT ON COLUMN BARS.CCK_RESTR.CUSTTYPE IS 'Признак клиента 2-Юр.л.3-Физ.л.';
COMMENT ON COLUMN BARS.CCK_RESTR.QTY_PAY IS 'Кількість платежів після реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR.DEL_PV IS 'Разница Delta_PV = PV_ПОСЛЕ - PV_ДО Реструктуризации на дату реструктуризации';
COMMENT ON COLUMN BARS.CCK_RESTR.KF IS '';




PROMPT *** Create  constraint CCK_RESTR_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR ADD CONSTRAINT CCK_RESTR_PK PRIMARY KEY (RESTR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCKRESTR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR ADD CONSTRAINT FK_CCKRESTR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR MODIFY (KF CONSTRAINT CC_CCKRESTR_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_RESTR_RESTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR MODIFY (RESTR_ID CONSTRAINT CCK_RESTR_RESTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCK_RESTR_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CCK_RESTR_PK ON BARS.CCK_RESTR (RESTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCK_RESTR_I ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CCK_RESTR_I ON BARS.CCK_RESTR (ND, VID_RESTR, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RESTR ***
grant SELECT                                                                 on CCK_RESTR       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RESTR       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR       to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RESTR.sql =========*** End *** ===
PROMPT ===================================================================================== 
