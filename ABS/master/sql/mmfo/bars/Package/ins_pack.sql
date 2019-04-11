
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ins_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.INS_PACK is

  -- Author  : TVSUKHOV
  -- Created : 09.02.2011 15:35:02
  -- Purpose : Пакет для работи с договорами страхования

  -- Public constant declarations
  g_header_version  constant varchar2(64) := 'version 3.0 07/07/2017';
  g_awk_header_defs constant varchar2(512) := '';

  g_dbgcode constant varchar2(12) := 'ins_pack.';
  g_modcode constant varchar2(3) := 'INS';

  -- маска формата для преобразования char <--> number
  g_number_format constant varchar2(128) := 'FM999999999999999999999999999990.0999999999999999999999999999999';
  -- параметры преобразования char <--> number
  g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  -- маска формата для преобразования char <--> date
  g_datetime_format constant varchar2(30) := 'YYYY.MM.DD HH24:MI:SS';
  g_date_format     constant varchar2(30) := 'YYYY.MM.DD';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  -- кол-во дней для оповещения
  function g_alertdays return number;

  -- ============= Методы ================

  -- Встановлення параметрів комісії
  procedure set_fee(p_fee_id     in ins_fees.id%type,
                    p_name       in ins_fees.name%type,
                    p_min_value  in ins_fees.min_value%type,
                    p_perc_value in ins_fees.perc_value%type,
                    p_max_value  in ins_fees.max_value%type);

  -- Видалення комісії
  procedure del_fee(p_fee_id in ins_fees.id%type);

  -- Встановлення параметрів комісії у розрізі періоду
  procedure set_fee_period(p_fee_id     in ins_fee_periods.fee_id%type,
                           p_period_id  in ins_fee_periods.period_id%type,
                           p_min_value  in ins_fee_periods.min_value%type,
                           p_perc_value in ins_fee_periods.perc_value%type,
                           p_max_value  in ins_fee_periods.max_value%type);

  -- Видалення параметрів комісії у розрізі періоду
  procedure del_fee_period(p_fee_id    in ins_fee_periods.fee_id%type,
                           p_period_id in ins_fee_periods.period_id%type);

  -- Встановлення параметрів тарифу
  procedure set_tariff(p_tariff_id in ins_tariffs.id%type,
                       p_name      in ins_tariffs.name%type,
                       p_min_value in ins_tariffs.min_value%type,
                       p_min_perc  in ins_tariffs.min_perc%type,
                       p_max_value in ins_tariffs.max_value%type,
                       p_max_perc  in ins_tariffs.max_perc%type,
                       p_amort     in ins_tariffs.amort%type);

  -- Видалення тарифу
  procedure del_tariff(p_tariff_id in ins_tariffs.id%type);

  -- Встановлення параметрів тарифу у розрізі періоду
  procedure set_tariff_period(p_tariff_id in ins_tariff_periods.tariff_id%type,
                              p_period_id in ins_tariff_periods.period_id%type,
                              p_min_value in ins_tariff_periods.min_value%type,
                              p_min_perc  in ins_tariff_periods.min_perc%type,
                              p_max_value in ins_tariff_periods.max_value%type,
                              p_max_perc  in ins_tariff_periods.max_perc%type,
                              p_amort     in ins_tariff_periods.amort%type);

  -- Видалення параметрів тарифу у розрізі періоду
  procedure del_tariff_period(p_tariff_id in ins_tariff_periods.tariff_id%type,
                              p_period_id in ins_tariff_periods.period_id%type);

  -- Встановлення параметрів ліміту
  procedure set_limit(p_limit_id   in ins_limits.id%type,
                      p_name       in ins_limits.name%type,
                      p_sum_value  in ins_limits.sum_value%type,
                      p_perc_value in ins_limits.perc_value%type);

  -- Видалення ліміту
  procedure del_limit(p_limit_id in ins_limits.id%type);

  -- Встановлення параметрів атрибуту
  procedure set_attr(p_attr_id in ins_attrs.id%type,
                     p_name    in ins_attrs.name%type,
                     p_type_id in ins_attrs.type_id%type);

  -- Видалення атрибуту
  procedure del_attr(p_attr_id in ins_attrs.id%type);

  -- Встановлення параметрів сканкопії
  procedure set_scan(p_scan_id in ins_scans.id%type,
                     p_name    in ins_scans.name%type);

  -- Видалення сканкопії
  procedure del_scan(p_scan_id in ins_scans.id%type);

  -- Встановлення параметрів СК-партнера
  function set_partner(p_partner_id in ins_partners.id%type,
                       p_name       in ins_partners.name%type,
                       p_rnk        in ins_partners.rnk%type,
                       p_agr_no     in ins_partners.agr_no%type,
                       p_agr_sdate  in ins_partners.agr_sdate%type,
                       p_agr_edate  in ins_partners.agr_edate%type,
                       p_tariff_id  in ins_partners.tariff_id%type,
                       p_fee_id     in ins_partners.fee_id%type,
                       p_limit_id   in ins_partners.limit_id%type,
                       p_active     in ins_partners.active%type,
                       p_custid     in ins_partners.custtype%type)
    return ins_partners.id%type;

  -- Видалення СК-партнера (у разі наявності залежних обїектів - помилка)
  procedure del_partner(p_partner_id in ins_partners.id%type);

  -- Встановлення РНК СК у відділеннях
  procedure set_partner_branch_rnk(p_partner_id in ins_partner_branch_rnk.partner_id%type,
                                   p_branch     in ins_partner_branch_rnk.branch%type,
                                   p_rnk        in ins_partner_branch_rnk.rnk%type);

  -- Видалення РНК СК у відділеннях
  procedure del_partner_branch_rnk(p_partner_id in ins_partner_branch_rnk.partner_id%type,
                                   p_branch     in ins_partner_branch_rnk.branch%type);

  -- Встановлення параметрів типу СД для СК-партнера
  procedure set_partner_type(p_partner_id in ins_partner_types.partner_id%type,
                             p_type_id    in ins_partner_types.type_id%type,
                             p_tariff_id  in ins_partner_types.tariff_id%type,
                             p_fee_id     in ins_partner_types.fee_id%type,
                             p_limit_id   in ins_partner_types.limit_id%type,
                             p_active     in ins_partner_types.active%type);

  -- Видалення типу СД для СК-партнера (у разі наявності залежних обїектів - помилка)
  procedure del_partner_type(p_partner_id in ins_partner_types.partner_id%type,
                             p_type_id    in ins_partner_types.type_id%type);

  -- Встановлення атрибуту типу СД для СК-партнера
  function set_partner_type_attr(p_id          in ins_partner_type_attrs.id%type,
                                 p_attr_id     in ins_partner_type_attrs.attr_id%type,
                                 p_partner_id  in ins_partner_type_attrs.partner_id%type,
                                 p_type_id     in ins_partner_type_attrs.type_id%type,
                                 p_is_required in ins_partner_type_attrs.is_required%type)
    return ins_partner_type_attrs.id%type;

  -- Видалення атрибуту типу СД для СК-партнера
  procedure del_partner_type_attr(p_id         in ins_partner_type_attrs.id%type,
                                  p_apply_hier in number);

  -- Встановлення доступності у відділенні типу СД для СК-партнера
  function set_partner_type_branch(p_id         in ins_partner_type_branches.id%type,
                                   p_branch     in ins_partner_type_branches.branch%type,
                                   p_partner_id in ins_partner_type_branches.partner_id%type,
                                   p_type_id    in ins_partner_type_branches.type_id%type,
                                   p_tariff_id  in ins_partner_type_branches.tariff_id%type,
                                   p_fee_id     in ins_partner_type_branches.fee_id%type,
                                   p_limit_id   in ins_partner_type_branches.limit_id%type,
                                   p_apply_hier in ins_partner_type_branches.apply_hier%type)
    return ins_partner_type_branches.id%type;

  -- Видалення доступності у відділенні типу СД для СК-партнера
  procedure del_partner_type_branch(p_id         in ins_partner_type_branches.id%type,
                                    p_apply_hier in number);

  -- Встановлення доступності у продукті типу СД для СК-партнера
  function set_partner_type_product(p_id         in ins_partner_type_products.id%type,
                                    p_product_id in ins_partner_type_products.product_id%type,
                                    p_partner_id in ins_partner_type_products.partner_id%type,
                                    p_type_id    in ins_partner_type_products.type_id%type)
    return ins_partner_type_products.id%type;

  -- Видалення доступності у продукті типу СД для СК-партнера
  procedure del_partner_type_product(p_id         in ins_partner_type_products.id%type,
                                     p_apply_hier in number);

  -- Встановлення сканкопії типу СД для СК-партнера
  function set_partner_type_scan(p_id          in ins_partner_type_scans.id%type,
                                 p_scan_id     in ins_partner_type_scans.scan_id%type,
                                 p_partner_id  in ins_partner_type_scans.partner_id%type,
                                 p_type_id     in ins_partner_type_scans.type_id%type,
                                 p_is_required in ins_partner_type_scans.is_required%type)
    return ins_partner_type_scans.id%type;

  -- Видалення сканкопії типу СД для СК-партнера
  procedure del_partner_type_scan(p_id         in ins_partner_type_scans.id%type,
                                  p_apply_hier in number);

  -- Встановлення шаблону типу СД для СК-партнера
  function set_partner_type_template(p_id          in ins_partner_type_templates.id%type,
                                     p_template_id in ins_partner_type_templates.template_id%type,
                                     p_partner_id  in ins_partner_type_templates.partner_id%type,
                                     p_type_id     in ins_partner_type_templates.type_id%type,
                                     p_prt_format  in ins_partner_type_templates.prt_format%type)
    return ins_partner_type_templates.id%type;

  -- Видалення шаблону типу СД для СК-партнера
  procedure del_partner_type_template(p_id         in ins_partner_type_templates.id%type,
                                      p_apply_hier in number);

  -- Встановлення платежу по СД
  function set_deal_pmt(p_id        in ins_payments_schedule.id%type,
                        p_deal_id   in ins_payments_schedule.deal_id%type,
                        p_plan_date in ins_payments_schedule.plan_date%type,
                        p_plan_sum  in ins_payments_schedule.plan_sum%type)
    return ins_payments_schedule.id%type;

  -- Видалення платежу по СД
  procedure del_deal_pmt(p_id in ins_payments_schedule.id%type);

  -- Відмітка про сплату платежу по СД
  procedure pay_deal_pmt(p_id        in ins_payments_schedule.id%type,
                         p_fact_date in ins_payments_schedule.fact_date%type,
                         p_fact_sum  in ins_payments_schedule.fact_sum%type,
                         p_pmt_num   in ins_payments_schedule.pmt_num%type,
                         p_pmt_comm  in ins_payments_schedule.pmt_comm%type);

  -- Встановлення стутусу СД
  procedure set_status(p_deal_id     in ins_deals.id%type,
                       p_status_id   in ins_deals.status_id%type,
                       p_status_comm in ins_deals.status_comm%type default null);

  -- Створення СД
  function create_deal(p_partner_id  in ins_deals.partner_id%type,
                       p_type_id     in ins_deals.type_id%type,
                       p_ins_rnk     in ins_deals.ins_rnk%type,
                       p_ser         in ins_deals.ser%type,
                       p_num         in ins_deals.num%type,
                       p_sdate       in ins_deals.sdate%type,
                       p_edate       in ins_deals.edate%type,
                       p_sum         in ins_deals.sum%type,
                       p_sum_kv      in ins_deals.sum_kv%type default 980,
                       p_insu_tariff in ins_deals.insu_tariff%type,
                       p_insu_sum    in ins_deals.insu_sum%type,
                       p_object_type in ins_deals.object_type%type,
                       p_rnk         in ins_deals.rnk%type,
                       p_grt_id      in ins_deals.grt_id%type,
                       p_nd          in ins_deals.nd%type,
                       p_pay_freq    in ins_deals.pay_freq%type,
                       p_renew_need  in ins_deals.renew_need%type default 0)
    return ins_deals.id%type;

  -- Створення дод. угоды до СД
  function create_addagr(p_deal_id in ins_add_agreements.deal_id%type,
                         p_ser     in ins_add_agreements.ser%type,
                         p_num     in ins_add_agreements.num%type,
                         p_sdate   in ins_add_agreements.sdate%type)
    return ins_add_agreements.id%type;

  -- Додавання зміни до СД
  procedure set_addagr_params(p_deal_id         in ins_add_agreements.deal_id%type,
                              p_id              in ins_add_agreements.id%type,
                              p_new_edate       in date,
                              p_new_sum         in number,
                              p_new_sum_kv      in number,
                              p_new_insu_tariff in number,
                              p_new_insu_sum    in number);

  -- Додавання зміни до СД - зміна пл. графіку
  procedure set_addagr_pmt(p_deal_id   in ins_add_agreements.deal_id%type,
                           p_id        in ins_add_agreements.id%type,
                           p_pmt_id    in ins_payments_schedule.id%type,
                           p_action    in varchar2,
                           p_plan_date in ins_payments_schedule.plan_date%type,
                           p_plan_sum  in ins_payments_schedule.plan_sum%type);

  -- Коментар-зміни по дод. угоді
  function get_addagr_comm(p_id in ins_add_agreements.id%type)
    return varchar2;

  -- Оновлення СД
  procedure update_deal(p_deal_id     in ins_deals.id%type,
                        p_branch      in ins_deals.branch%type,
                        p_partner_id  in ins_deals.partner_id%type,
                        p_type_id     in ins_deals.type_id%type,
                        p_ins_rnk     in ins_deals.ins_rnk%type,
                        p_ser         in ins_deals.ser%type,
                        p_num         in ins_deals.num%type,
                        p_sdate       in ins_deals.sdate%type,
                        p_edate       in ins_deals.edate%type,
                        p_sum         in ins_deals.sum%type,
                        p_sum_kv      in ins_deals.sum_kv%type default 980,
                        p_insu_tariff in ins_deals.insu_tariff%type,
                        p_insu_sum    in ins_deals.insu_sum%type,
                        p_rnk         in ins_deals.rnk%type,
                        p_grt_id      in ins_deals.grt_id%type,
                        p_nd          in ins_deals.nd%type,
                        p_renew_need  in ins_deals.renew_need%type default 0);

  -- Завершення вводу даних СД
  procedure finish_datainput(p_deal_id     in ins_deals.id%type,
                             p_status_comm in ins_deals.status_comm%type default null);

  -- Повернення договору на довведення
  procedure back2manager(p_deal_id     in ins_deals.id%type,
                         p_status_comm in ins_deals.status_comm%type);

  -- Авторизація СД
  procedure visa_deal(p_deal_id     in ins_deals.id%type,
                      p_status_comm in ins_deals.status_comm%type default null);

  -- Сторнування СД
  procedure storno_deal(p_deal_id     in ins_deals.id%type,
                        p_status_comm in ins_deals.status_comm%type);

  -- Закриття СД
  procedure close_deal(p_deal_id     in ins_deals.id%type,
                       p_renew_newid in ins_deals.renew_newid%type default null,
                       p_status_comm in ins_deals.status_comm%type default null);

  -- Встановлення значення атрибуту СД - Строка
  procedure set_deal_attr_s(p_deal_id in ins_deal_attrs.deal_id%type,
                            p_attr_id in ins_deal_attrs.attr_id%type,
                            p_val     in varchar2);

  -- Встановлення значення атрибуту СД - Число
  procedure set_deal_attr_n(p_deal_id in ins_deal_attrs.deal_id%type,
                            p_attr_id in ins_deal_attrs.attr_id%type,
                            p_val     in number);

  -- Встановлення значення атрибуту СД - Дата
  procedure set_deal_attr_d(p_deal_id in ins_deal_attrs.deal_id%type,
                            p_attr_id in ins_deal_attrs.attr_id%type,
                            p_val     in date);

  -- Выдалення значення атрибуту СД
  procedure del_deal_attr(p_deal_id in ins_deal_attrs.deal_id%type,
                          p_attr_id in ins_deal_attrs.attr_id%type);

  -- Отримання значення атрибуту СД - Строка
  function get_deal_attr_s(p_deal_id in ins_deal_attrs.deal_id%type,
                           p_attr_id in ins_deal_attrs.attr_id%type)
    return varchar2;

  -- Отримання значення атрибуту СД - Число
  function get_deal_attr_n(p_deal_id in ins_deal_attrs.deal_id%type,
                           p_attr_id in ins_deal_attrs.attr_id%type)
    return number;

  -- Отримання значення атрибуту СД - Дата
  function get_deal_attr_d(p_deal_id in ins_deal_attrs.deal_id%type,
                           p_attr_id in ins_deal_attrs.attr_id%type)
    return date;

  -- Встановлення значення сканкопії СД
  procedure set_deal_scan(p_deal_id in ins_deal_scans.deal_id%type,
                          p_scan_id in ins_deal_scans.scan_id%type,
                          p_val     in ins_deal_scans.val%type);

  -- Выдалення значення сканкопії СД
  procedure del_deal_scan(p_deal_id in ins_deal_scans.deal_id%type,
                          p_scan_id in ins_deal_scans.scan_id%type);

  -- Отримання значення сканкопії СД
  function get_deal_scan(p_deal_id in ins_deal_attrs.deal_id%type,
                         p_scan_id in ins_deal_scans.scan_id%type)
    return blob;

  -- Побудова графіку платежів по СД
  procedure build_deal_pmts_schedule(p_deal_id in ins_payments_schedule.deal_id%type);

  -- Створення страхового випадку
  function create_accident(p_id          in ins_accidents.id%type,
                           p_deal_id     in ins_accidents.deal_id%type,
                           p_acdt_date   in ins_accidents.acdt_date%type,
                           p_comm        in ins_accidents.comm%type,
                           p_refund_sum  in ins_accidents.refund_sum%type,
                           p_refund_date in ins_accidents.refund_date%type)
    return ins_accidents.id%type;

  --Проверка наличия документов оплати
  procedure check_payment;

  --------------------------------------------------------------------------------
  -- set_w4_deal - запись договора БПК в справочник договоров со страховкой
  --
  -- @p_nd id договора залога
  --
  procedure set_w4_deal(p_nd in number);

    -- установка статуса договора БПК
  procedure set_w4_state(p_nd in number,
                         p_state_id in varchar2,
                         p_msg in varchar2 default null);

  -- запись запроса/ответа по договорам БПК
  procedure set_w4_req_res(p_nd in number,
                           p_value in clob,
                           p_key in number,
                           p_deal_id in varchar2 default null,
                           p_date_from in date default null,
                           p_date_to in date default null);

  -- запись внешнего ИД СК по договорам БПК
  procedure set_w4_ins_id(p_nd in number, p_ins_id in number, p_tmp_id in number);

  function get_ins_w4_deal(p_nd in number) return ins_w4_deals%rowtype;
  procedure ins_w4_deal_to_arc(p_ns_w4_deals in ins_w4_deals%rowtype);
end ins_pack;
/
CREATE OR REPLACE PACKAGE BODY BARS.INS_PACK is

  -- Private constant declarations
  g_body_version  constant varchar2(64) := 'version 3.1 25/10/2018';
  g_awk_body_defs constant varchar2(512) := '';
--3.0
--исправлены мелкие ошибки при создании договоров страхования (форматы дат и т.п.)
--обвернуты sequence для ммфо
--добавлен функционал " продуктовые пакеты"
--

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header ins_pack ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body ins_pack ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

  -- кол-во дней для оповещения
  function g_alertdays return number is
    l_res number;
  begin
    select nvl(to_number(min(p.val)), 3)
      into l_res
      from params p
     where p.par = 'INSADAYS';
    return l_res;
  end g_alertdays;

  -- ============= Методы ================

  -- Встановлення параметрів комісії
  procedure set_fee(p_fee_id     in ins_fees.id%type,
                    p_name       in ins_fees.name%type,
                    p_min_value  in ins_fees.min_value%type,
                    p_perc_value in ins_fees.perc_value%type,
                    p_max_value  in ins_fees.max_value%type) is
  begin
    update ins_fees f
       set f.name       = p_name,
           f.min_value  = p_min_value,
           f.perc_value = p_perc_value,
           f.max_value  = p_max_value
     where f.id = p_fee_id;

    if (sql%rowcount = 0) then
      insert into ins_fees
        (id, name, min_value, perc_value, max_value)
      values
        (p_fee_id, p_name, p_min_value, p_perc_value, p_max_value);
    end if;
  end set_fee;

  -- Видалення комісії
  procedure del_fee(p_fee_id in ins_fees.id%type) is
  begin
    for cur in (select * from ins_fee_periods fp where fp.fee_id = p_fee_id) loop
      del_fee_period(cur.fee_id, cur.period_id);
    end loop;

    delete from ins_fees f where f.id = p_fee_id;
  end del_fee;

  -- Встановлення параметрів комісії у розрізі періоду
  procedure set_fee_period(p_fee_id     in ins_fee_periods.fee_id%type,
                           p_period_id  in ins_fee_periods.period_id%type,
                           p_min_value  in ins_fee_periods.min_value%type,
                           p_perc_value in ins_fee_periods.perc_value%type,
                           p_max_value  in ins_fee_periods.max_value%type) is
  begin
    update ins_fee_periods fp
       set fp.min_value  = p_min_value,
           fp.perc_value = p_perc_value,
           fp.max_value  = p_max_value
     where fp.fee_id = p_fee_id
       and fp.period_id = p_period_id;

    if (sql%rowcount = 0) then
      insert into ins_fee_periods
        (fee_id, period_id, min_value, perc_value, max_value)
      values
        (p_fee_id, p_period_id, p_min_value, p_perc_value, p_max_value);
    end if;
  end set_fee_period;

  -- Видалення параметрів комісії у розрізі періоду
  procedure del_fee_period(p_fee_id    in ins_fee_periods.fee_id%type,
                           p_period_id in ins_fee_periods.period_id%type) is
  begin
    delete from ins_fee_periods fp
     where fp.fee_id = p_fee_id
       and fp.period_id = p_period_id;
  end del_fee_period;

  -- Встановлення параметрів тарифу
  procedure set_tariff(p_tariff_id in ins_tariffs.id%type,
                       p_name      in ins_tariffs.name%type,
                       p_min_value in ins_tariffs.min_value%type,
                       p_min_perc  in ins_tariffs.min_perc%type,
                       p_max_value in ins_tariffs.max_value%type,
                       p_max_perc  in ins_tariffs.max_perc%type,
                       p_amort     in ins_tariffs.amort%type) is
  begin
    update ins_tariffs t
       set t.name      = p_name,
           t.min_value = p_min_value,
           t.min_perc  = p_min_perc,
           t.max_value = p_max_value,
           t.max_perc  = p_max_perc,
           t.amort     = p_amort
     where t.id = p_tariff_id;

    if (sql%rowcount = 0) then
      insert into ins_tariffs
        (id, name, min_value, min_perc, max_value, max_perc, amort)
      values
        (p_tariff_id,
         p_name,
         p_min_value,
         p_min_perc,
         p_max_value,
         p_max_perc,
         p_amort);
    end if;
  end set_tariff;

  -- Видалення тарифу
  procedure del_tariff(p_tariff_id in ins_tariffs.id%type) is
  begin
    for cur in (select *
                  from ins_tariff_periods tp
                 where tp.tariff_id = p_tariff_id) loop
      del_tariff_period(cur.tariff_id, cur.period_id);
    end loop;

    delete from ins_tariffs t where t.id = p_tariff_id;
  end del_tariff;

  -- Встановлення параметрів тарифу у розрізі періоду
  procedure set_tariff_period(p_tariff_id in ins_tariff_periods.tariff_id%type,
                              p_period_id in ins_tariff_periods.period_id%type,
                              p_min_value in ins_tariff_periods.min_value%type,
                              p_min_perc  in ins_tariff_periods.min_perc%type,
                              p_max_value in ins_tariff_periods.max_value%type,
                              p_max_perc  in ins_tariff_periods.max_perc%type,
                              p_amort     in ins_tariff_periods.amort%type) is
  begin
    update ins_tariff_periods tp
       set tp.min_value = p_min_value,
           tp.min_perc  = p_min_perc,
           tp.max_value = p_max_value,
           tp.max_perc  = p_max_perc,
           tp.amort     = p_amort
     where tp.tariff_id = p_tariff_id
       and tp.period_id = p_period_id;

    if (sql%rowcount = 0) then
      insert into ins_tariff_periods
        (tariff_id,
         period_id,
         min_value,
         min_perc,
         max_value,
         max_perc,
         amort)
      values
        (p_tariff_id,
         p_period_id,
         p_min_value,
         p_min_perc,
         p_max_value,
         p_max_perc,
         p_amort);
    end if;
  end set_tariff_period;

  -- Видалення параметрів тарифу у розрізі періоду
  procedure del_tariff_period(p_tariff_id in ins_tariff_periods.tariff_id%type,
                              p_period_id in ins_tariff_periods.period_id%type) is
  begin
    delete from ins_tariff_periods tp
     where tp.tariff_id = p_tariff_id
       and tp.period_id = p_period_id;
  end del_tariff_period;

  -- Встановлення параметрів ліміту
  procedure set_limit(p_limit_id   in ins_limits.id%type,
                      p_name       in ins_limits.name%type,
                      p_sum_value  in ins_limits.sum_value%type,
                      p_perc_value in ins_limits.perc_value%type) is
  begin
    update ins_limits l
       set l.name       = p_name,
           l.sum_value  = p_sum_value,
           l.perc_value = p_perc_value
     where l.id = p_limit_id;

    if (sql%rowcount = 0) then
      insert into ins_limits
        (id, name, sum_value, perc_value)
      values
        (p_limit_id, p_name, p_sum_value, p_perc_value);
    end if;
  end set_limit;

  -- Видалення ліміту
  procedure del_limit(p_limit_id in ins_limits.id%type) is
  begin
    delete from ins_limits l where l.id = p_limit_id;
  end del_limit;

  -- Встановлення параметрів атрибуту
  procedure set_attr(p_attr_id in ins_attrs.id%type,
                     p_name    in ins_attrs.name%type,
                     p_type_id in ins_attrs.type_id%type) is
  begin
    update ins_attrs a
       set a.name = p_name, a.type_id = p_type_id
     where a.id = p_attr_id;

    if (sql%rowcount = 0) then
      insert into ins_attrs
        (id, name, type_id)
      values
        (p_attr_id, p_name, p_type_id);
    end if;
  end set_attr;

  -- Видалення атрибуту
  procedure del_attr(p_attr_id in ins_attrs.id%type) is
  begin
    delete from ins_attrs a where a.id = p_attr_id;
  end del_attr;

  -- Встановлення параметрів сканкопії
  procedure set_scan(p_scan_id in ins_scans.id%type,
                     p_name    in ins_scans.name%type) is
  begin
    update ins_scans s set s.name = p_name where s.id = p_scan_id;

    if (sql%rowcount = 0) then
      insert into ins_scans (id, name) values (p_scan_id, p_name);
    end if;
  end set_scan;

  -- Видалення сканкопії
  procedure del_scan(p_scan_id in ins_scans.id%type) is
  begin
    delete from ins_attrs s where s.id = p_scan_id;
  end del_scan;

  -- Встановлення параметрів СК-партнера
  function set_partner(p_partner_id in ins_partners.id%type,
                       p_name       in ins_partners.name%type,
                       p_rnk        in ins_partners.rnk%type,
                       p_agr_no     in ins_partners.agr_no%type,
                       p_agr_sdate  in ins_partners.agr_sdate%type,
                       p_agr_edate  in ins_partners.agr_edate%type,
                       p_tariff_id  in ins_partners.tariff_id%type,
                       p_fee_id     in ins_partners.fee_id%type,
                       p_limit_id   in ins_partners.limit_id%type,
                       p_active     in ins_partners.active%type,
                       p_custid     in ins_partners.custtype%type)
    return ins_partners.id%type is
    l_partner_id ins_partners.id%type := p_partner_id;
  begin
    update ins_partners p
       set p.name      = p_name,
           p.rnk       = p_rnk,
           p.agr_no    = p_agr_no,
           p.agr_sdate = p_agr_sdate,
           p.agr_edate = p_agr_edate,
           p.tariff_id = p_tariff_id,
           p.fee_id    = p_fee_id,
           p.limit_id  = p_limit_id,
           p.active    = p_active,
           p.custtype  = p_custid
     where p.id = l_partner_id;


    if (sql%rowcount = 0) then

      -- получение нового ID
      select nvl(l_partner_id, bars_sqnc.get_nextval('s_inspartners'))
        into l_partner_id
        from dual;

      insert into ins_partners
        (id,
         name,
         rnk,
         agr_no,
         agr_sdate,
         agr_edate,
         tariff_id,
         fee_id,
         limit_id,
         active,
         custtype)
      values
        (l_partner_id,
         p_name,
         p_rnk,
         p_agr_no,
         p_agr_sdate,
         p_agr_edate,
         p_tariff_id,
         p_fee_id,
         p_limit_id,
         p_active,
         p_custid)
      returning id into l_partner_id;
    end if;

    return l_partner_id;
  end set_partner;

  -- Видалення СК-партнера (у разі наявності залежних обїектів - помилка)
  procedure del_partner(p_partner_id in ins_partners.id%type) is
    l_has_deals number := 0;
  begin
    -- шукаємо угоди
    select count(1)
      into l_has_deals
      from ins_deals d
     where d.partner_id = p_partner_id;

    if (l_has_deals > 0) then
      -- Неможливо видалити СК, знайдено залежні угоди
      bars_error.raise_nerror(g_modcode, 'CNNT_DEL_PARTNER');
    end if;

    -- поочередно удаляем зависимые объекты
    for cur in (select *
                  from ins_partner_type_attrs pta
                 where pta.partner_id = p_partner_id) loop
      del_partner_type_attr(cur.id, 1);
    end loop;

    for cur in (select *
                  from ins_partner_type_branches ptb
                 where ptb.partner_id = p_partner_id) loop
      del_partner_type_branch(cur.id, 1);
    end loop;

    for cur in (select *
                  from ins_partner_type_products ptp
                 where ptp.partner_id = p_partner_id) loop
      del_partner_type_product(cur.id, 1);
    end loop;

    for cur in (select *
                  from ins_partner_type_scans pts
                 where pts.partner_id = p_partner_id) loop
      del_partner_type_scan(cur.id, 1);
    end loop;

    for cur in (select *
                  from ins_partner_type_templates ptt
                 where ptt.partner_id = p_partner_id) loop
      del_partner_type_template(cur.id, 1);
    end loop;
    for cur in (select *
                  from ins_partner_branch_rnk pbr
                 where pbr.partner_id = p_partner_id) loop
    del_partner_branch_rnk(cur.partner_id, cur.branch);
    end loop;

    -- удаляем типы
    for cur in (select *
                  from ins_partner_types pt
                 where pt.partner_id = p_partner_id) loop
      del_partner_type(cur.partner_id, cur.type_id);
    end loop;

    -- удаляем СК
    delete from ins_partners p where p.id = p_partner_id;
  end del_partner;

  -- Встановлення РНК СК у відділеннях
  procedure set_partner_branch_rnk(p_partner_id in ins_partner_branch_rnk.partner_id%type,
                                   p_branch     in ins_partner_branch_rnk.branch%type,
                                   p_rnk        in ins_partner_branch_rnk.rnk%type) is
  begin
    -- обновляем или вставляем
    update ins_partner_branch_rnk pbr
       set pbr.rnk = p_rnk
     where pbr.partner_id = p_partner_id
       and pbr.branch = p_branch;

    if (sql%rowcount = 0) then
      insert into ins_partner_branch_rnk
        (partner_id, branch, rnk)
      values
        (p_partner_id, p_branch, p_rnk);
    end if;
  end set_partner_branch_rnk;

  -- Видалення РНК СК у відділеннях
  procedure del_partner_branch_rnk(p_partner_id in ins_partner_branch_rnk.partner_id%type,
                                   p_branch     in ins_partner_branch_rnk.branch%type) is
  begin
    delete from ins_partner_branch_rnk pbr
     where pbr.partner_id = p_partner_id
       and pbr.branch = p_branch;
  end del_partner_branch_rnk;

  -- Встановлення параметрів типу СД для СК-партнера
  procedure set_partner_type(p_partner_id in ins_partner_types.partner_id%type,
                             p_type_id    in ins_partner_types.type_id%type,
                             p_tariff_id  in ins_partner_types.tariff_id%type,
                             p_fee_id     in ins_partner_types.fee_id%type,
                             p_limit_id   in ins_partner_types.limit_id%type,
                             p_active     in ins_partner_types.active%type) is
  begin
    update ins_partner_types pt
       set pt.tariff_id = p_tariff_id,
           pt.fee_id    = p_fee_id,
           pt.limit_id  = p_limit_id,
           pt.active    = p_active
     where pt.partner_id = p_partner_id
       and pt.type_id = p_type_id;

    if (sql%rowcount = 0) then
      insert into ins_partner_types
        (partner_id, type_id, tariff_id, fee_id, limit_id, active)
      values
        (p_partner_id,
         p_type_id,
         p_tariff_id,
         p_fee_id,
         p_limit_id,
         p_active);
    end if;
  end set_partner_type;

  -- Видалення типу СД для СК-партнера (у разі наявності залежних обїектів - помилка)
  procedure del_partner_type(p_partner_id in ins_partner_types.partner_id%type,
                             p_type_id    in ins_partner_types.type_id%type) is
    l_has_deals number := 0;
  begin
    -- шукаємо угоди
    select count(1)
      into l_has_deals
      from ins_deals d
     where d.partner_id = p_partner_id
       and d.type_id = p_type_id;

    if (l_has_deals > 0) then
      -- Неможливо видалити тип СК, знайдено залежні угоди
      bars_error.raise_nerror(g_modcode, 'CNNT_DEL_PARTNER_TYPE');
    end if;

    -- видаляемо запис
    delete from ins_partner_types pt
     where pt.partner_id = p_partner_id
       and pt.type_id = p_type_id;
  end del_partner_type;

  -- Встановлення атрибуту типу СД для СК-партнера
  function set_partner_type_attr(p_id          in ins_partner_type_attrs.id%type,
                                 p_attr_id     in ins_partner_type_attrs.attr_id%type,
                                 p_partner_id  in ins_partner_type_attrs.partner_id%type,
                                 p_type_id     in ins_partner_type_attrs.type_id%type,
                                 p_is_required in ins_partner_type_attrs.is_required%type)
    return ins_partner_type_attrs.id%type is
    l_id ins_partner_type_attrs.id%type := p_id;
  begin
    update ins_partner_type_attrs pta
       set pta.attr_id     = p_attr_id,
           pta.partner_id  = p_partner_id,
           pta.type_id     = p_type_id,
           pta.is_required = p_is_required
     where pta.id = l_id;

    if (sql%rowcount = 0) then
      insert into ins_partner_type_attrs
        (id, attr_id, partner_id, type_id, is_required)
      values
        (bars_sqnc.get_nextval('s_ptntypeattrs'),
         p_attr_id,
         p_partner_id,
         p_type_id,
         p_is_required)
      returning id into l_id;
    end if;

    return l_id;
  end set_partner_type_attr;

  -- Видалення атрибуту типу СД для СК-партнера
  procedure del_partner_type_attr(p_id         in ins_partner_type_attrs.id%type,
                                  p_apply_hier in number) is
  begin
    if (p_apply_hier = 1) then
      -- удаляем со всеми подчиненными
      delete from ins_partner_type_attrs pta
       where (pta.attr_id, pta.partner_id, pta.type_id) in
             (select pta0.attr_id,
                     nvl(pta0.partner_id, pta.partner_id),
                     nvl(pta0.type_id, pta.type_id)
                from ins_partner_type_attrs pta0
               where pta0.id = p_id);
    else
      delete from ins_partner_type_attrs pta where pta.id = p_id;
    end if;
  end del_partner_type_attr;

  -- Встановлення доступності у відділенні типу СД для СК-партнера
  function set_partner_type_branch(p_id         in ins_partner_type_branches.id%type,
                                   p_branch     in ins_partner_type_branches.branch%type,
                                   p_partner_id in ins_partner_type_branches.partner_id%type,
                                   p_type_id    in ins_partner_type_branches.type_id%type,
                                   p_tariff_id  in ins_partner_type_branches.tariff_id%type,
                                   p_fee_id     in ins_partner_type_branches.fee_id%type,
                                   p_limit_id   in ins_partner_type_branches.limit_id%type,
                                   p_apply_hier in ins_partner_type_branches.apply_hier%type)
    return ins_partner_type_branches.id%type is
    l_id ins_partner_type_branches.id%type := p_id;
  begin
    select nvl(min(ptb.id), p_id)
      into l_id
      from ins_partner_type_branches ptb
     where ptb.branch = p_branch
       and nvl(ptb.partner_id, -1) = nvl(p_partner_id, -1)
       and nvl(ptb.type_id, -1) = nvl(p_type_id, -1);

    update ins_partner_type_branches ptb
       set ptb.branch     = p_branch,
           ptb.partner_id = p_partner_id,
           ptb.type_id    = p_type_id,
           ptb.tariff_id  = p_tariff_id,
           ptb.fee_id     = p_fee_id,
           ptb.limit_id   = p_limit_id,
           ptb.apply_hier = p_apply_hier
     where ptb.id = l_id;

    if (sql%rowcount = 0) then
      insert into ins_partner_type_branches
        (id,
         branch,
         partner_id,
         type_id,
         tariff_id,
         fee_id,
         limit_id,
         apply_hier)
      values
        (bars_sqnc.get_nextval('s_ptntypebrhs'),
         p_branch,
         p_partner_id,
         p_type_id,
         p_tariff_id,
         p_fee_id,
         p_limit_id,
         p_apply_hier)
      returning id into l_id;
    end if;

    return l_id;
  end set_partner_type_branch;

  -- Видалення доступності у відділенні типу СД для СК-партнера
  procedure del_partner_type_branch(p_id         in ins_partner_type_branches.id%type,
                                    p_apply_hier in number) is
  begin
    if (p_apply_hier = 1) then
      -- удаляем со всеми подчиненными
      delete from ins_partner_type_branches ptb
       where (ptb.branch, ptb.partner_id, ptb.type_id) in
             (select ptb0.branch,
                     nvl(ptb0.partner_id, ptb.partner_id),
                     nvl(ptb0.type_id, ptb.type_id)
                from ins_partner_type_branches ptb0
               where ptb0.id = p_id);
    else
      delete from ins_partner_type_branches ptb where ptb.id = p_id;
    end if;
  end del_partner_type_branch;

  -- Встановлення доступності у продукті типу СД для СК-партнера
  function set_partner_type_product(p_id         in ins_partner_type_products.id%type,
                                    p_product_id in ins_partner_type_products.product_id%type,
                                    p_partner_id in ins_partner_type_products.partner_id%type,
                                    p_type_id    in ins_partner_type_products.type_id%type)
    return ins_partner_type_products.id%type is
    l_id ins_partner_type_products.id%type := p_id;
  begin
    update ins_partner_type_products ptp
       set ptp.product_id = p_product_id,
           ptp.partner_id = p_partner_id,
           ptp.type_id    = p_type_id
     where ptp.id = l_id;

    if (sql%rowcount = 0) then
      insert into ins_partner_type_products
        (id, product_id, partner_id, type_id)
      values
        (bars_sqnc.get_nextval('s_ptntypeprds'), p_product_id, p_partner_id, p_type_id)
      returning id into l_id;
    end if;

    return l_id;
  end set_partner_type_product;

  -- Видалення доступності у продукті типу СД для СК-партнера
  procedure del_partner_type_product(p_id         in ins_partner_type_products.id%type,
                                     p_apply_hier in number) is
  begin
    if (p_apply_hier = 1) then
      -- удаляем со всеми подчиненными
      delete from ins_partner_type_products ptp
       where (ptp.product_id, ptp.partner_id, ptp.type_id) in
             (select ptp0.product_id,
                     nvl(ptp0.partner_id, ptp.partner_id),
                     nvl(ptp0.type_id, ptp.type_id)
                from ins_partner_type_products ptp0
               where ptp0.id = p_id);
    else
      delete from ins_partner_type_products ptp where ptp.id = p_id;
    end if;
  end del_partner_type_product;

  -- Встановлення сканкопії типу СД для СК-партнера
  function set_partner_type_scan(p_id          in ins_partner_type_scans.id%type,
                                 p_scan_id     in ins_partner_type_scans.scan_id%type,
                                 p_partner_id  in ins_partner_type_scans.partner_id%type,
                                 p_type_id     in ins_partner_type_scans.type_id%type,
                                 p_is_required in ins_partner_type_scans.is_required%type)
    return ins_partner_type_scans.id%type is
    l_id ins_partner_type_scans.id%type := p_id;
  begin
    update ins_partner_type_scans pts
       set pts.scan_id     = p_scan_id,
           pts.partner_id  = p_partner_id,
           pts.type_id     = p_type_id,
           pts.is_required = p_is_required
     where pts.id = l_id;

    if (sql%rowcount = 0) then
      insert into ins_partner_type_scans
        (id, scan_id, partner_id, type_id, is_required)
      values
        (bars_sqnc.get_nextval('s_ptntypescns'),
         p_scan_id,
         p_partner_id,
         p_type_id,
         p_is_required)
      returning id into l_id;
    end if;

    return l_id;
  end set_partner_type_scan;

  -- Видалення сканкопії типу СД для СК-партнера
  procedure del_partner_type_scan(p_id         in ins_partner_type_scans.id%type,
                                  p_apply_hier in number) is
  begin
    if (p_apply_hier = 1) then
      -- удаляем со всеми подчиненными
      delete from ins_partner_type_scans pts
       where (pts.scan_id, pts.partner_id, pts.type_id) in
             (select pts0.scan_id,
                     nvl(pts0.partner_id, pts.partner_id),
                     nvl(pts0.type_id, pts.type_id)
                from ins_partner_type_scans pts0
               where pts0.id = p_id);
    else
      delete from ins_partner_type_scans pts where pts.id = p_id;
    end if;
  end del_partner_type_scan;

  -- Встановлення шаблону типу СД для СК-партнера
  function set_partner_type_template(p_id          in ins_partner_type_templates.id%type,
                                     p_template_id in ins_partner_type_templates.template_id%type,
                                     p_partner_id  in ins_partner_type_templates.partner_id%type,
                                     p_type_id     in ins_partner_type_templates.type_id%type,
                                     p_prt_format  in ins_partner_type_templates.prt_format%type)
    return ins_partner_type_templates.id%type is
    l_id ins_partner_type_templates.id%type := p_id;
  begin
    update ins_partner_type_templates ptt
       set ptt.template_id = p_template_id,
           ptt.partner_id  = p_partner_id,
           ptt.type_id     = p_type_id,
           ptt.prt_format  = p_prt_format
     where ptt.id = l_id;

    if (sql%rowcount = 0) then
      insert into ins_partner_type_templates
        (id, template_id, partner_id, type_id, prt_format)
      values
        (bars_sqnc.get_nextval('s_ptntypetpls'),
         p_template_id,
         p_partner_id,
         p_type_id,
         p_prt_format)
      returning id into l_id;
    end if;

    return l_id;
  end set_partner_type_template;

  -- Видалення шаблону типу СД для СК-партнера
  procedure del_partner_type_template(p_id         in ins_partner_type_templates.id%type,
                                      p_apply_hier in number) is
  begin
    if (p_apply_hier = 1) then
      -- удаляем со всеми подчиненными
      delete from ins_partner_type_templates ptt
       where (ptt.template_id, ptt.partner_id, ptt.type_id) in
             (select ptt0.template_id,
                     nvl(ptt0.partner_id, ptt.partner_id),
                     nvl(ptt0.type_id, ptt.type_id)
                from ins_partner_type_templates ptt0
               where ptt0.id = p_id);
    else
      delete from ins_partner_type_templates ptt where ptt.id = p_id;
    end if;
  end del_partner_type_template;

  -- Встановлення платежу по СД
  function set_deal_pmt(p_id        in ins_payments_schedule.id%type,
                        p_deal_id   in ins_payments_schedule.deal_id%type,
                        p_plan_date in ins_payments_schedule.plan_date%type,
                        p_plan_sum  in ins_payments_schedule.plan_sum%type)
    return ins_payments_schedule.id%type is
    l_th constant varchar2(100) := g_dbgcode || 'set_deal_pmt';
    l_id ins_payments_schedule.id%type := p_id;
  begin
    -- обеспечиваем уникальность по номеру договора и дате
    begin
      select ps.id
        into l_id
        from ins_payments_schedule ps
       where ps.deal_id = p_deal_id
         and ps.plan_date = p_plan_date;
    exception
      when no_data_found then
        null;
    end;

    update ins_payments_schedule ps
       set ps.deal_id   = p_deal_id,
           ps.plan_date = p_plan_date,
           ps.plan_sum  = p_plan_sum
     where ps.id = l_id;

    if (sql%rowcount = 0) then
      insert into ins_payments_schedule
        (id, deal_id, plan_date, plan_sum)
      values
        (bars_sqnc.get_nextval('s_inspsch'), p_deal_id, p_plan_date, p_plan_sum)
      returning id into l_id;
    end if;

    bars_audit.info(l_th || ' Користувач встановив платіж №' || p_id ||
                    ' у графіку платежів СД №' || p_deal_id);

    return l_id;
  end set_deal_pmt;

  -- Видалення платежу по СД
  procedure del_deal_pmt(p_id in ins_payments_schedule.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'del_deal_pmt';
  begin
    delete from ins_payments_schedule ps where ps.id = p_id;

    bars_audit.info(l_th || ' Користувач видалив платіж №' || p_id ||
                    ' у графіку платежів СД');
  end del_deal_pmt;

  -- Відмітка про сплату платежу по СД
  procedure pay_deal_pmt(p_id        in ins_payments_schedule.id%type,
                         p_fact_date in ins_payments_schedule.fact_date%type,
                         p_fact_sum  in ins_payments_schedule.fact_sum%type,
                         p_pmt_num   in ins_payments_schedule.pmt_num%type,
                         p_pmt_comm  in ins_payments_schedule.pmt_comm%type) is
    l_th constant varchar2(100) := g_dbgcode || 'pay_deal_pmt';
  begin
    update ins_payments_schedule ps
       set ps.fact_date = p_fact_date,
           ps.fact_sum  = p_fact_sum,
           ps.pmt_num   = p_pmt_num,
           ps.pmt_comm  = p_pmt_comm,
           ps.payed     = 1
     where ps.id = p_id;

    bars_audit.info(l_th || ' Користувач відмітив платіж №' || p_id ||
                    ' у графіку платежів СД як сплачений');
  end pay_deal_pmt;

  -- Побудова графіку платежів по СД
  procedure build_deal_pmts_schedule(p_deal_id in ins_payments_schedule.deal_id%type) is
    l_d_row ins_deals%rowtype;

    l_total_sum number;
    l_pmt_sum   number;

    l_months number;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;

    -- определяем размер страховой премии
    if (l_d_row.insu_tariff is not null) then
      l_total_sum := l_d_row.sum * l_d_row.insu_tariff / 100;/* *
                     months_between(l_d_row.edate, l_d_row.sdate) / 12;*/
    else
      l_total_sum := l_d_row.insu_sum;
    end if;

    -- определяем шаг для построения графика
    case l_d_row.pay_freq
      when 5 then
        -- Щомісячно
        l_months := 1;
      when 7 then
        -- Щоквартально
        l_months := 3;
      when 180 then
        -- Раз на півроку
        l_months := 6;
      when 360 then
        -- Раз на рік
        l_months := 12;
      when 120 then
        -- Раз на 4 місяці
        l_months := 4;
      when 390 then
        -- Раз на рік та місяць
        l_months := 13;
      when 420 then
        -- Раз на рік та 2 місяці
        l_months := 14;
      when 540 then
        -- Раз на півтора року
        l_months := 12;
      else
        l_months := 12;
    end case;

    -- считаем сумму разового платежа
    declare
      l_cnt      number := 1;
      l_tmp_date date := add_months(l_d_row.sdate, l_months);
    begin
      while (l_tmp_date < l_d_row.edate) loop
        l_cnt      := l_cnt + 1;
        l_tmp_date := add_months(l_tmp_date, l_months);
      end loop;

      l_pmt_sum := round(l_total_sum / l_cnt, 2);
    end;

    -- создаем плановые платежи
    declare
      l_tmp_date date ;--:= to_date(lpad(extract(DAY from l_d_row.edate),2,'0')||to_char(l_d_row.sdate,'mmyyyy'),'dd.mm.yyyy');--l_d_row.sdate;
      l_id       ins_payments_schedule.id%type;
    begin
      if to_number(substr(l_d_row.edate,1,2))>to_number(substr(last_day(l_d_row.sdate),1,2))
        then l_tmp_date:=last_day(l_d_row.sdate);
        else l_tmp_date:=to_date(lpad(extract(DAY from l_d_row.edate),2,'0')||to_char(l_d_row.sdate,'mmyyyy'),'dd.mm.yyyy');
      end if;
      while (l_tmp_date < l_d_row.edate) loop
        l_id       := set_deal_pmt(null, p_deal_id, l_tmp_date, l_pmt_sum);
        l_tmp_date := add_months(l_tmp_date, l_months);
      end loop;
    end;
  end build_deal_pmts_schedule;

  -- Валідація параметрів СД
  procedure validate_deal_data(p_deal_id in ins_deals.id%type) is
  begin
    -- !!! Всякие проверки !!!
    null;
  end validate_deal_data;

  -- Встановлення стутусу СД
  procedure set_status(p_deal_id     in ins_deals.id%type,
                       p_status_id   in ins_deals.status_id%type,
                       p_status_comm in ins_deals.status_comm%type default null) is
  begin
    update ins_deals d
       set d.status_id   = p_status_id,
           d.status_date = sysdate,
           d.status_comm = p_status_comm
     where d.id = p_deal_id;

    insert into ins_deal_sts_history
      (id, deal_id, status_id, set_date, comm, staff_id)
      select bars_sqnc.get_nextval('s_insdstshistory'),
             p_deal_id,
             p_status_id,
             sysdate,
             p_status_comm,
             sys_context('bars_global', 'user_id')
        from dual;
  end set_status;

  -- Створення СД
  function create_deal(p_partner_id  in ins_deals.partner_id%type,
                       p_type_id     in ins_deals.type_id%type,
                       p_ins_rnk     in ins_deals.ins_rnk%type,
                       p_ser         in ins_deals.ser%type,
                       p_num         in ins_deals.num%type,
                       p_sdate       in ins_deals.sdate%type,
                       p_edate       in ins_deals.edate%type,
                       p_sum         in ins_deals.sum%type,
                       p_sum_kv      in ins_deals.sum_kv%type default 980,
                       p_insu_tariff in ins_deals.insu_tariff%type,
                       p_insu_sum    in ins_deals.insu_sum%type,
                       p_object_type in ins_deals.object_type%type,
                       p_rnk         in ins_deals.rnk%type,
                       p_grt_id      in ins_deals.grt_id%type,
                       p_nd          in ins_deals.nd%type,
                       p_pay_freq    in ins_deals.pay_freq%type,
                       p_renew_need  in ins_deals.renew_need%type default 0)
    return ins_deals.id%type is
    l_th constant varchar2(100) := g_dbgcode || 'create_deal';

    l_deal_id ins_deals.id%type;

    l_branch   ins_deals.branch%type := sys_context('bars_context',
                                                    'user_branch');
    l_staff_id ins_deals.staff_id%type := user_id;
    l_crt_date ins_deals.crt_date%type := sysdate;
  begin
    insert into ins_deals
      (id,
       branch,
       staff_id,
       crt_date,
       partner_id,
       type_id,
       ins_rnk,
       ser,
       num,
       sdate,
       edate,
       sum,
       sum_kv,
       insu_tariff,
       insu_sum,
       object_type,
       rnk,
       grt_id,
       nd,
       pay_freq,
       renew_need)
    values
      (bars_sqnc.get_nextval('s_insdeals'),
       l_branch,
       l_staff_id,
       l_crt_date,
       p_partner_id,
       p_type_id,
       p_ins_rnk,
       p_ser,
       p_num,
       p_sdate,
       p_edate,
       p_sum,
       p_sum_kv,
       p_insu_tariff,
       p_insu_sum,
       p_object_type,
       p_rnk,
       p_grt_id,
       p_nd,
       p_pay_freq,
       p_renew_need)
    returning id into l_deal_id;

    set_status(l_deal_id, 'NEW');

    if p_insu_tariff != 0 or p_insu_sum != 0 then
      build_deal_pmts_schedule(l_deal_id);
    end if;

    bars_audit.info(l_th || ' Користувач створив договір страхування №' ||
                    l_deal_id);

    return l_deal_id;
  exception
    when others then
      bars_audit.info(g_modcode||'.create_deal error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
      raise_application_error(-20001, 'Помилка створення СД '||chr(10)||sqlerrm);
  end create_deal;

  -- Визначення чи є зміни у дод. угоді (0/1)
  function is_addagr_empty(p_id in ins_add_agreements.id%type) return number is
    l_xml xmltype;
  begin
    -- берем текущий XML изменений
    select aa.changes
      into l_xml
      from ins_add_agreements aa
     where aa.id = p_id;

    -- основные параметры
    if (l_xml.existsNode('//param') = 0 and
       l_xml.existsNode('//pmts_schedule/pmt') = 0) then
      return 1;
    else
      return 0;
    end if;
  end is_addagr_empty;

  -- Створення дод. угоды до СД
  function create_addagr(p_deal_id in ins_add_agreements.deal_id%type,
                         p_ser     in ins_add_agreements.ser%type,
                         p_num     in ins_add_agreements.num%type,
                         p_sdate   in ins_add_agreements.sdate%type)
    return ins_add_agreements.id%type is
    l_th constant varchar2(100) := g_dbgcode || 'create_addagr';

    l_id ins_add_agreements.id%type;

    l_branch   ins_add_agreements.branch%type := sys_context('bars_context',
                                                             'user_branch');
    l_staff_id ins_add_agreements.staff_id%type := user_id;
    l_crt_date ins_add_agreements.crt_date%type := sysdate;

    l_empty_xml xmltype := xmltype('<?xml version="1.0"?><changes><pmts_schedule></pmts_schedule></changes>');
  begin
    -- проверяем не заведено ли такое ДС
    select aa.id
      into l_id
      from ins_add_agreements aa
     where aa.deal_id = p_deal_id
       and nvl(aa.ser, 'NONE') = nvl(p_ser, 'NONE')
       and aa.num = p_num
       and aa.sdate = p_sdate;

    return l_id;
  exception
    when no_data_found then
      insert into ins_add_agreements
        (id, deal_id, branch, staff_id, crt_date, ser, num, sdate, changes)
      values
        (bars_sqnc.get_nextval('s_insaddagrs'),
         p_deal_id,
         l_branch,
         l_staff_id,
         l_crt_date,
         p_ser,
         p_num,
         p_sdate,
         l_empty_xml)
      returning id into l_id;

      bars_audit.info(l_th || ' Користувач створив дод. угоду ід. ' || l_id);

      return l_id;
  end create_addagr;

  -- Видалення дод. угоды до СД
  procedure del_addagr(p_id in ins_add_agreements.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'create_addagr';
  begin
    delete from ins_add_agreements aa where aa.id = p_id;
  end del_addagr;

  -- Додавання зміни до СД
  procedure set_addagr_params(p_deal_id         in ins_add_agreements.deal_id%type,
                              p_id              in ins_add_agreements.id%type,
                              p_new_edate       in date,
                              p_new_sum         in number,
                              p_new_sum_kv      in number,
                              p_new_insu_tariff in number,
                              p_new_insu_sum    in number) is
    l_th constant varchar2(100) := g_dbgcode || 'set_addagr_params';

    l_d_row ins_deals%rowtype;

    procedure set_param(p_name in varchar2,
                        p_old  in varchar2,
                        p_new  in varchar2) is
      l_th constant varchar2(100) := g_dbgcode || 'set_addagr_param';

      l_xml xmltype;
    begin
      -- берем текущий XML изменений
      select aa.changes
        into l_xml
        from ins_add_agreements aa
       where aa.id = p_id;

      -- проверяем есть ли такой параметр
      if (l_xml.existsNode('//param[@name="' || p_name || '"]') = 1) then
        select updateXml(l_xml,
                         '//param[@name="' || p_name || '"]/@new',
                         p_new)
          into l_xml
          from dual;
      else
        select insertChildXml(l_xml,
                              '//changes',
                              'param',
                              xmltype('<param name="' || p_name || '" old="' ||
                                      p_old || '" new="' || p_new || '" />'))
          into l_xml
          from dual;
      end if;

      -- вставляем обновленный XML
      update ins_add_agreements aa
         set aa.changes = l_xml
       where aa.id = p_id;
    end set_param;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;

    -- смотрим было ли изменение параметра
    if (l_d_row.edate != p_new_edate) then
      set_param('EDATE',
                to_char(l_d_row.edate, g_date_format),
                to_char(p_new_edate, g_date_format));
    end if;
    if (l_d_row.sum != p_new_sum) then
      set_param('SUM',
                to_char(l_d_row.sum, g_number_format, g_number_nlsparam),
                to_char(p_new_sum, g_number_format, g_number_nlsparam));
    end if;
    if (l_d_row.sum_kv != p_new_sum_kv) then
      set_param('SUM_KV',
                to_char(l_d_row.sum_kv, g_number_format, g_number_nlsparam),
                to_char(p_new_sum_kv, g_number_format, g_number_nlsparam));
    end if;
    if (l_d_row.insu_tariff != p_new_insu_tariff) then
      set_param('INSU_TARIFF',
                to_char(l_d_row.insu_tariff,
                        g_number_format,
                        g_number_nlsparam),
                to_char(p_new_insu_tariff,
                        g_number_format,
                        g_number_nlsparam));
    end if;
    if (l_d_row.insu_sum != p_new_insu_sum) then
      set_param('INSU_SUM',
                to_char(l_d_row.insu_sum,
                        g_number_format,
                        g_number_nlsparam),
                to_char(p_new_insu_sum, g_number_format, g_number_nlsparam));
    end if;
  end set_addagr_params;

  -- Додавання зміни до СД - зміна пл. графіку
  procedure set_addagr_pmt(p_deal_id   in ins_add_agreements.deal_id%type,
                           p_id        in ins_add_agreements.id%type,
                           p_pmt_id    in ins_payments_schedule.id%type,
                           p_action    in varchar2,
                           p_plan_date in ins_payments_schedule.plan_date%type,
                           p_plan_sum  in ins_payments_schedule.plan_sum%type) is
    l_th constant varchar2(100) := g_dbgcode || 'set_addagr_pmt';

    l_pmt_id ins_payments_schedule.id%type := p_pmt_id;
    l_ps_row ins_payments_schedule%rowtype;

    procedure set_pmt(p_id       in ins_add_agreements.id%type,
                      p_pmt_id   in ins_payments_schedule.id%type,
                      p_action   in varchar2,
                      p_old_date in ins_payments_schedule.plan_date%type,
                      p_old_sum  in ins_payments_schedule.plan_sum%type,
                      p_new_date in ins_payments_schedule.plan_date%type,
                      p_new_sum  in ins_payments_schedule.plan_sum%type) is
      l_th constant varchar2(100) := g_dbgcode || 'set_pmt';

      l_xml     xmltype;
      l_pmt_xml xmltype := xmltype('<pmt id="' || p_pmt_id || '" action="' ||
                                   p_action || '" old_date="' ||
                                   to_char(p_old_date, g_date_format) ||
                                   '" old_sum="' ||
                                   to_char(p_old_sum,
                                           g_number_format,
                                           g_number_nlsparam) ||
                                   '" new_date="' ||
                                   to_char(p_new_date, g_date_format) ||
                                   '" new_sum="' ||
                                   to_char(p_new_sum,
                                           g_number_format,
                                           g_number_nlsparam) || '" />');
    begin
      -- берем текущий XML изменений
      select aa.changes
        into l_xml
        from ins_add_agreements aa
       where aa.id = p_id;

      -- проверяем есть ли платеж
      if (l_xml.existsNode('//pmts_schedule/pmt[@id="' || p_pmt_id || '"]') = 1) then
        select updateXml(l_xml,
                         '//pmts_schedule/pmt[@id="' || p_pmt_id || '"]',
                         l_pmt_xml)
          into l_xml
          from dual;
      else
        select insertChildXml(l_xml, '//pmts_schedule', 'pmt', l_pmt_xml)
          into l_xml
          from dual;
      end if;

      -- вставляем обновленный XML
      update ins_add_agreements aa
         set aa.changes = l_xml
       where aa.id = p_id;
    end set_pmt;
  begin
    -- обеспечиваем уникальность по номеру договора и дате
    begin
      select ps.id
        into l_pmt_id
        from ins_payments_schedule ps
       where ps.deal_id = p_deal_id
         and ps.plan_date = p_plan_date;
    exception
      when no_data_found then
        null;
    end;

    begin
      select *
        into l_ps_row
        from ins_payments_schedule ps
       where ps.id = l_pmt_id;
    exception
      when no_data_found then
        l_ps_row.plan_date := null;
        l_ps_row.plan_sum  := null;
    end;

    if (p_action in ('I', 'D')) then
      set_pmt(p_id,
              l_pmt_id,
              p_action,
              l_ps_row.plan_date,
              l_ps_row.plan_sum,
              p_plan_date,
              p_plan_sum);
    elsif (l_ps_row.plan_date is not null and l_ps_row.plan_sum is not null and
          (l_ps_row.plan_date != p_plan_date or
          l_ps_row.plan_sum != p_plan_sum)) then
      set_pmt(p_id,
              l_pmt_id,
              p_action,
              l_ps_row.plan_date,
              l_ps_row.plan_sum,
              p_plan_date,
              p_plan_sum);
    end if;
  end set_addagr_pmt;

  -- Коментар-зміни по дод. угоді
  function get_addagr_comm(p_id in ins_add_agreements.id%type)
    return varchar2 is
    l_comm varchar2(4000);
    l_xml  xmltype;
  begin
    -- берем текущий XML изменений
    select aa.changes
      into l_xml
      from ins_add_agreements aa
     where aa.id = p_id;

    -- основные параметры
    if (l_xml.existsNode('//param[@name="EDATE"]') = 1) then
      l_comm := l_comm || '"Дата закінчення" змінена з ' || l_xml.extract('//param[@name="EDATE"]/@old')
               .getStringVal() || ' на ' || l_xml.extract('//param[@name="EDATE"]/@new')
               .getStringVal() || '; ';
    end if;
    if (l_xml.existsNode('//param[@name="SUM"]') = 1) then
      l_comm := l_comm || '"Страхова сума" змінена з ' || l_xml.extract('//param[@name="SUM"]/@old')
               .getStringVal() || ' на ' || l_xml.extract('//param[@name="SUM"]/@new')
               .getStringVal() || '; ';
    end if;
    if (l_xml.existsNode('//param[@name="SUM_KV"]') = 1) then
      l_comm := l_comm || '"Валюта cтрахової суми" змінена з ' || l_xml.extract('//param[@name="SUM_KV"]/@old')
               .getStringVal() || ' на ' || l_xml.extract('//param[@name="SUM_KV"]/@new')
               .getStringVal() || '; ';
    end if;
    if (l_xml.existsNode('//param[@name="INSU_TARIFF"]') = 1) then
      l_comm := l_comm || '"Премія - тариф" змінена з ' || l_xml.extract('//param[@name="INSU_TARIFF"]/@old')
               .getStringVal() || ' на ' || l_xml.extract('//param[@name="INSU_TARIFF"]/@new')
               .getStringVal() || '; ';
    end if;
    if (l_xml.existsNode('//param[@name="INSU_SUM"]') = 1) then
      l_comm := l_comm || '"Премія - фікс. сума" змінена з ' || l_xml.extract('//param[@name="INSU_SUM"]/@old')
               .getStringVal() || ' на ' || l_xml.extract('//param[@name="INSU_SUM"]/@new')
               .getStringVal() || '; ';
    end if;

    -- пл. график
    for cur in (select extractValue(value(t), '//pmt/@id') as id,
                       extractValue(value(t), '//pmt/@action') as action,
                       extractValue(value(t), '//pmt/@old_date') as old_date,
                       extractValue(value(t), '//pmt/@old_sum') as old_sum,
                       extractValue(value(t), '//pmt/@new_date') as new_date,
                       extractValue(value(t), '//pmt/@new_sum') as new_sum
                  from table(XMLSequence(l_xml.extract('//pmts_schedule/pmt'))) t) loop
      case (cur.action)
        when 'I' then
          l_comm := l_comm || 'Додано плат. дату ' || cur.new_date ||
                    ' сума ' || cur.new_sum || '; ';
        when 'U' then
          l_comm := l_comm || 'Для платежу №' || cur.id ||
                    ' змінено плат. дату з ' || cur.old_date || ' на ' ||
                    cur.new_date || ' суму з ' || cur.old_sum || ' на ' ||
                    cur.new_sum || '; ';
        when 'D' then
          l_comm := l_comm || 'Видалено плат. дату ' || cur.old_date ||
                    ' сума ' || cur.old_sum || '; ';
        else
          null;
      end case;
    end loop;

    return l_comm;
  end get_addagr_comm;

  -- Оновлення СД
  procedure update_deal(p_deal_id     in ins_deals.id%type,
                        p_branch      in ins_deals.branch%type,
                        p_partner_id  in ins_deals.partner_id%type,
                        p_type_id     in ins_deals.type_id%type,
                        p_ins_rnk     in ins_deals.ins_rnk%type,
                        p_ser         in ins_deals.ser%type,
                        p_num         in ins_deals.num%type,
                        p_sdate       in ins_deals.sdate%type,
                        p_edate       in ins_deals.edate%type,
                        p_sum         in ins_deals.sum%type,
                        p_sum_kv      in ins_deals.sum_kv%type default 980,
                        p_insu_tariff in ins_deals.insu_tariff%type,
                        p_insu_sum    in ins_deals.insu_sum%type,
                        p_rnk         in ins_deals.rnk%type,
                        p_grt_id      in ins_deals.grt_id%type,
                        p_nd          in ins_deals.nd%type,
                        p_renew_need  in ins_deals.renew_need%type default 0) is
    l_th constant varchar2(100) := g_dbgcode || 'update_deal';
  begin
    update ins_deals d
       set d.ins_rnk     = p_ins_rnk,
           d.branch      = p_branch,
           d.partner_id  = p_partner_id,
           d.type_id     = p_type_id,
           d.ser         = p_ser,
           d.num         = p_num,
           d.sdate       = p_sdate,
           d.edate       = p_edate,
           d.sum         = p_sum,
           d.sum_kv      = p_sum_kv,
           d.insu_tariff = p_insu_tariff,
           d.insu_sum    = p_insu_sum,
           d.rnk         = p_rnk,
           d.grt_id      = p_grt_id,
           d.nd          = p_nd,
           d.renew_need  = p_renew_need
     where d.id = p_deal_id;

    -- чистим пустые доп. соглашения
    for cur in (select *
                  from ins_add_agreements aa
                 where aa.deal_id = p_deal_id) loop
      if (is_addagr_empty(cur.id) = 1) then
        del_addagr(cur.id);
      end if;
    end loop;

    bars_audit.info(l_th ||
                    ' Користувач оновив парамтри договору страхування №' ||
                    p_deal_id);
  end update_deal;

  -- Завершення вводу даних СД
  procedure finish_datainput(p_deal_id     in ins_deals.id%type,
                             p_status_comm in ins_deals.status_comm%type default null) is
    l_th constant varchar2(100) := g_dbgcode || 'finish_datainput';

    l_d_row ins_deals%rowtype;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;
    if (l_d_row.status_id not in ('NEW', 'NEW_ADD')) then
      -- Недопустимый статус СД (%s)
      bars_error.raise_nerror(g_modcode,
                              'INVALID_DEAL_STATE',
                              l_d_row.status_id);
    end if;

    validate_deal_data(p_deal_id);

    set_status(p_deal_id, 'VISA', p_status_comm);

    bars_audit.info(l_th || ' Користувач передав договір страхування №' ||
                    p_deal_id || ' на візу' || ' (коментар: ' ||
                    nvl(p_status_comm, '-') || ')');
  end finish_datainput;

  -- Повернення договору на довведення
  procedure back2manager(p_deal_id     in ins_deals.id%type,
                         p_status_comm in ins_deals.status_comm%type) is
    l_th constant varchar2(100) := g_dbgcode || 'back2manager';

    l_d_row ins_deals%rowtype;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;
    if (l_d_row.status_id not in ('VISA')) then
      -- Недопустимый статус СД (%s)
      bars_error.raise_nerror(g_modcode,
                              'INVALID_DEAL_STATE',
                              l_d_row.status_id);
    end if;

    set_status(p_deal_id, 'NEW_ADD', p_status_comm);

    bars_audit.info(l_th || ' Контролер повернув договір страхування №' ||
                    p_deal_id || ' на доопрацювання' || ' (коментар: ' ||
                    nvl(p_status_comm, '-') || ')');
  end back2manager;

  -- Візування СД
  procedure visa_deal(p_deal_id     in ins_deals.id%type,
                      p_status_comm in ins_deals.status_comm%type default null) is
    l_th constant varchar2(100) := g_dbgcode || 'visa_deal';

    l_d_row ins_deals%rowtype;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;
    if (l_d_row.status_id not in ('VISA')) then
      -- Недопустимый статус СД (%s)
      bars_error.raise_nerror(g_modcode,
                              'INVALID_DEAL_STATE',
                              l_d_row.status_id);
    end if;

    set_status(p_deal_id, 'ON', p_status_comm);

    bars_audit.info(l_th ||
                    ' Користувач авторизував договір страхування №' ||
                    p_deal_id || ' (коментар: ' || nvl(p_status_comm, '-') || ')');
  end visa_deal;

  -- Сторнування СД
  procedure storno_deal(p_deal_id     in ins_deals.id%type,
                        p_status_comm in ins_deals.status_comm%type) is
    l_th constant varchar2(100) := g_dbgcode || 'storno_deal';

    l_d_row ins_deals%rowtype;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;

    set_status(p_deal_id, 'STORNO', p_status_comm);

    bars_audit.info(l_th || ' Користувач сторнував договір страхування №' ||
                    p_deal_id || ' (коментар: ' || p_status_comm || ')');
  end storno_deal;

  -- Закриття СД
  procedure close_deal(p_deal_id     in ins_deals.id%type,
                       p_renew_newid in ins_deals.renew_newid%type default null,
                       p_status_comm in ins_deals.status_comm%type default null) is
    l_th constant varchar2(100) := g_dbgcode || 'close_deal';

    l_d_row ins_deals%rowtype;
  begin
    select * into l_d_row from ins_deals d where d.id = p_deal_id;
    if (l_d_row.status_id != 'ON') then
      -- Недопустимый статус СД (%s)
      bars_error.raise_nerror(g_modcode,
                              'INVALID_DEAL_STATE',
                              l_d_row.status_id);
    end if;

    if (l_d_row.renew_need = 1) then
      if (p_renew_newid is null) then
        -- Нельзя закрыть СД не указав номер нового СД
        bars_error.raise_nerror(g_modcode, 'RENEW_NEEDED');
      else
        update ins_deals d
           set d.renew_newid = p_renew_newid
         where d.id = p_deal_id;
      end if;
    end if;

    if (l_d_row.renew_need = 1 and p_renew_newid is null) then
      -- Нельзя закрыть СД не указав номер нового СД
      bars_error.raise_nerror(g_modcode, 'RENEW_NEEDED');
    end if;

    set_status(p_deal_id, 'OFF', p_status_comm);
    bars_audit.info(l_th || ' Користувач закрив договір страхування №' ||
                    p_deal_id || ' (коментар: ' || p_status_comm || ')');
  end close_deal;

  -- Встановлення значення атрибуту СД
  procedure set_deal_attr(p_deal_id in ins_deal_attrs.deal_id%type,
                          p_attr_id in ins_deal_attrs.attr_id%type,
                          p_val     in ins_deal_attrs.val%type) is
  begin
    update ins_deal_attrs da
       set da.val = p_val
     where da.deal_id = p_deal_id
       and da.attr_id = p_attr_id;

    if (sql%rowcount = 0) then
      insert into ins_deal_attrs
        (deal_id, attr_id, val)
      values
        (p_deal_id, p_attr_id, p_val);
    end if;
  end set_deal_attr;

  -- Встановлення значення атрибуту СД - Строка
  procedure set_deal_attr_s(p_deal_id in ins_deal_attrs.deal_id%type,
                            p_attr_id in ins_deal_attrs.attr_id%type,
                            p_val     in varchar2) is
    l_a_row ins_attrs%rowtype;
  begin
    select * into l_a_row from ins_attrs a where a.id = p_attr_id;
    if (l_a_row.type_id != 'S') then
      bars_error.raise_nerror(g_modcode, 'ATTR_WRONG_TYPE');
    end if;

    set_deal_attr(p_deal_id, p_attr_id, trim(p_val));
  end set_deal_attr_s;

  -- Встановлення значення атрибуту СД - Число
  procedure set_deal_attr_n(p_deal_id in ins_deal_attrs.deal_id%type,
                            p_attr_id in ins_deal_attrs.attr_id%type,
                            p_val     in number) is
    l_a_row ins_attrs%rowtype;
  begin
    select * into l_a_row from ins_attrs a where a.id = p_attr_id;
    if (l_a_row.type_id != 'N') then
      bars_error.raise_nerror(g_modcode, 'ATTR_WRONG_TYPE');
    end if;

    set_deal_attr(p_deal_id,
                  p_attr_id,
                  to_char(p_val, g_number_format, g_number_nlsparam));
  end set_deal_attr_n;

  -- Встановлення значення атрибуту СД - Дата
  procedure set_deal_attr_d(p_deal_id in ins_deal_attrs.deal_id%type,
                            p_attr_id in ins_deal_attrs.attr_id%type,
                            p_val     in date) is
    l_a_row ins_attrs%rowtype;
  begin
    select * into l_a_row from ins_attrs a where a.id = p_attr_id;
    if (l_a_row.type_id != 'D') then
      bars_error.raise_nerror(g_modcode, 'ATTR_WRONG_TYPE');
    end if;

    set_deal_attr(p_deal_id, p_attr_id, to_char(p_val, g_datetime_format));
  end set_deal_attr_d;

  -- Выдалення значення атрибуту СД
  procedure del_deal_attr(p_deal_id in ins_deal_attrs.deal_id%type,
                          p_attr_id in ins_deal_attrs.attr_id%type) is
  begin
    delete from ins_deal_attrs da
     where da.deal_id = p_deal_id
       and da.attr_id = p_attr_id;
  end del_deal_attr;

  -- Отримання значення атрибуту СД
  function get_deal_attr(p_deal_id in ins_deal_attrs.deal_id%type,
                         p_attr_id in ins_deal_attrs.attr_id%type)
    return varchar2 is
    l_val ins_deal_attrs.val%type;
  begin
    select da.val
      into l_val
      from ins_deal_attrs da
     where da.deal_id = p_deal_id
       and da.attr_id = p_attr_id;

    return l_val;
  exception
    when no_data_found then
      return null;
  end get_deal_attr;

  -- Отримання значення атрибуту СД - Строка
  function get_deal_attr_s(p_deal_id in ins_deal_attrs.deal_id%type,
                           p_attr_id in ins_deal_attrs.attr_id%type)
    return varchar2 is
    l_a_row ins_attrs%rowtype;
  begin
    select * into l_a_row from ins_attrs a where a.id = p_attr_id;
    if (l_a_row.type_id != 'S') then
      bars_error.raise_nerror(g_modcode, 'ATTR_WRONG_TYPE');
    end if;

    return get_deal_attr(p_deal_id, p_attr_id);
  end get_deal_attr_s;

  -- Отримання значення атрибуту СД - Число
  function get_deal_attr_n(p_deal_id in ins_deal_attrs.deal_id%type,
                           p_attr_id in ins_deal_attrs.attr_id%type)
    return number is
    l_a_row ins_attrs%rowtype;
  begin
    select * into l_a_row from ins_attrs a where a.id = p_attr_id;
    if (l_a_row.type_id != 'N') then
      bars_error.raise_nerror(g_modcode, 'ATTR_WRONG_TYPE');
    end if;

    return to_number(get_deal_attr(p_deal_id, p_attr_id),
                     g_number_format,
                     g_number_nlsparam);
  end get_deal_attr_n;

  -- Отримання значення атрибуту СД - Дата
  function get_deal_attr_d(p_deal_id in ins_deal_attrs.deal_id%type,
                           p_attr_id in ins_deal_attrs.attr_id%type)
    return date is
    l_a_row ins_attrs%rowtype;
  begin
    select * into l_a_row from ins_attrs a where a.id = p_attr_id;
    if (l_a_row.type_id != 'D') then
      bars_error.raise_nerror(g_modcode, 'ATTR_WRONG_TYPE');
    end if;

    return to_date(get_deal_attr(p_deal_id, p_attr_id), g_datetime_format);
  end get_deal_attr_d;

  -- Встановлення значення сканкопії СД
  procedure set_deal_scan(p_deal_id in ins_deal_scans.deal_id%type,
                          p_scan_id in ins_deal_scans.scan_id%type,
                          p_val     in ins_deal_scans.val%type) is
  begin
    update ins_deal_scans ds
       set ds.val = p_val
     where ds.deal_id = p_deal_id
       and ds.scan_id = p_scan_id;

    if (sql%rowcount = 0) then
      insert into ins_deal_scans
        (deal_id, scan_id, val)
      values
        (p_deal_id, p_scan_id, p_val);
    end if;
  end set_deal_scan;

  -- Выдалення значення сканкопії СД
  procedure del_deal_scan(p_deal_id in ins_deal_scans.deal_id%type,
                          p_scan_id in ins_deal_scans.scan_id%type) is
  begin
    delete from ins_deal_scans ds
     where ds.deal_id = p_deal_id
       and ds.scan_id = p_scan_id;
  end del_deal_scan;

  -- Отримання значення сканкопії СД
  function get_deal_scan(p_deal_id in ins_deal_attrs.deal_id%type,
                         p_scan_id in ins_deal_scans.scan_id%type)
    return blob is
    l_val ins_deal_scans.val%type;
  begin
    select ds.val
      into l_val
      from ins_deal_scans ds
     where ds.deal_id = p_deal_id
       and ds.scan_id = p_scan_id;

    return l_val;
  exception
    when no_data_found then
      return null;
  end get_deal_scan;

  -- Створення страхового випадку
  function create_accident(p_id          in ins_accidents.id%type,
                           p_deal_id     in ins_accidents.deal_id%type,
                           p_acdt_date   in ins_accidents.acdt_date%type,
                           p_comm        in ins_accidents.comm%type,
                           p_refund_sum  in ins_accidents.refund_sum%type,
                           p_refund_date in ins_accidents.refund_date%type)
    return ins_accidents.id%type is
    l_th constant varchar2(100) := g_dbgcode || 'create_accident';

    l_id       ins_add_agreements.id%type;
    l_branch   ins_add_agreements.branch%type := sys_context('bars_context',
                                                             'user_branch');
    l_staff_id ins_add_agreements.staff_id%type := user_id;
    l_crt_date ins_add_agreements.crt_date%type := sysdate;
  begin
    if (p_id is not null) then
      -- обновляем
      update ins_accidents a
         set a.deal_id     = p_deal_id,
             a.acdt_date   = p_acdt_date,
             a.comm        = p_comm,
             a.refund_sum  = p_refund_sum,
             a.refund_date = p_refund_date
       where a.id = p_id
      returning a.id into l_id;
    else
      -- вставляем
      insert into ins_accidents
        (id,
         deal_id,
         branch,
         staff_id,
         crt_date,
         acdt_date,
         comm,
         refund_sum,
         refund_date)
      values
        (bars_sqnc.get_nextval('s_insaccidents'),
         p_deal_id,
         l_branch,
         l_staff_id,
         l_crt_date,
         p_acdt_date,
         p_comm,
         p_refund_sum,
         p_refund_date)
      returning id into l_id;
    end if;

    bars_audit.info(l_th ||
                    ' Користувач створив/обновив страховий выпадок ід. ' || l_id ||
                    ' по договору ід. ' || p_deal_id);

    return l_id;
  end create_accident;

  --Проверка наличия документов оплати (job)
  procedure check_payment is
      l_th constant varchar2(100) := g_dbgcode || 'check_payment';
      l_id_d decimal;
      l_pay_d decimal;
      l_id_p decimal;
      l_last_ref number;
      l_new_ref number;
    begin
      bars_audit.trace('%s: entry point', l_th);
      -- предидущий ключ синхронизации
      select nvl(max(ref), 0)
        into l_last_ref
        from ins_sync;

      -- новый ключ синхронизации
      select max(o.ref)
        into l_new_ref
        from oper o
       where o.ref >= l_last_ref;

      for cur in (select p.rnk, o.vdat, o.s, o.ref, o.nazn,
                         substr(regexp_substr(o.nazn, '№[A-ZА-ЯІЇЄ]*'), 2) ser,
                         regexp_substr(regexp_substr(o.nazn, '[0-9]+ від'),'[0-9]+') n
                    from ins_partners p, accounts a, oper o
                   where p.rnk = a.rnk
                     and a.nls = o.nlsa
                     and o.ref > l_last_ref
                     and o.ref <= l_new_ref
                     and regexp_like(o.nazn, '^(\W|\w)*№[A-ZА-ЯІЇЄ]+[0-9]+\sвід\s[0-9]{2}\S[0-9]{2}\S[0-9]{4}')
                   order by ref)
      loop
        begin
          bars_audit.trace('%s: entry cursor', l_th);
          --поиск ДС
          select d.id
            into l_id_d
            from ins_deals d
           where d.ser=trim(cur.ser)
             and d.num=trim(cur.n);
          --проверка оплаты
          select max(p.id)
            into l_pay_d
            from ins_payments_schedule p
           where p.deal_id=l_id_d
             and p.pmt_num = cur.ref
             and p.payed = 1;

          if l_pay_d is null then
            --поиск записи в платежном графике
            select * into l_id_p
              from(
              select p.id
                from ins_payments_schedule p
               where p.deal_id=l_id_d
                 and p.fact_date is null
                 and p.fact_sum is null
                 and p.plan_sum*100 between cur.s - 10000 and cur.s + 10000
               order by p.plan_date)
            where rownum = 1;
            --обновление платежного графика
            ins_pack.pay_deal_pmt(l_id_p, cur.vdat, cur.s/100, cur.ref, cur.nazn);
          end if;
        exception
          when no_data_found then
            bars_audit.trace('%s: cursor no data found', l_th);
            null;
        end;
      end loop;
      begin
      update ins_sync s
         set s.ref = l_new_ref, s.time = sysdate;
      end;
      bars_audit.trace('%s: done', l_th);
      commit;
  end check_payment;
    -- запись договора БПК в справочник договоров со страховкой
  procedure set_w4_deal(p_nd in number) is
    l_deal ins_w4_deals%rowtype;
  begin
    begin
      select * into l_deal from ins_w4_deals where nd = p_nd;
    exception
      when no_data_found then
        insert into ins_w4_deals(nd, state)
        values(p_nd, 'AWAITING');
    end;
  end set_w4_deal;

  -- установка статуса договора БПК
  procedure set_w4_state(p_nd in number,
                         p_state_id in varchar2,
                         p_msg in varchar2 default null) is
  begin
    update ins_w4_deals set state = p_state_id, err_msg = p_msg, set_date = sysdate where nd = p_nd;
  end set_w4_state;

  -- запись запроса/ответа по договорам БПК
  procedure set_w4_req_res(p_nd in number,
                           p_value in clob,
                           p_key in number,
                           p_deal_id in varchar2 default null,
                           p_date_from in date default null,
                           p_date_to in date default null) is -- 0 - request, 1 - response
  begin
    if p_key = 0 then
      update ins_w4_deals set request = p_value where nd = p_nd;
    elsif p_key = 1 then
      update ins_w4_deals set response = p_value where nd = p_nd;
    end if;
    if p_deal_id is not null then
      update ins_w4_deals set deal_id = p_deal_id where nd = p_nd;
    end if;
    if p_date_from is not null then
      update ins_w4_deals set date_from = p_date_from where nd = p_nd;
    end if;
    if p_date_to is not null then
      update ins_w4_deals set date_to = p_date_to where nd = p_nd;
    end if;
  end set_w4_req_res;

  -- запись внешнего ИД СК по договорам БПК
  procedure set_w4_ins_id(p_nd in number, p_ins_id in number, p_tmp_id in number) is
  begin
    update ins_w4_deals set ins_ext_id = p_ins_id, ins_ext_tmp = p_tmp_id where nd = p_nd;
  end set_w4_ins_id;


  function get_ins_w4_deal(p_nd in number) return ins_w4_deals%rowtype is
    l_ins_w4_deal ins_w4_deals%rowtype;
  begin
    select t.* into l_ins_w4_deal from ins_w4_deals t where t.nd = p_nd;
    return l_ins_w4_deal;

  exception
    when no_data_found then
      l_ins_w4_deal := null;
      return l_ins_w4_deal;
  end;

  procedure ins_w4_deal_to_arc(p_ns_w4_deals in ins_w4_deals%rowtype) is
  begin
    insert into ins_w4_deals_arc values p_ns_w4_deals;
  end;

-- Обновленние мат. представлений (вешается на job)
/*
  procedure p_job_refresh_mv is
    l_th constant varchar2(100) := g_dbgcode || 'p_job_refresh_mv';
  begin
    bars_audit.trace('%s: entry point', l_th);

    dbms_mview.refresh('MV_INS_PORTFOLIO_TOTALS');
    bars_audit.trace('%s: MV_INS_PORTFOLIO_TOTALS done', l_th);

    dbms_mview.refresh('MV_INS_BROKEN_LIMITS');
    bars_audit.trace('%s: MV_INS_BROKEN_LIMITS done', l_th);

    --dbms_mview.refresh('MV_INS_SCHEDULE_TASKS');
    --bars_audit.trace('%s: MV_INS_SCHEDULE_TASKS done', l_th);

    bars_audit.trace('%s: done', l_th);
  end p_job_refresh_mv;
  */

end ins_pack;
/
 show err;
 
PROMPT *** Create  grants  INS_PACK ***
grant EXECUTE                                                                on INS_PACK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ins_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
