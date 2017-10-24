
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpu_utils.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPU_UTILS 
is
  -------------------------------------------------------------
  --                                                         --
  --   Пакет вспомогательных функций для работы модуля DPU   --
  --                                                         --
  -------------------------------------------------------------

  -- constants
  head_ver     constant varchar2(64)  := 'version 1.02 03.06.2013';
  head_awk     constant varchar2(512) := '';

  --
  -- HEADER_VERSION() - функция определения версии заголовка пакета
  --
  function header_version return varchar2;

  --
  -- BODY_VERSION() - функция определения версии тела пакета
  --
  function body_version   return varchar2;

  --
  -- GEN_SCRIPT4VIDD() - процедура создания сценария для выгрузки вида депозита
  --
  -- Параметры:
  --            p_vidd - код вида депозитного договора юр.лица
  --
  procedure gen_script4vidd (p_vidd in dpu_vidd.vidd%type);

  --
  -- GEN_SCRIPT4TYPES() - ф-я  створення сценарію для експорту типу депозиту ЮО
  --
  -- Параметри:
  --            p_typeid - код типу депозитного продукту ЮО
  --
  function gen_script4types
  ( p_typeid in dpu_types.type_id%type )
  return varchar2_list pipelined;

  --
  -- Синхронізація параметрів продукту з видами депозитів
  --
  -- Параметри:
  --            p_typeid - код типу депозитного продукту ЮО
  --
  procedure TYPE_CONSTRUCTOR
  ( p_typeid in dpu_types.type_id%type );


  --
  -- SET_DPUVIDDRATE() - процедура валидации и записи строки в справочник
  --                     "Шкалы процентных ставок по депозитам ЮЛ"
  --
  -- Параметры:
  --              p_id - идентификатор записи
  --          p_typeid - код типа депозитного договора юр.лица
  --              p_kv - числовой код валюты
  --            p_vidd - код вида депозитного договора юр.лица
  --        p_termmnth - срок депозита в месяцах
  --        p_termdays - срок депозита в днях
  --        p_termincl - признак включения гран.срока в диапазон
  --           p_limit - граничная сумма в коп.
  --        p_summincl - признак включения гран.суммы в диапазон
  --         p_actrate - процентная ставка
  --         p_maxrate - макс.допустимая процентная ставка
  --
  procedure set_dpuviddrate (p_id        in  dpu_vidd_rate.id%type,
                             p_typeid    in  dpu_vidd_rate.type_id%type,
                             p_kv        in  dpu_vidd_rate.kv%type,
                             p_vidd      in  dpu_vidd_rate.vidd%type,
                             p_termmnth  in  dpu_vidd_rate.term%type,
                             p_termdays  in  dpu_vidd_rate.term_days%type,
                             p_termincl  in  dpu_vidd_rate.term_include%type,
                             p_limit     in  dpu_vidd_rate.limit%type,
                             p_summincl  in  dpu_vidd_rate.summ_include%type,
                             p_actrate   in  dpu_vidd_rate.rate%type,
                             p_maxrate   in  dpu_vidd_rate.max_rate%type);

end dpu_utils;
/
CREATE OR REPLACE PACKAGE BODY BARS.DPU_UTILS wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
b549 2a40
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
E7UdootRXw==
/
 show err;
 
PROMPT *** Create  grants  DPU_UTILS ***
grant EXECUTE                                                                on DPU_UTILS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPU_UTILS       to DPT;
grant EXECUTE                                                                on DPU_UTILS       to DPT_ADMIN;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpu_utils.sql =========*** End *** =
 PROMPT ===================================================================================== 
 