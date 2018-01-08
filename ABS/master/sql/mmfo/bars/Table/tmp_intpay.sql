

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INTPAY.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INTPAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_INTPAY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TMP_INTPAY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_INTPAY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INTPAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INTPAY 
   (	ID NUMBER(38,0), 
	ACC NUMBER(38,0), 
	TT CHAR(3), 
	VOB NUMBER(38,0), 
	NAZN VARCHAR2(160), 
	S NUMBER(38,0), 
	DPT_ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	APL_DAT DATE, 
	DAT_END DATE, 
	ACCA NUMBER(38,0), 
	NLSA VARCHAR2(15), 
	KVA NUMBER(3,0), 
	NMSA VARCHAR2(38), 
	OKPOA VARCHAR2(14), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	KVB NUMBER(3,0), 
	NMSB VARCHAR2(38), 
	OKPOB VARCHAR2(14), 
	ND VARCHAR2(35), 
	DK NUMBER(1,0), 
	MFOA VARCHAR2(12), 
	S2 NUMBER(38,0), 
	DIG NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INTPAY ***
 exec bpa.alter_policies('TMP_INTPAY');


COMMENT ON TABLE BARS.TMP_INTPAY IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_INTPAY.ID IS 'ID';
COMMENT ON COLUMN BARS.TMP_INTPAY.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INTPAY.TT IS 'Тип операции';
COMMENT ON COLUMN BARS.TMP_INTPAY.VOB IS 'Вид обработки';
COMMENT ON COLUMN BARS.TMP_INTPAY.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARS.TMP_INTPAY.S IS 'Сумма операции';
COMMENT ON COLUMN BARS.TMP_INTPAY.DPT_ID IS '';
COMMENT ON COLUMN BARS.TMP_INTPAY.VIDD IS 'Вид';
COMMENT ON COLUMN BARS.TMP_INTPAY.APL_DAT IS '';
COMMENT ON COLUMN BARS.TMP_INTPAY.DAT_END IS '';
COMMENT ON COLUMN BARS.TMP_INTPAY.ACCA IS '';
COMMENT ON COLUMN BARS.TMP_INTPAY.NLSA IS 'Счет отправителя';
COMMENT ON COLUMN BARS.TMP_INTPAY.KVA IS 'Валюта А (отправителя)';
COMMENT ON COLUMN BARS.TMP_INTPAY.NMSA IS 'Название счета отправителя';
COMMENT ON COLUMN BARS.TMP_INTPAY.OKPOA IS 'ОКПО отправителя';
COMMENT ON COLUMN BARS.TMP_INTPAY.MFOB IS 'МФО получателя';
COMMENT ON COLUMN BARS.TMP_INTPAY.NLSB IS 'Счет получателя';
COMMENT ON COLUMN BARS.TMP_INTPAY.KVB IS 'Валюта В (получателя)';
COMMENT ON COLUMN BARS.TMP_INTPAY.NMSB IS 'Название счета получателя';
COMMENT ON COLUMN BARS.TMP_INTPAY.OKPOB IS 'ОКПО получателя';
COMMENT ON COLUMN BARS.TMP_INTPAY.ND IS '';
COMMENT ON COLUMN BARS.TMP_INTPAY.DK IS 'Дебет/Кредит';
COMMENT ON COLUMN BARS.TMP_INTPAY.MFOA IS 'МФО-А';
COMMENT ON COLUMN BARS.TMP_INTPAY.S2 IS 'Сумма в валюте 2';
COMMENT ON COLUMN BARS.TMP_INTPAY.DIG IS 'Разрядность валюты';
COMMENT ON COLUMN BARS.TMP_INTPAY.KF IS '';




PROMPT *** Create  constraint PK_TMPINTPAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT PK_TMPINTPAY PRIMARY KEY (ID, DPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_ACCOUNTS3 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (KF CONSTRAINT CC_TMPINTPAY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_DIG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (DIG CONSTRAINT CC_TMPINTPAY_DIG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_S2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (S2 CONSTRAINT CC_TMPINTPAY_S2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (MFOA CONSTRAINT CC_TMPINTPAY_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (DK CONSTRAINT CC_TMPINTPAY_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (ND CONSTRAINT CC_TMPINTPAY_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_OKPOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (OKPOB CONSTRAINT CC_TMPINTPAY_OKPOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_NMSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (NMSB CONSTRAINT CC_TMPINTPAY_NMSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_KVB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (KVB CONSTRAINT CC_TMPINTPAY_KVB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (NLSB CONSTRAINT CC_TMPINTPAY_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (MFOB CONSTRAINT CC_TMPINTPAY_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_OKPOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (OKPOA CONSTRAINT CC_TMPINTPAY_OKPOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_NMSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (NMSA CONSTRAINT CC_TMPINTPAY_NMSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_KVA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (KVA CONSTRAINT CC_TMPINTPAY_KVA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (NLSA CONSTRAINT CC_TMPINTPAY_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (DPT_ID CONSTRAINT CC_TMPINTPAY_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (S CONSTRAINT CC_TMPINTPAY_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (NAZN CONSTRAINT CC_TMPINTPAY_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_VOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (VOB CONSTRAINT CC_TMPINTPAY_VOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (TT CONSTRAINT CC_TMPINTPAY_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (ACC CONSTRAINT CC_TMPINTPAY_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_ACCOUNTS4 FOREIGN KEY (KF, ACCA)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_TABVAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_TABVAL2 FOREIGN KEY (KVB)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_TABVAL FOREIGN KEY (KVA)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_DPTDEPOSIT2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_DPTDEPOSIT2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTPAY_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY MODIFY (ID CONSTRAINT CC_TMPINTPAY_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPINTPAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPINTPAY ON BARS.TMP_INTPAY (ID, DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INTPAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTPAY      to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_INTPAY      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INTPAY      to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_INTPAY      to DPT;
grant SELECT                                                                 on TMP_INTPAY      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_INTPAY      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INTPAY.sql =========*** End *** ==
PROMPT ===================================================================================== 
