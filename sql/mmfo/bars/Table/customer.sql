

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''CUSTOMER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER 
   (	RNK NUMBER(38,0), 
	TGR NUMBER(1,0), 
	CUSTTYPE NUMBER(1,0), 
	COUNTRY NUMBER(3,0), 
	NMK VARCHAR2(70), 
	NMKV VARCHAR2(70), 
	NMKK VARCHAR2(38), 
	CODCAGENT NUMBER(1,0), 
	PRINSIDER NUMBER(38,0), 
	OKPO VARCHAR2(14), 
	ADR VARCHAR2(70), 
	SAB VARCHAR2(6), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	RGTAX VARCHAR2(30), 
	DATET DATE DEFAULT TRUNC(SYSDATE), 
	ADM VARCHAR2(70), 
	DATEA DATE DEFAULT TRUNC(SYSDATE), 
	STMT NUMBER(5,0), 
	DATE_ON DATE DEFAULT TRUNC(SYSDATE), 
	DATE_OFF DATE, 
	NOTES VARCHAR2(140), 
	NOTESEC VARCHAR2(256), 
	CRISK NUMBER(38,0), 
	PINCODE VARCHAR2(10), 
	ND VARCHAR2(10), 
	RNKP NUMBER(38,0), 
	ISE CHAR(5), 
	FS CHAR(2), 
	OE CHAR(5), 
	VED CHAR(5), 
	SED CHAR(4), 
	LIM NUMBER(24,0), 
	MB CHAR(1), 
	RGADM VARCHAR2(30), 
	BC NUMBER(1,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	TOBO VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ISP NUMBER(38,0), 
	TAXF VARCHAR2(12), 
	NOMPDV VARCHAR2(9), 
	K050 CHAR(3), 
	NREZID_CODE VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER ***
 exec bpa.alter_policies('CUSTOMER');


COMMENT ON TABLE BARS.CUSTOMER IS 'Контрагенты';
COMMENT ON COLUMN BARS.CUSTOMER.LIM IS 'Лимит';
COMMENT ON COLUMN BARS.CUSTOMER.MB IS 'Принадлежность к малому бизнесу';
COMMENT ON COLUMN BARS.CUSTOMER.RGADM IS 'Рег.номер в Администрации';
COMMENT ON COLUMN BARS.CUSTOMER.BC IS 'Признак НЕклиента банка (1)';
COMMENT ON COLUMN BARS.CUSTOMER.BRANCH IS 'Код отделенния';
COMMENT ON COLUMN BARS.CUSTOMER.TOBO IS 'Код ТОБО';
COMMENT ON COLUMN BARS.CUSTOMER.ISP IS 'Менеджер клиента (ответ. исполнитель)';
COMMENT ON COLUMN BARS.CUSTOMER.TAXF IS '';
COMMENT ON COLUMN BARS.CUSTOMER.NOMPDV IS '';
COMMENT ON COLUMN BARS.CUSTOMER.K050 IS 'Показатель k050';
COMMENT ON COLUMN BARS.CUSTOMER.NREZID_CODE IS 'Код в стране регистрации (для нерезидентов)';
COMMENT ON COLUMN BARS.CUSTOMER.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.CUSTOMER.RNK IS 'Регистрационный номер';
COMMENT ON COLUMN BARS.CUSTOMER.TGR IS 'ТГР
(1=ЄДР.,2=ДРФ.,3=тимчас)';
COMMENT ON COLUMN BARS.CUSTOMER.CUSTTYPE IS 'Тип
 (1=БН,2=ЮЛ,3=ФЛ)';
COMMENT ON COLUMN BARS.CUSTOMER.COUNTRY IS 'Код страны';
COMMENT ON COLUMN BARS.CUSTOMER.NMK IS 'Полное Наименование контрагента';
COMMENT ON COLUMN BARS.CUSTOMER.NMKV IS 'Краткое Наименование контрагента';
COMMENT ON COLUMN BARS.CUSTOMER.NMKK IS 'Наименование';
COMMENT ON COLUMN BARS.CUSTOMER.CODCAGENT IS 'Характеристика';
COMMENT ON COLUMN BARS.CUSTOMER.PRINSIDER IS 'Код инсайдера';
COMMENT ON COLUMN BARS.CUSTOMER.OKPO IS 'Код ОКПО';
COMMENT ON COLUMN BARS.CUSTOMER.ADR IS 'Адрес';
COMMENT ON COLUMN BARS.CUSTOMER.SAB IS 'Эл.код';
COMMENT ON COLUMN BARS.CUSTOMER.C_REG IS 'Код обл.НИ';
COMMENT ON COLUMN BARS.CUSTOMER.C_DST IS 'Код район.НИ';
COMMENT ON COLUMN BARS.CUSTOMER.RGTAX IS '';
COMMENT ON COLUMN BARS.CUSTOMER.DATET IS '';
COMMENT ON COLUMN BARS.CUSTOMER.ADM IS 'Админ.орган';
COMMENT ON COLUMN BARS.CUSTOMER.DATEA IS '';
COMMENT ON COLUMN BARS.CUSTOMER.STMT IS 'Формат выписки';
COMMENT ON COLUMN BARS.CUSTOMER.DATE_ON IS 'Дата открытия';
COMMENT ON COLUMN BARS.CUSTOMER.DATE_OFF IS 'Дата закрытия';
COMMENT ON COLUMN BARS.CUSTOMER.NOTES IS 'Комментарий';
COMMENT ON COLUMN BARS.CUSTOMER.NOTESEC IS 'Комментарий службы безопастности';
COMMENT ON COLUMN BARS.CUSTOMER.CRISK IS 'Категория риска';
COMMENT ON COLUMN BARS.CUSTOMER.PINCODE IS '';
COMMENT ON COLUMN BARS.CUSTOMER.ND IS '№ дог';
COMMENT ON COLUMN BARS.CUSTOMER.RNKP IS '';
COMMENT ON COLUMN BARS.CUSTOMER.ISE IS 'Код сектора экономики';
COMMENT ON COLUMN BARS.CUSTOMER.FS IS 'Форма собственности';
COMMENT ON COLUMN BARS.CUSTOMER.OE IS 'Отрасли экономики';
COMMENT ON COLUMN BARS.CUSTOMER.VED IS 'Вид экономичческой деятельности';
COMMENT ON COLUMN BARS.CUSTOMER.SED IS 'Код отрасли экономики';




PROMPT *** Create  constraint FK_CUSTOMER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_ISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_ISE FOREIGN KEY (ISE)
	  REFERENCES BARS.ISE (ISE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER MODIFY (KF CONSTRAINT CC_CUSTOMER_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_TOBO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER MODIFY (TOBO CONSTRAINT CC_CUSTOMER_TOBO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER MODIFY (DATE_ON CONSTRAINT CC_CUSTOMER_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER MODIFY (RNK CONSTRAINT CC_CUSTOMER_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_BC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT CC_CUSTOMER_BC CHECK (bc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_DATEOFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT CC_CUSTOMER_DATEOFF CHECK (date_off = trunc(date_off)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_FS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_FS FOREIGN KEY (FS)
	  REFERENCES BARS.FS (FS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_PRINSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_PRINSIDER FOREIGN KEY (PRINSIDER)
	  REFERENCES BARS.PRINSIDER (PRINSIDER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_SPK050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_SPK050 FOREIGN KEY (K050)
	  REFERENCES BARS.SP_K050 (K050) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_CUSTOMER FOREIGN KEY (RNKP)
	  REFERENCES BARS.CUSTOMER (RNK) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_OE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_OE FOREIGN KEY (OE)
	  REFERENCES BARS.OE (OE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_STMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_STMT FOREIGN KEY (STMT)
	  REFERENCES BARS.STMT (STMT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_SPRREG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_SPRREG FOREIGN KEY (C_REG, C_DST)
	  REFERENCES BARS.SPR_REG (C_REG, C_DST) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_TGR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_TGR FOREIGN KEY (TGR)
	  REFERENCES BARS.TGR (TGR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_CODCAGENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_CODCAGENT FOREIGN KEY (CODCAGENT)
	  REFERENCES BARS.CODCAGENT (CODCAGENT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_SED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_SED FOREIGN KEY (SED)
	  REFERENCES BARS.SED (SED) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_BRANCH_TOBO_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT CC_CUSTOMER_BRANCH_TOBO_CC CHECK (branch=tobo) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_SAB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT CC_CUSTOMER_SAB CHECK (sab is null or sab = upper(sab) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I6_CUSTOMER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I6_CUSTOMER ON BARS.CUSTOMER (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_CUSTOMER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_CUSTOMER ON BARS.CUSTOMER (UPPER(NMK)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CUSTOMER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CUSTOMER ON BARS.CUSTOMER (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMER ON BARS.CUSTOMER (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CUSTOMER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CUSTOMER ON BARS.CUSTOMER (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_CUSTOMER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_CUSTOMER ON BARS.CUSTOMER (NMK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_CUSTOMER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_CUSTOMER ON BARS.CUSTOMER (RNKP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER        to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMER        to BARS009;
grant SELECT                                                                 on CUSTOMER        to BARS010;
grant FLASHBACK,REFERENCES,SELECT                                            on CUSTOMER        to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CUSTOMER        to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUSTOMER        to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CUSTOMER        to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUSTOMER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER        to BARS_DM;
grant SELECT                                                                 on CUSTOMER        to CC_DOC;
grant SELECT                                                                 on CUSTOMER        to CHCK;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER        to CUST001;
grant SELECT                                                                 on CUSTOMER        to DPT;
grant SELECT                                                                 on CUSTOMER        to DPT_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on CUSTOMER        to FINMON;
grant SELECT                                                                 on CUSTOMER        to FOREX;
grant SELECT                                                                 on CUSTOMER        to IBSADM_ROLE;
grant SELECT                                                                 on CUSTOMER        to KLB;
grant SELECT,SELECT                                                          on CUSTOMER        to KLBX;
grant SELECT                                                                 on CUSTOMER        to OBPC;
grant SELECT                                                                 on CUSTOMER        to OPERKKK;
grant SELECT                                                                 on CUSTOMER        to PYOD001;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUSTOMER        to RCC_DEAL;
grant SELECT                                                                 on CUSTOMER        to REFSYNC_USR;
grant SELECT                                                                 on CUSTOMER        to RPBN001;
grant SELECT                                                                 on CUSTOMER        to RPBN002;
grant SELECT,UPDATE                                                          on CUSTOMER        to SALGL;
grant SELECT                                                                 on CUSTOMER        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTOMER        to WR_CREDIT;
grant SELECT                                                                 on CUSTOMER        to WR_CREPORTS;
grant SELECT,UPDATE                                                          on CUSTOMER        to WR_CUSTLIST;
grant SELECT                                                                 on CUSTOMER        to WR_CUSTREG;
grant SELECT                                                                 on CUSTOMER        to WR_DEPOSIT_U;
grant SELECT                                                                 on CUSTOMER        to WR_DOCHAND;
grant SELECT                                                                 on CUSTOMER        to WR_DOC_INPUT;
grant SELECT                                                                 on CUSTOMER        to WR_ND_ACCOUNTS;
grant SELECT                                                                 on CUSTOMER        to WR_VIEWACC;



PROMPT *** Create SYNONYM  to CUSTOMER ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTOMER1 FOR BARS.CUSTOMER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER.sql =========*** End *** ====
PROMPT ===================================================================================== 
