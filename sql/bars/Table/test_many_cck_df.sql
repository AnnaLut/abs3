PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Table/TEST_MANY_CCK_DF.sql =====*** Run *** ====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to TEST_MANY_CCK_DF ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TEST_MANY_CCK_DF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TEST_MANY_CCK_DF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEST_MANY_CCK_DF ***
begin 
  execute immediate '
      CREATE TABLE BARS.TEST_MANY_CCK_DF 
            (ND        NUMBER,
             PV        NUMBER,
             IRR0      NUMBER,
             IRR       NUMBER,
             SERR      VARCHAR2(100 BYTE),
             BRANCH    VARCHAR2(22 BYTE),
             VIDD      INTEGER,
             SDATE     DATE,
             WDATE     DATE,
             IR        NUMBER,
             BV        NUMBER,
             RNK       NUMBER,
             K         NUMBER,
             KAT       NUMBER,
             NLS       VARCHAR2(15 BYTE),
             KV        INTEGER,
             OBS       INTEGER,
             FIN       INTEGER,
             FINN      VARCHAR2(35 BYTE),
             OBESP     NUMBER,
             REZ       NUMBER,
             DAT       DATE,
             ID        NUMBER,
             BASEY     INTEGER,
             KOL_P     INTEGER,
             KOL_VZ    INTEGER,
             D_P       DATE,
             D_V       DATE,
             REZQ      NUMBER,
             OB22      CHAR(2 BYTE),
             BVQ       NUMBER,
             S180      VARCHAR2(1 BYTE),
             R011      VARCHAR2(1 BYTE),
             OKPO      VARCHAR2(14 BYTE),
             NMS       VARCHAR2(70 BYTE),
             ZAXODY    VARCHAR2(70 BYTE),
             NBS       VARCHAR2(4 BYTE),
             R013      VARCHAR2(1 BYTE),
             PVQ       NUMBER,
             NBS_REZ   CHAR(4 BYTE),
             OB22_REZ  CHAR(2 BYTE)
           ) SEGMENT CREATION IMMEDIATE 
             PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
             NOCOMPRESS LOGGING
             TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to TEST_MANY_CCK_DF ***
 exec bpa.alter_policies('TEST_MANY_CCK_DF');

COMMENT ON TABLE BARS.TEST_MANY_CCK_DF          IS 'Резерв по фінансовій дебіторській заборгованності';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.ND      IS 'Внутрішній номер рахунку';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.PV      IS 'Теперішня вартість (BV*K)';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.SERR    IS 'Коментар';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.BRANCH  IS 'Номер відділення';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.VIDD    IS 'Вид (8 - ручные УПБ, 9 - остальные';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.SDATE   IS 'Дата початку';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.WDATE   IS 'Дата закінчення';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.BV      IS 'Балансова вартість ном.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.RNK     IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.K       IS 'Показник ризику';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KAT     IS 'Категорія якості';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.NLS     IS 'Номер рахунку';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KV      IS 'Код валюти';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.REZ     IS 'Резерв ном.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.DAT     IS 'Отчетная дата';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.ID      IS 'Користувач';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KOL_P   IS 'К-ть днів прострочки';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KOL_VZ  IS 'К-ть днів визнання заборгованності';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.D_P     IS 'Дата прострочки';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.D_V     IS 'Дата виникнення заборгованності';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.REZQ    IS 'Резерв екв.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.OB22    IS 'ОБ22 рахунку';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.BVQ     IS 'Балансова вартість екв.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.S180    IS 'S180 - код срока';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.NMS     IS 'Зміст заборгованності(Наименов.счета)';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.ZAXODY  IS 'Вжиті заходи';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.R011    IS 'R011';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.OKPO    IS 'OKPO';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.NBS     IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.R013    IS 'Параметр R013';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.PVQ     IS 'Теперішня вартість екв.';

PROMPT *** Create  constraint PK_TESTMANYCCK_DF ***

begin
  EXECUTE IMMEDIATE 
   'ALTER TABLE BARS.TEST_MANY_CCK_DF DROP PRIMARY KEY CASCADE';
 exception when others then
  -- ORA-02260:  Cannot drop nonexistent primary key
  if SQLCODE = -02441 then null;   else raise; end if; 
end;
/

PROMPT *** Create  grants  TEST_MANY_CCK_DF ***

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK_DF TO BARS_ACCESS_DEFROLE;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK_DF TO RCC_DEAL;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK_DF TO START1;
GRANT SELECT                         ON BARS.TEST_MANY_CCK_DF TO UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Table/TEST_MANY_CCK_DF.sql =====*** End *** ====
PROMPT ===================================================================================== 
