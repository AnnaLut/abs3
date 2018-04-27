prompt view/vw_ref_dpt_vidd.sql
CREATE OR REPLACE FORCE VIEW VW_REF_DPT_VIDD AS
SELECT cast(bars.F_OURMFO_G as varchar2(6)) MFO,
       FLAG,
       VIDD,
       d.TYPE_NAME,
       BASEM,
       FREQ_N,
       FREQ_K,
       DURATION,
       TERM_TYPE,
       MIN_SUMM,
       COMMENTS,
       TYPE_COD,
       KV,
       DATN,
       DATK,
       FL_DUBL,
       FL_2620,
       COMPROC,
       LIMIT,
       TERM_ADD,
       TERM_DUBL,
       DURATION_DAYS,
       MAX_LIMIT,
       DISABLE_ADD,
       DURATION_MAX,
       DURATION_DAYS_MAX,
       IRREVOCABLE,
       BR_ID,
       (select br_type from bars.brates where br_id = d.BR_ID) br_type,
       bars.getbrat(sysdate, BR_ID, d.kv, d.limit) as BR_IDrate,
       BR_WD,
       bars.getbrat(sysdate, BR_WD, d.kv, d.limit) as BR_WDrate,
       BR_ID_L,
       bars.getbrat(sysdate, BR_ID_L, d.kv, d.limit) as BR_ID_Lrate,
       (select val from bars.dpt_vidd_params where vidd = d.vidd and tag = 'FORB_EARLY') as FORB_EARLY,
       (select val from bars.dpt_vidd_params where vidd = d.vidd and tag = 'FORB_EARLY_DATE') as FORB_EARLY_DATE,
       nvl((select case when fl_demand = 1 then 'N' else 'Y' end from bars.dpt_types where type_code = d.type_cod), 'Y') used_ebp,
       T.TYPE_NAME as FAMILY
  FROM bars.dpt_vidd d, bars.DPT_TYPES t
 where BSD in ('2630', '2635') -- без текущих счетов 2620
   and flag = 1 -- только активные
   and D.TYPE_ID = T.TYPE_ID;


comment on table VW_REF_DPT_VIDD is 'Виды вкладов';
comment on column VW_REF_DPT_VIDD.FLAG is 'Флаг активності';
comment on column VW_REF_DPT_VIDD.VIDD is 'Вид вкладу';
comment on column VW_REF_DPT_VIDD.TYPE_NAME is 'Название вида вклада';
comment on column VW_REF_DPT_VIDD.BASEM is 'Ознака фіксованої відсоткової ставки';
comment on column VW_REF_DPT_VIDD.FREQ_N is 'Періодичність нарахування відсотків';
comment on column VW_REF_DPT_VIDD.FREQ_K is 'Періодичність виплати відсотків';
comment on column VW_REF_DPT_VIDD.DURATION is 'Строк виду вкладу в місяцях';
comment on column VW_REF_DPT_VIDD.TERM_TYPE is 'Тип срока: 1-фикс, 0-плав, 2-диапазон';
comment on column VW_REF_DPT_VIDD.MIN_SUMM is 'Мінімальна сума вкладу';
comment on column VW_REF_DPT_VIDD.COMMENTS is 'Коментар';
comment on column VW_REF_DPT_VIDD.TYPE_COD is 'Тип коду групи продукта';
comment on column VW_REF_DPT_VIDD.KV is 'Валюта (цифровой ISO-код)';
comment on column VW_REF_DPT_VIDD.DATN is 'Дата початку дії вкладу';
comment on column VW_REF_DPT_VIDD.DATK is 'Дата закінчення дії вкладу';
comment on column VW_REF_DPT_VIDD.FL_DUBL is 'Флаг автопролонгації (0 - без переоформления, 1 - переоформление без пересмотра ставки, 2 - переоформление с пересмотром ставки)';
comment on column VW_REF_DPT_VIDD.FL_2620 is 'Перенесення на вклад "До вимоги"';
comment on column VW_REF_DPT_VIDD.COMPROC is 'Капіталізація відсотків';
comment on column VW_REF_DPT_VIDD.LIMIT is 'Мінімальна сума поповнення';
comment on column VW_REF_DPT_VIDD.TERM_ADD is 'Строк поповнення вкладу';
comment on column VW_REF_DPT_VIDD.TERM_DUBL is 'Максимальна к-ть автопролонгацій вкладу';
comment on column VW_REF_DPT_VIDD.DURATION_DAYS is 'Строк виду вкладу в днях';
comment on column VW_REF_DPT_VIDD.MAX_LIMIT is 'Макисмальна сума поповнення';
comment on column VW_REF_DPT_VIDD.DISABLE_ADD is 'Ознака непоповнюваного депозиту';
comment on column VW_REF_DPT_VIDD.DURATION_MAX is 'Максимальний термін вкладу в місяцях';
comment on column VW_REF_DPT_VIDD.DURATION_DAYS_MAX is 'Максимальний термін вкладу в в днях';
comment on column VW_REF_DPT_VIDD.IRREVOCABLE is 'Безвідкличний депозитний договір';
comment on column VW_REF_DPT_VIDD.BR_ID is 'Код базовой ставки?';
comment on column VW_REF_DPT_VIDD.BR_TYPE is 'тип базовой ставки';
comment on column VW_REF_DPT_VIDD.BR_IDRATE is 'значение базовой ставки';
comment on column VW_REF_DPT_VIDD.BR_WD is 'Код ставки при частичном снятии';
comment on column VW_REF_DPT_VIDD.BR_WDRATE is 'Значение ставки при частичном снятии';
comment on column VW_REF_DPT_VIDD.BR_ID_L is 'Код ставки пролонгации';
comment on column VW_REF_DPT_VIDD.BR_ID_LRATE is 'Значение ставки пролонгации';
comment on column VW_REF_DPT_VIDD.FORB_EARLY is 'Заборона дострокового розірвання';
comment on column VW_REF_DPT_VIDD.FORB_EARLY_DATE is 'Дата, з якої діє заборона дострокового розірвання';
comment on column VW_REF_DPT_VIDD.USED_EBP is 'признак эталонного бизнес-процесса (Y/N)';
comment on column VW_REF_DPT_VIDD.FAMILY is 'Название семейства (например "Мій депозит Преміальний", "Класичний", "Капітал")';