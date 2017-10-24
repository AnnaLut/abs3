

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INTARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INTARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_INTARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TMP_INTARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_INTARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INTARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INTARC 
   (	ID NUMBER(1,0), 
	ACC NUMBER(38,0), 
	NBS CHAR(4), 
	LCV CHAR(3), 
	NLS VARCHAR2(15), 
	FDAT DATE, 
	TDAT DATE, 
	IR NUMBER(20,4), 
	BR NUMBER, 
	OSTS NUMBER(24,0), 
	ACRD NUMBER(24,0), 
	NMS VARCHAR2(70), 
	OSTC NUMBER(24,0), 
	KV NUMBER(3,0), 
	USERID NUMBER(38,0), 
	BDAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INTARC ***
 exec bpa.alter_policies('TMP_INTARC');


COMMENT ON TABLE BARS.TMP_INTARC IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_INTARC.ID IS 'ID';
COMMENT ON COLUMN BARS.TMP_INTARC.ACC IS 'Внутр. номер деп. счета';
COMMENT ON COLUMN BARS.TMP_INTARC.NBS IS 'Номер балансового счета';
COMMENT ON COLUMN BARS.TMP_INTARC.LCV IS 'Обозначение валюты';
COMMENT ON COLUMN BARS.TMP_INTARC.NLS IS 'Лицевой счет';
COMMENT ON COLUMN BARS.TMP_INTARC.FDAT IS 'Дата открытия деп. дог';
COMMENT ON COLUMN BARS.TMP_INTARC.TDAT IS 'Дата поступления средств на счет деп. дог';
COMMENT ON COLUMN BARS.TMP_INTARC.IR IS '';
COMMENT ON COLUMN BARS.TMP_INTARC.BR IS '';
COMMENT ON COLUMN BARS.TMP_INTARC.OSTS IS 'Остаток на счете';
COMMENT ON COLUMN BARS.TMP_INTARC.ACRD IS 'Вспомог. поле';
COMMENT ON COLUMN BARS.TMP_INTARC.NMS IS 'Название счета';
COMMENT ON COLUMN BARS.TMP_INTARC.OSTC IS 'Остаток';
COMMENT ON COLUMN BARS.TMP_INTARC.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TMP_INTARC.USERID IS 'ID пользователя';
COMMENT ON COLUMN BARS.TMP_INTARC.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_INTARC.KF IS '';




PROMPT *** Create  constraint PK_TMPINTARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT PK_TMPINTARC PRIMARY KEY (ID, ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_TABVAL FOREIGN KEY (LCV)
	  REFERENCES BARS.TABVAL$GLOBAL (LCV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_TABVAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_TABVAL2 FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC MODIFY (KF CONSTRAINT CC_TMPINTARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTARC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC MODIFY (ACC CONSTRAINT CC_TMPINTARC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTARC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC MODIFY (ID CONSTRAINT CC_TMPINTARC_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPINTARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPINTARC ON BARS.TMP_INTARC (ID, ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INTARC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTARC      to BARS010;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTARC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INTARC      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTARC      to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTARC      to RCC_DEAL;
grant SELECT                                                                 on TMP_INTARC      to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTARC      to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_INTARC      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_INTARC ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_INTARC FOR BARS.TMP_INTARC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INTARC.sql =========*** End *** ==
PROMPT ===================================================================================== 
