

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_TARIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_TARIF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_TARIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_TARIF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_TARIF 
   (	ACC NUMBER(38,0), 
	KOD NUMBER(38,0), 
	TAR NUMBER(24,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0), 
	OST_AVG NUMBER(24,0), 
	BDATE DATE, 
	EDATE DATE, 
	NDOK_RKO NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	KV_SMIN NUMBER(3,0), 
	KV_SMAX NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_TARIF ***
 exec bpa.alter_policies('ACC_TARIF');


COMMENT ON TABLE BARS.ACC_TARIF IS 'Тарифы и комиссии по счетам';
COMMENT ON COLUMN BARS.ACC_TARIF.EDATE IS 'Дата окончания действия тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF.NDOK_RKO IS 'Количество документов за прошлый месяц';
COMMENT ON COLUMN BARS.ACC_TARIF.KF IS '';
COMMENT ON COLUMN BARS.ACC_TARIF.KV_SMIN IS 'Валюта минимальной граничной суммы';
COMMENT ON COLUMN BARS.ACC_TARIF.KV_SMAX IS 'Валюта максиимальной граничной суммы';
COMMENT ON COLUMN BARS.ACC_TARIF.ACC IS 'Внутр. номер счета';
COMMENT ON COLUMN BARS.ACC_TARIF.KOD IS 'Код тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF.TAR IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.ACC_TARIF.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.ACC_TARIF.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF.SMAX IS 'максимальная сумма тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF.OST_AVG IS 'Среднекалендарный остаток за прошлый месяц';
COMMENT ON COLUMN BARS.ACC_TARIF.BDATE IS 'Дата начала действия тарифа';




PROMPT *** Create  constraint CC_ACCTARIF_BDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF ADD CONSTRAINT CC_ACCTARIF_BDATE CHECK (bdate = trunc(bdate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIF_EDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF ADD CONSTRAINT CC_ACCTARIF_EDATE CHECK (edate = trunc(edate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF MODIFY (KF CONSTRAINT CC_ACCTARIF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005297 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF MODIFY (PR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005296 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF MODIFY (TAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIF_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF MODIFY (KOD CONSTRAINT CC_ACCTARIF_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIF_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF MODIFY (ACC CONSTRAINT CC_ACCTARIF_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIF_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF ADD CONSTRAINT FK_ACCTARIF_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF ADD CONSTRAINT FK_ACCTARIF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCTARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF ADD CONSTRAINT PK_ACCTARIF PRIMARY KEY (KF, ACC, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCTARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCTARIF ON BARS.ACC_TARIF (KF, ACC, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_TARIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_TARIF       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_TARIF       to BARSAQ;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on ACC_TARIF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_TARIF       to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACC_TARIF       to CUST001;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACC_TARIF       to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_TARIF       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_TARIF       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ACC_TARIF       to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_TARIF       to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_TARIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
