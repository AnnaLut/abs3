prompt -------------------------------------
prompt  создание таблицы DPT_VIDD_ARC
prompt  Виды вкладов (Архів)
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_VIDD_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_VIDD_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_VIDD_ARC(
  VIDD               NUMBER(38) CONSTRAINT CC_DPTVIDDARCARC_VIDD_NN NOT NULL,
  DEPOSIT_COD        VARCHAR2(4 BYTE),
  TYPE_NAME          VARCHAR2(50 BYTE) CONSTRAINT CC_DPTVIDDARC_TYPENAME_NN NOT NULL,
  BASEY              INTEGER                    DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BASEY_NN NOT NULL,
  BASEM              INTEGER                    DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BASEM_NN NOT NULL,
  BR_ID              NUMBER(38),
  FREQ_N             NUMBER(3)                  DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_FREQN_NN NOT NULL,
  FREQ_K             NUMBER(3) CONSTRAINT CC_DPTVIDDARC_FREQK_NN NOT NULL,
  BSD                CHAR(4 BYTE) CONSTRAINT CC_DPTVIDDARC_BSD_NN NOT NULL,
  BSN                CHAR(4 BYTE) CONSTRAINT CC_DPTVIDDARC_BSN_NN NOT NULL,
  METR               NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_METR_NN NOT NULL,
  AMR_METR           NUMBER                     DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_AMRMETR_NN NOT NULL,
  DURATION           NUMBER(10)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_DURATION_NN NOT NULL,
  TERM_TYPE          NUMBER                     DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_TERMTYPE_NN NOT NULL,
  MIN_SUMM           NUMBER(24),
  COMMENTS           VARCHAR2(128 BYTE),
  FLAG               NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_FLAG_NN NOT NULL,
  TYPE_COD           VARCHAR2(4 BYTE),
  KV                 NUMBER(3) CONSTRAINT CC_DPTVIDDARC_KV_NN NOT NULL,
  TT                 CHAR(3 BYTE),
  SHABLON            VARCHAR2(15 BYTE),
  IDG                NUMBER(38),
  IDS                NUMBER(38),
  NLS_K              VARCHAR2(15 BYTE),
  DATN               DATE,
  DATK               DATE,
  BR_ID_L            NUMBER(38),
  FL_DUBL            NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_FLDUBL_NN NOT NULL,
  ACC7               NUMBER(38),
  ID_STOP            NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_IDSTOP_NN NOT NULL,
  KODZ               NUMBER(38),
  FMT                NUMBER(2),
  FL_2620            NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_FL2620_NN NOT NULL,
  COMPROC            NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_COMPROC_NN NOT NULL,
  LIMIT              NUMBER(24),
  TERM_ADD           NUMBER(7,2),
  TERM_DUBL          NUMBER(10)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_TERMDUBL_NN NOT NULL,
  DURATION_DAYS      NUMBER(10)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_DURATIONDAYS_NN NOT NULL,
  EXTENSION_ID       NUMBER(38),
  TIP_OST            NUMBER(1)                  DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_TIPOST_NN NOT NULL,
  BR_WD              NUMBER(38),
  NLSN_K             VARCHAR2(14 BYTE),
  BSA                CHAR(4 BYTE),
  MAX_LIMIT          NUMBER(24),
  BR_BONUS           NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BRBONUS_NN NOT NULL,
  BR_OP              NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BROP_NN NOT NULL,
  AUTO_ADD           NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_AUTOADD_NN NOT NULL,
  TYPE_ID            NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_TYPEID_NN NOT NULL,
  DISABLE_ADD        NUMBER(1),
  CODE_TARIFF        NUMBER(38),
  DURATION_MAX       NUMBER(3),
  DURATION_DAYS_MAX  NUMBER(3),
  IRREVOCABLE        NUMBER(1)                  DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_IRREVOCABLE_NN NOT NULL,
  DATE_OFF           DATE                       DEFAULT sysdate CONSTRAINT CC_DPTVIDDARC_DATE_OFF NOT NULL,
  USER_OFF           NUMBER(38)                 DEFAULT sys_context(''bars_context'',''user_id'') CONSTRAINT CC_DPTVIDDARC_USER_OFF NOT NULL,
  SUPPLEMENTAL LOG DATA (ALL) COLUMNS,
  SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS,
  SUPPLEMENTAL LOG DATA (UNIQUE) COLUMNS,
  SUPPLEMENTAL LOG DATA (FOREIGN KEY) COLUMNS
) TABLESPACE brsmdld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPT_VIDD_ARC IS 'Види вкладів (Архів)';
COMMENT ON COLUMN DPT_VIDD_ARC.VIDD             IS 'Код вида вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.DEPOSIT_COD      IS 'не исп.';
COMMENT ON COLUMN DPT_VIDD_ARC.TYPE_NAME        IS 'Наименование вида вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.BASEY            IS 'Код базового года';
COMMENT ON COLUMN DPT_VIDD_ARC.BASEM            IS 'Признак фиксир.%-ной ставки';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_ID            IS 'Код базовой процентной ставки';
COMMENT ON COLUMN DPT_VIDD_ARC.FREQ_N           IS 'Периодичность начисления %%';
COMMENT ON COLUMN DPT_VIDD_ARC.FREQ_K           IS 'Периодичность выплаты %%';
COMMENT ON COLUMN DPT_VIDD_ARC.BSD              IS 'Балансовый счет депозита';
COMMENT ON COLUMN DPT_VIDD_ARC.BSN              IS 'Балансовый счет начисленных процентов';
COMMENT ON COLUMN DPT_VIDD_ARC.METR             IS 'Код метода начисления процентов';
COMMENT ON COLUMN DPT_VIDD_ARC.AMR_METR         IS 'Метод амортизации процентов';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION         IS 'Срок вида вклада в месяцах';
COMMENT ON COLUMN DPT_VIDD_ARC.TERM_TYPE        IS 'Тип срока: 1-фикс, 0-плав, 2-диапазон';
COMMENT ON COLUMN DPT_VIDD_ARC.MIN_SUMM         IS 'Минимальная сумма вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.COMMENTS         IS 'Комментарии';
COMMENT ON COLUMN DPT_VIDD_ARC.FLAG             IS 'Флаг активности';
COMMENT ON COLUMN DPT_VIDD_ARC.TYPE_COD         IS 'Символьный код вида вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.KV               IS 'Валюта вида вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.TT               IS 'Тип операции';
COMMENT ON COLUMN DPT_VIDD_ARC.SHABLON          IS 'Шаблон';
COMMENT ON COLUMN DPT_VIDD_ARC.IDG              IS 'Код группы для перекрытия счетов нач.%%';
COMMENT ON COLUMN DPT_VIDD_ARC.IDS              IS 'Код схемы для перекрытия счетов нач.%%';
COMMENT ON COLUMN DPT_VIDD_ARC.NLS_K            IS 'Счет консолидации депозита';
COMMENT ON COLUMN DPT_VIDD_ARC.DATN             IS 'Дата начала действия вида вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.DATK             IS 'Дата окончания действия вида вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_ID_L          IS 'Код ставки пролонгации';
COMMENT ON COLUMN DPT_VIDD_ARC.FL_DUBL          IS 'Флаг автопереоформления';
COMMENT ON COLUMN DPT_VIDD_ARC.ACC7             IS 'Внутр.номер счета расходов';
COMMENT ON COLUMN DPT_VIDD_ARC.ID_STOP          IS 'Код штрафа';
COMMENT ON COLUMN DPT_VIDD_ARC.KODZ             IS 'Код запроса для печати выписки';
COMMENT ON COLUMN DPT_VIDD_ARC.FMT              IS 'Формат выгрузки выписки';
COMMENT ON COLUMN DPT_VIDD_ARC.FL_2620          IS 'Перенос на вклад "До востребования"';
COMMENT ON COLUMN DPT_VIDD_ARC.COMPROC          IS 'Признак капитализации';
COMMENT ON COLUMN DPT_VIDD_ARC.LIMIT            IS 'Минимальная сумма пополнения';
COMMENT ON COLUMN DPT_VIDD_ARC.TERM_ADD         IS 'Срок пополнения';
COMMENT ON COLUMN DPT_VIDD_ARC.TERM_DUBL        IS 'Макс.кол-во автопереоформлений вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION_DAYS    IS 'Срок вида вклада в днях';
COMMENT ON COLUMN DPT_VIDD_ARC.EXTENSION_ID     IS 'Код меторда автопереоформления';
COMMENT ON COLUMN DPT_VIDD_ARC.TIP_OST          IS 'Тип вычисления остатка';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_WD            IS 'Код ставки при частичном снятии';
COMMENT ON COLUMN DPT_VIDD_ARC.NLSN_K           IS 'Счет консолидации начисл.%%';
COMMENT ON COLUMN DPT_VIDD_ARC.BSA              IS 'Балансовый счет амортизации';
COMMENT ON COLUMN DPT_VIDD_ARC.MAX_LIMIT        IS 'Максимальная сумма пополнения';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_BONUS         IS 'Код базовой бонусной ставки';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_OP            IS 'Код арифм.операции между базовой и бонусной ставками';
COMMENT ON COLUMN DPT_VIDD_ARC.AUTO_ADD         IS 'Флаг автопополнения вклада';
COMMENT ON COLUMN DPT_VIDD_ARC.TYPE_ID          IS 'Числ.код типа договора';
COMMENT ON COLUMN DPT_VIDD_ARC.DISABLE_ADD      IS 'Ознака непоповнюваного депозиту';
COMMENT ON COLUMN DPT_VIDD_ARC.CODE_TARIFF      IS 'Код тарифу за видачу готівки при безгот.зарах.';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION_MAX     IS 'Максимальний термін вкладу в місяцях (для TERM_TYPE = 2)';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION_DAYS_MAX IS 'Максимальний термін вкладу в в днях (для TERM_TYPE = 2)';
COMMENT ON COLUMN DPT_VIDD_ARC.IRREVOCABLE      IS 'Безвідкличний депозитний договір (заборонено дострокове вилучення)';
COMMENT ON COLUMN DPT_VIDD_ARC.DATE_OFF         IS 'Дата видалення в архів';
COMMENT ON COLUMN DPT_VIDD_ARC.USER_OFF         IS 'Користувач, видаливший вид в архів'; 
/

GRANT ALL ON DPT_VIDD_ARC TO BARS_ACCESS_DEFROLE;
/
