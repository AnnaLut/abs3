PROMPT ADD POLICY INFO FOR TABLE PRVN_FV_REZ_IFRS9
begin
bars_policy_adm.alter_policy_info('PRVN_FV_REZ_IFRS9','WHOLE', null, null, null, null);
bars_policy_adm.alter_policy_info('PRVN_FV_REZ_IFRS9','FILIAL', null, null, null, null);
end;
/
commit
/
PROMPT CREATE TABLE PRVN_FV_REZ_IFRS9
BEGIN
execute immediate
'CREATE TABLE BARS.PRVN_FV_REZ_IFRS9
(
  ID_CALC_SET           NUMBER(14)              NOT NULL,
  ID_CONTRACT           VARCHAR2(100)           NOT NULL,
  ID_COMMITMENT         VARCHAR2(100),
  UNIQUE_BARS_IS        VARCHAR2(30)            NOT NULL,
  ID_BRANCH             VARCHAR2(30)            NOT NULL,
  BARS_BRANCH_ID        VARCHAR2(30),
  RNK_CLIENT            VARCHAR2(30)            NOT NULL,
  ID_CURRENCY           VARCHAR2(30)            NOT NULL,
  PROV_BALANCE_CCY      NUMBER(24,2),
  PROV_OFFBALANCE_CCY   NUMBER(24,2),
  IFRS_CATEGORY         VARCHAR2(30),
  ID_IMP_STAGE          VARCHAR2(4),
  ID_PROV_TYPE          VARCHAR2(2),
  IS_POCI               NUMBER(1),
  PD_CUMUL_CURRENT      NUMBER(13,10),
  PD_CUMUL_INITIAL      NUMBER(13,10),
  RATING                VARCHAR2(30),
  CONTRACT_RATING_INIT  VARCHAR2(100),
  INITIAL_IMPAIRMENT    NUMBER(24,2),
  AIRC_CCY              NUMBER(24,2),
  IRC_CCY               NUMBER(24,2),
  FV_ADJ_NEW_FEE        NUMBER,
  FV_ADJ_AMORT          NUMBER,
  FV_ADJ_BALANCE        NUMBER,
  MODIF_NEW_FEE         NUMBER,
  MODIF_AMORT           NUMBER,
  MODIF_BALANCE         NUMBER,
  GENERAL_NEW_FEE       NUMBER,
  GENERAL_FEE_AMORT     NUMBER,
  GENERAL_FEE_BALANCE   NUMBER,
  ACCRUAL_ADJ_DELTA     NUMBER(20,7),
  ACCRUAL_ADJ_AMORT     NUMBER(20,7),
  ACCRUAL_ADJ_BALANCE   NUMBER(20,7),
  DERECOGNITION_FLAG    NUMBER(1),
  EIR                   NUMBER(13,8),
  DELTA_FV_CCY          NUMBER(24,2)
)
TABLESPACE BRSSMLD
RESULT_CACHE (MODE DEFAULT)
STORAGE    (
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
NOMONITORING';
exception when others then
    if (sqlcode=-955) then null; else raise; end if;
end;
/
PROMPT ADD COMMENTS AND GRANTS FOR PRVN_FV_REZ_IFRS9

COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_CALC_SET          IS 'Ідентифікатор розрахунку';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_CONTRACT          IS 'Ідентифікатор договору';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_COMMITMENT        IS 'Ідентифікатор генерального договору';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.UNIQUE_BARS_IS       IS 'Ідентифікатор договору в АБС "БАРС"';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_BRANCH            IS 'Номер відділення';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.BARS_BRANCH_ID       IS 'Код філії (за кодифікацією DWH)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.RNK_CLIENT           IS 'Ідентифікатор клієнта';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_CURRENCY          IS 'Ідентифікатор валюти (символьний)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.PROV_BALANCE_CCY     IS 'Резерв за балансовою частиною договору (залишок на звітну дату) ';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.PROV_OFFBALANCE_CCY  IS 'Резерв за позабалансовою частиною договору (залишок на звітну дату) ';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.IFRS_CATEGORY        IS 'Категорія обліку за IFRS-класифікацією';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_IMP_STAGE         IS 'Стейдж фінансового інструменту згідно МСФЗ9';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ID_PROV_TYPE         IS 'Тип резерву (С - колективний, І - індивідуальний)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.IS_POCI              IS 'Ознака віднесення договору до категорії POCI';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.PD_CUMUL_CURRENT     IS 'Поточне значення кумулятивної вірогідності дефолту на весь період дії інструменту';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.PD_CUMUL_INITIAL     IS 'Значення кумулятивної вірогідності дефолту, ввизначене на дату первинного визнання';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.RATING               IS 'Рейтинг поточний';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.CONTRACT_RATING_INIT IS 'Рейтинг на момент первинного визнання інструменту';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.INITIAL_IMPAIRMENT   IS 'Первинний збиток для інструментів, що віднесені до категорії РОСІ';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.AIRC_CCY             IS 'Коригування процентного доходу (залишок на звітну дату)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.IRC_CCY              IS 'Коригування процентного доходу (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.FV_ADJ_NEW_FEE       IS 'Коригування справедливої вартості (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.FV_ADJ_AMORT         IS 'Амортизація коригування справедливої вартості (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.FV_ADJ_BALANCE       IS 'Неамортизований дисконт / премія за коригуванням справедливої вартості (залишок на звітну дату)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.MODIF_NEW_FEE        IS 'Модифікація договору (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.MODIF_AMORT          IS 'Амортизація модифікації договору (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.MODIF_BALANCE        IS 'Неамортизований дисконт / премія за модифікацією договору (залишок на звітну дату)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.GENERAL_NEW_FEE      IS 'Формування "грошового" дисконту / премії (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.GENERAL_FEE_AMORT    IS 'Амортизація "грошового" дисконту / премії (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.GENERAL_FEE_BALANCE  IS 'Неамортизований "грошовий" дисконт / премія (залишок за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ACCRUAL_ADJ_DELTA    IS 'Формування "технічного" дисконту / премії (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ACCRUAL_ADJ_AMORT    IS 'Амортизація "технічного" дисконту / премії (оборот за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.ACCRUAL_ADJ_BALANCE  IS 'Неамортизований "технічний" дисконт / премія (залишок за звітний період)';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.DERECOGNITION_FLAG   IS 'Ознака припинення визнання фінансового інструменту';
COMMENT ON COLUMN BARS.PRVN_FV_REZ_IFRS9.EIR                  IS 'Ефективна процентна ставка';

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 add (DELTA_FV_CCY  NUMBER(24,2)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_FV_REZ_IFRS9.DELTA_FV_CCY IS 'Переоцінка';

begin   
 execute immediate '
  CREATE INDEX BARS.I1_PRVN_FV_REZ_IFRS9 ON BARS.PRVN_FV_REZ_IFRS9 (ID_CALC_SET, ID_BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


GRANT SELECT, INSERT, UPDATE, DELETE ON PRVN_FV_REZ_IFRS9 TO BARS_ACCESS_DEFROLE;
grant SELECT                         on PRVN_FV_REZ_IFRS9 to BARSREADER_ROLE;
grant SELECT                         on PRVN_FV_REZ_IFRS9 to BARS_DM;
grant SELECT                         on PRVN_FV_REZ_IFRS9 to START1;
grant SELECT                         on PRVN_FV_REZ_IFRS9 to UPLD;
