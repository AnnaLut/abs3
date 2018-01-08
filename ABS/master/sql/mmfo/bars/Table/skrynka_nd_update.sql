

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND_UPDATE 
   (	ND NUMBER, 
	N_SK NUMBER, 
	SOS NUMBER, 
	FIO VARCHAR2(70), 
	DOKUM VARCHAR2(100), 
	ISSUED VARCHAR2(100), 
	ADRES VARCHAR2(100), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	TEL VARCHAR2(30), 
	DOVER VARCHAR2(100), 
	NMK VARCHAR2(70), 
	DOV_DAT1 DATE, 
	DOV_DAT2 DATE, 
	DOV_PASP VARCHAR2(100), 
	MFOK VARCHAR2(12), 
	NLSK VARCHAR2(15), 
	CUSTTYPE NUMBER, 
	O_SK NUMBER, 
	ISP_DOV NUMBER, 
	NDOV VARCHAR2(30), 
	NLS VARCHAR2(15), 
	NDOC VARCHAR2(30), 
	DOCDATE DATE, 
	SDOC NUMBER, 
	TARIFF NUMBER, 
	FIO2 VARCHAR2(70), 
	ISSUED2 VARCHAR2(100), 
	ADRES2 VARCHAR2(100), 
	PASP2 VARCHAR2(100), 
	OKPO1 VARCHAR2(10), 
	OKPO2 VARCHAR2(10), 
	S_ARENDA NUMBER, 
	S_NDS NUMBER, 
	SD NUMBER, 
	KEYCOUNT NUMBER, 
	PRSKIDKA NUMBER, 
	PENY NUMBER, 
	DATR2 DATE, 
	MR2 VARCHAR2(100), 
	MR VARCHAR2(100), 
	DATR DATE, 
	ADDND NUMBER, 
	AMORT_DATE DATE, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6), 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ADD COLUMN EFFECTDATE to SKRYNKA_ND_UPDATE ***
begin
    dbms_output.put_line('... ADD COLUMN EFFECTDATE');
    EXECUTE IMMEDIATE 'ALTER TABLE BARS.SKRYNKA_ND_UPDATE ADD (EFFECTDATE DATE)';
EXCEPTION WHEN OTHERS
   THEN
      IF SQLCODE = -01430
          THEN dbms_output.put_line('column EFFECTDATE already exists in table SKRYNKA_ND_UPDATE');
      ELSE RAISE;
      END IF;
end;
/

PROMPT *** ADD COLUMN GLOBAL_BDATE to SKRYNKA_ND_UPDATE ***
begin
    dbms_output.put_line('... ADD COLUMN GLOBAL_BDATE');
    EXECUTE IMMEDIATE 'ALTER TABLE BARS.SKRYNKA_ND_UPDATE ADD (GLOBAL_BDATE DATE)';
EXCEPTION WHEN OTHERS
   THEN
      IF SQLCODE = -01430
          THEN dbms_output.put_line('column GLOBAL_BDATE already exists in table SKRYNKA_ND_UPDATE');
      ELSE RAISE;
      END IF;
end;
/

prompt -- ======================================================
prompt -- ... FILL COLUMNs EFFECTDATE, GLOBAL_BDATE
prompt -- !!! Warning - the procedure can be performed for a long time !!! 
prompt -- ======================================================
DECLARE
    portion_size NUMBER := 500000; i NUMBER := 0; 
begin
    LOOP
        i:= i+1;
        dbms_output.put_line(TO_CHAR(sysdate,'HH24:MI:SS')||' - Iteration '||TO_CHAR(i)); 
        --LOCK TABLE SKRYNKA_ND IN EXCLUSIVE MODE;
        LOCK TABLE SKRYNKA_ND_UPDATE IN EXCLUSIVE MODE;

        update /*+ PARALLEL(BARS.SKRYNKA_ND_UPDATE) */ BARS.SKRYNKA_ND_UPDATE
            set EFFECTDATE =  COALESCE(TRUNC(chgdate),TRUNC(sysdate)),
                GLOBAL_BDATE =  COALESCE(TRUNC(chgdate),TRUNC(sysdate))
            where GLOBAL_BDATE is Null AND ROWNUM <= portion_size;

        dbms_output.put_line( TO_CHAR(sysdate,'HH24:MI:SS')||' - '||to_char(sql%rowcount) || ' rows updated.');
        IF sql%rowcount < portion_size THEN
            EXIT;
        ELSE 
            COMMIT;
        END IF;    
    END LOOP;
    
    COMMIT;
end;
/

PROMPT *** ALTER_POLICIES to SKRYNKA_ND_UPDATE ***
 exec bpa.alter_policies('SKRYNKA_ND_UPDATE');


COMMENT ON TABLE BARS.SKRYNKA_ND_UPDATE IS 'історія змін договора аренды сейфов';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.RNK IS 'RNK';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ND IS 'номер договора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.N_SK IS 'номер сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.SOS IS 'статус договора 15 - закрыт, 1 - пролонгация, 0 - открыт';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.FIO IS 'ФИО';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOKUM IS 'документ (паспорт...)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ISSUED IS 'кем выдан';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ADRES IS 'адрес';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DAT_BEGIN IS 'дата начала договора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DAT_END IS 'дата конца договора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.TEL IS 'телефон';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOVER IS 'доверенность';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NMK IS 'наименование клиента (юрлицо)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOV_DAT1 IS 'дата начала действия доверенности';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOV_DAT2 IS 'дата конца действия доверенности';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOV_PASP IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.MFOK IS 'МФО клиента';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NLSK IS 'расчетный счет клиента';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.CUSTTYPE IS 'тип клиента';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.O_SK IS 'тип сейфа (размер)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ISP_DOV IS 'код исполнителя - доверенного лица банка';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NDOV IS 'номер доверености';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NLS IS 'счет сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NDOC IS 'номер договра (символьный для печати)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOCDATE IS 'дата договра';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.SDOC IS 'сумма договора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.TARIFF IS 'код тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.FIO2 IS 'ФИО дов лица клиента';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ISSUED2 IS 'кем выдан паспорт дов лица';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ADRES2 IS 'адрес доверенного лица';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.PASP2 IS 'серия и номер паспорта доверенного лица';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.OKPO1 IS 'окпо клиента (или идент код)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.OKPO2 IS 'окпо доверенного лица (или идент код)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.S_ARENDA IS 'сумма аренды';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.S_NDS IS 'сумма НДС';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.SD IS 'дневной тариф для расчета аренды частями';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.KEYCOUNT IS 'количество выданых клиенту ключей';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.PRSKIDKA IS 'процент скидки';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.PENY IS 'процент штрафа (+ к дневному тарифу)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DATR2 IS 'дата рождения доверенного лица';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.MR2 IS 'место рождения доверенного лица';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.MR IS 'место рождения арендатора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DATR IS 'дата рождения арендатора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ADDND IS 'текущий номер доп соглашения';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.AMORT_DATE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.IDUPD IS 'Id';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.EFFECTDATE IS 'Банківська дата внесення зміни';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата';

PROMPT *** Create  constraint CC_SKRYNKAND_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_SKRYNKAND_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_SKRYNKAND_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_SKRYNKAND_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_SKRYNKANDUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKANDUPD ON BARS.SKRYNKA_ND_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_SKRYNKANDUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_UPDATE ADD CONSTRAINT PK_SKRYNKANDUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_SKRYNKANDUPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SKRYNKANDUPDATE ON BARS.SKRYNKA_ND_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index XIE_SKRYNKANDUPD_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_SKRYNKANDUPD_CHGDATE ON BARS.SKRYNKA_ND_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index XIE_SKRYNKANDUPD_GLBDT_EFFDT ***
begin   
 execute immediate 'CREATE INDEX BARS.XIE_SKRYNKANDUPD_GLBDT_EFFDT ON BARS.SKRYNKA_ND_UPDATE (GLOBAL_BDATE, EFFECTDATE) TABLESPACE BRSDYND';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  SKRYNKA_ND_UPDATE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_UPDATE to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_UPDATE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
