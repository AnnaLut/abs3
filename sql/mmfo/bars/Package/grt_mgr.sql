
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/grt_mgr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.GRT_MGR is

  --
  -- Автор  : OLEG
  -- Создан : 28.01.2011
  --
  -- Purpose :  Управление портфелем договоров залога
  --

/*
  26-10-2011 Sta Проводки по обеспечению от залоговика,
                 уровень которого выше, чем происходит авторизация
                 (отмена и восстановление политик)
                 procedure create_account_balance

  20-10-2011 Sta Связь GRT_ID и PAWN
  05.08.2011 Sta Сопряжение во старой схемой
  05.10.2011 Sta OB22  для залогов и гарантий
*/

  -- Public constant declarations
  g_header_version  constant varchar2(64)  := 'version 1.2. 10/08/2011';
  g_awk_header_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- REPL_PAWN_ACC - для поддержки работоспособности ПО
  --                с обеспечением по-старому.
  --                Реплицирует параметры обеспечения в таблицу PAWN_ACC
  -- 05.08.2011 Сухова Т.А.
  --

  procedure REPL_PAWN_ACC( p_deal_id grt_deals.deal_id%type  );


  --------------------------------------------------------------------------------
  -- get_warn_days - возвращает параметр "кол-во дней для оповещения"
  --
  function get_warn_days return number;

  --------------------------------------------------------------------------------
  -- register_deal - регистрирует договор залога
  -- !!! tvSukhov: cхема должна предусматривать несколько видов залога под одним договором
  --
  function register_deal(
    p_grt_type_id in grt_deals.grt_type_id%type,
    p_grt_place_id in grt_deals.grt_place_id%type,
    p_deal_rnk in grt_deals.deal_rnk%type,
    p_deal_num in grt_deals.deal_num%type,
    p_deal_date in grt_deals.deal_date%type,
    p_deal_name in grt_deals.deal_name%type,
    p_deal_place in grt_deals.deal_place%type,
    p_grt_name in grt_deals.grt_name%type,
    p_grt_comment in grt_deals.grt_comment%type,
    p_grt_buy_dognum in grt_deals.grt_buy_dognum%type,
    p_grt_buy_dogdate in grt_deals.grt_buy_dogdate%type,
    p_grt_unit in grt_deals.grt_unit%type,
    p_grt_cnt in grt_deals.grt_cnt%type,
    p_grt_sum in grt_deals.grt_sum%type,
    p_grt_sum_curcode in grt_deals.grt_sum_curcode%type,
    p_chk_date_avail in grt_deals.chk_date_avail%type,
    p_chk_date_status in grt_deals.chk_date_status%type,
    p_revalue_date in grt_deals.revalue_date%type,
    p_chk_sum in grt_deals.chk_sum%type,
    p_warn_days in grt_deals.warn_days%type,
    p_staff_id in grt_deals.staff_id%type,
    p_branch in grt_deals.branch%type,
    p_chk_freq in grt_deals.chk_freq%type,
    p_calc_sum in grt_deals.calc_sum%type,
    p_grt_subj_id in grt_deals.grt_subj_id%type
  ) return number;

  --------------------------------------------------------------------------------
  -- authorize_deal - авторизует договор залога
  --
  -- @p_deal_id - идентификатор ранее зарегистрированного договора залога
  --
  function authorize_deal(p_deal_id in number) return number;

  --------------------------------------------------------------------------------
  -- build_events - заполняет график событий по договору
  --
  -- @p_deal_id - идентификатор договора залога
  -- @p_event_type - тип события
  -- @p_freq_id - идентификатор в справочнике периодичности
  --
  --  1    Щодня
  --  3    Шотижня
  --  5    Щомiсячно
  --  7    Щоквартально
  --  180  Раз на пiвроку
  --  360  Раз на рiк
  --  400  В концi строку
  --
  procedure build_events(
    p_deal_id in grt_deals.deal_id%type,
    p_event_type in grt_event_types.event_id%type,
    p_freq_id in freq.freq%type);

  --------------------------------------------------------------------------------
  -- iu_valuables - вставка или обновление данных о залоговых ценностях
  --
  -- @see grt_valuables column comments
  --
  procedure iu_valuables(
    p_deal_id in grt_valuables.deal_id%type,
    p_name in grt_valuables.name%type,
    p_descr in grt_valuables.descr%type,
    p_weight in grt_valuables.weight%type,
    p_part_cnt in grt_valuables.part_cnt%type,
    p_part_disc_weig in grt_valuables.part_disc_weig%type,
    p_value_weight in grt_valuables.value_weight%type,
    p_tariff_price in grt_valuables.tariff_price%type,
    p_expert_price in grt_valuables.expert_price%type,
    p_estimate_price in grt_valuables.estimate_price%type
  );

  --------------------------------------------------------------------------------
  -- iu_deposits - вставка или обновление данных о залоговых депозитах
  --
  -- @see grt_deposits column comments
  --
  procedure iu_deposits(
    p_deal_id in grt_deposits.deal_id%type,
    p_doc_num in grt_deposits.doc_num%type,
    p_doc_date in grt_deposits.doc_date%type,
    p_doc_enddate in grt_deposits.doc_enddate%type,
    p_acc in grt_deposits.acc%type
  );

  --------------------------------------------------------------------------------
  -- iu_products - вставка или обновление данных о залоговых товарах
  --
  -- @see grt_products column comments
  --
  procedure iu_products(
    p_deal_id in grt_products.deal_id%type,
    p_type_txt in grt_products.type_txt%type,
    p_name in grt_products.name%type,
    p_model in grt_products.model%type,
    p_modification in grt_products.modification%type,
    p_serial_num in grt_products.serial_num%type,
    p_made_date in grt_products.made_date%type,
    p_other_comments in grt_products.other_comments%type
  );

  --------------------------------------------------------------------------------
  -- iu_mortgage_land - вставка или обновление данных о залоговой ипотеке (земля)
  --
  -- @see grt_mortgage_land column comments
  --
  procedure iu_mortgage_land(
    p_deal_id in grt_mortgage_land.deal_id%type,
    p_area in grt_mortgage_land.area%type,
    p_land_purpose in grt_mortgage_land.land_purpose%type,
    p_build_num in grt_mortgage_land.build_num%type,
    p_build_lit in grt_mortgage_land.build_lit%type,
    p_ownship_doc_ser in grt_mortgage_land.ownship_doc_ser%type,
    p_ownship_doc_num in grt_mortgage_land.ownship_doc_num%type,
    p_ownship_doc_date in grt_mortgage_land.ownship_doc_date%type,
    p_ownship_doc_reason in grt_mortgage_land.ownship_doc_reason%type,
    p_ownship_regbook_num in grt_mortgage_land.ownship_regbook_num%type,
    p_extract_reg_date in grt_mortgage_land.extract_reg_date%type,
    p_extract_reg_organ in grt_mortgage_land.extract_reg_organ%type,
    p_extract_reg_num in grt_mortgage_land.extract_reg_num%type,
    p_extract_reg_sum in grt_mortgage_land.extract_reg_sum%type,
    p_lessee_num in grt_mortgage_land.lessee_num%type,
    p_lessee_name in grt_mortgage_land.lessee_name%type,
    p_lessee_dog_enddate in grt_mortgage_land.lessee_dog_enddate%type,
    p_lessee_dog_num in grt_mortgage_land.lessee_dog_num%type,
    p_lessee_dog_date in grt_mortgage_land.lessee_dog_date%type,
    p_bans_reg_num in grt_mortgage_land.bans_reg_num%type,
    p_bans_reg_date in grt_mortgage_land.bans_reg_date%type
  );

  --------------------------------------------------------------------------------
  -- iu_mortgage - вставка или обновление данных о залоговой ипотеке
  --
  -- @see grt_mortgage column comments
  --
  procedure iu_mortgage(
    p_deal_id in grt_mortgage.deal_id%type,
    p_rooms_cnt in grt_mortgage.rooms_cnt%type,
    p_app_num in grt_mortgage.app_num%type,
    p_total_space in grt_mortgage.total_space%type,
    p_living_space in grt_mortgage.living_space%type,
    p_floor in grt_mortgage.floor%type,
    p_addr in grt_mortgage.addr%type,
    p_buiding_type in grt_mortgage.buiding_type%type,
    p_building_num in grt_mortgage.building_num%type,
    p_building_lit in grt_mortgage.building_lit%type,
    p_city in grt_mortgage.city%type,
    p_city_distr in grt_mortgage.city_distr%type,
    p_living_distr in grt_mortgage.living_distr%type,
    p_micro_distr in grt_mortgage.micro_distr%type,
    p_area_num in grt_mortgage.area_num%type,
    p_build_sect_count in grt_mortgage.build_sect_count%type,
    p_add_grt_addr in grt_mortgage.add_grt_addr%type,
    p_mort_doc_num in grt_mortgage.mort_doc_num%type,
    p_mort_doc_date in grt_mortgage.mort_doc_date%type,
    p_ownship_reg_num in grt_mortgage.ownship_reg_num%type,
    p_ownship_reg_checksum in grt_mortgage.ownship_reg_checksum%type
  );

  --------------------------------------------------------------------------------
  -- iu_vehicles - вставка или обновление данных о залоговом движимом имуществе
  --
  -- @see grt_vehicles column comments
  --
  procedure iu_vehicles(
    p_deal_id in grt_vehicles.deal_id%type,
    p_type in grt_vehicles.type%type,
    p_model in grt_vehicles.model%type,
    p_mileage in grt_vehicles.mileage%type,
    p_veh_reg_num in grt_vehicles.veh_reg_num%type,
    p_made_date in grt_vehicles.made_date%type,
    p_color in grt_vehicles.color%type,
    p_vin in grt_vehicles.vin%type,
    p_engine_num in grt_vehicles.engine_num%type,
    p_reg_doc_ser in grt_vehicles.reg_doc_ser%type,
    p_reg_doc_num in grt_vehicles.reg_doc_num%type,
    p_reg_doc_date in grt_vehicles.reg_doc_date%type,
    p_reg_doc_organ in grt_vehicles.reg_doc_organ%type,
    p_reg_owner_addr in grt_vehicles.reg_owner_addr%type,
    p_reg_spec_marks in grt_vehicles.reg_spec_marks%type,
    p_parking_addr in grt_vehicles.parking_addr%type,
    p_crd_end_date in grt_vehicles.crd_end_date%type,
    p_ownship_reg_num in grt_vehicles.ownship_reg_num%type,
    p_ownship_reg_checksum in grt_vehicles.ownship_reg_checksum%type
  );

  --------------------------------------------------------------------------------
  -- fill_cc_grt - добавляет связь крединого и залогового договоров
  --
  -- @p_nd - идентификатор кредитного договора
  -- @p_deal_id - идентификатор договора залога
  --
  procedure fill_cc_grt(
    p_nd in cc_deal.nd%type,
    p_deal_id in grt_deals.deal_id%type);

  --------------------------------------------------------------------------------
  -- update_event - обновляет информацию о событии по договору
  --
  -- @p_event_id in - код события
  -- @p_actual_date - дата выполнения события
  -- @p_comment_text - комментарий пользователя
  --
  procedure update_event(
    p_event_id in grt_events.id%type,
    p_actual_date in grt_events.actual_date%type,
    p_comment_text in grt_events.comment_text%type
  );

    --------------------------------------------------------------------------------
  -- close_deal - переводит договор в состояние "закрыт"
  --
  -- @p_deal_id id договора залога
  --
  procedure close_deal(p_deal_id in number);

  --------------------------------------------------------------------------------
  -- insert_event - добавляет запись в график событий по договору
  --
  --
  procedure insert_event(
    p_deal_id in grt_deals.deal_id%type,
    p_type_id in grt_event_types.event_id%type,
    p_planned_date in grt_events.planned_date%type,
    p_actual_date in grt_events.actual_date%type,
    p_comment_text in grt_events.comment_text%type
  );


  --------------------------------------------------------------------------------
  -- create_account_balance - создает проводку для формирование
  --                          первоначального остатка по обеспечению
  --
  --

  procedure create_account_balance(  p_deal_id in cc_grt.grt_deal_id%type );



end grt_mgr;
/
CREATE OR REPLACE PACKAGE BODY BARS.GRT_MGR is

  --
  -- Автор  : OLEG
  -- Создан : 28.01.2011
  --
  -- Purpose :  Управление портфелем договоров залога
  --

/*
  05.08.2011 Sta  Сопряжение во старой схемой

  патч для nlsmask
  update nlsmask set masknms = 'Пока не придумал' where maskid='ZAL';
  commit;

 */

  -- Private constant declarations
  g_body_version  constant varchar2(64)  := 'version 1.2. 10/08/2011';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode constant varchar2(12) := 'grt_mgr.';
  g_modcode constant varchar2(3) := 'GRT';

  g_status_new constant number := 0;
  g_status_auth constant number := 10;
  g_status_del constant number := -10;

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header grt_mgr '||g_header_version||'.'||chr(10)
  	   ||'AWK definition: '||chr(10)
  	   ||g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body grt_mgr '||g_body_version||'.'||chr(10)
	     ||'AWK definition: '||chr(10)
	     ||g_awk_body_defs;
  end body_version;

  --------------------------------------------------------------------------------
  -- REPL_PAWN_ACC - для поддержки работоспособности ПО
  --                с обеспечением по-старому.
  --                Реплицирует параметры обеспечения в таблицу PAWN_ACC
  -- 05.08.2011 Сухова Т.А.
  --

  procedure REPL_PAWN_ACC( p_deal_id grt_deals.deal_id%type ) is

      l_ACC        pawn_acc.ACC%type        ;
      l_PAWN       pawn_acc.PAWN%type       ;
      l_MPAWN      pawn_acc.MPAWN%type      ;
      l_nree       pawn_acc.NREE%type       := null ;
      l_IDZ        pawn_acc.IDZ%type        ;
      l_NDZ        pawn_acc.NDZ%type        := p_deal_id;
      l_SV         pawn_acc.SV%type         ; -- Оценочная стоимость залога (рыночная)
      l_CC_IDZ     pawn_acc.CC_IDZ%type     ;
      l_SDATZ      pawn_acc.SDATZ%type      ;
      l_DEPOSIT_ID pawn_acc.DEPOSIT_ID%type := null ;

  begin

    begin
      SELECT d.acc,
             d.grt_type_id,
             d.grt_place_id,
             NVL ( m.ownship_reg_num,
                   NVL(ml.ownship_doc_ser || ml.ownship_doc_num,
                   vh.ownship_reg_num )
                  ),
             d.staff_id,  dp.deposit_id,
             d.CHK_SUM, d.deal_num, d.deal_date
      into l_ACC, l_PAWN, l_MPAWN, l_NREE,
           l_IDZ, l_DEPOSIT_ID, l_SV, l_CC_IDZ, l_SDATZ
      FROM grt_deals d,
           ( SELECT gd.*, dd.deposit_id  FROM grt_deposits gd, dpt_deposit dd
             WHERE gd.acc = dd.acc
           ) dp,
           grt_mortgage m,
           grt_mortgage_land ml,
           grt_products p,
           grt_valuables v,
           grt_vehicles vh
      WHERE d.deal_id = p_deal_id
        and d.deal_id = dp.deal_id (+)
        AND d.deal_id = m.deal_id  (+)
        AND d.deal_id = ml.deal_id (+)
        AND d.deal_id = p.deal_id  (+)
        AND d.deal_id = v.deal_id  (+)
        AND d.deal_id = vh.deal_id (+)
        and d.deal_id = v.deal_id  (+)
        and d.deal_id = vh.deal_id (+) ;

      update pawn_acc set pawn       = l_pawn  ,
                          mpawn      = l_mpawn ,
                          nree       = l_nree  ,
                          idz        = l_idz   ,
                          ndz        = l_ndz   ,
                          DEPOSIT_ID = l_DEPOSIT_ID,
                          sv         = l_sv    ,
                          cc_idz     = l_cc_idz,
                          sdatz      = l_sdatz
      where acc=l_acc;

      if SQL%rowcount = 0 then
         insert into pawn_acc(  ACC,  PAWN,  MPAWN,  NREE,  IDZ,  NDZ,  DEPOSIT_ID,  SV,  CC_IDZ,  SDATZ)
         values              (l_ACC,l_PAWN,l_MPAWN,l_NREE,l_IDZ,l_NDZ,l_DEPOSIT_ID,l_SV,l_CC_IDZ,l_SDATZ);
      end if;

      bars_audit.trace('REPL_PAWN_ACC, реф.договора залога =%s', to_char(l_ndz ));

    exception when no_data_found then null;
    end;

    RETURN;

  end REPL_PAWN_ACC;

  --------------------------------------------------------------------------------
  -- get_warn_days - возвращает параметр "кол-во дней для оповещения"
  --
  function get_warn_days return number is
    l_res number;
  begin
    select nvl(to_number(min(p.val)), 3)
      into l_res
      from params p
     where p.par = 'GRTWDAYS';
    return l_res;
  end get_warn_days;

  --------------------------------------------------------------------------------
  -- save_history - сохраняет историю изменения статуса договора
  --
  --
  procedure upd_history(
    p_deal_id in grt_deals.deal_id%type,
    p_status_id in grt_deals.status_id%type
  )
  is
    l_th constant varchar2(100) := g_dbgcode || 'save_history';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_deal_id=%s, p_status_id=%s', l_th, to_char(p_deal_id), to_char(p_status_id));
    insert into grt_deal_statuses_hist (change_date, deal_id, status_id, staff_id)
      values (current_timestamp, p_deal_id, p_status_id, user_id);
    bars_audit.trace('%s: done', l_th);
  end upd_history;

  --------------------------------------------------------------------------------
  -- register_deal - регистрирует договор залога
  -- !!! tvSukhov: cхема должна предусматривать несколько видов залога под одним договором
  --
  function register_deal(
    p_grt_type_id in grt_deals.grt_type_id%type,
    p_grt_place_id in grt_deals.grt_place_id%type,
    p_deal_rnk in grt_deals.deal_rnk%type,
    p_deal_num in grt_deals.deal_num%type,
    p_deal_date in grt_deals.deal_date%type,
    p_deal_name in grt_deals.deal_name%type,
    p_deal_place in grt_deals.deal_place%type,
    p_grt_name in grt_deals.grt_name%type,
    p_grt_comment in grt_deals.grt_comment%type,
    p_grt_buy_dognum in grt_deals.grt_buy_dognum%type,
    p_grt_buy_dogdate in grt_deals.grt_buy_dogdate%type,
    p_grt_unit in grt_deals.grt_unit%type,
    p_grt_cnt in grt_deals.grt_cnt%type,
    p_grt_sum in grt_deals.grt_sum%type,
    p_grt_sum_curcode in grt_deals.grt_sum_curcode%type,
    p_chk_date_avail in grt_deals.chk_date_avail%type,
    p_chk_date_status in grt_deals.chk_date_status%type,
    p_revalue_date in grt_deals.revalue_date%type,
    p_chk_sum in grt_deals.chk_sum%type,
    p_warn_days in grt_deals.warn_days%type,
    p_staff_id in grt_deals.staff_id%type,
    p_branch in grt_deals.branch%type,
    p_chk_freq in grt_deals.chk_freq%type,
    p_calc_sum in grt_deals.calc_sum%type,
    p_grt_subj_id in grt_deals.grt_subj_id%type
  ) return number is
    l_th constant varchar2(100) := g_dbgcode || 'register_deal';
    l_deal_id number;
  begin
    bars_audit.trace('%s: entry point', l_th);

    -- поиск договора по альтернативному ключу
    select max(deal_id) into l_deal_id from grt_deals
     where deal_rnk = p_deal_rnk
       and deal_num = p_deal_num
       and deal_date = p_deal_date;

    if (l_deal_id is not null) then

      update grt_deals set
        grt_type_id = p_grt_type_id,
        grt_place_id = p_grt_place_id,
        deal_name = p_deal_name,
        deal_place = p_deal_place,
        grt_name = p_grt_name,
        grt_comment = p_grt_comment,
        grt_buy_dognum = p_grt_buy_dognum,
        grt_buy_dogdate = p_grt_buy_dogdate,
        grt_unit = p_grt_unit,
        grt_cnt = p_grt_cnt,
        grt_sum = p_grt_sum,
        grt_sum_curcode = p_grt_sum_curcode,
        chk_date_avail = p_chk_date_avail,
        chk_date_status = p_chk_date_status,
        revalue_date = p_revalue_date,
        chk_sum = p_chk_sum,
        warn_days = p_warn_days,
        staff_id = p_staff_id,
        chk_freq = p_chk_freq,
        calc_sum = p_calc_sum,
        grt_subj_id = p_grt_subj_id
      where
        deal_rnk = p_deal_rnk and
        deal_num = p_deal_num and
        deal_date = p_deal_date;

    else

      select s_grt_deals.nextval into l_deal_id from dual;

      insert into grt_deals (deal_id, grt_type_id, grt_place_id, deal_rnk, deal_num,
        deal_date, deal_name, deal_place, grt_name, grt_comment, grt_buy_dognum,
        grt_buy_dogdate, grt_unit, grt_cnt, grt_sum, grt_sum_curcode,
        chk_date_avail, chk_date_status, revalue_date, chk_sum,
        warn_days, staff_id, branch, status_id,
        calc_sum, chk_freq, grt_subj_id)
      values
        (l_deal_id, p_grt_type_id, p_grt_place_id, p_deal_rnk, p_deal_num,
         p_deal_date, p_deal_name, p_deal_place, p_grt_name, p_grt_comment,
         p_grt_buy_dognum, p_grt_buy_dogdate, p_grt_unit, p_grt_cnt, p_grt_sum,
         p_grt_sum_curcode, p_chk_date_avail, p_chk_date_status, p_revalue_date,
         p_chk_sum, p_warn_days, p_staff_id, p_branch, g_status_new,
         p_chk_sum, p_chk_freq, p_grt_subj_id);
       bars_audit.trace('%s: deal registered, id=%s', l_th, to_char(l_deal_id));

    end if;

    -- сохранение истории
    upd_history(l_deal_id, g_status_new);

    -- запись в журнал
    bars_audit.info(bars_msg.get_msg(g_modcode, 'GRT_DEAL_CREATED', to_char(l_deal_id)));

    bars_audit.trace('%s: done', l_th);
    return l_deal_id;
  end register_deal;

    --------------------------------------------------------------------------------
    -- authorize_deal - авторизует договор залога
    --
    -- @p_deal_id - идентификатор ранее зарегистрированного договора залога
    --
  function authorize_deal(p_deal_id in number) return number is
    l_th constant varchar2(100) := g_dbgcode || 'authorize_deal';
    l_acc          number;
    l_p4           number;
    l_nls          varchar2(14);
    l_nbs          accounts.nbs%type;
    l_nms          accounts.nms%type;
    l_grtdeals_rec grt_deals%rowtype;

    -- 05.08.2011 Sta Исполнитель по счету
    l_id_isp   staff$base.id%type;
    l_fio_isp  staff$base.fio%type;
    l_type     staff$base.type%type;
    l_ob22     accounts.ob22%type;
    l_table_id grt_detail_tables.table_id%type;

  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p[0]=>%s', l_th, to_char(p_deal_id));

    -- поиск и лок зарегистрированного договора
    begin
      select *
        into l_grtdeals_rec
        from grt_deals
       where deal_id = p_deal_id
         for update of acc;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'DEAL_NOTFOUND',
                                to_char(p_deal_id));
      when others then
        bars_error.raise_nerror(g_modcode, 'DEAL_LOCKERR', sqlerrm);
    end;

    -- балансовый счет
    begin
      select nbs
        into l_nbs
        from grt_types
       where type_id = l_grtdeals_rec.grt_type_id;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode,
                                'DEAL_GRTTYPE_NOTFOUND',
                                to_char(p_deal_id));
    end;

    -- получение номера счета
    l_nls := f_newnls2(acc2_      => null,
                       descrname_ => 'ZAL',
                       nbs2_      => l_nbs,
                       rnk2_      => l_grtdeals_rec.deal_rnk,
                       idd2_      => null);

    -- получение наименования счета
    l_nms := f_newnms(ACC2_      => null,
                      descrname_ => 'ZAL',
                      nbs_       => l_nbs,
                      RNK2_      => l_grtdeals_rec.deal_rnk,
                      IDD2_      => null);

    --05.08.2011 Sta открытие счета
    --   найти ответ.исп по счету
    begin
      select id, fio, type
        into l_id_isp, l_fio_isp, l_type
        from staff$base
       where id = cc_i_nls(l_grtdeals_rec.staff_id, l_grtdeals_rec.branch);

      if nvl(l_type, 0) <> 1 then
        raise_application_error(-20205,
                                '\    ' || l_id_isp || ' ' || l_fio_isp ||
                                ' - не є вiдповiдальним виконавцем. Заповните довiдник "Вiдповiдальнi виконавцi по бранчам для автом. проводок у КП"!',
                                TRUE);
      end if;

    exception
      when no_data_found then
        raise_application_error(-20210,
                                '\    Для бранча ' || l_grtdeals_rec.branch ||
                                ' - незаповнен довiдник "Вiдповiдальнi виконавцi по бранчам для автом. проводок у КП"!',
                                TRUE);
    end;

    -- собственно открытие счета
    op_reg_Ex(mod_     => 99, -- Opening mode : 0, 1, 2, 3, 4, 9, 99, 77
              p1_      => 0,
              p2_      => 0,
              p3_      => 0,
              p4_      => l_p4, --    OUT INTEGER,
              rnk_     => l_grtdeals_rec.deal_rnk, -- Customer number
              nls_     => l_nls, -- Account  number
              kv_      => l_grtdeals_rec.grt_sum_curcode, -- Currency code
              nms_     => l_nms, -- Account name
              tip_     => 'ZAL', -- Account type
              isp_     => l_id_isp,
              accR_    => l_acc, --    OUT INTEGER,
              nbsnull_ => '1',
              pap_     => null, -- признак а/п береться из плана счетов
              tobo_    => l_grtdeals_rec.branch);

    -- получаем тип обеспечения
    select t.detail_table_id
      into l_table_id
      from grt_types t
     where t.type_id = l_grtdeals_rec.grt_type_id;

    --  05.10.2011 Sta OB22  для залогов и гарантий
    If l_nbs like '950_' then
       -- движимое имущество
       -- ob22 = mpawn = место нахождения залога = 01,02,03
       if    l_grtdeals_rec.grt_place_id = 2 then  l_ob22 := '02';
       elsif l_grtdeals_rec.grt_place_id = 3 then  l_ob22 := '03';
       else                                        l_ob22 := '01';
       end if;
    else
       -- гарантии и НЕдвижимое имущество
       -- ob22 =тип контрагента
       -- 01 - отриманi вiд фiзичних осiб
       -- 02 - отриманi вiд суб`єктiв господарювання
       -- 03 - отриманi вiд органiв державної влади *****пока нет ! уточнить у Вирко (Овчарука)
       select decode (custtype, 3, '01', '02') into l_ob22
       from customer where rnk = l_grtdeals_rec.deal_rnk; -- Customer number
    end if;

    update specparam_int set ob22 = l_ob22 where acc = l_acc;
    if SQL%rowcount = 0 then
       insert into specparam_int (acc, ob22) values (l_acc, l_ob22);
    end if;
    -----------------------

    bars_audit.trace('%s: account registered, acc=%s',
                     l_th,
                     to_char(l_acc));

    -- привязка счета к счетам договора
    insert into cc_accp
      (acc, accs)
      select l_acc, a.acc
        from accounts a, nd_acc n
       where n.nd in (select nd from cc_grt where grt_deal_id = p_deal_id)
         and n.acc = a.acc
         and a.tip in ('SS ', 'SP ', 'SL ')
         and not exists (select 1
                from cc_accp
               where acc = l_acc
                 and accs = a.acc);

    update grt_deals
       set acc = l_acc, status_id = g_status_auth, status_date = sysdate
     where deal_id = p_deal_id;

    bars_audit.trace('%s: grt_deals updated', l_th);

    --05.08.2011 Sta Репликация в старую таблицу PAWN_ACC
    -- должно работать до полного перевода всех приложений типа:
    -- КП, отчетность, резервы, общ.библиотеки по обеспечению
    -- на новое ПО по обеспечению (прежде всего bin\Bars017.apd)

    repl_pawn_acc(p_deal_id);

    -- сохранение истории
    upd_history(p_deal_id, g_status_auth);

    -- запись в журнал
    bars_audit.info(bars_msg.get_msg(g_modcode,
                                     'GRT_DEAL_AUTH',
                                     to_char(p_deal_id)));

    return l_acc;

    bars_audit.trace('%s: done', l_th);

  end authorize_deal;


    --------------------------------------------------------------------------------
      -- close_deal - переводит договор в состояние "закрыт"
  --
  -- @p_deal_id id договора залога
  --
  procedure close_deal(p_deal_id in number) is
    l_th constant varchar2(100) := g_dbgcode || 'close_deal';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_deal_id in number', l_th, to_char(p_deal_id));

    update grt_deals
       set
         status_id = g_status_del,
         status_date = sysdate
     where
       deal_id = p_deal_id;

    -- сохранение истории
    upd_history(p_deal_id, g_status_del);

    -- запись в журнал
    bars_audit.info(bars_msg.get_msg(g_modcode, 'GRT_DEAL_DEL', to_char(p_deal_id)));

    bars_audit.trace('%s: done', l_th);
  end close_deal;

  --------------------------------------------------------------------------------
  -- build_events - заполняет график событий по договору
  --
  -- @p_deal_id - идентификатор договора залога
  -- @p_event_type - тип события
  -- @p_freq_id - идентификатор в справочнике периодичности
  --
  --  1    Щодня
  --  3    Шотижня
  --  5    Щомiсячно
  --  7    Щоквартально
  --  180  Раз на пiвроку
  --  360  Раз на рiк
  --  400  В концi строку
  --
  /* эталонный запрос для получения разных промежутков дат
      with k as (
          select
            :start_date - trunc(:start_date,'mm') as offset,
            :start_date as start_date,
            rownum as i
        from dual
        connect by level < trunc(:end_date) - trunc(:start_date)
      )
      select
        start_date + i   as evdays,
        trunc(start_date + i,'mm') + offset as evmonth,
        trunc(start_date + i,'WW') + offset as evweek,
        trunc(start_date + i,'Q') + offset as evquart,
        trunc(start_date + i,'yyyy') + offset as evyear
      from k
  */
  procedure build_events(
    p_deal_id in grt_deals.deal_id%type,
    p_event_type in grt_event_types.event_id%type,
    p_freq_id in freq.freq%type)
  is
    l_th constant varchar2(100) := g_dbgcode || 'build_events';
    l_end_date date;
    l_start_date date;
    l_mod varchar2(12);
    l_cur_date date;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p[0]=>%s, p[1]=>%s, p[2]=>%s',
      l_th, to_char(p_deal_id), to_char(p_event_type), to_char(p_freq_id) );

    -- поиск даты открытия и закрытия кредитного договора
    select trunc(max(c.wdate)), trunc(max(c.sdate))
      into l_end_date, l_start_date
      from cc_deal c, grt_deals g, cc_grt cg
     where cg.nd = c.nd
       and cg.grt_deal_id = g.deal_id
       and cg.grt_deal_id = p_deal_id;

    bars_audit.trace('%s: l_start_date=%s, l_end_date=%s', l_th,
      to_char(l_start_date,'dd.mm.yyyy'), to_char(l_end_date,'dd.mm.yyyy'));

    -- договор не найден
    if (l_start_date is null or l_end_date is null) then
      bars_error.raise_nerror(g_modcode, 'DEAL_NOTLINKED', to_char(p_deal_id));
    end if;

    -- ежедневно
    if (p_freq_id = 1) then
      l_mod := null;
    -- еженедельно
    elsif (p_freq_id = 3) then
      l_mod := 'WW';
    -- ежемесячно
    elsif (p_freq_id = 5) then
      l_mod := 'mm';
    -- ежеквартально
    elsif (p_freq_id = 7) then
      l_mod := 'Q';
    -- раз в пол-года
    elsif (p_freq_id = 180) then
      l_mod := 'J';
    -- раз в год
    elsif (p_freq_id = 360) then
      l_mod := 'yyyy';
    else
      bars_error.raise_nerror(g_modcode, 'UNSUPPORTED_FREQ', to_char(p_freq_id));
    end if;

    bars_audit.trace('%s: l_mod = %s', l_th, l_mod);

    -- удалить ранее заполненные события
    delete from grt_events
     where deal_id = p_deal_id
       and type_id = p_event_type
       and actual_date is null
       and comment_text is null;

    -- заполнить таблицу событиями
    insert into grt_events(id, deal_id, type_id, planned_date)
    select s_grt_events.nextval, p_deal_id, p_event_type, planned_date
    from
    (
      with k as (
        select
          l_start_date - trunc(l_start_date,'mm') as offset,
          l_start_date as start_date,
          rownum as i
      from dual
      connect by level < trunc(l_end_date) - trunc(l_start_date)
      )
      select unique
        decode(
          l_mod,
          null, start_date + i,
          'J', add_months(trunc(start_date + i, 'year') , trunc((to_char(start_date + i, 'MM') -1)/6)*6+6)-1
           ,trunc(start_date + i, l_mod)
        ) +
        decode(l_mod, null ,0, offset) as planned_date
      from k
    ) where planned_date > l_start_date and planned_date < l_end_date;
    bars_audit.trace('%s: events filled', l_th);

    -- ближайшая дата по типу события
    select min(planned_date) into l_cur_date
      from grt_events where deal_id = p_deal_id and type_id = p_event_type;
    bars_audit.trace('%s: l_cur_date = %s', l_th, to_char(l_cur_date,'dd.mm.yyyy'));

    -- сохранение ближайших дат из графика в таблицу договоров залога

    -- Перевiрка наявностi
    if (p_event_type = 1) then

      update grt_deals set chk_date_avail = l_cur_date
       where deal_id = p_deal_id;
    -- Перевiрка стану
    elsif (p_event_type = 2) then

      update grt_deals set chk_date_status = l_cur_date
       where deal_id = p_deal_id;

    -- Переоцiнка
    elsif (p_event_type = 3) then

      update grt_deals set revalue_date = l_cur_date
       where deal_id = p_deal_id;

    -- не поддерживаемый тип события
    else

      bars_error.raise_nerror(g_modcode, 'UNSUPPORTED_EVENT', to_char(p_event_type));

    end if;

    -- запись в журнал
    bars_audit.info(bars_msg.get_msg(g_modcode, 'GRT_DEAL_TASKS_DONE', to_char(p_deal_id)));

    bars_audit.trace('%s: done', l_th);
  end build_events;

  --------------------------------------------------------------------------------
  -- iu_vehicles - вставка или обновление данных о залоговом движимом имуществе
  --
  -- @see grt_vehicles column comments
  --
  procedure iu_vehicles(
    p_deal_id in grt_vehicles.deal_id%type,
    p_type in grt_vehicles.type%type,
    p_model in grt_vehicles.model%type,
    p_mileage in grt_vehicles.mileage%type,
    p_veh_reg_num in grt_vehicles.veh_reg_num%type,
    p_made_date in grt_vehicles.made_date%type,
    p_color in grt_vehicles.color%type,
    p_vin in grt_vehicles.vin%type,
    p_engine_num in grt_vehicles.engine_num%type,
    p_reg_doc_ser in grt_vehicles.reg_doc_ser%type,
    p_reg_doc_num in grt_vehicles.reg_doc_num%type,
    p_reg_doc_date in grt_vehicles.reg_doc_date%type,
    p_reg_doc_organ in grt_vehicles.reg_doc_organ%type,
    p_reg_owner_addr in grt_vehicles.reg_owner_addr%type,
    p_reg_spec_marks in grt_vehicles.reg_spec_marks%type,
    p_parking_addr in grt_vehicles.parking_addr%type,
    p_crd_end_date in grt_vehicles.crd_end_date%type,
    p_ownship_reg_num in grt_vehicles.ownship_reg_num%type,
    p_ownship_reg_checksum in grt_vehicles.ownship_reg_checksum%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'iu_vehicles';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id = %s', l_th, p_deal_id);

    update grt_vehicles set
      type = p_type,
      model = p_model,
      mileage = p_mileage,
      veh_reg_num = p_veh_reg_num,
      made_date = p_made_date,
      color = p_color,
      vin = p_vin,
      engine_num = p_engine_num,
      reg_doc_ser = p_reg_doc_ser,
      reg_doc_num = p_reg_doc_num,
      reg_doc_date = p_reg_doc_date,
      reg_doc_organ = p_reg_doc_organ,
      reg_owner_addr = p_reg_owner_addr,
      reg_spec_marks = p_reg_spec_marks,
      parking_addr = p_parking_addr,
      crd_end_date = p_crd_end_date,
      ownship_reg_num = p_ownship_reg_num,
      ownship_reg_checksum = p_ownship_reg_checksum
    where deal_id = p_deal_id;

    if (sql%rowcount = 0) then

      insert into grt_vehicles (deal_id, type, model, mileage, veh_reg_num,
        made_date, color, vin, engine_num, reg_doc_ser, reg_doc_num,
        reg_doc_date, reg_doc_organ, reg_owner_addr, reg_spec_marks,
        parking_addr, crd_end_date, ownship_reg_num, ownship_reg_checksum)
      values (
        p_deal_id, p_type, p_model, p_mileage, p_veh_reg_num, p_made_date,
        p_color, p_vin, p_engine_num, p_reg_doc_ser, p_reg_doc_num,
        p_reg_doc_date, p_reg_doc_organ, p_reg_owner_addr, p_reg_spec_marks,
        p_parking_addr, p_crd_end_date, p_ownship_reg_num, p_ownship_reg_checksum
      );

    end if;

    bars_audit.trace('%s: done', l_th);
  end iu_vehicles;

  --------------------------------------------------------------------------------
  -- iu_mortgage - вставка или обновление данных о залоговой ипотеке
  --
  -- @see grt_mortgage column comments
  --
  procedure iu_mortgage(
    p_deal_id in grt_mortgage.deal_id%type,
    p_rooms_cnt in grt_mortgage.rooms_cnt%type,
    p_app_num in grt_mortgage.app_num%type,
    p_total_space in grt_mortgage.total_space%type,
    p_living_space in grt_mortgage.living_space%type,
    p_floor in grt_mortgage.floor%type,
    p_addr in grt_mortgage.addr%type,
    p_buiding_type in grt_mortgage.buiding_type%type,
    p_building_num in grt_mortgage.building_num%type,
    p_building_lit in grt_mortgage.building_lit%type,
    p_city in grt_mortgage.city%type,
    p_city_distr in grt_mortgage.city_distr%type,
    p_living_distr in grt_mortgage.living_distr%type,
    p_micro_distr in grt_mortgage.micro_distr%type,
    p_area_num in grt_mortgage.area_num%type,
    p_build_sect_count in grt_mortgage.build_sect_count%type,
    p_add_grt_addr in grt_mortgage.add_grt_addr%type,
    p_mort_doc_num in grt_mortgage.mort_doc_num%type,
    p_mort_doc_date in grt_mortgage.mort_doc_date%type,
    p_ownship_reg_num in grt_mortgage.ownship_reg_num%type,
    p_ownship_reg_checksum in grt_mortgage.ownship_reg_checksum%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'iu_mortgage';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id = %s', l_th, p_deal_id);

    update grt_mortgage set
      rooms_cnt = p_rooms_cnt,
      app_num = p_app_num,
      total_space = p_total_space,
      living_space = p_living_space,
      floor = p_floor,
      addr = p_addr,
      buiding_type = p_buiding_type,
      building_num = p_building_num,
      building_lit = p_building_lit,
      city = p_city,
      city_distr = p_city_distr,
      living_distr = p_living_distr,
      micro_distr = p_micro_distr,
      area_num = p_area_num,
      build_sect_count = p_build_sect_count,
      add_grt_addr = p_add_grt_addr,
      mort_doc_num = p_mort_doc_num,
      mort_doc_date = p_mort_doc_date,
      ownship_reg_num = p_ownship_reg_num,
      ownship_reg_checksum = p_ownship_reg_checksum
    where
      deal_id = p_deal_id;

    if (sql%rowcount = 0) then

      insert into grt_mortgage (deal_id, rooms_cnt, app_num, total_space, living_space,
        floor, addr, buiding_type, building_num, building_lit, city, city_distr,
        living_distr, micro_distr, area_num, build_sect_count, add_grt_addr,
        mort_doc_num, mort_doc_date, ownship_reg_num, ownship_reg_checksum)
      values (
        p_deal_id, p_rooms_cnt, p_app_num, p_total_space, p_living_space,
        p_floor, p_addr, p_buiding_type, p_building_num, p_building_lit,
        p_city, p_city_distr, p_living_distr, p_micro_distr, p_area_num,
        p_build_sect_count, p_add_grt_addr, p_mort_doc_num, p_mort_doc_date,
        p_ownship_reg_num, p_ownship_reg_checksum
      );

    end if;

    bars_audit.trace('%s: done', l_th);
  end iu_mortgage;

  --------------------------------------------------------------------------------
  -- iu_mortgage_land - вставка или обновление данных о залоговой ипотеке (земля)
  --
  -- @see grt_mortgage_land column comments
  --
  procedure iu_mortgage_land(
    p_deal_id in grt_mortgage_land.deal_id%type,
    p_area in grt_mortgage_land.area%type,
    p_land_purpose in grt_mortgage_land.land_purpose%type,
    p_build_num in grt_mortgage_land.build_num%type,
    p_build_lit in grt_mortgage_land.build_lit%type,
    p_ownship_doc_ser in grt_mortgage_land.ownship_doc_ser%type,
    p_ownship_doc_num in grt_mortgage_land.ownship_doc_num%type,
    p_ownship_doc_date in grt_mortgage_land.ownship_doc_date%type,
    p_ownship_doc_reason in grt_mortgage_land.ownship_doc_reason%type,
    p_ownship_regbook_num in grt_mortgage_land.ownship_regbook_num%type,
    p_extract_reg_date in grt_mortgage_land.extract_reg_date%type,
    p_extract_reg_organ in grt_mortgage_land.extract_reg_organ%type,
    p_extract_reg_num in grt_mortgage_land.extract_reg_num%type,
    p_extract_reg_sum in grt_mortgage_land.extract_reg_sum%type,
    p_lessee_num in grt_mortgage_land.lessee_num%type,
    p_lessee_name in grt_mortgage_land.lessee_name%type,
    p_lessee_dog_enddate in grt_mortgage_land.lessee_dog_enddate%type,
    p_lessee_dog_num in grt_mortgage_land.lessee_dog_num%type,
    p_lessee_dog_date in grt_mortgage_land.lessee_dog_date%type,
    p_bans_reg_num in grt_mortgage_land.bans_reg_num%type,
    p_bans_reg_date in grt_mortgage_land.bans_reg_date%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'iu_mortgage_land';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id = %s', l_th, p_deal_id);

    update grt_mortgage_land set
      area = p_area,
      land_purpose = p_land_purpose,
      build_num = p_build_num,
      build_lit = p_build_lit,
      ownship_doc_ser = p_ownship_doc_ser,
      ownship_doc_num = p_ownship_doc_num,
      ownship_doc_date = p_ownship_doc_date,
      ownship_doc_reason = p_ownship_doc_reason,
      ownship_regbook_num = p_ownship_regbook_num,
      extract_reg_date = p_extract_reg_date,
      extract_reg_organ = p_extract_reg_organ,
      extract_reg_num = p_extract_reg_num,
      extract_reg_sum = p_extract_reg_sum,
      lessee_num = p_lessee_num,
      lessee_name = p_lessee_name,
      lessee_dog_enddate = p_lessee_dog_enddate,
      lessee_dog_num = p_lessee_dog_num,
      lessee_dog_date = p_lessee_dog_date,
      bans_reg_num = p_bans_reg_num,
      bans_reg_date = p_bans_reg_date
    where
      deal_id = p_deal_id;

    if (sql%rowcount = 0) then

      insert into grt_mortgage_land(deal_id, area, land_purpose, build_num,
        build_lit, ownship_doc_ser, ownship_doc_num, ownship_doc_date,
        ownship_doc_reason, ownship_regbook_num, extract_reg_date,
        extract_reg_organ, extract_reg_num, extract_reg_sum, lessee_num,
        lessee_name, lessee_dog_enddate, lessee_dog_num, lessee_dog_date,
        bans_reg_num, bans_reg_date)
      values (
        p_deal_id, p_area, p_land_purpose, p_build_num, p_build_lit,
        p_ownship_doc_ser, p_ownship_doc_num, p_ownship_doc_date,
        p_ownship_doc_reason, p_ownship_regbook_num, p_extract_reg_date,
        p_extract_reg_organ, p_extract_reg_num, p_extract_reg_sum,
        p_lessee_num, p_lessee_name, p_lessee_dog_enddate, p_lessee_dog_num,
        p_lessee_dog_date, p_bans_reg_num, p_bans_reg_date
      );

    end if;
    bars_audit.trace('%s: done', l_th);
  end iu_mortgage_land;

  --------------------------------------------------------------------------------
  -- iu_products - вставка или обновление данных о залоговых товарах
  --
  -- @see grt_products column comments
  --
  procedure iu_products(
    p_deal_id in grt_products.deal_id%type,
    p_type_txt in grt_products.type_txt%type,
    p_name in grt_products.name%type,
    p_model in grt_products.model%type,
    p_modification in grt_products.modification%type,
    p_serial_num in grt_products.serial_num%type,
    p_made_date in grt_products.made_date%type,
    p_other_comments in grt_products.other_comments%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'iu_products';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id = %s', l_th, p_deal_id);

    update grt_products set
      type_txt = p_type_txt,
      name = p_name,
      model = p_model,
      modification = p_modification,
      serial_num = p_serial_num,
      made_date = p_made_date,
      other_comments = p_other_comments
    where
      deal_id = p_deal_id;

    if (sql%rowcount = 0) then

      insert into grt_products(deal_id, type_txt, name, model, modification, serial_num,
        made_date, other_comments)
      values (p_deal_id, p_type_txt, p_name, p_model, p_modification, p_serial_num,
        p_made_date, p_other_comments);

    end if;

    bars_audit.trace('%s: done', l_th);
  end iu_products;

  --------------------------------------------------------------------------------
  -- iu_deposits - вставка или обновление данных о залоговых депозитах
  --
  -- @see grt_deposits column comments
  --
  procedure iu_deposits(
    p_deal_id in grt_deposits.deal_id%type,
    p_doc_num in grt_deposits.doc_num%type,
    p_doc_date in grt_deposits.doc_date%type,
    p_doc_enddate in grt_deposits.doc_enddate%type,
    p_acc in grt_deposits.acc%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'iu_deposits';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id = %s', l_th, p_deal_id);

    update grt_deposits set
      doc_num = p_doc_num,
      doc_date = p_doc_date,
      doc_enddate = p_doc_enddate,
      acc = p_acc
    where deal_id = p_deal_id;

    if (sql%rowcount = 0) then

      insert into grt_deposits(deal_id, doc_num, doc_date, doc_enddate, acc)
      values (p_deal_id, p_doc_num, p_doc_date, p_doc_enddate, p_acc);

    end if;

    bars_audit.trace('%s: done', l_th);
  end iu_deposits;

  --------------------------------------------------------------------------------
  -- iu_valuables - вставка или обновление данных о залоговых ценностях
  --
  -- @see grt_valuables column comments
  --
  procedure iu_valuables(
    p_deal_id in grt_valuables.deal_id%type,
    p_name in grt_valuables.name%type,
    p_descr in grt_valuables.descr%type,
    p_weight in grt_valuables.weight%type,
    p_part_cnt in grt_valuables.part_cnt%type,
    p_part_disc_weig in grt_valuables.part_disc_weig%type,
    p_value_weight in grt_valuables.value_weight%type,
    p_tariff_price in grt_valuables.tariff_price%type,
    p_expert_price in grt_valuables.expert_price%type,
    p_estimate_price in grt_valuables.estimate_price%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'iu_valuables';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id = %s', l_th, p_deal_id);

    update grt_valuables set
      name = p_name,
      descr = p_descr,
      weight = p_weight,
      part_cnt = p_part_cnt,
      part_disc_weig = p_part_disc_weig,
      value_weight = p_value_weight,
      tariff_price = p_tariff_price,
      expert_price = p_expert_price,
      estimate_price = p_estimate_price
    where
      deal_id = p_deal_id;

    if (sql%rowcount = 0) then

      insert into grt_valuables(deal_id, name, descr, weight, part_cnt,
        part_disc_weig, value_weight, tariff_price, expert_price, estimate_price)
      values (p_deal_id, p_name, p_descr, p_weight, p_part_cnt,
        p_part_disc_weig, p_value_weight, p_tariff_price, p_expert_price, p_estimate_price);

    end if;
    bars_audit.trace('%s: done', l_th);
  end iu_valuables;

  --------------------------------------------------------------------------------
  -- fill_cc_grt - добавляет связь крединого и залогового договоров
  --
  -- @p_nd - идентификатор кредитного договора
  -- @p_deal_id - идентификатор договора залога
  --
  procedure fill_cc_grt(
    p_nd in cc_deal.nd%type,
    p_deal_id in grt_deals.deal_id%type)
  is
    l_th constant varchar2(100) := g_dbgcode || 'fill_cc_grt';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_deal_id=%s, p_nd=%s', l_th, to_char(p_deal_id), to_char(p_nd));

    begin
      insert into cc_grt(nd, grt_deal_id) values(p_nd, p_deal_id);
    exception when dup_val_on_index then
      bars_audit.trace('%s: dup_val_on_index raised', l_th);
    end;

    bars_audit.trace('%s: done', l_th);
  end fill_cc_grt;

  --------------------------------------------------------------------------------
  -- check_auth - проверяет договор на предмет его авторизации
  --
  -- @p_deal_id in number
  --
  procedure check_auth(p_deal_id in number)
  is
    l_th constant varchar2(100) := g_dbgcode || 'check_auth';
    l_status_id number;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_deal_id in number', l_th, to_char(p_deal_id));

    select max(status_id) into l_status_id
      from grt_deals
     where deal_id = p_deal_id;

    if (l_status_id != g_status_auth) then
      bars_error.raise_nerror(g_modcode, 'DEAL_NOTAUTH', to_char(p_deal_id));
    end if;

    bars_audit.trace('%s: done', l_th);

  end check_auth;

  --------------------------------------------------------------------------------
  -- insert_event - добавляет запись в график событий по договору
  --
  --
  procedure insert_event(
    p_deal_id in grt_deals.deal_id%type,
    p_type_id in grt_event_types.event_id%type,
    p_planned_date in grt_events.planned_date%type,
    p_actual_date in grt_events.actual_date%type,
    p_comment_text in grt_events.comment_text%type
  )
  is
    l_th constant varchar2(100) := g_dbgcode || 'insert_event';
    l_cnt number;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_deal_id=%s, p_type_id=%s, p_planned_date=%s', l_th,
      to_char(p_deal_id), to_char(p_type_id), to_char(p_planned_date,'dd.mm.yyyy'));

    select count(*) into l_cnt from grt_events
    where deal_id = p_deal_id and type_id = p_type_id
      and planned_date = trunc(p_planned_date);

    if (l_cnt = 0) then

      if (p_actual_date is not null) then
        check_auth(p_deal_id);
      end if;

      insert into grt_events (id, deal_id, type_id, planned_date, actual_date, comment_text)
        values (s_grt_events.nextval, p_deal_id, p_type_id, p_planned_date, p_actual_date, p_comment_text);
    end if;

    bars_audit.trace('%s: done', l_th);
  end insert_event;

  --------------------------------------------------------------------------------
  -- update_event - обновляет информацию о событии по договору
  --
  -- @p_event_id in - код события
  -- @p_actual_date - дата выполнения события
  -- @p_comment_text - комментарий пользователя
  --
  procedure update_event(
    p_event_id in grt_events.id%type,
    p_actual_date in grt_events.actual_date%type,
    p_comment_text in grt_events.comment_text%type
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'update_event';
    l_deal_id number;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_event_id =', l_th, to_char(p_event_id));

    select deal_id into l_deal_id
      from grt_events
     where id = p_event_id;

    check_auth(l_deal_id);

    update grt_events
       set
         actual_date = p_actual_date,
         comment_text = p_comment_text
     where id = p_event_id;

    bars_audit.trace('%s: done', l_th);
  end update_event;

  --------------------------------------------------------------------------------
  -- create_account_balance - создает проводку для формирование
  --                          первоначального остатка по обеспечению
  --
  --
  procedure create_account_balance(  p_deal_id in cc_grt.grt_deal_id%type ) is

    l_th constant varchar2(100) := g_dbgcode || 'create_account_balance';

    l_vob    oper.vob%type;
    l_dk     oper.dk%type;
    REF_     oper.ref%type;
    l_nls9   tts.nlsm%type;
    l_nms9   oper.nam_a%type;
    l_nazn   OPER.NAZN%type;
    l_fl_opl int;

  begin
    select nlsM, substr(flags, 38, 1)
      into l_nls9, l_fl_opl
      from tts
     where tt = 'ZAL';

    IF SUBSTR(l_nls9, 1, 2) = '#(' THEN
      -- Dynamic account number present
      BEGIN
        EXECUTE IMMEDIATE 'SELECT ' || SUBSTR(l_nls9, 3, LENGTH(l_nls9) - 3) ||
                          ' FROM DUAL'
          INTO l_nls9;
      EXCEPTION
        WHEN OTHERS THEN
          raise_application_error(- (20203),
                                  '\9351 - Cannot get account nom via ' ||
                                  l_nls9 || ' ' || SQLERRM,
                                  TRUE);
      END;
    END IF;

    bars_audit.trace('%s: l_nls9 = %s  l_fl_opl=%s',
                     l_th,
                     to_char(l_nls9),
                     to_char(l_fl_opl));

    select substr(nms, 1, 38)
      into l_nms9
      from accounts
     where nls = l_nls9
       and kv = gl.baseval;

    SELECT to_number(val) into l_vob from params where par = 'VOB9_P';

    for k in (select d.cc_id,
                     d.sdate,
                     A.NBS,
                     a.nls,
                     a.nms,
                     a.kv,
                     GD.GRT_SUM,
                     c.okpo,
                     gd.staff_id,
                     gd.branch
                from cc_grt    cc,
                     grt_deals gd,
                     accounts  a,
                     cc_deal   d,
                     customer  c
               where cc.grt_deal_id = p_deal_id
                 and cc.nd = d.nd
                 and cc.grt_deal_id = gd.deal_id
                 and gd.grt_sum > 0
                 and gd.acc = a.acc
                 and a.ostc = 0
                 and a.ostc = a.ostb
                 and a.rnk = c.rnk)
    loop

      if k.nbs = '9031' then
        l_dk   := 0;
        l_NAZN := 'Зарахування суми поруки згiдно угоди ' || k.CC_ID || ' вiд ' ||
                  to_char(k.sdate, 'dd/mm/yyyy');
      else
        l_dk   := 1;
        l_NAZN := 'Зарахування суми застави згiдно угоди ' || k.CC_ID || ' вiд ' ||
                  to_char(k.sdate, 'dd/mm/yyyy');
      end if;
      --GRT_SUM Начальная стоимость заложенного имущества
      --        она же "Балансовая стоимость"
      GL.REF(REF_);

-- 26-10-2011 STA ===================================================
--    k.staff_id = код залоговика, уровень которого м.б. выше,
--                 чем уровень с которого делается эта процедура
      declare

       --запомнить свой уровень ( не начальный по STAFF$BASE, а после возможного прикида )
       t_branch branch.branch%type := sys_context('bars_context','user_branch') ;


      begin

        -- установить филиальный доступ (МФО)
        -- Taras Shedenko: Документ залга должен быть на том же уровне, что и договор
        begin
          bc.subst_branch(k.branch);
        exception when others then
          bars_audit.error(l_th||
            '%s: Не удалось перейти в бранч "'||k.branch||'" при создании проводки по дог. залога "'||p_deal_id||'"'||
            dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
          raise;
        end;

        -- вызов внутренней процедуры
        gl.in_doc3(ref_ => REF_,         tt_    => 'ZAL',   vob_  => l_VOB,
                 nd_    => substr(to_char(REF_),1, 10) ,    pdat_ => SYSDATE,
                 vdat_  => gl.BDATE,      dk_   => l_dk,    kv_   => k.kv,
                 s_     => k.GRT_Sum,     kv2_  => k.kv,    s2_   => k.GRT_Sum,
                 sk_    => null,          data_ => gl.BDATE,datp_ => gl.bdate,
                 nam_a_ => substr(k.nms, 1,38),             nlsa_ => k.nls, mfoa_ => gl.aMfo,
                 nam_b_ => substr(l_nms9,1,38),             nlsb_ => l_nls9,mfob_ => gl.aMfo,
                 nazn_  => substr(l_NAZN,1,160),            d_rec_=> null,  id_a_ => null,
                 id_b_  => null,          id_o_ => null,    sign_ => null,  sos_  => 0,
                 prty_  => null,          uid_  => k.staff_id);

        -- вернуться в свою область видимости
        bc.subst_branch ( t_branch ) ;
      exception when others then
        -- вернуться в свою область видимости
        bc.subst_branch ( t_branch ) ;
        -- исключение бросаем дальше
        raise_application_error(-20000, SQLERRM||chr(10)
        	||dbms_utility.format_error_backtrace(), true);
      end;
-- 26-10-2011 STA ===================================================

      --GL.PAYV(l_fl_opl,REF_,GL.BDATE,'ZAL',l_dk, gl.baseval,k.nls,k.GRT_Sum, gl.baseval,l_nls9,k.GRT_Sum );
      gl.payv(flg_  => 0,
              ref_  => REF_,
              dat_  => gl.bDATE,
              tt_   => 'ZAL',
              dk_   => l_dk,
              kv1_  => k.kv,
              nls1_ => k.nls,
              sum1_ => k.GRT_Sum,
              kv2_  => k.kv,
              nls2_ => l_nls9,
              sum2_ => k.GRT_Sum);

      if l_fl_opl = 1 then
        gl.pay(2, REF_, gl.bdate);
      end if;

    end loop;

  end create_account_balance;

begin
  -- Initialization
  null;
end grt_mgr;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/grt_mgr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 