-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 27.08.2016
-- ======================================================================================
-- create view V_DPU_VIDD
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_DPU_VIDD
prompt -- ======================================================

CREATE OR REPLACE VIEW BARS.V_DPU_VIDD
( VIDD_ID
, VIDD_NM
, VIDD_CODE
, TYPE_ID
, TYPE_NM
, CCY_ID
, CCY_CODE
, SROK
, R020_DEP
, R020_INT
, BR_ID
, BR_NM
, FREQ_ID
, FREQ_NM
, COMPROC
, AMNT_MIN
, AMNT_MAX
, AMNT_ADD
, REPLENISHABLE
, STOP_ID
, STOP_NM
, PROLONGABLE
, TEMPLATE_ID
, COMMENTS
, IS_LINE
, IS_ACTIVE
, IRREVOCABLE
, TERM_TP
, TERM_MIN_MO
, TERM_MIN_DY
, TERM_MAX_MO
, TERM_MAX_DY
, TERM_ADD
, SEGMENT
, DEAL_QTY
) 
as
select DPU_VIDD.VIDD
     , DPU_VIDD.NAME
     , DPU_VIDD.DPU_CODE
     , DPU_VIDD.TYPE_ID
     , DPU_TYPES.TYPE_NAME
     , DPU_VIDD.KV
     , TABVAL$GLOBAL.LCV
     , DPU_VIDD.SROK
     , DPU_VIDD.BSD
     , DPU_VIDD.BSN
     , BRATES.BR_ID
     , BRATES.NAME
     , FREQ.FREQ
     , FREQ.NAME
     , DPU_VIDD.COMPROC
     , DPU_VIDD.MIN_SUMM/100
     , DPU_VIDD.MAX_SUMM/100
     , LIMIT/100
     , nvl(DPU_VIDD.FL_ADD,0)
     , DPT_STOP.ID
     , DPT_STOP.NAME
     , DPU_VIDD.FL_AUTOEXTEND
     , DPU_VIDD.SHABLON
     , DPU_VIDD.COMMENTS
     , sign(DPU_VIDD.FL_EXTEND)
     , nvl(DPU_VIDD.FLAG,0)
     , DPU_VIDD.IRVK
     , DPU_VIDD.TERM_TYPE
     , trunc(DPU_VIDD.TERM_MIN) as TERM_MIN_MO
     , (DPU_VIDD.TERM_MIN - trunc(DPU_VIDD.TERM_MIN))*10000 as TERM_MIN_DY
     , trunc(DPU_VIDD.TERM_MAX) as TERM_MAX_MO
     , (DPU_VIDD.TERM_MAX - trunc(DPU_VIDD.TERM_MAX))*10000 as TERM_MAX_DY
     , DPU_VIDD.TERM_ADD
     , 0 as SEGMENT
     , ( select count(DPU_ID)
           from DPU_DEAL
          where VIDD = DPU_VIDD.VIDD
            and CLOSED = 0
       ) as QTY
  from DPU_VIDD
  join DPU_TYPES
    on ( DPU_TYPES.TYPE_ID = DPU_VIDD.TYPE_ID )
  join TABVAL$GLOBAL
    on ( TABVAL$GLOBAL.KV = DPU_VIDD.KV )
  join DPT_STOP
    on ( DPT_STOP.ID = DPU_VIDD.ID_STOP )
  join FREQ
    on ( FREQ.FREQ = DPU_VIDD.FREQ_V )
  left
  join BRATES
    on ( BRATES.BR_ID = DPU_VIDD.BR_ID )
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_DPU_VIDD               IS 'Види депозитів ЮЛ';

COMMENT ON COLUMN BARS.V_DPU_VIDD.VIDD_ID       IS 'Вид депозиту (ідентифікатор)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.VIDD_NM       IS 'Назва виду депозиту';
COMMENT ON COLUMN BARS.V_DPU_VIDD.CCY_ID        IS 'Ід. валюты';
COMMENT ON COLUMN BARS.V_DPU_VIDD.CCY_CODE      IS 'Код валюты';
COMMENT ON COLUMN BARS.V_DPU_VIDD.SROK          IS 'Длительность вида депозитного договора ЮЛ';
COMMENT ON COLUMN BARS.V_DPU_VIDD.R020_DEP      IS 'Бал.счет депозита';
COMMENT ON COLUMN BARS.V_DPU_VIDD.R020_INT      IS 'Бал.счет начисл.%%';
COMMENT ON COLUMN BARS.V_DPU_VIDD.BR_ID         IS 'Код базовой %% ставки';
COMMENT ON COLUMN BARS.V_DPU_VIDD.BR_NM         IS 'Код базовой %% ставки';
COMMENT ON COLUMN BARS.V_DPU_VIDD.FREQ_ID       IS 'Ід. періодичності виплати %%';
COMMENT ON COLUMN BARS.V_DPU_VIDD.FREQ_NM       IS 'Назва періодичності виплати %%';
COMMENT ON COLUMN BARS.V_DPU_VIDD.COMPROC       IS 'Флаг капитализации %%';
COMMENT ON COLUMN BARS.V_DPU_VIDD.STOP_ID       IS 'Код штрафа за досрочное расторжение договора';
COMMENT ON COLUMN BARS.V_DPU_VIDD.STOP_NM       IS 'Назва штрафа за досрочное расторжение договора';
COMMENT ON COLUMN BARS.V_DPU_VIDD.AMNT_MIN      IS 'Min. сума депозиту';
COMMENT ON COLUMN BARS.V_DPU_VIDD.AMNT_MAX      IS 'Max. сума депозиту';
COMMENT ON COLUMN BARS.V_DPU_VIDD.AMNT_ADD      IS 'Мін. сума поповнення депозиту';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TEMPLATE_ID   IS 'Шаблон договора';
COMMENT ON COLUMN BARS.V_DPU_VIDD.COMMENTS      IS 'Комментарий';
COMMENT ON COLUMN BARS.V_DPU_VIDD.IS_ACTIVE     IS 'Флаг активности вида депозита';
COMMENT ON COLUMN BARS.V_DPU_VIDD.IS_LINE       IS 'Флаг депозитной линии';
COMMENT ON COLUMN BARS.V_DPU_VIDD.REPLENISHABLE IS 'Флаг пополнения депозита' ;
COMMENT ON COLUMN BARS.V_DPU_VIDD.PROLONGABLE   IS 'Признак автомат.переоформления договора';
COMMENT ON COLUMN BARS.V_DPU_VIDD.IRREVOCABLE   IS 'Безвідкличний депозитний договір (заборонено дострокове вилучення)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TYPE_ID       IS 'Ід. типу депозиту (депозитного продукту )';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TYPE_NM       IS 'Назва типу депозиту (депозитного продукту )';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TERM_TP       IS 'Тип терміну депозиту (1 - фікований, 2 - діапазон)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TERM_MIN_MO   IS 'Мінімальний термін дії депозиту (в місяцях)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TERM_MIN_DY   IS 'Мінімальний термін дії депозиту (в днях)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TERM_MAX_MO   IS 'Максимальний термін дії депозиту (в місяцях)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TERM_MAX_DY   IS 'Максимальний термін дії депозиту (в днях)';
COMMENT ON COLUMN BARS.V_DPU_VIDD.TERM_ADD      IS 'Термін протягом якого дозволено поповнення депозиту';
COMMENT ON COLUMN BARS.V_DPU_VIDD.SEGMENT       IS 'Клієнтський Сегмент';
COMMENT ON COLUMN BARS.V_DPU_VIDD.DEAL_QTY      IS 'К-ть діючих депозитних договорів';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_DPU_VIDD TO BARS_ACCESS_DEFROLE;
