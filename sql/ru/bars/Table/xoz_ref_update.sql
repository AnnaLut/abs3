PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Table/XOZ_REF_UPDATE.sql ======*** Run *** =====
PROMPT ===================================================================================== 
-- version 1.0 06/12/2017 V.Kharin
PROMPT *** ALTER_POLICY_INFO to XOZ_REF_UPDATE***
BEGIN
        execute immediate
          'begin  
               bpa.alter_policy_info(''XOZ_REF_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XOZ_REF_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end;';
END;
/

PROMPT *** Create  table XOZ_REF_UPDATE ***
begin    execute immediate
' CREATE TABLE BARS.XOZ_REF_UPDATE(
  IDUPD         NUMBER(38)           CONSTRAINT CC_XOZUPD_IDUPD_NN NOT NULL,
  CHGACTION     CHAR(1 BYTE)         CONSTRAINT CC_XOZUPD_CHG_NN   NOT NULL,
  EFFECTDATE    DATE                 CONSTRAINT CC_XOZUPD_EFF_NN   NOT NULL,
  GLOBAL_BD     DATE                 CONSTRAINT CC_XOZUPD_GLB_NN   NOT NULL,
  CHGDATE       DATE                 CONSTRAINT CC_XOZUPD_CHD_NN   NOT NULL,
  DONEBY        NUMBER,
  REF1          NUMBER               CONSTRAINT CC_XOZUPD_REF1_NN  NOT NULL,
  STMT1         NUMBER               CONSTRAINT CC_XOZUPD_STMT1_NN NOT NULL,
  REF2          NUMBER,
  ACC           NUMBER,
  MDATE         DATE,
  S             NUMBER,
  FDAT          DATE,
  S0            NUMBER,
  NOTP          INTEGER,
  PRG           INTEGER,
  BU            VARCHAR2(30 BYTE),
  DATZ          DATE,
  REFD          NUMBER,
  KF            VARCHAR2(6 BYTE)     CONSTRAINT CC_XOZUPD_KF_NN    NOT NULL,
  ID            NUMBER(38)           CONSTRAINT CC_XOZUPD_ID_NN    NOT NULL
) NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD
PARTITION BY LIST (KF)
( PARTITION P_01_300465 VALUES (''300465''),
  PARTITION P_02_324805 VALUES (''324805''),
  PARTITION P_03_302076 VALUES (''302076''),
  PARTITION P_04_303398 VALUES (''303398''),
  PARTITION P_05_305482 VALUES (''305482''),
  PARTITION P_06_335106 VALUES (''335106''),
  PARTITION P_07_311647 VALUES (''311647''),
  PARTITION P_08_312356 VALUES (''312356''),
  PARTITION P_09_313957 VALUES (''313957''),
  PARTITION P_10_336503 VALUES (''336503''),
  PARTITION P_11_322669 VALUES (''322669''),
  PARTITION P_12_323475 VALUES (''323475''),
  PARTITION P_13_304665 VALUES (''304665''),
  PARTITION P_14_325796 VALUES (''325796''),
  PARTITION P_15_326461 VALUES (''326461''),
  PARTITION P_16_328845 VALUES (''328845''),
  PARTITION P_17_331467 VALUES (''331467''),
  PARTITION P_18_333368 VALUES (''333368''),
  PARTITION P_19_337568 VALUES (''337568''),
  PARTITION P_20_338545 VALUES (''338545''),
  PARTITION P_21_351823 VALUES (''351823''),
  PARTITION P_22_352457 VALUES (''352457''),
  PARTITION P_23_315784 VALUES (''315784''),
  PARTITION P_24_354507 VALUES (''354507''),
  PARTITION P_25_356334 VALUES (''356334''),
  PARTITION P_26_353553 VALUES (''353553'')
)';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('XOZ_REF_UPDATE');

COMMENT ON TABLE  BARS.XOZ_REF_UPDATE            IS 'История изменений картотеки дебиторов хоз.деб';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.IDUPD      IS 'Идентификатор изменения';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.CHGACTION  IS 'Тип изменения';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.EFFECTDATE IS 'Банковская дата изменения';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.GLOBAL_BD  IS 'Глобальная банковская дата изменения';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.CHGDATE    IS 'Дата/время изменения';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.DONEBY     IS 'Пользователь, выполнивший изменение';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.REF1       IS 'Референс начального документа  ДЕБЕТ';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.STMT1      IS 'stmt начального документа  ДЕБЕТ';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.REF2       IS 'Референс передебетованного док КРЕДИТ';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.ACC        IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.MDATE      IS 'План-дата закриття';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.S          IS 'План-сума закриття';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.FDAT       IS 'Факт-дата откр.деб.';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.S0         IS 'Сума проплати (ДЕБЕТ)';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.NOTP       IS 'Признак "Нет.дог". 1 = В рез-23 НЕ учитывать просрочку по дате, как просрочку';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.PRG        IS 'Код проекту';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.BU         IS 'Код бюджетної одиниці';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.DATZ       IS 'Звітна дата зактиття деб.заб.';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.REFD       IS 'Референс деб.запиту до ЦА на закриття дебітора';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.KF         IS 'Код региона';
COMMENT ON COLUMN BARS.XOZ_REF_UPDATE.ID         IS 'Идентификатор';


PROMPT *** Create  constraint PK_XOZ_REF_UPD ***
begin
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_UPDATE  ADD CONSTRAINT PK_XOZ_REF_UPD  PRIMARY KEY (IDUPD)
  USING INDEX TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_XOZ_REF_UPD ***

begin
 execute immediate 'CREATE INDEX IDXL_XOZREFUPD_IDUPD ON XOZ_REF_UPDATE (KF, IDUPD) LOCAL';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

begin
 execute immediate 'CREATE INDEX IDXL_XOZREFUPD_REF1 ON XOZ_REF_UPDATE (KF, REF1) LOCAL';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

begin
 execute immediate 'CREATE INDEX IDXL_XOZREFUPD_REF2 ON XOZ_REF_UPDATE (KF, REF2) LOCAL';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

begin
 execute immediate 'CREATE INDEX IDXL_XOZREFUPD_ACC ON XOZ_REF_UPDATE (KF, ACC) LOCAL';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

begin
 execute immediate 'CREATE INDEX IDXL_XOZREFUPD_EFFGL ON XOZ_REF_UPDATE (EFFECTDATE, GLOBAL_BD) LOCAL';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

------------------------------------------------------------------------------------

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.XOZ_REF_UPDATE TO BARS_ACCESS_DEFROLE;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.XOZ_REF_UPDATE TO START1;
GRANT SELECT                         ON BARS.XOZ_REF_UPDATE TO BARSUPL, UPLD;
GRANT SELECT                         ON BARS.XOZ_REF_UPDATE TO BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_REF_UPDATE.sql ======*** End *** =
PROMPT ===================================================================================== 






