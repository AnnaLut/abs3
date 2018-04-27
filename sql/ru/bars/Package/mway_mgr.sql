PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mway_mgr.sql =========*** Run *** ==
PROMPT ===================================================================================== 

CREATE OR REPLACE PACKAGE BARS.MWAY_MGR
is
  --
  -- Автор  : OLEG
  -- Создан : 04.06.2013
  --
  -- Purpose : обработка запросов от WAY4 mobile banking
  --

  -- Public constant declarations
  g_header_version  constant varchar2(64)  := 'version 4.6 13/02/2018';
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
  -- get_mw_date -  переводит дату в формат вея
  --
  --
  function get_mway_date(p_date in date) return varchar2;

  --------------------------------------------------------------------------------
  -- formatISO_8601 -  формат по стандарту ISO 8601
  --
  --
  function formatISO_8601(duration_years in int, duration_month in int, duration_days in int) return varchar2;

  --------------------------------------------------------------------------------
  -- get_response_http - точка входа для обработки входящих запросов через HTTP
  --
  -- @p_request_head - заголовок http-запроса
  -- @p_request_body - тело http-запроса
  --
  function get_response_http(
    p_request_head in clob,
    p_request_body in clob) return clob;

  --------------------------------------------------------------------------------
  -- get_response - точка входа для обработки входящих запросов через PL/SQL
  --
  -- @p_request_body - тело http-запроса
  --
  function get_response(
    p_request_xml in clob) return clob;

  --------------------------------------------------------------------------------
  -- get_product_xml -  возвращает элемент Product
  --
  --
  function get_product(
    p_product_name in varchar2,
    p_parm_code in varchar2,
    p_parm_value in varchar2,
    p_product_code in varchar2 default null
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_contract_idt -  озвращает элемент ContractIDT
  --
  --
  function get_contract_idt(
    p_contract_number in varchar2,
    p_nmk in customer.nmk%type
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_general_info -  озвращает элементы  заголовка элемента Contract
  --
  --
  function get_general_info(
    p_lcv in varchar2,
    p_date_open in date,
    p_date_expiry in date,
    p_name in varchar2
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_acclist -  возвращает элемент ContractRs для текущих счетов клиента
  --
  --
  function get_acclist(
    p_rnk in number
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_add_info -  возвращает элемент AddContractInfo
  --
  --
  function get_add_info(
    p_info in varchar2
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_crdlist -  возвращает элемент ContractRs для текущих депозитов клиента
  --
  --
  function get_dptlist(
    p_rnk in number,
    p_is_replanish in number default null
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_dpt -  возвращает элемент ContractRs для текущего депозита клиента
  --
  --
  function get_dpt(
    p_rnk in number,
    p_deposit_id in number
  ) return xmltype;

  --------------------------------------------------------------------------------
  -- get_crdlist -  возвращает элемент ContractRs для текущих кредитов клиента
  --
  --
  function get_crdlist(
    p_rnk in number
  ) return xmltype  ;

    --------------------------------------------------------------------------------
  -- get_datetime_fact -  возвращает дату и время фактической оплаты документа
  --
  --
  function get_datetime_fact(
    p_ref oper.ref%type
  ) return varchar2;

  function get_response_int
  ( p_request_xml in clob
  ) return clob;

  procedure set_state_trans(p_id mway_match.id%type,
                          p_state mway_match.state%type
  );

  procedure PAY_REVERSAL;

/*function get_destination_prop
  ( p_xml xmltype,
    p_extra_type varchar2,
    p_property_code varchar2,
    p_extra_parm varchar2
  ) return varchar2;*/

end mway_mgr;
/

show errors;

CREATE OR REPLACE PACKAGE BODY MWAY_MGR
is
  --
  -- Автор  : OLEG
  -- Создан : 04.06.2013
  --
  -- Purpose : обработка запросов от WAY4 mobile banking
  --

  -- Private constant declarations
  g_body_version  constant varchar2(64)  := 'version 5.7 16/03/2018';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode constant varchar2(12) := 'mway_mgr.';

  g_last_reqid number;

  G_DIRECTION_INPUT constant varchar2(1) := 'I';
  G_DIRECTION_OUTPUT constant varchar2(1) := 'O';
  G_MW_DATE_FORMAT constant varchar2(10) := 'yyyy-mm-dd';

  G_TECH_USER constant varchar2(30) := 'TECH_W4';
  G_W4LIMIT constant varchar2(30) := 'W4LIMIT';

  G_ABS_ACCOUNT constant varchar2(50) := 'ABS_ACCOUNT';
  G_ABS_CREDIT constant varchar2(50) := 'ABS_CREDIT';
  G_ABS_DEPOSIT constant varchar2(50) := 'ABS_DEPOSIT';
  G_ABS_DEPOSIT_REFILL constant varchar2(50) := 'ABS_DEPOSIT_REFILL';
  G_TRANSFER_CARD_ACC constant varchar2(50) := 'TRANSFER_CARD_ACC';--Перевод карта –> текущий счет в АБС
  G_TRANSFER_ACC_CARD constant varchar2(50) := 'TRANSFER_ACC_CARD';--Перевод текущий счет в АБС –> карта
  G_TRANSFER_CARD_DEP_ACC constant varchar2(50) := 'TRANSFER_CARD_DEP_ACC';--Перевод карта – депозит
  G_TRANSFER_CARD_CREDIT constant varchar2(50) := 'TRANSFER_CARD_CREDIT';--Перевод карта – кредит
  G_TRANSFER_ACC_UKR_FIZ_UR constant varchar2(50) := 'TRANSFER_ACC_UKR_FIZ_UR';--Перевод текущий счет – другой банк
  --G_TRANSFER_BANK_UKR_FIZ constant varchar2(50) := 'TRANSFER_BANK_UKR_FIZ';--Перевод текущий счет – текущий счет
  G_TRANSFER_BANK_UKR_FIZ constant varchar2(50) := 'TRANSFER_ACC_ACC';--Перевод текущий счет – текущий счет
  G_TRANSFER_CARDACC_DEPOSIT constant varchar2(50) := 'TRANSFER_CARDACC_DEPOSIT';--Перевод карта\текущий – депозит
  G_TRANSFER_ACC_DEPOSIT constant varchar2(50) := 'TRANSFER_ACC_DEPOSIT'; --Перевод текущий – депозит

  l_tech_user number;

  l_target varchar2(20);

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header mway_mgr '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body mway_mgr '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
  end body_version;


  --------------------------------------------------------------------------------
  -- get_mw_date -  переводит дфту в формат вея
  --
  --
  function get_mway_date(p_date in date) return varchar2
  is
  begin
    return to_char(p_date, G_MW_DATE_FORMAT);
  end;


  --------------------------------------------------------------------------------
  -- txtcnv -  переводит строку с кодировки 1251 в UTF8
  --
  --
  function txtcnv(p_txt in varchar2) return  varchar2 is
  begin
    return convert(p_txt, 'CL8MSWIN1251','UTF8');
  end txtcnv;

  --------------------------------------------------------------------------------
  -- formatISO_8601 -  формат по стандарту ISO 8601
  --
  --
  function formatISO_8601(duration_years in int, duration_month in int, duration_days in int) return varchar2
  is
   l_result varchar2(500) := 'P';
   l_years int := nvl(duration_years,0);
   l_months int := nvl(duration_month,0);
   l_days int := nvl(duration_days,0);
  begin
   if l_months >= 12
   then
    l_years := l_years + round(l_months/12);
    l_months := l_months -  l_years*12;
   end if;
   if (l_years > 0)   then l_result := l_result ||to_char(l_years)|| 'Y'; end if;
   if (l_months > 0)  then l_result := l_result ||lpad(to_char(l_months),2,'')|| 'M'; end if;
   if (l_days > 0)    then l_result := l_result ||lpad(to_char(l_days),2,'') || 'D'; end if;

   return l_result;
  end;


  --------------------------------------------------------------------------------
  -- log - сохраняет входящие и исходящие запросы
  --
  -- @p_direction - направление входящие/исходящие
  -- @p_data - xml запроса
  --
  procedure log(p_direction in varchar2, p_data in clob, p_userrnk customer.rnk%type, p_transcode varchar2) is
    pragma autonomous_transaction;

    l_th constant varchar2(100) := g_dbgcode || 'log';
    l_resp_for number;
  begin
    bars_audit.trace('%s: entry point', l_th);

    if p_direction = G_DIRECTION_OUTPUT then
      l_resp_for := g_last_reqid;
    else
      l_resp_for := null;
    end if;

    g_last_reqid := s_mwaylog.nextval;

    insert into mway_log
      (id, log_dir, log_date, log_data, resp_for, userrnk, transcode, MsgId)
    values
      (g_last_reqid, p_direction, sysdate, p_data, l_resp_for, p_userrnk, p_transcode,
       case p_direction when G_DIRECTION_INPUT then xmltype(p_data).extract('/UFXMsg/MsgId/text()') end);
    commit work;

    bars_audit.trace('%s: done', l_th);
  end log;

  --------------------------------------------------------------------------------
  -- make_crddata -  подготавливает данные для отображения кредитов клиента
  --
  --
  procedure make_crddata(
    p_rnk in customer.rnk%type
  )
  is
    l_th constant varchar2(100) := g_dbgcode || 'make_crddata';
    l_row tmp_mw_crddata%rowtype;
  begin

    bars_audit.trace('%s: entry point', l_th);

    for c in (
      select d.*--, a.
        from cc_deal d--, cc_add a
       where --d.nd = a.nd
         d.rnk = p_rnk
         and d.vidd in (11,12,13)
         and d.sos >= 10
         and d.sos < 14
    )
    loop

      l_row.nd := c.nd;
      l_row.client_id := c.rnk;
      l_row.cr_vidd := c.vidd;
      l_row.cr_number := c.cc_id;
      l_row.branch := c.branch;
      l_row.cr_date_open := c.sdate;
      l_row.cr_date_close := c.wdate;
      l_row.cr_agreement := c.cc_id;

      -- Сумма кредита
      select greatest(c.sdog*100,sum(nvl(sumg, 0))) -- общ. без % план-сумма договора
        into l_row.cr_amount
        from cc_pog
       where nd = c.nd
         and (sumg > 0 or sumo > 0);

      -- валюта кредита
      select a.kv, t.lcv, a.nls
        into l_row.cr_currency, l_row.cr_currency_lcv, l_row.cr_account_lim
        from accounts a, nd_acc na, tabval$global t
       where a.acc = na.acc and na.ND = c.nd and a.nls like '8999%' and a.tip = 'LIM'
         and a.kv = t.kv;

      --  Номер расчетного счета, через который клиент может производить погашение кредита

      select max(a.nls)
        into l_row.cr_account
        from
          accounts a,
          nd_acc n
       where
         a.acc = n.acc and
         (a.tip = 'SG ' or a.tip = 'DEP') and
         n.nd = c.nd;

      -- ccудный счет
      select max(a.nls)
        into l_row.cr_account_ss
        from
          accounts a,
          nd_acc n
       where
         a.acc = n.acc and
         a.tip = 'SS ' and
         n.nd = c.nd;

      --Процентная ставка
      select rate
        into l_row.cr_interest_rate
        from (select acrn.fprocn(acc,0, bankdate_g) rate
                from (select a.acc from accounts a,int_accn i,nd_acc n
                       where n.acc=a.acc
                         and a.tip in (upper('ss'),upper('lim'))
                         and (select count(1) from saldoa sa where sa.acc=a.acc)!=0
                         and i.id=0
                         and i.acc=a.acc
                         and n.nd=c.nd
                       order by decode(acrn.fprocn(a.acc,0, bankdate_g),0,0,1), a.daos desc
                       )
               where rownum =1
              );

      -- Сумма начисленных процентов
      select abs(sum(nvl(gl.p_ncurval(980, gl.p_icurval(a.kv, fost(a.acc, bankdate_g), bankdate_g), bankdate_g),0)))
        into l_row.cr_interest_amount
        from accounts a, nd_acc n
       where n.nd = c.nd
         and n.acc = a.acc
         and a.tip in (--'SS ', -- SS  Основний борг
                       'SN ', -- SN  Процентний борг
                       --'SP ', -- SP  Просрочений осн.борг
                       'SPN', -- SPN Просрочений проц.борг
                       --'SL ', -- SL  Сумнівний осн.борг
                       'SLN'--, -- SLN Сомнительный процентный долг
                       --'SK0', -- SK0 Нарах. комісія за кредит
                       --'SK9', -- SK9 Просроч. комісія за кредит
                       --'SN8' -- SN8 Нарах.пеня
                       );
      -- Остаток кредита по договору
      select abs(sum(nvl(gl.p_ncurval(980, gl.p_icurval(a.kv, fost(a.acc, bankdate_g), bankdate_g), bankdate_g),0)))
        into l_row.cr_due_amount
        from accounts a, nd_acc n
       where n.nd = c.nd
         and n.acc = a.acc
         and a.tip in (upper('LIM'));

      -- Дата ближайшего погашения
      select (select dat_next_u(min(fdat)-1,1)
                from cc_lim l
               where l.fdat > trunc(bankdate_g)
                 and l.nd = c.nd
                 and l.sumo  != 0)
        into l_row.cr_next_paym_date
        from dual;

        -- Размер тела следующего платежа
        select (case
               when c.vidd in (12,13) then null else nvl((select sumg
                      from cc_lim
                     where nd = c.nd
                       and fdat =
                                  (select min(fdat)
                                     from cc_lim l
                                    where l.fdat > trunc(bankdate_g)
                                      and l.nd = c.nd
                                      and l.sumo  != 0)
                       ),0) end)
         into l_row.cr_principal_base
         from dual;

        --Проценти -- budnikov 02.06.2014
        select (case
               when c.vidd in (12,13) then null else nvl((select sumo - sumg
                      from cc_lim
                     where nd = c.nd
                       and fdat =
                                  (select min(fdat)
                                     from cc_lim l
                                    where l.fdat > trunc(bankdate_g)
                                      and l.nd = c.nd
                                      and l.sumo  != 0)
                       ),0) end)
         into l_row.cr_interest_base
         from dual;

        --Розмер просроченой задолжености по телу
         select nvl(
           (select abs(sum(nvl(gl.p_ncurval(980, gl.p_icurval(a.kv, fost(a.acc, bankdate_g), bankdate_g), bankdate_g),0))) cr_principal_overdue
                  from accounts a, nd_acc n
                 where n.acc=a.acc
                   and n.nd=c.nd
                   and a.tip in (--'SS ', -- SS  Основний борг
                                 --'SN ', -- SN  Процентний борг
                                 'SP ', -- SP  Просрочений осн.борг
                                 --'SPN', -- SPN Просрочений проц.борг
                                 'SL '--,  SL  Сумнівний осн.борг
                                 --'SLN', -- SLN Сомнительный процентный долг
                                 --'SK0', -- SK0 Нарах. комісія за кредит
                                 --'SK9', -- SK9 Просроч. комісія за кредит
                                 --'SN8' -- SN8 Нарах.пеня
                                   )
             ),0)
             into l_row.cr_principal_overdue
             from dual;

         --Розмер просроченой задолжености по процентах

         select nvl(
           (select abs(sum(nvl(gl.p_ncurval(980, gl.p_icurval(a.kv, fost(a.acc, bankdate_g), bankdate_g), bankdate_g),0))) cr_interest_overdue
              from accounts a, nd_acc n
             where n.acc=a.acc
               and n.nd=c.nd
               and a.tip in (--'SS ', -- SS  Основний борг
                             --'SN ', -- SN  Процентний борг
                             --'SP ', -- SP  Просрочений осн.борг
                             'SPN', -- SPN Просрочений проц.борг
                             --'SL ', -- SL  Сумнівний осн.борг
                             'SLN'--,  SLN Сомнительный процентный долг
                             --'SK0', -- SK0 Нарах. комісія за кредит
                             --'SK9', -- SK9 Просроч. комісія за кредит
                             --'SN8' -- SN8 Нарах.пеня
                            )
            ),0)
          into l_row.cr_interest_overdue
          from dual;

        select (case
               when c.vidd in (12,13) then null else (l_row.cr_principal_base +
               l_row.cr_interest_base  +
               l_row.cr_principal_overdue +
               l_row.cr_interest_overdue) end)
          into l_row.cr_next_paym
          from dual;

      insert into tmp_mw_crddata values l_row;

    end loop;

    bars_audit.trace('%s: done', l_th);
  end;


  --------------------------------------------------------------------------------
  -- get_datetime_fact -  возвращает дату и время фактической оплаты документа
  --
  --
  function get_datetime_fact(p_ref oper.ref%type) return varchar2
  is
    l_res varchar2(20);
    l_oper oper%rowtype;
  begin
    begin
      select * into l_oper from oper where ref = p_ref;
    exception
      when no_data_found then
        return null;
    end;

    if l_oper.sos < 0 then
      select to_char(max(dat),'yyyy-mm-dd hh24:mi:ss') into l_res from oper_visa where ref = p_ref and status = 3;
      if l_res is null then
        l_res := to_char(l_oper.pdat,'yyyy-mm-dd hh24:mi:ss');
      end if;
    elsif l_oper.sos = 5 then
      select to_char(min(dat),'yyyy-mm-dd hh24:mi:ss') into l_res from oper_visa where ref = p_ref and status = 2;
      if l_res is null then
        l_res := to_char(l_oper.pdat,'yyyy-mm-dd hh24:mi:ss');
      end if;
    end if;

    return l_res;
  end;

  --------------------------------------------------------------------------------
  -- get_contract_idt -  озвращает элемент ContractIDT
  --
  --
  function get_contract_idt(
    p_contract_number in varchar2,
    p_nmk in customer.nmk%type
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_product_idt';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);

    select
      XmlElement ("ContractIDT",
        XmlElement ("ContractNumber", p_contract_number),
        XmlElement ("Client",
          XmlElement("ShortName", p_nmk),
          XmlElement("FirstName", fio(p_nmk, 2)),
          XmlElement("LastName", fio(p_nmk, 1))
        ) -- Client
      ) --ContractIDT
      into l_res
    from dual;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_contract_idt;

  --------------------------------------------------------------------------------
  -- get_general_info -  озвращает элементы  заголовка элемента Contract
  --
  --
  function get_general_info(
    p_lcv in varchar2,
    p_date_open in date,
    p_date_expiry in date,
    p_name in varchar2
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_general_info';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);

    select
      XmlAgg(e)
      into l_res
      from
      (
      select  XmlElement("Institution", '001') e from dual
      union all
      select XmlElement("InstitutionIDType", 'Branch') e from dual
      union all
      select XmlElement ("ContractName", p_name) e from dual
      union all
      select XmlElement ("Currency", p_lcv) e from dual
      union all
      select
        case when p_date_open is not null then
          XmlElement ("DateOpen", to_char(p_date_open, G_MW_DATE_FORMAT))
        end e
      from dual
      union all
      select
        case when p_date_expiry is not null then
          XmlElement ("DateExpiry", to_char(p_date_expiry, G_MW_DATE_FORMAT)) -- или CloseDate
        end e
      from dual
      );

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_general_info;

  --------------------------------------------------------------------------------
  -- get_product -  возвращает элемент Product
  --
  --
  function get_product(
    p_product_name in varchar2,
    p_parm_code in varchar2,
    p_parm_value in varchar2,
    p_product_code in varchar2 default null
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_product';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_product_name=%s, p_parm_code=%s, p_parm_value=%s ',
      l_th, p_product_name, p_parm_code, p_parm_value);

    select
      XmlElement ("Product",
        -- это отображается в заголовке
        XmlElement("ProductName", p_product_name),
        decode(p_parm_value,'Deposit',XmlElement("ProductCode1", p_product_code),''),
        XmlElement("AddInfo",
          XmlElement("Parm",
            XmlElement("ParmCode", p_parm_code),
            XmlElement("Value", p_parm_value)
          ) -- Parm
        ) -- AddInfo
      ) --Product
      into l_res
    from dual;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_product;

  --------------------------------------------------------------------------------
  -- get_add_info -  возвращает элемент AddContractInfo
  --
  --
  function get_add_info(
    p_info in varchar2
  ) return xmltype is
    l_th constant varchar2(100) := g_dbgcode || 'get_add_info';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);

    select
      XmlElement("AddContractInfo",
        XmlElement("ExtraRs", p_info)
      )
    into l_res
    from dual;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_add_info;

  --------------------------------------------------------------------------------
  -- get_acclist -  возвращает элемент ContractRs для текущих счетов клиента
  --
  --
  function get_acclist(
    p_rnk in number
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_acclist';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_rnk=%s', l_th, to_char(p_rnk));

    select
      XmlAgg(
        XmlElement("ContractRs",
          XmlElement("Contract",
            get_general_info(
              p_lcv => t.lcv,
              p_date_open => a.daos,
              p_date_expiry => a.dazs,
              p_name => a.nms
            ),
            get_contract_idt(
              p_contract_number => a.nls,
              p_nmk => c.nmk
            ),
            get_product(
              p_product_name => 'Поточний рахунок', -- budnikov 10.06.2014
              p_parm_code => 'ContractCategory',
              p_parm_value => 'Current'
            ),
            get_add_info(
              'CBS_ACCOUNT_NAME='||a.nms||
              ';CBS_ACCOUNT_NUMBER='||a.nls|| -- budnikov 02.06.2014
              ';CBS_ACCOUNT_AMOUNT='||num2str1000(a.ostc/100,'.','')||
              ';CBS_ACCOUNT_CURRENCY='||t.lcv||
              ';CLIENT_ID='||to_char(p_rnk))
          ), -- Contract
          XmlElement("Info",
            XmlElement("Status",
              XmlElement ("StatusClass", decode(dazs, null, 'Valid', 'Invalid')),
              XmlElement ("StatusCode", decode(dazs, null, '00', '14')),
              XmlElement ("StatusDetails", decode(dazs, null, 'Діючий рахунок', 'Рахунок закрито')),
              XmlElement ("ProductionStatus", 'Ready')
            ), -- Status
            XmlElement("Balances",
              XmlElement("Balance",
                XmlElement ("Name", 'Остаток'/*a.nms*/),
                XmlElement ("Type", 'AVAILABLE'),
                XmlElement ("Amount", a.ostc / 100), -- budnikov 29.05.2014
                XmlElement ("Currency", t.lcv)
              ) -- Balance
            ) -- Balances
          ) -- Info
        ) -- ContractRs
      ) --XmlAgg
    into l_res
    from
      accounts a,
      tabval$global t,
      customer c,
      person p
    where a.kv = t.kv
      and a.rnk = c.rnk
      and c.rnk = p.rnk
      and a.nbs='2620'
      and c.rnk = p_rnk
      and a.dazs is null;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_acclist;


  --------------------------------------------------------------------------------
  -- get_crdlist -  возвращает элемент ContractRs для текущих кредитов клиента
  --
  --
  function get_crdlist(
    p_rnk in number
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_crdlist';
    l_res xmltype;
    --l_product_xml xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_rnk=%s', l_th, to_char(p_rnk));

    make_crddata(p_rnk);

    select
      XmlAgg(
        XmlElement("ContractRs",
          XmlElement("Contract",
            get_general_info(
              p_lcv => t.cr_currency_lcv,
              p_date_open => t.cr_date_open,
              p_date_expiry => t.cr_date_close,
              p_name => v.name
            ),
            get_contract_idt(
              p_contract_number => t.cr_number,
              p_nmk => c.nmk
            ),
            get_product(
              p_product_name => 'Кредит', -- budnikov 10.06.2014
              p_parm_code => 'ContractCategory',
              p_parm_value => 'Credit'
            ),
            get_add_info(
              case when t.cr_account_ss                        is not null then  'CREDIT_NUMBER='               || t.cr_account_ss                      ||';' else '' end ||
              case when get_mway_date(t.cr_date_open)       is not null then  'CREDIT_DATE_OPEN='            || get_mway_date(t.cr_date_open)        ||';' else '' end ||
              case when get_mway_date(t.cr_date_close)      is not null then  'CREDIT_DATE_CLOSE='           || get_mway_date(t.cr_date_close)       ||';' else '' end ||
              case when to_char(t.cr_amount/100)            is not null then  'CREDIT_AMOUNT='               || num2str1000(t.cr_amount/100,'.','')             ||';' else '' end ||
              case when t.cr_currency_lcv                   is not null then  'CREDIT_CURRENCY='             || t.cr_currency_lcv                    ||';' else '' end ||
              case when t.cr_account                        is not null then  'CREDIT_REPAYMENT_ACCOUNT='    || t.cr_account                         ||';' else '' end ||
              case when to_char(t.cr_interest_rate)         is not null then  'CREDIT_INTEREST_RATE='        || num2str1000(t.cr_interest_rate,'.','')||'%'     ||';' else '' end ||
              case when to_char(t.cr_interest_amount/100)   is not null then  'CREDIT_INTEREST_AMOUNT='      || num2str1000(t.cr_interest_amount/100,'.','')    ||';' else '' end ||
              case when t.cr_currency_lcv                   is not null then  'CREDIT_INTEREST_CURRENCY='    || t.cr_currency_lcv                    ||';' else '' end ||  -- budnikov 10.06.2014
              case when to_char(t.cr_next_paym/100)         is not null then  'CREDIT_NEXT_PAYM_AMOUNT='     || num2str1000(t.cr_next_paym/100,'.','')          ||';' else '' end || -- budnikov 10.06.2014
              case when t.cr_currency_lcv                   is not null then  'CREDIT_NEXT_PAYM_CURRENCY='   || t.cr_currency_lcv                    ||';' else '' end || -- budnikov 10.06.2014
              case when to_char(t.cr_principal_base/100)    is not null then  'CREDIT_PRN_BASE_AMOUNT='       || num2str1000(t.cr_principal_base/100,'.','')          ||';' else '' end || -- budnikov 10.06.2014
              case when t.cr_currency_lcv                   is not null then  'CREDIT_PRN_BASE_CURRENCY='    || t.cr_currency_lcv                    ||';' else '' end || -- budnikov 10.06.2014
              case when to_char(t.cr_interest_base/100)     is not null then  'CREDIT_INT_BASE_AMOUNT='        || num2str1000(t.cr_interest_base/100,'.','')          ||';' else '' end || -- budnikov 10.06.2014
              case when t.cr_currency_lcv                   is not null then  'CREDIT_INT_BASE_CURRENCY='    || t.cr_currency_lcv                    ||';' else '' end || -- budnikov 10.06.2014
              case when to_char(t.cr_principal_overdue/100) is not null then  'CREDIT_PRN_OVERDUE_AMOUNT='    || num2str1000(t.cr_principal_overdue/100,'.','')          ||';' else '' end || -- budnikov 10.06.2014
              case when t.cr_currency_lcv                   is not null then  'CREDIT_PRN_OVERDUE_CURRENCY='    || t.cr_currency_lcv                    ||';' else '' end || -- budnikov 10.06.2014
              case when to_char(t.cr_interest_overdue/100)  is not null then  'CREDIT_INT_OVERDUE_AMOUNT='     || num2str1000(t.cr_interest_overdue/100,'.','')          ||';' else '' end || -- budnikov 10.06.2014
              case when t.cr_currency_lcv                   is not null then  'CREDIT_INT_OVERDUE_CURRENCY='    || t.cr_currency_lcv                    ||';' else '' end || -- budnikov 10.06.2014
              case when get_mway_date(t.cr_next_paym_date)  is not null then  'CREDIT_NEXT_PAYM_DATE='       || get_mway_date(t.cr_next_paym_date)   ||';' else '' end ||
              case when to_char(t.cr_agreement)             is not null then  'CREDIT_AGREEMENT='            || to_char(t.cr_agreement)              ||';' else '' end ||
              case when to_char(t.cr_due_amount/100)        is not null then  'CREDIT_DUE_AMOUNT='           || num2str1000(t.cr_due_amount/100,'.','')         ||';' else '' end ||
              case when t.cr_currency_lcv                   is not null then  'CREDIT_DUE_CURRENCY='    || t.cr_currency_lcv                    ||';' else '' end || -- budnikov 10.06.2014

              case when to_char(p_rnk)                     is not null then  'CustomIDT='                   || to_char(p_rnk) ||';' else '' end
            )
          ), -- Contract
          XmlElement("Info",
            XmlElement("Status",
              XmlElement ("StatusClass", 'Valid'),
              XmlElement ("StatusCode", '0'),
              XmlElement ("StatusDetails", 'Діючий рахунок'),
              XmlElement ("ProductionStatus", 'Ready')
            ), -- Status
            XmlElement("Balances",
              XmlElement("Balance",
                XmlElement ("Name", 'Остаток'/*t.cr_number*/),
                XmlElement ("Type", 'AVAILABLE'),
                XmlElement ("Amount", nvl( t.cr_due_amount, 0) / 100 ), -- budnikov 29.05.2014
                XmlElement ("Currency", t.cr_currency_lcv)
              ) -- Balance
            ) -- Balances
          ) -- Info
        ) -- ContractRs
      ) -- XmlAgg
    into l_res
    from tmp_mw_crddata t, customer c, cc_vidd v
    where t.client_id = c.rnk
      and t.cr_vidd = v.vidd
      and c.rnk = p_rnk;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_crdlist;

  --------------------------------------------------------------------------------
  -- get_crdlist -  возвращает элемент ContractRs для текущих депозитов клиента
  --
  --
  function get_dptlist(
    p_rnk in number,
    p_is_replanish in number default null
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_dptlist';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_rnk=%s', l_th, to_char(p_rnk));

    select
      XmlAgg(
        XmlElement("ContractRs",
          XmlElement("Contract",
            get_general_info(
              p_lcv => d.dpt_curcode, -- budnikov 29.05.2014
              p_date_open => d.dat_begin,
              p_date_expiry => d.dat_end,
              p_name => d.vidd_name
            ),
            get_contract_idt(
              p_contract_number => d.dpt_id,
              p_nmk => d.cust_name
            ),
            get_product(
              p_product_name => 'Депозит', -- budnikov 10.06.2014
              p_parm_code => 'ContractCategory',
              p_parm_value => 'Deposit',
              p_product_code => d.product_code
            ),
            get_add_info(
              'DEPOSIT_NUMBER='                 || to_char(d.dpt_accnum)                                            ||';'||
              'DEPOSIT_NAME='                   || d.vidd_name                                                      ||';'||
              'DEPOSIT_PERIOD='                 || intg_wb.formatISO_8601(0,d.duration,d.duration_days)             ||';'||
              'DEPOSIT_AMOUNT='                 || num2str1000(fost(d.dpt_accid,bankdate_g)/100,'.','')             ||';'||
              'DEPOSIT_CURRENCY='               || d.dpt_curcode                                                    ||';'||
              'DEPOSIT_INTEREST_AMOUNT='        || num2str1000(fost(d.INT_ACCID,bankdate_g)/100,'.','')             ||';'||
              'DEPOSIT_INTEREST_CURRENCY='      || d.dpt_curcode                                                    ||';'||
              'DEPOSIT_INTEREST_RATE='          || num2str1000(d.rate,'.','')                                       ||';'||
              'DEPOSIT_INTEREST_PAYMENT='       || (CASE
                                                        WHEN d.freq_k = 1 THEN upper('daily')
                                                        WHEN d.freq_k = 3 THEN upper('weekly')
                                                        WHEN d.freq_k = 5 THEN upper('monthly')
                                                        WHEN d.freq_k = 7 THEN upper('quarterly')
                                                        WHEN d.freq_k = 180 THEN upper('halfyearly')
                                                        WHEN d.freq_k = 360 THEN upper('yearly')
                                                        WHEN d.freq_k = 400 THEN upper('at_maturity')
                                                     END)                                                           ||';'||
              decode(nvl(d.disable_add, 0), 0,'DEPOSIT_TOPUP_AMOUNT=' || /*nvl(d.dpt_amount, 100000000) ||*/'100000000;','')     ||
              'DEPOSIT_WITHDRAWAL='             || decode(dpt_irrevocable(d.dpt_id),0,'Y','N')                      ||';'||
              'DEPOSIT_EARLY_CLOSE='            || decode(dpt_irrevocable(d.dpt_id),0,'Y','N')                      ||';'||
--              'DEPOSIT_AUTOPROLONGATION='       || decode(d.fl_dubl,0,'N','Y')                                      ||';'||
              'DEPOSIT_AUTOPROLONGATION='       || decode(dpt_web.check_for_extension(d.dpt_id),0,'N','Y')                                      ||';'||
              'DEPOSIT_REINVEST_INTEREST='      || decode(d.comproc,0,'N','Y')                                      ||';'||
              'DEPOSIT_REPLENISHABLE='          || decode(r.cnt, 0, 'Без поповнення', 'З поповненням')      ||';'||
              'DEPOSIT_AGREEMENT='              || d.dpt_num                                                        ||';'||
              'DEPOSIT_AUTOPROLONGATION_ALLOWED='              || decode(dpt_web.check_for_extension(d.dpt_id),0,'N','Y')  ||';'||
              'DEPOSIT_DATE_OPEN='              || get_mway_date(d.dpt_dat)                                         ||';'||
              'DEPOSIT_DATE_CLOSE='             || get_mway_date(d.dat_end)                                         ||';'||
              'DEPOSIT_TERM='                   || period2str (d.dat_begin, d.dat_end)                              ||';'||
              'DEPOSIT_INTEREST_PERIOD='        || d.freq_k_name                                                    ||';'||
              'DEPOSIT_REFILL_MIN_AMOUNT='      || (select limit from dpt_vidd where vidd = d.vidd_code)            ||';'||
              'CustomIDT='                      || to_char(p_rnk)                                                   ||';'||
              /*'DEPOSIT_AUTOPROLONGATION_ALLOWED='|| (case
                                                        when (select count(1)
                                                                from dpt_vidd_scheme
                                                               where vidd = d.vidd_code
                                                                 and flags in (4,17)) > 0 then 'Y'
                                                        when (select count(1)
                                                                from dpt_agreements
                                                               where dpt_id = d.dpt_id
                                                                 and agrmnt_type = 17) > 0 then 'N'
                                                        else 'N'
                                                     end)                                                           ||';'||*/
              'DEPOSIT_TARGET_CONTRACT_NUMBER=' || d.dptrcp_acc                                                     ||';'||
              'DEPOSIT_TARGET_CBS_NUMBER='      || d.dptrcp_mfo                                                       ||';'||
              'DEPOSIT_TARGET_MEMBER_ID='       || l_target
            )
          ), -- Contract
          XmlElement("Info",
            XmlElement("Status",
              XmlElement ("StatusClass", decode(d.dpt_dazs, null, 'Valid', 'Invalid')),
              XmlElement ("StatusCode", decode(d.dpt_dazs, null, '00', '14')),
              XmlElement ("StatusDetails", decode(d.dpt_dazs, null, 'Діючий рахунок', 'Рахунок закрито')),
              XmlElement ("ProductionStatus", 'Ready')
            ), -- Status
            XmlElement("Balances",
              XmlElement("Balance",
                XmlElement ("Name", 'Остаток'/*d.cust_name*/),
                XmlElement ("Type", 'AVAILABLE'),
                XmlElement ("Amount", nvl(fost(d.dpt_accid,bankdate_g)/100,0)), -- budnikov 29.05.2014
                XmlElement ("Currency", d.dpt_curcode)
              ) -- Balance
            ) -- Balances
          ) -- Info
        ) -- ContractRs
      ) -- XmlAgg
     into l_res
     from v_mway_dpt_portfolio_all d,
          accounts a,
          (select t1.deposit_id, (select count(v1.tt)
                                    from dpt_tts_vidd v1,
                                         op_rules o1
                                   where v1.vidd = t1.vidd
                                     and v1.tt = o1.tt
                                     and o1.tag = 'DPTOP'
                                     and o1.val = '1'
                                     and o1.tt like 'DP%') as cnt
             from dpt_deposit t1) r
    where d.cust_id = p_rnk
      and a.acc=d.dpt_accid
      and a.nbs!=2620
      and d.dpt_id = r.deposit_id
      and p_is_replanish is null;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_dptlist;

  --------------------------------------------------------------------------------
  -- get_dpt -  возвращает элемент ContractRs для текущего депозита клиента
  --
  --
  function get_dpt(
    p_rnk in number,
    p_deposit_id in number
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_dpt';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_rnk=%s', l_th, to_char(p_rnk));

    select
      XmlAgg(
        XmlElement("ContractRs",
          XmlElement("Contract",
            get_general_info(
              p_lcv => d.dpt_curcode, -- budnikov 29.05.2014
              p_date_open => d.dat_begin,
              p_date_expiry => d.dat_end,
              p_name => d.vidd_name
            ),
            get_contract_idt(
              p_contract_number => d.dpt_id,
              p_nmk => d.cust_name
            ),
            get_product(
              p_product_name => 'Депозит', -- budnikov 10.06.2014
              p_parm_code => 'ContractCategory',
              p_parm_value => 'Deposit'
            ),
            get_add_info(
              'DEPOSIT_NUMBER='                 || to_char(a.nls)                                                   ||';'||
              'DEPOSIT_NAME='                   || d.vidd_name                                                      ||';'||
              'DEPOSIT_PERIOD='                 || intg_wb.formatISO_8601(0,d.duration,d.duration_days)             ||';'||
              'DEPOSIT_AMOUNT='                 || num2str1000(fost(d.dpt_accid,bankdate_g)/100,'.','')             ||';'||
              'DEPOSIT_CURRENCY='               || d.dpt_curcode                                                    ||';'||
              'DEPOSIT_INTEREST_AMOUNT='        || num2str1000(fost(d.INT_ACCID,bankdate_g)/100,'.','')             ||';'||
              'DEPOSIT_INTEREST_RATE='          || num2str1000(d.rate,'.','')                                       ||';'||
              'DEPOSIT_INTEREST_PAYMENT='       || (CASE
                                                        WHEN d.freq_k = 1 THEN upper('daily')
                                                        WHEN d.freq_k = 3 THEN upper('weekly')
                                                        WHEN d.freq_k = 5 THEN upper('monthly')
                                                        WHEN d.freq_k = 7 THEN upper('quarterly')
                                                        WHEN d.freq_k = 180 THEN upper('halfyearly')
                                                        WHEN d.freq_k = 360 THEN upper('yearly')
                                                        WHEN d.freq_k = 400 THEN upper('at_maturity')
                                                     END)                                                           ||';'||
              decode(d.disable_add, 0,'DEPOSIT_TOPUP_AMOUNT=' || d.dpt_amount ||';','')                                  ||
              'DEPOSIT_WITHDRAWAL='             || decode(dpt_irrevocable(d.dpt_id),0,'Y','N')                      ||';'||
              'DEPOSIT_EARLY_CLOSE='            || decode(dpt_irrevocable(d.dpt_id),0,'Y','N')                      ||';'||
              --              'DEPOSIT_AUTOPROLONGATION='       || decode(d.fl_dubl,0,'N','Y')                                      ||';'||
              'DEPOSIT_AUTOPROLONGATION='       || decode(dpt_web.check_for_extension(d.dpt_id),0,'N','Y')          ||';'||
              'DEPOSIT_REINVEST_INTEREST='      || decode(d.comproc,0,'N','Y')                                      ||';'||
              'DEPOSIT_AGREEMENT='              || d.dpt_num                                                        ||';'||
              'DEPOSIT_AUTOPROLONGATION_ALLOWED='              || decode(dpt_web.check_for_extension(d.dpt_id),0,'N','Y')  ||';'||
              /*'DEPOSIT_AUTOPROLONGATION_ALLOWED='|| (case
                                                        when (select count(1)
                                                                from dpt_vidd_scheme
                                                               where vidd = d.vidd_code
                                                                 and flags in (4,17)) > 0 then 'Y'
                                                        when (select count(1)
                                                                from dpt_agreements
                                                               where dpt_id = d.dpt_id
                                                                 and agrmnt_type = 17) > 0 then 'N'
                                                        else 'N'
                                                     end)                                                           ||';'||*/
              'DEPOSIT_TARGET_CONTRACT_NUMBER=' || d.dptrcp_acc                                                     ||';'||
              'DEPOSIT_TARGET_CBS_NUMBER='      || f_ourmfo_g                                                       ||';'||
              'DEPOSIT_TARGET_MEMBER_ID='       || l_target
            )
          ), -- Contract
          XmlElement("Info",
            XmlElement("Status",
              XmlElement ("StatusClass", decode(d.dpt_dazs, null, 'Valid', 'Invalid')),
              XmlElement ("StatusCode", decode(d.dpt_dazs, null, '00', '14')),
              XmlElement ("StatusDetails", decode(d.dpt_dazs, null, 'Діючий рахунок', 'Рахунок закрито')),
              XmlElement ("ProductionStatus", 'Ready')
            ), -- Status
            XmlElement("Balances",
              XmlElement("Balance",
                XmlElement ("Name", 'Остаток'/*d.cust_name*/),
                XmlElement ("Type", 'AVAILABLE'),
                XmlElement ("Amount", nvl(fost(d.dpt_accid,bankdate_g)/100,0)), -- budnikov 29.05.2014
                XmlElement ("Currency", d.dpt_curcode)
              ) -- Balance
            ) -- Balances
          ) -- Info
        ) -- ContractRs
      ) -- XmlAgg
     into l_res
     from v_mway_dpt_portfolio_all d,
          accounts a,
          (select t1.deposit_id, (select count(v1.tt)
                                    from dpt_tts_vidd v1,
                                         op_rules o1
                                   where v1.vidd = t1.vidd
                                     and v1.tt = o1.tt
                                     and o1.tag = 'DPTOP'
                                     and o1.val = '1'
                                     and o1.tt like 'DP%') as cnt
             from dpt_deposit t1) r
    where d.cust_id = p_rnk
      and d.dpt_id = p_deposit_id
      and a.acc=d.dpt_accid
      and a.nbs!=2620
      and d.dpt_id = r.deposit_id;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_dpt;

  --------------------------------------------------------------------------------
  -- get_hist_operation -  возвращает элемент DataRs с историей операций
  --
  --
  function get_hist_operation(
    p_nls in accounts.nls%type,
    p_lcv  in char,
    p_mfo in varchar2,
    p_date_from in date default null,
    p_date_to in date default null
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_hist_operation';
    l_res xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_nls=%s, p_lcv=%s, p_date_from=%s, p_date_to=%s', l_th, to_char(p_nls),to_char(p_lcv),to_char(p_date_from,'DD/MM/YYYY'),to_char(p_date_to,'DD/MM/YYYY'));

    with m as (
    select trim(to_char(decode(o.dk, 1, -o.s, o.s) / 100,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) Amount,
           (select lcv from tabval$global t where t.kv = oo.kv) Currency,
           s.fdat TransDate,
           get_datetime_fact(oo.ref) LocalDt,
--           t.name TransName
           'Financial' TransName,
           oo.nazn Description,
           oo.nlsa nlsA,
           oo.nlsb nlsB
      from accounts a,
           saldoa   s,
           opldok   o,
           tts      t,
           oper     oo
     where a.acc = s.acc
       and s.acc = o.acc
       and s.fdat = o.fdat
       and o.tt = t.tt
       and oo.ref = o.ref
       and a.nls = p_nls
       and ((o.fdat >= p_date_from) or (p_date_from is null))
       and ((o.fdat <= p_date_to) or (p_date_to is null))
       and oo.sos = 5
       and a.kf = p_mfo
    --and   a.kv=980
     order by o.fdat desc
    )
    select XmlElement("DataRs",
                      XmlElement("Stmt",
                                 XmlElement("AdditionalStmt",
                                            decode(count(Amount),0,null,
                                                   XMLAGG(XmlElement("StmtItem",
                                                   -----------------------------------------------------------------------------
                                                                     XmlElement("PostingDetails",
                                                                                XmlElement("AccountAmount",
                                                                                           XmlElement("Type",'Full'),
                                                                                           XmlElement("Currency",Currency),
                                                                                           XmlElement("Amount", Amount)
                                                                                           ),--AccountAmount
                                                                                XmlElement("ProcessingStatus",'Posted'),--ProcessingStatus
                                                                                XmlElement("Status",
                                                                                           XmlElement("RespClass",'Information'),
                                                                                           XmlElement("RespCode",'0'),
                                                                                           XmlElement("RespText",'Successfully completed'),
                                                                                           XmlElement("PostingStatus",'Posted')
                                                                                           )--Status
                                                                                ),--PostingDetails
                                                                     XmlElement("DocData",
                                                                                XmlElement("TransType",null),--TransType
                                                                                XmlElement("DocRefSet",null),--DocRefSet
                                                                                XmlElement("LocalDt", LocalDt),--LocalDt
                                                                                XmlElement("Description",Description),--Description
                                                                                XmlElement("SourceDtls",null),--SourceDtls
                                                                                XmlElement("ContractFor",
                                                                                           XmlElement("ContractNumber",p_nls)
                                                                                           ),--ContractFor
                                                                                XmlElement("Originator",
                                                                                           XmlElement("ContractNumber",nlsA)
                                                                                           ),--Originator
                                                                                XmlElement("Destination",
                                                                                           XmlElement("ContractNumber",nlsB)
                                                                                           ),--Destination
                                                                                XmlElement("Transaction",
                                                                                           XmlElement("Currency",Currency),
                                                                                           XmlElement("Amount",Amount)
                                                                                           )--Transaction
                                                                                ),--DocData
                                                                     XmlElement("Billing",
                                                                                XmlElement("PhaseDate",TransDate),
                                                                                XmlElement("Currency",Currency),
                                                                                XmlElement("Amount",Amount)
                                                                                )--Billing
                                                          -----------------------------------------------------------------------------
                                                                            ) -- StmtItem
                                                                 ) --xmlagg
                                                  )
                                           ) -- AdditionalStmt
                                ) -- Stmt
                     ) -- DataRs
    into l_res
    from m;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_hist_operation;

  --------------------------------------------------------------------------------
  -- set_transaction -  запись в таблицу матчинга
  --
  --
  procedure set_transaction(p_date mway_match.date_tr%type,
                            p_sum mway_match.sum_tr%type,
                            p_lcv mway_match.lcv_tr%type,
                            p_nls mway_match.nls_tr%type,
                            p_rrn mway_match.rrn_tr%type,
                            p_drn mway_match.drn_tr%type,
                            p_ref mway_match.ref_tr%type,
                            p_state mway_match.state%type default 0
    )
  is
  begin
    insert into mway_match(id,date_tr,sum_tr,lcv_tr,nls_tr,rrn_tr,drn_tr,state,ref_tr)
    values (s_mwaymatch.nextval,trunc(p_date),p_sum,p_lcv,p_nls,p_rrn,p_drn,p_state,p_ref);
  end set_transaction;

  --------------------------------------------------------------------------------
  -- set_state_trans -  обновление статуса матчинга
  --
  --
  procedure set_state_trans(p_id mway_match.id%type,
                            p_state mway_match.state%type
    )
  is
  begin
    update mway_match
       set state = p_state
     where id = p_id;
  end set_state_trans;

  --------------------------------------------------------------------------------
  -- get_transaction_exvalue -  для получения значений параметров трансакции
  --
  --
  function get_transaction_exvalue(p_xml xmltype,
                                p_extra_type varchar2,
                                p_tag varchar2
    ) return varchar2
  is
    l_xml xmltype;
    l_res clob;
    l_nls varchar2(100);
  begin

    l_xml := p_xml;
    select (
    select tag_val
                    from (select (column_value).extract('Extra/Type/text()').getStringVal() type_trans,
                                 (column_value).extract('Extra/'||p_tag||'/text()').getStringVal() tag_val
                            from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/Transaction/Extra'))
                                         from dual))
    where lower(type_trans) = lower(p_extra_type)
      )
      into l_res
      from dual;

    return l_res;
  end get_transaction_exvalue;

  --------------------------------------------------------------------------------
  -- get_transaction_prop -  для получения параметров трансакции
  --
  --
  function get_transaction_prop(p_xml xmltype,
                                p_extra_type varchar2,
                                p_property_code varchar2,
                                p_extra_parm varchar2
    ) return varchar2
  is
    l_xml xmltype;
    l_res clob;
    l_nls varchar2(100);
  begin

    l_xml := p_xml;
    select (
    select add_info
                    from (select (column_value).extract('Extra/Type/text()').getStringVal() type_trans,
                                 (column_value).extract('Extra/AddInfo').getClobVal() add_info
                            from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/Transaction/Extra'))
                                         from dual))
    where lower(type_trans) = lower(p_extra_type)
      )
      into l_res
      from dual;

    l_xml := xmltype(l_res);
    select (
      select adddata
        from ( select (column_value).extract('Property/Code/text()').getStringVal() code,
                      (column_value).extract('Property/Extra/AddData').getClobVal() adddata
                 from table(select XMLSequence(l_xml.extract('AddInfo/Properties/Property'))
                              from dual))
       where code = p_property_code
    )
    into l_res
    from dual;

    l_xml := xmltype(l_res);
    select (
      select value
        from ( select (column_value).extract('Parm/ParmCode/text()').getStringVal() paramcode,
                      (column_value).extract('Parm/Value/text()').getStringVal() value
                 from table(select XMLSequence(l_xml.extract('AddData/Parm'))
                              from dual))
       where lower(paramcode) = lower(p_extra_parm)
    )
      into l_nls
      from dual;

    return l_nls;
  end get_transaction_prop;

  --------------------------------------------------------------------------------
  -- get_transaction_prop -  для получения параметров трансакции
  --
  --
  function get_transprop_codeval(p_xml xmltype,
                                 p_extra_type varchar2,
                                 p_property_code varchar2
    ) return varchar2
  is
    l_xml xmltype;
    l_res clob;
    l_value varchar2(100);
  begin

    l_xml := p_xml;
    select (
    select add_info
                    from (select (column_value).extract('Extra/Type/text()').getStringVal() type_trans,
                                 (column_value).extract('Extra/AddInfo').getClobVal() add_info
                            from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/Transaction/Extra'))
                                         from dual))
    where lower(type_trans) = lower(p_extra_type)
      )
      into l_res
      from dual;

    l_xml := xmltype(l_res);
    select (
      select value
        from ( select (column_value).extract('Property/Code/text()').getStringVal() code,
                      (column_value).extract('Property/Value/text()').getClobVal() value
                 from table(select XMLSequence(l_xml.extract('AddInfo/Properties/Property'))
                              from dual))
       where code = p_property_code
    )
    into l_value
    from dual;

    return l_value;
  end get_transprop_codeval;

  --------------------------------------------------------------------------------
  -- get_docrefset_parm -  для получения параметров запроса
  --
  --
  function get_docrefset_parm(p_xml xmltype,
                              p_parm_code varchar2
    ) return varchar2
  is
    l_xml xmltype;
    l_value varchar2(400);
  begin
    l_xml := p_xml;
    select (
      select value
        from (  select (column_value).extract('Parm/ParmCode/text()').getStringVal() parmcode,
                       (column_value).extract('Parm/Value/text()').getStringVal() value
                  from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/DocRefSet/Parm'))
                               from dual))
       where lower(parmcode) = lower(p_parm_code)
    )
      into l_value
      from dual;

    return l_value;
  end get_docrefset_parm;
  --------------------------------------------------------------------------------
  -- get_error - 
  --
  --
  procedure get_error(p_code mway_errors.err_code%type,
                      p_param varchar2,
                      p_error_code out mway_errors.err_code%type,
                      p_error_message out mway_errors.err_message%type
  )
  is
  begin
    p_error_code := p_code;
    select regexp_replace(err_message,'%s',p_param) into p_error_message from mway_errors where err_code = p_code;
  end get_error;

  --------------------------------------------------------------------------------
  -- get_payord -  создание проводки
  --
  --
  procedure get_payord
  ( p_xml in xmltype,
    p_rnk in customer.rnk%type,
    p_transcode in varchar2,
    p_mfo in varchar2,
    p_error_code out number,
    p_error_message out varchar2
  ) is
    l_th constant varchar2(100) := g_dbgcode || 'get_payord';
    l_res xmltype;
    l_errcode decimal := null;
    l_errmsg varchar2(4000) := null;
    l_doc bars_xmlklb_imp.t_doc;
    l_impdoc xml_impdocs%rowtype;
    l_ref decimal;
    l_dk decimal;
    l_obj_operation varchar2(50);
    l_nlsa accounts.nls%type;
    l_nlsb accounts.nls%type;
    l_nameb varchar2(38);
    l_mfob varchar2(6);
    l_okpob varchar2(14);
    l_lcv tabval$global.lcv%type;
    l_sum oper.s%type;
    l_sum_fee oper.s%type;
    l_date date;
    l_acca accounts%rowtype;
    l_cusa customer%rowtype;
    l_tt varchar2(3 Byte);
    l_tt_fee varchar2(3 Byte);
    l_vob decimal;
    l_dpt_id dpt_deposit.deposit_id%type;
    l_nd_id cc_deal.nd%type;
    l_deposit v_mway_dpt_portfolio_all%rowtype;
    l_dpt_vidd dpt_vidd%rowtype;
    l_cc_deal cc_deal%rowtype;
    l_accb accounts%rowtype;
    l_cusb customer%rowtype;
    l_acc26 varchar2(400);
    l_acctransit accounts%rowtype;
    l_rrn varchar2(400);
    l_drn varchar2(400);
    l_servicecode varchar2(100);
    l_is_replenished int;
    l_sep int := 0;
    l_nazn varchar2(160);
    l_limit_for_day number;
    l_drn_tr mway_match.drn_tr%type;
    l_termadd        number;
    l_dat_start      date;
    l_dat_end        date;
    l_count_mm       number(5);
    l_dat_s          date;
    l_dat_po         date;
    l_sum_month      oper.s%type;
    l_summ           number;
    function get_ammount_for_day(p_nls accounts.nls%type) return number
    is
      l_sum_ammount number := 0;
      l_fee_sum number := 0;
    begin
      for c in (select * from mway_match where date_tr = trunc(sysdate) and nls_tr = p_nls)
        loop
          l_sum_ammount := l_sum_ammount + c.sum_tr;
          if c.ref_fee_tr is not null then
            select s into l_fee_sum from oper where ref = c.ref_fee_tr;
            l_sum_ammount := l_sum_ammount + l_fee_sum;
          end if;
        end loop;
      return l_sum_ammount;
    end get_ammount_for_day;
    ---
    procedure REVERSALS
    ( p_rrn   mway_match.rrn_tr%type
    ) is
      l_ref   mway_match.ref_tr%type;
      l_par2  number;
      l_par3  varchar2(40);
    begin
      begin

        select REF_TR
          into l_ref
          from MWAY_MATCH
         where RRN_TR = p_rrn;

        P_BACK_DOK( l_ref, 5, null, l_par2, l_par3 );

        p_error_code    := 0;
        p_error_message := null;

      exception
        when NO_DATA_FOUND then
          GET_ERROR(713,l_servicecode,p_error_code,p_error_message);
          begin
            insert
              into MWAY_RVRS ( RRN_TR )
            values ( p_rrn );
          exception
            when DUP_VAL_ON_INDEX then
              null;
          end;
      end;
    end REVERSALS;
    ---
  begin
    savepoint sp_paystart;
    begin
      if p_transcode not in ('04200P','04200F') then
        l_lcv := p_xml.extract('UFXMsg/MsgData/Doc/Transaction/Currency/text()').getStringVal();
        l_sum := to_number(p_xml.extract('UFXMsg/MsgData/Doc/Transaction/Amount/text()').getStringVal()) * 100;
        l_sum_fee := to_number(get_transaction_exvalue(p_xml,'Fee','Amount')) * 100;
        l_date := to_date(p_xml.extract('UFXMsg/MsgData/Doc/LocalDt/text()').getStringVal(),G_MW_DATE_FORMAT||' hh24:mi:ss');
        l_drn := get_docrefset_parm(p_xml,'DRN');
      end if;
      l_servicecode := get_transprop_codeval(p_xml,'ServiceProperties','SERVICE_CODE');
      l_rrn := get_docrefset_parm(p_xml,'RRN');
      l_nazn := substr(p_xml.extract('UFXMsg/MsgData/Doc/Description/text()').getStringVal(),1,160);
      logger.trace('WAY4 logger: select TT '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));
      begin
        select tt into l_tt from mway_pay_tt where service_code = l_servicecode and is_fee = 0;
        select vob into l_vob from tts_vob where tt = l_tt and rownum = 1;
      exception
        when no_data_found then
          --711 Операції не існує
          rollback to savepoint sp_paystart;
          get_error(711,l_obj_operation,p_error_code,p_error_message);
          return;
      end;
      logger.trace('WAY4 logger: result select TT '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));
      logger.trace('WAY4 logger: start select acc '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));
      case
        when l_servicecode = G_TRANSFER_CARD_ACC then
          if p_transcode not in ('04200P','04200F') then
            begin
              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','DESTINATION');
              l_obj_operation := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              l_acc26 := get_transprop_codeval(p_xml,'OperationProperties','REQUESTOR_ACCOUNT');
              l_acc26 := substr(l_acc26, instr(l_acc26,'-') + 1);
              l_nlsb := l_obj_operation;
              begin
                select a.* into l_accb from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_nlsb and a.rnk = p_rnk and t.lcv = l_lcv;
                select * into l_cusb from customer where rnk = l_accb.rnk;
              exception
                when no_data_found then
                  --701 Рахунок %s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(701,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;

              --l_nlsa := nbs_ob22(2924,'26');
              --select nls into l_nlsa from accounts where nbs = 2924 and ob22 = '26' and branch like '/'||f_ourmfo_g||'/' and dazs is null;
              begin
                select a.*
                  into l_acca
                  from accounts a,
                       tabval$global t
                 where a.kv = t.kv
                   and a.nbs = '2924'
                   and a.ob22 = '26'
                   and a.branch like '/'||p_mfo||'/'
                   and a.dazs is null
                   and t.lcv = l_lcv;
                select * into l_cusa from customer where rnk = l_acca.rnk;
              exception
                when no_data_found then
                  --702 Не знайдено транзитний рахунок
                  rollback to savepoint sp_paystart;
                  get_error(702,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;

              bc.subst_branch(l_accb.branch);
            end;
          else
             begin
              REVERSALS( l_rrn );
              return;
            exception
              when others then
                rollback to savepoint sp_paystart;
                get_error(714,l_servicecode,p_error_code,p_error_message);
                return;
            end;
          end if;
        when l_servicecode = G_TRANSFER_ACC_CARD then
          if p_transcode not in ('04200P','04200F') then
            begin
              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','REQUESTOR');
              l_obj_operation := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              l_acc26 := get_transprop_codeval(p_xml,'OperationProperties','DESTINATION_ACCOUNT');
              l_acc26 := substr(l_acc26, instr(l_acc26,'-') + 1);
              l_nlsa := l_obj_operation;
              begin
                select a.* into l_acca from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_nlsa and a.rnk = p_rnk and t.lcv = l_lcv;
                select * into l_cusa from customer where rnk = l_acca.rnk;
                if l_acca.ostc < l_sum then
                  --715 Залишок на рахунку менше суми
                  rollback to savepoint sp_paystart;
                  get_error(715,l_acca.nls,p_error_code,p_error_message);
                  return;
                end if;
              exception
                when no_data_found then
                  --701 Рахунок %s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(701,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;
              if l_acca.nbs = '2620' and l_acca.ob22 = '34' then
                --724 Переказ коштів з відповідного поточного рахунку заборонено
                rollback to savepoint sp_paystart;
                get_error(724,l_acca.nls,p_error_code,p_error_message);
                return;
              end if;

              --l_nlsb := nbs_ob22(2924,'25');
              --select nls into l_nlsa from accounts where nbs = 2924 and ob22 = '25' and branch like '/'||f_ourmfo_g||'/' and dazs is null;
              begin
                select a.*
                  into l_accb
                  from accounts a,
                       tabval$global t
                 where a.kv = t.kv
                   and a.nbs = '2924'
                   and a.ob22 = '25'
                   and a.branch like '/'||p_mfo||'/'
                   and a.dazs is null
                   and t.lcv = l_lcv;
                select * into l_cusb from customer where rnk = l_accb.rnk;
              exception
                when no_data_found then
                  --702 Не знайдено транзитний рахунок
                  rollback to savepoint sp_paystart;
                  get_error(702,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;

              bc.subst_branch(l_acca.branch);
            end;
          else
             begin
              REVERSALS( l_rrn );
              return;
            exception
              when others then
                rollback to savepoint sp_paystart;
                get_error(714,l_servicecode,p_error_code,p_error_message);
                return;
            end;
          end if;
        when l_servicecode = G_TRANSFER_CARD_DEP_ACC or l_servicecode = G_TRANSFER_CARDACC_DEPOSIT then
          if p_transcode not in ('04200P','04200F') then
            begin
              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','DESTINATION');
              l_obj_operation := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              l_acc26 := get_transprop_codeval(p_xml,'OperationProperties','REQUESTOR_ACCOUNT');
              l_acc26 := substr(l_acc26, instr(l_acc26,'-') + 1);
              l_dpt_id := l_obj_operation;

              begin
                select drn_tr into l_drn_tr from mway_match where drn_tr = l_drn;
                p_error_code := 0;
                p_error_message := null;
                return;
              exception
                when no_data_found then
                  null;
              end;
              
              begin
                select * into l_deposit from v_mway_dpt_portfolio_all v where v.dpt_id = l_dpt_id and v.cust_id = p_rnk;
                select * into l_dpt_vidd from dpt_vidd where vidd = l_deposit.vidd_code;
              exception
                when no_data_found then
                  --703 Депозит №%s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(703,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;

              select count(1)
                into l_is_replenished
                from dpt_tts_vidd v,
                     op_rules o,
                     dpt_deposit d
               where v.vidd = d.vidd
                 and v.tt = o.tt
                 and o.tag = 'DPTOP'
                 and o.val = '1'
                 and o.tt like 'DP%'
                 and d.deposit_id = l_dpt_id;

              if /*(l_dpt_vidd.disable_add is null or l_dpt_vidd.disable_add = 1) and*/ l_is_replenished > 0 then
                if l_sum >= nvl(l_dpt_vidd.limit*100,0) then
                  select a.* into l_accb from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_deposit.dpt_accnum and a.rnk = p_rnk and t.lcv = l_lcv;
                  select * into l_cusb from customer where rnk = l_accb.rnk;

                  --l_nlsa := nbs_ob22(2924,'26');
                  if substr(l_acc26,1,4) = '2620' then -- Костыль так как вей передает в одном сервисе и 2620 и 2625
                    begin
                       select tt into l_tt from mway_pay_tt where service_code = 'TRANSFER_ACC_DEPOSIT' and is_fee = 0;
                    exception
                         when no_data_found then
                         --711 Операції не існує
                         rollback to savepoint sp_paystart;
                         get_error(711,l_obj_operation,p_error_code,p_error_message);
                         return;
                    end;
                    begin
                       select a.* into l_acca from accounts a, tabval$global t where a.kv = t.kv and a.branch like '/'||p_mfo||'/' and a.nls = l_acc26 and t.lcv = l_lcv;
                       select * into l_cusa from customer where rnk = l_acca.rnk;
                    exception
                          when no_data_found then
                          --701 Рахунок %s не належить клієнту
                          rollback to savepoint sp_paystart;
                          get_error(701,l_obj_operation,p_error_code,p_error_message);
                          return;
                    end;
                  else 
                  select a.*
                    into l_acca
                    from accounts a,
                         tabval$global t
                   where a.kv = t.kv
                     and a.nbs = '2924'
                     and a.ob22 = '26'
                     and a.branch like '/'||p_mfo||'/'
                     and a.dazs is null
                     and t.lcv = l_lcv;
                  select * into l_cusa from customer where rnk = l_acca.rnk;
                  end if;

                  bc.subst_branch(l_accb.branch);
                  
                 -- COBUSUPABS-6352 щодо обмеження поповнення нових строкових вкладів
                  if substr(l_accb.nls, 1, 3) = '263' then

                    l_termadd := trunc(l_dpt_vidd.term_add, 0);

                    --безсрочный вид вклада
                    if nvl(l_termadd, 0) > 0 then

                      -- проверить можно ли его пополнить в указанных сроках на виде вклада
                      l_dat_start := l_deposit.dat_begin;
                      l_dat_end   := add_months(l_deposit.dat_begin,
                                                l_termadd) - 1;

                      if trunc(sysdate) between l_dat_start and l_dat_end then
                        null;
                      else
                        -- 730 Закончился срок пополнения
                        rollback to savepoint sp_paystart;
                        get_error(730,
                                  ltrim(to_char(l_termadd)),
                                  p_error_code,
                                  p_error_message);
                        return;
                      end if;

                      --  вычислить граничные даты  месяца
                      select floor(months_between(trunc(sysdate), (l_deposit.dat_begin)))
                        into l_count_mm
                        from dual;

                      l_dat_s  := add_months(l_deposit.dat_begin,
                                             l_count_mm);
                      l_dat_po := add_months(l_dat_s, 1) - 1;

                      if nvl(l_dpt_vidd.comproc, 0) = 0 then
                        --нет капитализации-то учитываем сумму пополнения операций 'DP5' и 'DPL
                        select nvl(sum(o.s), 0)
                          into l_sum_month
                          from dpt_payments p, oper o
                         where p.ref = o.ref
                           and p.dpt_id = l_deposit.dpt_id
                           and o.sos >=0
                           and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DP5', 'DPD', 'DPI', 'DPL', 'W2D', 'DBF', 'ALT',
                                        '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
                           /*and o.tt in ('PKD','OW4','PK!','215','015','515','013','R01','DP0',
                                        'DP2','DP5','DPD','DPI','DPL','W2D','DBF','ALT')*/
                           and o.pdat between l_dat_s and l_dat_po;

                      else
                        --есть капитализация-то не учитываем в сумму пополнения операций 'DP5' и 'DPL'
                        select nvl(sum(o.s), 0)
                          into l_sum_month
                          from dpt_payments p, oper o
                         where p.ref = o.ref
                           and p.dpt_id = l_deposit.dpt_id
                           and o.sos >=0
                           and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DPD', 'DPI', 'W2D', 'DBF', 'ALT',
                                        '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
                           /*and o.tt in ('PKD','OW4','PK!','215','015','515','013','R01','DP0',
                                        'DP2','DP5','DPD','DPI','DPL','W2D','DBF','ALT')*/
                           and o.pdat between l_dat_s and l_dat_po;

                      end if;

                      l_summ := l_sum_month + l_sum;
                      
                      if l_count_mm = 0 then -- первый месяц
                      
                       if kost(l_deposit.dpt_accid,trunc(sysdate - 1)) = 0 then -- первичный взнос
                          null;
                        else
                         if l_summ > l_deposit.dpt_amount * 2 then
                            --731 Превышен лимит пополнения за период
                            rollback to savepoint sp_paystart;
                            get_error(731,
                                  ltrim(to_char(l_deposit.dpt_amount)),
                                  p_error_code,
                                  p_error_message);
                             return;
                         else
                            null;
                         end if; 
                        end if;    
                      else  -- не первый месяц
                        if l_summ > l_deposit.dpt_amount then
                            --731 Превышен лимит пополнения за период
                            rollback to savepoint sp_paystart;
                            get_error(731,
                                  ltrim(to_char(l_deposit.dpt_amount)),
                                  p_error_code,
                                  p_error_message);
                             return;
                         else
                            null;
                         end if;    
                      end if;  
                    
                    else
                      null;
                    end if;

                  end if;
                    
                else
                  --705 Мінімальна сума поповнення %s
                  rollback to savepoint sp_paystart;
                  get_error(705,ltrim(to_char(l_deposit.dpt_saldo/100,'9999999999999999999D99')),p_error_code,p_error_message);
                  return;
                end if;
              else
                --704 Депозит не можна поповнювати
                rollback to savepoint sp_paystart;
                get_error(704,l_obj_operation,p_error_code,p_error_message);
                return;
              end if;
            end;
          else
            begin
              REVERSALS( l_rrn );
              return;
            exception
              when others then
                rollback to savepoint sp_paystart;
                get_error(714,l_servicecode,p_error_code,p_error_message);
                return;
            end;
          end if;
        when l_servicecode = G_TRANSFER_ACC_DEPOSIT then
          if p_transcode not in ('04200P','04200F') then
            begin
              begin
                select drn_tr into l_drn_tr from mway_match where drn_tr = l_drn;
                p_error_code := 0;
                p_error_message := null;
                return;
              exception
                when no_data_found then
                  null;
              end;
            
              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','DESTINATION');
              l_obj_operation := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              l_acc26 := get_transprop_codeval(p_xml,'OperationProperties','REQUESTOR_ACCOUNT');
              l_acc26 := substr(l_acc26, instr(l_acc26,'-') + 1);
              l_dpt_id := l_obj_operation;

              begin
                select * into l_deposit from v_mway_dpt_portfolio_all v where v.dpt_id = l_dpt_id and v.cust_id = p_rnk;
                select * into l_dpt_vidd from dpt_vidd where vidd = l_deposit.vidd_code;
              exception
                when no_data_found then
                  --703 Депозит №%s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(703,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;

              select count(1)
                into l_is_replenished
                from dpt_tts_vidd v,
                     op_rules o,
                     dpt_deposit d
               where v.vidd = d.vidd
                 and v.tt = o.tt
                 and o.tag = 'DPTOP'
                 and o.val = '1'
                 and o.tt like 'DP%'
                 and d.deposit_id = l_dpt_id;

              if /*(l_dpt_vidd.disable_add is null or l_dpt_vidd.disable_add = 1) and*/ l_is_replenished > 0 then
                if l_sum >= nvl(l_dpt_vidd.limit*100,0) then
                   begin
                       select a.* into l_acca from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_acc26 and t.lcv = l_lcv;
                       select * into l_cusa from customer where rnk = l_acca.rnk;
                   exception
                         when no_data_found then
                      --701 Рахунок %s не належить клієнту
                          rollback to savepoint sp_paystart;
                          get_error(701,l_nlsa,p_error_code,p_error_message);
                      return;
                   end;
                  
                   begin
                      select a.* into l_accb from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_deposit.dpt_accnum and a.rnk = p_rnk and t.lcv = l_lcv;
                      select * into l_cusb from customer where rnk = l_accb.rnk;
                   exception
                         when no_data_found then
                      --701 Рахунок %s не належить клієнту
                          rollback to savepoint sp_paystart;
                          get_error(701,l_nlsa,p_error_code,p_error_message);
                      return;
                   end;


                  bc.subst_branch(l_accb.branch);
                  
                   -- COBUSUPABS-6352 щодо обмеження поповнення нових строкових вкладів
                  if substr(l_accb.nls, 1, 3) = '263' then

                    l_termadd := trunc(l_dpt_vidd.term_add, 0);

                    --безсрочный вид вклада
                    if nvl(l_termadd, 0) > 0 then

                      -- проверить можно ли его пополнить в указанных сроках на виде вклада
                      l_dat_start := l_deposit.dat_begin;
                      l_dat_end   := add_months(l_deposit.dat_begin,
                                                l_termadd) - 1;

                      if trunc(sysdate) between l_dat_start and l_dat_end then
                        null;
                      else
                        -- 730 Закончился срок пополнения
                        rollback to savepoint sp_paystart;
                        get_error(730,
                                  ltrim(to_char(l_termadd)),
                                  p_error_code,
                                  p_error_message);
                        return;
                      end if;

                      --  вычислить граничные даты  месяца
                      select floor(months_between(trunc(sysdate), (l_deposit.dat_begin)))
                        into l_count_mm
                        from dual;

                      l_dat_s  := add_months(l_deposit.dat_begin,
                                             l_count_mm);
                      l_dat_po := add_months(l_dat_s, 1) - 1;

                      if nvl(l_dpt_vidd.comproc, 0) = 0 then
                        --нет капитализации-то учитываем сумму пополнения операций 'DP5' и 'DPL
                        select nvl(sum(o.s), 0)
                          into l_sum_month
                          from dpt_payments p, oper o
                         where p.ref = o.ref
                           and p.dpt_id = l_deposit.dpt_id
                           and o.sos >=0
                           and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DP5', 'DPD', 'DPI', 'DPL', 'W2D', 'DBF', 'ALT',
                                        '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
                           /*and o.tt in ('PKD','OW4','PK!','215','015','515','013','R01','DP0',
                                        'DP2','DP5','DPD','DPI','DPL','W2D','DBF','ALT')*/
                           and o.pdat between l_dat_s and l_dat_po;

                      else
                        --есть капитализация-то не учитываем в сумму пополнения операций 'DP5' и 'DPL'
                        select nvl(sum(o.s), 0)
                          into l_sum_month
                          from dpt_payments p, oper o
                         where p.ref = o.ref
                           and p.dpt_id = l_deposit.dpt_id
                           and o.sos >=0
                           and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DPD', 'DPI', 'W2D', 'DBF', 'ALT',
                                        '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
                           /*and o.tt in ('PKD','OW4','PK!','215','015','515','013','R01','DP0',
                                        'DP2','DP5','DPD','DPI','DPL','W2D','DBF','ALT')*/
                           and o.pdat between l_dat_s and l_dat_po;

                      end if;

                      l_summ := l_sum_month + l_sum;
                      
                      if l_count_mm = 0 then -- первый месяц
                       if kost(l_deposit.dpt_accid,trunc(sysdate - 1)) = 0 then -- первичный взнос
                          null;
                        else
                         if l_summ > l_deposit.dpt_amount * 2 then
                            --731 Превышен лимит пополнения за период
                            rollback to savepoint sp_paystart;
                            get_error(731,
                                  ltrim(to_char(l_deposit.dpt_amount)),
                                  p_error_code,
                                  p_error_message);
                             return;
                         else
                            null;
                         end if;
                       end if;
                      else  -- не первый месяц
                        if l_summ > l_deposit.dpt_amount then
                            --731 Превышен лимит пополнения за период
                            rollback to savepoint sp_paystart;
                            get_error(731,
                                  ltrim(to_char(l_deposit.dpt_amount)),
                                  p_error_code,
                                  p_error_message);
                             return;
                         else
                            null;
                         end if;
                      end if;
                    else
                      null;
                    end if;

                  end if;
                  
                else
                  --705 Мінімальна сума поповнення %s
                  rollback to savepoint sp_paystart;
                  get_error(705,ltrim(to_char(l_deposit.dpt_saldo/100,'9999999999999999999D99')),p_error_code,p_error_message);
                  return;
                end if;
              else
                --704 Депозит не можна поповнювати
                rollback to savepoint sp_paystart;
                get_error(704,l_obj_operation,p_error_code,p_error_message);
                return;
              end if;
            end;
          else
             begin
              REVERSALS( l_rrn );
              return;
            exception
              when others then
                rollback to savepoint sp_paystart;
                get_error(714,l_servicecode,p_error_code,p_error_message);
                return;
            end;
          end if;
        when l_servicecode = G_TRANSFER_CARD_CREDIT then
          if p_transcode not in ('04200P','04200F') then
            begin
              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','DESTINATION');
              l_obj_operation := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              l_acc26 := get_transprop_codeval(p_xml,'OperationProperties','REQUESTOR_ACCOUNT');
              l_acc26 := substr(l_acc26, instr(l_acc26,'-') + 1);
              l_nd_id := l_obj_operation;

              begin
                select * into l_cc_deal from cc_deal where nd = l_nd_id;
              exception
                when no_data_found then
                  -- 721 Кредитний договір №%s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(721,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;

              begin
                select a.* into l_accb from accounts a, nd_acc na where a.acc = na.acc and na.nd = l_cc_deal.nd and a.tip = 'SG ';
              exception
                when no_data_found then
                  begin
                    select a.* into l_accb from accounts a, nd_acc na where a.acc = na.acc and na.nd = l_cc_deal.nd and a.nbs = '2620';
                  exception
                    when no_data_found then
                      begin
                        select a.* into l_accb from accounts a, nd_acc na where a.acc = na.acc and na.nd = l_cc_deal.nd and a.nbs = '2625';
                      exception
                        when no_data_found then
                          -- 722 Рахунок погашення для договору №%s не знайдено
                          rollback to savepoint sp_paystart;
                          get_error(721,l_obj_operation,p_error_code,p_error_message);
                          return;
                      end;
                  end;
              end;
              select * into l_cusb from customer where rnk = l_accb.rnk;

              --l_nlsa := nbs_ob22(2924,'26');
              select a.*
                into l_acca
                from accounts a,
                     tabval$global t
               where a.kv = t.kv
                 and a.nbs = '2924'
                 and a.ob22 = '26'
                 and a.branch like '/'||p_mfo||'/'
                 and a.dazs is null
                 and t.lcv = l_lcv;
              select * into l_cusa from customer where rnk = l_acca.rnk;
            end;
          else
             begin
              REVERSALS( l_rrn );
              return;
            exception
              when others then
                rollback to savepoint sp_paystart;
                get_error(714,l_servicecode,p_error_code,p_error_message);
                return;
            end;
          end if;
        when l_servicecode = G_TRANSFER_ACC_UKR_FIZ_UR then
          declare
            l_rnk number;
            l_str varchar2(4000);
            l_okpoa varchar(10);
            l_chk_mfo varchar(15);
            l_kv tabval$global.kv%type;
          begin
            /*l_str := p_xml.extract('UFXMsg/MsgData/Doc/Requestor/Client/CustomIDT/text()').getStringVal();
            l_okpoa := substr(substr(l_str,instr(l_str,'$')+1),0,instr(substr(l_str,instr(l_str,'$')+1),'$')-1);*/
            l_sep := 1;
            l_nlsa := p_xml.extract('UFXMsg/MsgData/Doc/Originator/ContractNumber/text()').getStringVal();
            l_sum := to_number(get_transaction_exvalue(p_xml,'SourceAmount','Amount')) * 100;
            begin
              select a.* into l_acca from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_nlsa and t.lcv = l_lcv;
              select * into l_cusa from customer where rnk = l_acca.rnk;
              if l_acca.ostc < l_sum then
                rollback to savepoint sp_paystart;
                get_error(715,l_acca.nls,p_error_code,p_error_message);
                return;
              end if;
            exception
              when no_data_found then
                --701 Рахунок %s не належить клієнту
                rollback to savepoint sp_paystart;
                get_error(701,l_nlsa,p_error_code,p_error_message);
                return;
            end;

            if l_acca.nbs = '2620' and l_acca.ob22 = '34' then
              --724 Переказ коштів з відповідного поточного рахунку заборонено
              rollback to savepoint sp_paystart;
              get_error(724,l_acca.nls,p_error_code,p_error_message);
              return;
            end if;

            l_nlsb := p_xml.extract('UFXMsg/MsgData/Doc/Destination/ContractNumber/text()').getStringVal();
            l_nameb := substr(p_xml.extract('UFXMsg/MsgData/Doc/Destination/Client/ClientInfo/ShortName/text()').getStringVal(),0,38);
            l_mfob := p_xml.extract('UFXMsg/MsgData/Doc/Destination/MemberId/text()').getStringVal();
            if l_mfob <> l_acca.kf then
              begin
                select mfo into l_mfob from banks where mfo = l_mfob;
              exception
                when no_data_found then
                  --709 МФО банка отримувача не існує
                  rollback to savepoint sp_paystart;
                  get_error(709,l_mfob,p_error_code,p_error_message);
                  return;
              end;
            else
              begin
                select tt into l_tt from mway_pay_tt where service_code = G_TRANSFER_BANK_UKR_FIZ and is_fee = 0;
                select vob into l_vob from tts_vob where tt = l_tt and rownum = 1;
              exception
                when no_data_found then
                  --711 Операції не існує
                  rollback to savepoint sp_paystart;
                  get_error(711,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;
            end if;
            l_chk_mfo := vkrzn(substr(l_mfob,1,5),l_nlsb);
            if l_nlsb != l_chk_mfo then
              --716 Невірний контрольний розряд рахунка
              rollback to savepoint sp_paystart;
              get_error(716,l_nlsb,p_error_code,p_error_message);
              return;
            end if;
            l_okpob := p_xml.extract('UFXMsg/MsgData/Doc/Destination/Client/ClientInfo/TaxpayerIdentifier/text()').getStringVal();
            bc.subst_branch(l_acca.branch);
            select kv into l_kv from tabval$global where lcv = l_lcv;
            update alien a
               set a.name = l_nameb,
                   a.okpo = l_okpob
             where a.mfo = l_mfob
               and a.kv = l_kv
               and a.nls = l_nlsb
               and a.id = user_id;
            if sql%rowcount = 0 then
              insert into alien(mfo,nls,nlsalt,kv,okpo,name,crisk,notesec,id)
              values(l_mfob,l_nlsb,null,l_kv,l_okpob,l_nameb,null,null,user_id);
            end if;
            l_acc26 := l_nlsa;
            select to_number(val) into l_limit_for_day from params$global where par = G_W4LIMIT;
            if get_ammount_for_day(l_acc26) > l_limit_for_day then
              --720 Сума операцій по рахунку за день перевищує ліміт
              rollback to savepoint sp_paystart;
              get_error(720,l_acc26,p_error_code,p_error_message);
              return;
            end if;
          end;
        when l_servicecode = G_TRANSFER_BANK_UKR_FIZ then
          declare
            l_rnk number;
            l_str varchar2(4000);
            l_okpoa varchar(10);
          begin
            --if p_xml.extract('UFXMsg/MsgData/Doc/Destination/MemberId/text()').getStringVal() = f_ourmfo_g then
              /*l_str := p_xml.extract('UFXMsg/MsgData/Doc/Requestor/Client/CustomIDT/text()').getStringVal();
              l_okpoa := substr(substr(l_str,instr(l_str,'$')+1),0,instr(substr(l_str,instr(l_str,'$')+1),'$')-1);*/
             /* l_nlsa := p_xml.extract('UFXMsg/MsgData/Doc/Originator/ContractNumber/text()').getStringVal();*/
              begin
                select drn_tr into l_drn_tr from mway_match where drn_tr = l_drn;
                p_error_code := 0;
                p_error_message := null;
                return;
              exception
                when no_data_found then
                  null;
              end;
              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','REQUESTOR');
              l_nlsa := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              l_sum := to_number(get_transaction_exvalue(p_xml,'SourceAmount','Amount')) * 100;
              begin
                select a.* into l_acca from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_nlsa and t.lcv = l_lcv;
                select * into l_cusa from customer where rnk = l_acca.rnk;
                if l_acca.ostc < l_sum then
                  rollback to savepoint sp_paystart;
                  get_error(715,l_acca.nls,p_error_code,p_error_message);
                  return;
                end if;
              exception
                when no_data_found then
                  --701 Рахунок %s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(701,l_nlsa,p_error_code,p_error_message);
                  return;
              end;

              l_obj_operation := get_transprop_codeval(p_xml,'OperationProperties','DESTINATION');
              l_nlsb := substr(l_obj_operation,1,instr(l_obj_operation,'.') - 1);
              /*l_nlsb := p_xml.extract('UFXMsg/MsgData/Doc/Destination/ContractNumber/text()').getStringVal();
              l_okpob := p_xml.extract('UFXMsg/MsgData/Doc/Destination/Client/ClientInfo/TaxpayerIdentifier/text()').getStringVal();

              begin
                select rnk into l_rnk from customer where okpo = l_okpob;
              exception
                when no_data_found then
                  --708 Клієнта не існує
                  rollback to savepoint sp_paystart;
                  get_error(708,l_okpob,p_error_code,p_error_message);
                  return;
              end;*/

              begin
                select a.* into l_accb from accounts a, tabval$global t where a.kv = t.kv and a.nls = l_nlsb  and t.lcv = l_lcv;
                select * into l_cusb from customer where rnk = l_accb.rnk;
              exception
                when no_data_found then
                  --701 Рахунок %s не належить клієнту
                  rollback to savepoint sp_paystart;
                  get_error(701,l_obj_operation,p_error_code,p_error_message);
                  return;
              end;
              bc.subst_branch(l_acca.branch);
              l_acc26 := l_nlsa;
              select to_number(val) into l_limit_for_day from params$global where par = G_W4LIMIT;
              if get_ammount_for_day(l_acc26) > l_limit_for_day then
                --720 Сума операцій по рахунку за день перевищує ліміт
                rollback to savepoint sp_paystart;
                get_error(720,l_acc26,p_error_code,p_error_message);
                return;
              end if;
            /*else
              --710 МФО банка не належить поточному відділеню банка
              rollback to savepoint sp_paystart;
              get_error(709,l_mfob,p_error_code,p_error_message);
              return;*/
            --end if;
          end;
        else
          --712 Сервіс кода не існує
          rollback to savepoint sp_paystart;
          get_error(712,l_obj_operation,p_error_code,p_error_message);
          return;
      end case;
      logger.trace('WAY4 logger: finish select acc '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));
      if l_date > gl.bDATE then
        l_date := gl.bDATE;
      end if;
      l_errcode:=null;
      l_errmsg:=null;

      l_dk:=1;

      l_impdoc.ref_a  := null ;
      l_impdoc.impref := null ;
      l_impdoc.nd     := l_drn;
      l_impdoc.datd   := trunc(l_date);
      l_impdoc.vdat   := trunc(l_date)    ;
      l_impdoc.nam_a  := l_cusa.nmkk   ;
      l_impdoc.mfoa   := l_acca.kf    ;
      l_impdoc.nlsa   := l_acca.nls    ;
      l_impdoc.id_a   := l_cusa.okpo   ;
      if l_sep = 1 then
        l_impdoc.nam_b  := l_nameb;
        l_impdoc.mfob   := l_mfob;
        l_impdoc.nlsb   := l_nlsb;
        l_impdoc.id_b   := l_okpob;
      else
        l_impdoc.nam_b  := l_cusb.nmkk    ;
        l_impdoc.mfob   := l_accb.kf    ;
        l_impdoc.nlsb   := l_accb.nls    ;
        l_impdoc.id_b   := l_cusb.okpo   ;
      end if;
      l_impdoc.s      := l_sum       ;
      l_impdoc.kv     := l_acca.kv      ;
      l_impdoc.s2     := l_sum      ;
      l_impdoc.kv2    := l_acca.kv      ;
      l_impdoc.sk     := null      ;
      l_impdoc.dk     := l_dk      ;
      l_impdoc.tt     := l_tt      ;
      l_impdoc.vob    := l_vob     ;
      l_impdoc.nazn   := 'Переказ коштів ч/з Веб-банкінг'; --l_nazn    ;
      l_impdoc.datp   := trunc(l_date)     ;

      l_impdoc.userid := null     ;

      l_impdoc.d_rec  := null;

      l_doc.doc  := l_impdoc;
      logger.trace('WAY4 logger: start pay '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));
      bars_xmlklb_imp.pay_extern_doc( p_doc  => l_doc,
                        p_errcode => l_errcode,
                        p_errmsg  => l_errmsg );
      logger.trace('WAY4 logger: finish pay '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));

      if l_errcode <> 0 then
        --706 Помилка оплати документа
        rollback to savepoint sp_paystart;
        get_error(706,l_obj_operation,p_error_code,p_error_message);
        return;
      else
        set_transaction(sysdate,l_sum,l_lcv,l_acc26,l_rrn,l_drn,l_doc.doc.ref);
      end if;
      /*Оформление платежки по комиссии*/
      if l_sum_fee > 0 then
        begin
          select tt into l_tt from mway_pay_tt where service_code = l_servicecode and is_fee = 1;
          select vob into l_vob from tts_vob where tt = l_tt and rownum = 1;
        exception
          when no_data_found then
            --717 операції для комісії, не існує
            rollback to savepoint sp_paystart;
            get_error(717,l_obj_operation,p_error_code,p_error_message);
            return;
        end;

        l_nlsb := GetGlobalOption('NLS_373914_LOCPAYFEE')/*nbs_ob22('3739','15')*/;
        begin
          select * into l_accb from accounts where nls = l_nlsb and dazs is null;
          select * into l_cusb from customer where rnk = l_accb.rnk;
        exception
          when no_data_found then
            --719 не існує рахунка для нарахування комісії
            rollback to savepoint sp_paystart;
            get_error(719,l_obj_operation,p_error_code,p_error_message);
            return;
        end;

        l_errcode:=null;
        l_errmsg:=null;
        l_dk:=1;
        l_impdoc.ref_a  := null ;
        l_impdoc.impref := null ;
        l_impdoc.nd     := l_drn;
        l_impdoc.datd   := trunc(l_date);
        l_impdoc.vdat   := trunc(l_date)    ;
        l_impdoc.nam_a  := l_cusa.nmkk   ;
        l_impdoc.mfoa   := l_acca.kf    ;
        l_impdoc.nlsa   := l_acca.nls    ;
        l_impdoc.id_a   := l_cusa.okpo   ;
        l_impdoc.nam_b  := l_cusb.nmkk    ;
        l_impdoc.mfob   := l_accb.kf    ;
        l_impdoc.nlsb   := l_accb.nls    ;
        l_impdoc.id_b   := l_cusb.okpo   ;
        l_impdoc.s      := l_sum_fee      ;
        l_impdoc.kv     := l_acca.kv      ;
        l_impdoc.s2     := l_sum_fee      ;
        l_impdoc.kv2    := l_acca.kv      ;
        l_impdoc.sk     := null      ;
        l_impdoc.dk     := l_dk      ;
        l_impdoc.tt     := l_tt      ;
        l_impdoc.vob    := l_vob     ;
        l_impdoc.nazn   := 'Комісія за переказ з захунку №'||l_acca.nls    ;
        l_impdoc.datp   := trunc(l_date)     ;

        l_impdoc.userid := null     ;

        l_impdoc.d_rec  := null;

        l_doc.doc  := l_impdoc;
        logger.trace('WAY4 logger: start pay fee '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));
        bars_xmlklb_imp.pay_extern_doc( p_doc  => l_doc,
                          p_errcode => l_errcode,
                          p_errmsg  => l_errmsg );
        logger.trace('WAY4 logger: finish pay fee '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' l_sum='||to_char(l_sum));

        if l_errcode <> 0 then
          --718 Помилка оплати комісії
          rollback to savepoint sp_paystart;
          get_error(718,l_obj_operation,p_error_code,p_error_message);
          return;
        else
          update mway_match
             set ref_fee_tr = l_doc.doc.ref
           where rrn_tr = l_rrn
             and drn_tr = l_drn;
        end if;
      end if;

      p_error_code := 0;
      p_error_message := null;
      return;
    exception when others then
      l_errcode := sqlcode;
      l_errmsg := sqlerrm;
      rollback to savepoint sp_paystart;
      bars_audit.error(l_th||sqlcode||' : '||sqlerrm);
      get_error(700,l_obj_operation,p_error_code,p_error_message);
      return;
    end;
  end get_payord;

  --
  --
  --
  procedure PAY_REVERSAL
  is
    title   constant varchar2(64) := $$PLSQL_UNIT||'.PAY_REVERSAL';
    l_par2  number(1);
    l_par3  varchar2(1);
    l_kf    oper.kf%type;
    l_sos   oper.sos%type;
  begin

    BARS_AUDIT.TRACE( '%s: Entry.', title );

    for cur in ( select /*+ ORDERED FULL(r) */ 
                        r.ROWID as REC_ID
                      , m.REF_TR
                   from MWAY_RVRS  r
                   join MWAY_MATCH m
                     on ( m.RRN_TR = r.RRN_TR )
                  where m.REF_TR Is Not Null
                    for update of r.RRN_TR
               )
    loop

      begin

        begin
          select d.KF, d.SOS 
            into l_kf, l_sos
            from OPER d
           where d.REF = cur.REF_TR;
        exception
          when NO_DATA_FOUND then
           l_kf  := null;
           l_sos := null;
        end;

        if ( l_sos >= 0 )
        then

          BARS_CONTEXT.SUBST_MFO( l_kf );

          P_BACK_DOK( cur.REF_TR, 5, null, l_par2, l_par3 );

          BARS_CONTEXT.SET_CONTEXT;

        end if;

        delete MWAY_RVRS
         where ROWID = cur.REC_ID;

      exception
        when OTHERS then
          bars_audit.error( title || ': REF_TR=' || to_char(cur.REF_TR)
                                  || CHR(10) ||dbms_utility.format_error_stack()
                                  || CHR(10) || dbms_utility.format_error_backtrace() );
          BARS_CONTEXT.SET_CONTEXT;
      end;

    end loop;

    BARS_AUDIT.TRACE( '%s: Exit.', title );

  end PAY_REVERSAL;

  --------------------------------------------------------------------------------
  -- get_dpthtml -  возвращает HTML отчет по депозитному счету
  --
  --
  function get_dpthtml(
    p_nls in varchar2,
    p_dpt_lcv  in char,
    p_mfo in varchar2,
    p_date_from in date,
    p_date_to   in date
  ) return clob
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_dpthtml';
    l_res clob;
    l_iterator number:=0;
    l_int_nls accounts.nls%type;
    l_dpt_kv number;
    l_int_kv number;
    l_int_lcv char(3);
    l_startDate date; -- дата начала договора
    l_is_nls accounts.nbs%type;
  begin
    begin
      select a.nbs into l_is_nls
        from v_mway_dpt_portfolio_all d, accounts a
       where d.dpt_accnum = p_nls
         and a.kv = (select t.kv from tabval$global t where t.lcv = p_dpt_lcv)
         and d.dpt_accid = a.acc
         and a.nbs!=2620
         and a.kf = p_mfo;
    exception
      when no_data_found then
        return null;
    end;
  bars_audit.trace('%s: entry point', l_th);
  bars_audit.trace('%s: p_nls=%s, p_lcv=%s, p_date_from=%s, p_date_to=%s', l_th, to_char(p_nls),p_dpt_lcv,to_char(p_date_from,'DD/MM/YYYY'),to_char(p_date_to,'DD/MM/YYYY'));
  l_res:=
    '<html>'||chr(10)||
    '  <head>'||chr(10)||
    '    <meta http-equiv="Content-Type" content="text/html; charset=win1251" />'/* charset="utf-8" />'*/||chr(10)||
    '    <title>Сформовано '||to_char(sysdate,'DD.MM.RRRR, HH24:MI:SS')||'</title>'||chr(10)||
    '    <style type="text/css">'||chr(10)||
    '      p{'||chr(10)||
    '      padding: 0px;'||chr(10)||
    '      margin: 0px;'||chr(10)||
    '      line-height: 1;'||chr(10)||
    '      font-size: 12px;'||chr(10)||
    '      font-family: "Times New Roman";'||chr(10)||
    '      }'||chr(10)||
    '    </style>'||chr(10)||
    '  </head>'||chr(10)||
    '<body>'||chr(10);
  for aa in
    (
    select 'Сформовано '||to_char(sysdate,'DD.MM.YYYY')||'р.  '||to_char(sysdate,'HH24:MM') a1,
           'Виписка по депозитному договору №'||d.dpt_id a2_1,
           ' за період з '||to_char(p_date_from,'DD.MM.YYYY')||'р. по '||to_char(p_date_to,'DD.MM.YYYY')||'р.' a2_2,
           'Клієнт: '||d.cust_name a3,
           'Номер рахунку: '||d.dpt_accnum a4,
           'Валюта: '||d.dpt_curcode||'('||d.dpt_curname||')' a5,
           'Сума депозиту: '||trim(to_char(d.dpt_amount/100,'9999999999999D99')) a6,
           'Ставка: '||d.rate||' %' a7,
           'Строк: '||(select duration from dpt_vidd v where v.vidd=d.vidd_code)||' міс.' a8,
           'Дата закінчення: '||to_char(d.dat_end,'DD.MM.YYYY') a9,
           num2str1000(fost(d.dpt_accid,p_date_from)/100) a10,
           d.dpt_curcode a11,
           d.int_accnum,
           d.int_curid,
           d.int_curcode,
           d.dpt_curid,
           d.dat_begin datStart--дата начала договора
      from v_mway_dpt_portfolio_all d
     where d.dpt_accnum=p_nls
       and d.dpt_curcode=p_dpt_lcv
       and rownum=1
    )
  loop
    l_res:=l_res||
    '<p align="right">'||trim(aa.a1)||'</p>'||chr(10)||
    '<p> </p>'||chr(10)||
    '<br />'||chr(10)||
    '<br />'||chr(10);
    l_res:=l_res||
    '<p align="center">'||chr(10)||
    '  <strong>'||trim(aa.a2_1)||'</strong>'||chr(10)||
    '<br />'||chr(10)||
    '  <strong>'||trim(aa.a2_2)||'</strong>'||chr(10)||
    '</p>'||chr(10)||
    '<p> </p>'||chr(10);
    l_res:=l_res||
    '<p>'||trim(aa.a3)||'</p>'||chr(10)||
    '<p>'||trim(aa.a4)||'</p>'||chr(10)||
    '<p>'||trim(aa.a5)||'</p>'||chr(10)||
    '<p>'||trim(aa.a6)||'</p>'||chr(10)||
    '<p>'||trim(aa.a7)||'</p>'||chr(10)||
    '<p>'||trim(aa.a8)||'</p>'||chr(10)||
    '<p>'||trim(aa.a9)||'</p>'||chr(10)||
    '<p> </p>'||chr(10)||
    '<p><strong>Операції з депозитом:</strong></p>'||chr(10);
    l_int_nls:=aa.int_accnum;
    l_int_kv:=aa.int_curid;
    l_int_lcv:=aa.int_curcode;
    l_startDate:=aa.datStart;
    l_dpt_kv:=aa.dpt_curid;

  delete from tmp_licm;
  --сформировать проводки
  if l_dpt_kv = 980 then
    bars_rptlic.lic_grnb (p_date_from, p_date_to, p_nls, 0, '%', 0);
  else
    bars_rptlic.lic_valb (p_date_from, p_date_to, p_nls, l_dpt_kv, 0, '%', 0);
  end if;

  l_res:=l_res||
  '<table border="1" cellspacing="0" cellpadding="0" width="929">'||chr(10)||
  '  <tr>'||chr(10)||
  '    <td width="26" valign="top"><p align="center"><strong>№ п.п.</strong></p></td>'||chr(10)||
  '    <td width="86" valign="top"><p align="center"><strong>Дата операції</strong></p></td>'||chr(10)||
  '    <td width="114" valign="top"><p align="center"><strong>Дата відображення операції в системі Банку</strong></p></td>'||chr(10)||
  '    <td width="366" valign="top"><p align="center"><strong>Призначення платежу</strong></p></td>'||chr(10)||
  '    <td width="114" valign="top"><p align="center"><strong>Сума<br />зарахування</strong></p></td>'||chr(10)||
  '    <td width="113" valign="top"><p align="center"><strong>Сума<br />списання</strong></p></td>'||chr(10)||
  '    <td width="94" valign="top"><p align="center"><strong>Валюта</strong></p></td>'||chr(10)||
  '  </tr>'||chr(10)||
  '  <tr>'||chr(10)||
  '    <td colspan="4" valign="top"><p>Залишок коштів    на початок періоду: </p></td>'||chr(10)||
  '    <td width="114" valign="top"><p align="center">'||aa.a10||'</p></td>'||chr(10)||
  '    <td width="113" valign="top"><p align="center"> </p></td>'||chr(10)||
  '    <td width="94" valign="top"><p align="center">'||aa.a11||'</p></td>'||chr(10)||
  '  </tr>'||chr(10);
  for bb in
    (
    select to_char(vrp.datd,G_MW_DATE_FORMAT) datd,
           to_char(vrp.fdat,G_MW_DATE_FORMAT) fdat,
           vrp.nazn,
           num2str1000(abs(vrp.koss)) koss,
           num2str1000(abs(vrp.doss)) doss,
           t.lcv lcv
      from v_rptlic vrp,tabval$global t
     where t.kv=vrp.kv
       and vrp.nls = p_nls and t.lcv = p_dpt_lcv
     order by vrp.fdat
    )
    loop
      l_iterator:=l_iterator+1;
      l_res:=l_res||
      '  <tr>'||chr(10)||
      '    <td width="26" valign="top"><p>'||to_char(l_iterator)||'.</p></td>'||chr(10)||
      '    <td width="86" valign="top"><p>'||bb.datd||'</p></td>'||chr(10)||
      '    <td width="114" valign="top"><p>'||bb.fdat||'</p></td>'||chr(10)||
      '    <td width="366" valign="top"><p>'||bb.nazn||'</p></td>'||chr(10)||
      '    <td width="114" valign="top"><p align="center">'||nvl(bb.koss,' ')||'</p></td>'||chr(10)||
      '    <td width="113" valign="top"><p align="center">'||nvl(bb.doss,' ')||'</p></td>'||chr(10)||
      '    <td width="94" valign="top"><p align="center">'||bb.lcv||'</p></td>'||chr(10)||
      '  </tr>'||chr(10);
    end loop;

  for cc in
    (
    select num2str1000(abs(sum(vrp.koss))) c1,
           num2str1000(abs(sum(vrp.doss))) c2,
           p_dpt_lcv                       c3,
           num2str1000(fost(vrp.acc,p_date_to)/100) c4
      from v_rptlic vrp, tabval$global t
     where t.kv=vrp.kv
       and vrp.nls = p_nls
       and t.lcv = p_dpt_lcv
     group by vrp.acc
    )
    loop
      l_res:=l_res||
      '<tr>'||chr(10)||
      '  <td colspan="4" valign="top"><p>Всього    зараховано\списано за період</p></td>'||chr(10)||
      '  <td width="114" valign="top"><p align="center">'||cc.c1||'</p></td>'||chr(10)||
      '  <td width="113" valign="top"><p align="center">'||cc.c2||'</p></td>'||chr(10)||
      '  <td width="94" valign="top"><p align="center">'||cc.c3||'</p></td>'||chr(10)||
      '</tr>'||chr(10)||
      '<tr>'||chr(10)||
      '  <td colspan="4" valign="top"><p>Залишок коштів  на кінець періоду по депозиту </p></td>'||chr(10)||
      '  <td width="114" valign="top"><p align="center">'||cc.c4||'</p></td>'||chr(10)||
      '  <td width="113" valign="top"><p align="center"> </p></td>'||chr(10)||
      '  <td width="94" valign="top"><p align="center">'||cc.c3||'</p></td>'||chr(10)||
      '</tr>'||chr(10);
     end loop;
  l_res:=l_res||
  '</table>'||chr(10)||
  '<p> </p>';
  delete from tmp_licm;

  if l_int_kv = 980 then
    bars_rptlic.lic_grnb (p_date_from, p_date_to, l_int_nls, 0, '%', 0);
  else
    bars_rptlic.lic_valb (p_date_from, p_date_to, l_int_nls, l_int_kv, 0, '%', 0);
  end if;

  for dd in
    (
    select num2str1000(fkos(vrp.acc,l_startDate,p_date_from-1)/100) d1,
           num2str1000(fdos(vrp.acc,l_startDate,p_date_from-1)/100) d2,
           l_int_lcv d3,
           num2str1000(abs(sum(vrp.koss))) d4,
           num2str1000(abs(sum(vrp.doss))) d5
      from v_rptlic vrp, tabval$global t
     where t.kv=vrp.kv
       and vrp.nls = l_int_nls
       and t.lcv = l_int_lcv
     group by vrp.acc
    )
    loop
      l_res:=l_res||
      '<p><strong>Нарахування та виплата процентів за депозитом:</strong></p>'||chr(10)||
      '<table border="1" cellspacing="0" cellpadding="0" width="929">'||chr(10)||
      '  <tr>'||chr(10)||
      '    <td width="26" valign="top"><p align="center"><strong>№ п.п.</strong></p></td>'||chr(10)||
      '    <td width="86" valign="top"><p align="center"><strong>Дата операції</strong></p></td>'||chr(10)||
      '    <td width="114" valign="top"><p align="center"><strong>Дата відображення операції в системі Банку</strong></p></td>'||chr(10)||
      '    <td width="366" valign="top"><p align="center"><strong>Призначення платежу</strong></p></td>'||chr(10)||
      '    <td width="114" valign="top"><p align="center"><strong>Сума</strong><br />'||chr(10)||
      '      <strong>нарахованих процентів</strong></p></td>'||chr(10)||
      '    <td width="113" valign="top"><p align="center"><strong>Сума</strong><br />'||chr(10)||
      '      <strong>сплачених процентів</strong></p></td>'||chr(10)||
      '    <td width="94" valign="top"><p align="center"><strong>Валюта</strong></p></td>'||chr(10)||
      '  </tr>'||chr(10)||
      '  <tr>'||chr(10)||
      '    <td colspan="4" valign="top"><p>Залишок коштів    на початок періоду: </p></td>'||chr(10)||
      '    <td width="114" valign="top"><p align="center">'||dd.d1||'</p></td>'||chr(10)||
      '    <td width="113" valign="top"><p align="center">'||dd.d2||'</p></td>'||chr(10)||
      '    <td width="94" valign="top"><p align="center">'||dd.d3||'</p></td>'||chr(10)||
      '  </tr>    '||chr(10);

      l_iterator:=0;
      for ee in
        (
        select to_char(vrp.datd,G_MW_DATE_FORMAT) datd,
               to_char(vrp.fdat,G_MW_DATE_FORMAT) fdat,
               vrp.nazn,
               num2str1000(abs(vrp.koss)) koss,
               num2str1000(abs(vrp.doss)) doss,
               t.lcv lcv
          from v_rptlic vrp,tabval$global t
         where t.kv=vrp.kv
           and vrp.nls = l_int_nls and t.lcv = l_int_lcv
         order by vrp.fdat
        )
        loop
          l_iterator:=l_iterator+1;
          l_res:=l_res||
          '  <tr>'||chr(10)||
          '    <td width="26" valign="top"><p>'||to_char(l_iterator)||'.</p></td>'||chr(10)||
          '    <td width="86" valign="top"><p>'||ee.datd||'</p></td>'||chr(10)||
          '    <td width="114" valign="top"><p>'||ee.fdat||'</p></td>'||chr(10)||
          '    <td width="366" valign="top"><p>'||ee.nazn||'</p></td>'||chr(10)||
          '    <td width="114" valign="top"><p align="center">'||nvl(ee.koss,' ')||'</p></td>'||chr(10)||
          '    <td width="113" valign="top"><p align="center">'||nvl(ee.doss,' ')||'</p></td>'||chr(10)||
          '    <td width="94" valign="top"><p align="center">'||ee.lcv||'</p></td>'||chr(10)||
          '  </tr>'||chr(10);

        end loop;
      l_res:=l_res||
      '  <tr>'||chr(10)||
      '    <td colspan="4" valign="top"><p>Всього за    період</p></td>'||chr(10)||
      '    <td width="114" valign="top"><p align="center">'||dd.d4||'</p></td>'||chr(10)||
      '    <td width="113" valign="top"><p align="center">'||dd.d5||'</p></td>'||chr(10)||
      '    <td width="94" valign="top"><p align="center">'||dd.d3||'</p></td>'||chr(10)||
      '  </tr>'||chr(10)||
      '</table>'||chr(10)||
       '<p> </p>'||chr(10);
    end loop;
  end loop;
    bars_audit.trace('%s: done', l_th);
    l_res := l_res||'</body>'||chr(10)||'</html>';
    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_dpthtml;

  --------------------------------------------------------------------------------
  -- get_acchtml -  возвращает HTML отчет по счету
  --
  --
  function get_acchtml(
    p_nls in varchar2,
    p_acc_lcv  in char,
    p_mfo in varchar2,
    p_date_from in date,
    p_date_to   in date
  ) return clob
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_acchtml';
    l_res clob;
    l_iterator number:=0;
    l_acc_kv number;
    l_is_nls accounts.nbs%type;
  begin
    begin
      select nbs into l_is_nls from accounts a, tabval$global t where a.nls=p_nls and t.kv=a.kv and t.lcv=p_acc_lcv and a.nbs=2620 and a.kf = p_mfo;
    exception
      when no_data_found then
        return null;
    end;
  bars_audit.trace('%s: entry point', l_th);
  bars_audit.trace('%s: p_nls=%s, p_lcv=%s, p_date_from=%s, p_date_to=%s', l_th, to_char(p_nls),p_acc_lcv,to_char(p_date_from,'DD/MM/YYYY'),to_char(p_date_to,'DD/MM/YYYY'));
  l_res:=
    '<html>'||chr(10)||
    '  <head>'||chr(10)||
    '    <meta http-equiv="Content-Type" content="text/html; charset=win1251" />'||chr(10)||
    '    <title>Сформовано '||to_char(sysdate,'DD.MM.RRRR, HH24:MI:SS')||'</title>'||chr(10)||
    '    <style type="text/css">'||chr(10)||
    '      p{'||chr(10)||
    '      padding: 0px;'||chr(10)||
    '      margin: 0px;'||chr(10)||
    '      line-height: 1;'||chr(10)||
    '      font-size: 12px;'||chr(10)||
    '      font-family: "Times New Roman";'||chr(10)||
    '      }'||chr(10)||
    '    </style>'||chr(10)||
    '  </head>'||chr(10)||
    '<body>'||chr(10)||
    '<p align="right">Сформовано '||to_char(sysdate,'DD.MM.YYYY')||'р.  '||to_char(sysdate,'HH24:MM')||'</p>'||chr(10)||
    '<p> </p>'||chr(10)||
    '<br />'||chr(10)||
    '<br />'||chr(10)||
    '<p align="center">'||chr(10)||
    '  <strong>Виписка по рахунку '||p_nls||'</strong>'||chr(10)||
    '<br />'||chr(10)||
    '  <strong> за період з '||to_char(p_date_from,'DD.MM.YYYY')||'р. по '||to_char(p_date_to,'DD.MM.YYYY')||'р.</strong>'||chr(10)||
    '</p>'||chr(10)||
    '<p> </p>'||chr(10);
  for ff in
    (
    select 'Клієнт: '||(select upper(nms) from customer c where c.rnk=a.rnk) f3,
           'Номер рахунку: '||a.nls f4,
           'Валюта: '||(select lcv||'('||t.name||')' from tabval$global t where t.kv=a.kv) f5,
           num2str1000(fost(a.acc,p_date_from)/100) f6,
           (select lcv from tabval$global t where t.kv=a.kv) f7,
           num2str1000(fost(a.acc,p_date_to)/100) f8,
           a.kv
      from accounts a
     where a.nls=p_nls
       and a.dazs is null
    )
  loop
    l_res:=l_res||
    '<p>'||trim(ff.f3)||'</p>'||chr(10)||
    '<p>'||trim(ff.f4)||'</p>'||chr(10)||
    '<p>'||trim(ff.f5)||'</p>'||chr(10)||
    '<p> </p>'||chr(10)||
    '<p><strong>Операції по рахунку:</strong></p>'||chr(10);
    l_acc_kv:=ff.kv;

  execute immediate 'delete from tmp_licm';
  --сформировать проводки
  if l_acc_kv = 980 then
    bars_rptlic.lic_grnb (p_date_from, p_date_to, p_nls, 0, '%', 0);
  else
    bars_rptlic.lic_valb (p_date_from, p_date_to, p_nls, l_acc_kv, 0, '%', 0);
  end if;

  l_res:=l_res||
  '<table border="1" cellspacing="0" cellpadding="0" width="929">'||chr(10)||
  '  <tr>
       <td width="26" rowspan="2" valign="top"><p align="center"><strong>№ п.п.</strong></p></td>
       <td width="86" rowspan="2" valign="top"><p align="center"><strong>Дата здійснення операції</strong></p></td>
       <td width="114" rowspan="2" valign="top"><p align="center"><strong>Дата відображення операції в системі Банку</strong></p></td>
       <td colspan="4" valign="top"><p align="center"><strong>Зміст операції</strong></p></td>
       <td width="94" rowspan="2" valign="top"><p align="center"><strong>Сума(+ зарахування- списання)</strong></p></td>
       <td width="50" rowspan="2" valign="top"><p align="center"><strong>Валюта</strong></p></td>
     </tr>
     <tr>
       <td width="88" valign="top"><p align="center"><strong>Рахунок одержувача</strong></p></td>
       <td width="94" valign="top"><p align="center"><strong>Код банку одержувача</strong></p></td>
       <td width="102" valign="top"><p align="center"><strong>Назва банку одержувача</strong></p></td>
       <td width="255" valign="top"><p align="center"><strong>Призначення платежу</strong></p></td>
     </tr>
     <tr>
       <td width="799" colspan="7" valign="top"><p>Залишок коштів    на початок періоду: </p></td>
       <td width="116" valign="top"><p align="center">'||ff.f6||'</p></td>
       <td width="70" valign="top"><p align="center">'||ff.f7||'</p></td>
     </tr>'||chr(10);
  for gg in
    (
    select vrp.datd,
           vrp.fdat,
           vrp.nls2,
           vrp.mfo2,
           vrp.nb2,
           vrp.nazn,
           num2str1000(vrp.s) s,
           (select t.lcv from tabval$global t where t.kv = vrp.kv) lcv
      from v_rptlic vrp,tabval$global t
     where t.kv=vrp.kv
       and vrp.nls = p_nls and t.lcv = p_acc_lcv
     order by vrp.fdat
    )
    loop
      l_iterator:=l_iterator+1;
      l_res:=l_res||
      '  <tr>'||chr(10)||
      '    <td width="21" valign="top"><p>'||to_char(l_iterator)||'.</p></td>'||chr(10)||
      '<td width="96" valign="top"><p>'||gg.datd||'</p></td>'||chr(10)||
      '<td width="123" valign="top"><p></p>'||gg.fdat||'</td>'||chr(10)||
      '<td width="126" valign="top"><p></p>'||gg.nls2||'</td>'||chr(10)||
      '<td width="100" valign="top"><p></p>'||gg.mfo2||'</td>'||chr(10)||
      '<td width="100" valign="top"><p></p>'||gg.nb2||'</td>'||chr(10)||
      '<td width="213" valign="top"><p></p>'||gg.nazn||'</td>'||chr(10)||
      '<td width="116" valign="top"><p align="center">'||gg.s||'</p></td>'||chr(10)||
      '<td width="70" valign="top"><p align="center">'||gg.lcv||'</p></td>'||chr(10)||
      '  </tr>'||chr(10);
    end loop;

      l_res:=l_res||
      '<tr>'||chr(10)||
      '  <td width="799" colspan="7" valign="top"><p>Залишок коштів    на кінець періоду: </p></td>'||chr(10)||
      '  <td width="116" valign="top"><p align="center">'||ff.f8||'</p></td>'||chr(10)||
      '  <td width="70" valign="top"><p align="center">'||ff.f7||'</p></td>'||chr(10)||
      '</tr>'||chr(10);

      l_res:=l_res||
  '</table>'||chr(10)||
  '<p> </p><br />';
     end loop;
  l_res:=l_res||chr(10)||
  '</body>'||chr(10)||
  '</html>';
    return l_res;
  end get_acchtml;

  --------------------------------------------------------------------------------
  -- get_acchtml -  возвращает HTML отчет по счету
  --
  --

  function get_crdhtml(
    p_nls in varchar2,
    p_crd_lcv  in char,
    p_mfo in varchar2,
    p_date_from in date,
    p_date_to   in date
  ) return clob
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_crdhtml';
    l_res clob;
    l_nd cc_deal.nd%type;
    l_iterator number:=0;
    l_crd_kv number;
    l_cr_prn_base number;
    l_cr_int_base number;
    l_cr_prn_overdue number;
    l_cr_int_overdue number;
    l_rate number;
     l_is_nls accounts.nbs%type;
  begin
    begin
      select nbs into l_is_nls
        from accounts a,nd_acc n,tabval t
       where a.acc=n.acc
         and a.nls=p_nls
         and t.kv=a.kv
         and t.lcv=p_crd_lcv
         and a.tip='SS '
         and a.kf = p_mfo;
    exception
      when no_data_found then
        return null;
    end;
  bars_audit.trace('%s: entry point', l_th);
  bars_audit.trace('%s: p_nls=%s, p_lcv=%s, p_date_from=%s, p_date_to=%s', l_th, to_char(p_nls),p_crd_lcv,to_char(p_date_from,'DD/MM/YYYY'),to_char(p_date_to,'DD/MM/YYYY'));
  l_res:=
    '<html>'||chr(10)||
    '  <head>'||chr(10)||
    '    <meta http-equiv="Content-Type" content="text/html; charset=win1251" />'||chr(10)||
    '    <title>Сформовано '||to_char(sysdate,'DD.MM.RRRR, HH24:MI:SS')||'</title>'||chr(10)||
    '    <style type="text/css">'||chr(10)||
    '      p{'||chr(10)||
    '      padding: 0px;'||chr(10)||
    '      margin: 0px;'||chr(10)||
    '      line-height: 1;'||chr(10)||
    '      font-size: 12px;'||chr(10)||
    '      font-family: "Times New Roman";'||chr(10)||
    '      }'||chr(10)||
    '    </style>'||chr(10)||
    '  </head>'||chr(10)||
    '<body>'||chr(10);
  for hh in
    (
    select c.nd,
           a.kv,
           'Сформовано '||to_char(sysdate,'DD.MM.YYYY')||'р.  '||to_char(sysdate,'HH24:MM') h1,
           'Виписка по кредитному договору №'||c.cc_id h2_1,
           ' за період з '||to_char(p_date_from,'DD.MM.YYYY')||'р. по '||to_char(p_date_to,'DD.MM.YYYY')||'р.' h2_2,
           'Клієнт: '||(select nmk from customer where rnk = c.rnk) h3,
           'Валюта: '||(select lcv||'('||t.name||')' from tabval$global t where t.kv=a.kv) h4,
           'Сума кредиту '||num2str1000(c.sdog) h5,
           (select to_char(max(fdat),G_MW_DATE_FORMAT) from cc_lim l where l.nd = c.nd) h7,
           'Заборгованість по кредиту станом на '||to_char(p_date_to,'DD.MM.YYYY')||'р.' h8,
           'Залишок кредиту: '||nvl((select num2str1000(abs(fost(aa.acc,p_date_to)/100)) from accounts aa, nd_acc nn where aa.acc=nn.acc and aa.tip='SS' and aa.kv=a.kv and nn.nd=c.nd and rownum=1),'0') h9,
           'Несплачений поточний платіж по кредиту: ' h10,
           '                   Несплачені проценти: ' h11,
           'Просрочена заборгованість по кредиту: ' h12,
           '                 просрочені проценти: ' h13,
           nvl((select abs(sum(fost(aa.acc,p_date_to))/100) from accounts aa, nd_acc nn where aa.acc=nn.acc and aa.tip in ('SN8') and aa.kv=a.kv and nn.nd=c.nd),'0') h14,
           'Штраф: 0' h15,
           nvl((select abs(sum(fost(aa.acc,p_date_to))/100) from accounts aa, nd_acc nn where aa.acc=nn.acc and aa.tip in ('SK0','SK9') and aa.kv=a.kv and nn.nd=c.nd),'0') h16,
           'Всього до сплати' h17
      from accounts a,
           nd_acc n,
           cc_deal c
     where c.nd=n.nd
       and n.acc=a.acc
       and a.nls=p_nls
       and (select lcv from tabval$global t where kv=a.kv)=p_crd_lcv
    )
  loop
    l_res:=l_res||
    '<p align="right">'||trim(hh.h1)||'</p>'||chr(10)||
    '<p> </p>'||chr(10)||
    '<br />'||chr(10)||
    '<br />'||chr(10);
    l_res:=l_res||
    '<p align="center">'||chr(10)||
    '  <strong>'||trim(hh.h2_1)||'</strong>'||chr(10)||
    '<br />'||chr(10)||
    '  <strong>'||trim(hh.h2_2)||'</strong>'||chr(10)||
    '</p>'||chr(10)||
    '<p> </p>'||chr(10);
    l_res:=l_res||
    '<p>'||trim(hh.h3)||'</p>'||chr(10)||
    '<p>'||trim(hh.h4)||'</p>'||chr(10)||
    '<p>'||trim(hh.h5)||'</p>'||chr(10);

    select nvl((
        select rate
          from (select acrn.fprocn(acc,0, bankdate_g) rate
                  from (select a.acc from accounts a,int_accn i,nd_acc n
                         where n.acc=a.acc
                           and a.tip in (upper('ss'),upper('lim'))
                           and (select count(1) from saldoa sa where sa.acc=a.acc)!=0
                           and i.id=0
                           and i.acc=a.acc
                           and n.nd=hh.nd
                         order by decode(acrn.fprocn(a.acc,0, bankdate_g),0,0,1), a.daos desc
                         )
                 where rownum =1
                      )),0)
    into l_rate
      from dual;
    l_res:=l_res||
    '<p>'||'Ставка: '||num2str1000(l_rate)||'% </p>'||chr(10)||
    '<p>'||'Дата закінчення'||hh.h7||'</p>'||chr(10)||
    '<p> </p>'||chr(10)||
    '<p><strong>'||hh.h8||'</strong></p>'||chr(10)||
    '<p>'||trim(hh.h9)||'</p>'||chr(10);

    select nvl((select sumg
            from cc_lim
           where nd = hh.nd
             and fdat =
                        (select min(fdat)
                           from cc_lim l
                          where l.fdat > trunc(bankdate_g)
                            and l.nd = hh.nd
                            and l.sumo  != 0)
             ),0)/100
    into l_cr_prn_base
    from dual;

    l_res:=l_res||'<p>'||hh.h10||num2str1000(l_cr_prn_base)||'</p>'||chr(10);

    select nvl((select sumo - sumg
                      from cc_lim
                     where nd = hh.nd
                       and fdat =
                                  (select min(fdat)
                                     from cc_lim l
                                    where l.fdat > trunc(bankdate_g)
                                      and l.nd = hh.nd
                                      and l.sumo  != 0)
                       ),0)/100
      into l_cr_int_base
      from dual;

    l_res:=l_res||'<p>'||hh.h11||num2str1000(l_cr_int_base)||'</p>'||chr(10);
                              l_res:=l_res||'<p> </p>'||chr(10);

    select nvl(
           (select abs(sum(nvl(gl.p_ncurval(980, gl.p_icurval(a.kv, fost(a.acc, bankdate_g), bankdate_g), bankdate_g),0))) cr_principal_overdue
                  from accounts a, nd_acc n
                 where n.acc=a.acc
                   and n.nd=hh.nd
                   and a.tip in (--'SS ', -- SS  Основний борг
                                 --'SN ', -- SN  Процентний борг
                                 'SP ', -- SP  Просрочений осн.борг
                                 --'SPN', -- SPN Просрочений проц.борг
                                 'SL '--,  SL  Сумнівний осн.борг
                                 --'SLN', -- SLN Сомнительный процентный долг
                                 --'SK0', -- SK0 Нарах. комісія за кредит
                                 --'SK9', -- SK9 Просроч. комісія за кредит
                                 --'SN8' -- SN8 Нарах.пеня
                                   )
             ),0)
      into l_cr_prn_overdue
      from dual;
    l_res:=l_res||'<p>'||hh.h12||num2str1000(l_cr_prn_overdue)||'</p>'||chr(10);

    select nvl(
           (select abs(sum(nvl(gl.p_ncurval(980, gl.p_icurval(a.kv, fost(a.acc, bankdate_g), bankdate_g), bankdate_g),0))) cr_interest_overdue
              from accounts a, nd_acc n
             where n.acc=a.acc
               and n.nd=hh.nd
               and a.tip in (--'SS ', -- SS  Основний борг
                             --'SN ', -- SN  Процентний борг
                             --'SP ', -- SP  Просрочений осн.борг
                             'SPN', -- SPN Просрочений проц.борг
                             --'SL ', -- SL  Сумнівний осн.борг
                             'SLN'--,  SLN Сомнительный процентный долг
                             --'SK0', -- SK0 Нарах. комісія за кредит
                             --'SK9', -- SK9 Просроч. комісія за кредит
                             --'SN8' -- SN8 Нарах.пеня
                            )
            ),0)
      into l_cr_int_overdue
      from dual;
    l_res:=l_res||'<p>'||hh.h13||num2str1000(l_cr_int_overdue)||'</p>'||chr(10);
    l_res:=l_res||'<p> </p>'||chr(10);
    l_res:=l_res||'<p>'||'Пеня: '||num2str1000(hh.h14)||'</p>'||chr(10) ;
    l_res:=l_res||'<p>'||hh.h15||'</p>'||chr(10) ;
    l_res:=l_res||'<p>'||'Комісії: '||num2str1000(hh.h16)||'</p>'||chr(10)
                              ||'<p> </p>'||chr(10);
    l_res:=l_res||'<p>'||hh.h17||num2str1000(l_cr_prn_base+l_cr_int_base+l_cr_prn_overdue+l_cr_int_overdue+hh.h14+hh.h16)||'</p>'||chr(10)
                              ||'<p> </p>'||chr(10);

    l_res:=l_res||
    '<table border="1" cellspacing="0" cellpadding="0" width="986">'||chr(10)||
    '  <tr>'||chr(10)||
    '    <td width="41" rowspan="2" valign="top"><p align="center"><strong>№ п.п.</strong></p></td>'||chr(10)||
    '    <td width="101" rowspan="2" valign="top"><p align="center"><strong>Дата операції </strong></p></td>'||chr(10)||
    '    <td width="111" rowspan="2" valign="top"><p align="center"><strong>Дата відображення операції в системі Банку</strong></p></td>'||chr(10)||
    '    <td width="497" colspan="2" valign="top"><p align="center"><strong>Зміст операції</strong></p></td>'||chr(10)||
    '    <td width="133" rowspan="2" valign="top"><p align="center"><strong>Сума</strong></p></td>'||chr(10)||
    '    <td width="103" rowspan="2" valign="top"><p align="center"><strong>Валюта</strong></p></td>'||chr(10)||
    '  </tr>'||chr(10)||
    '  <tr>'||chr(10)||
    '    <td width="137" valign="top"><p align="center"><strong>Рахунок одержувача</strong></p></td>'||chr(10)||
    '    <td width="360" valign="top"><p align="center"><strong>Призначення платежу</strong></p></td>'||chr(10)||
    '  </tr>'||chr(10);
    l_crd_kv:=hh.kv;

    for jj in (
    select fdat d,
           decode((lag(fdat,1,to_date(null)) over (order by fdat,lcv))||lcv,fdat||lcv,to_date(null),fdat) fdat,
           nls,nazn,s/100 s,tip,
           decode((lag(fdat,1,to_date(null)) over (order by fdat,lcv))||lcv,fdat||lcv,null,sum(s/100) over (partition by fdat,kv)) ss,
           decode((lag(fdat,1,to_date(null)) over (order by fdat,lcv))||lcv,fdat||lcv,null,lcv) lcv,
           (count(fdat) over(partition by fdat,kv)+1) cc
      from(
      select k.*
              from (select o.fdat,
                           o.ref,
                           o.stmt,
                           o.s,
                           a.kv,
                           a.nls
                      from opldok   o,
                           accounts a,
                           saldoa   s
                     where o.dk = 0
                       and a.acc = o.acc
                       and a.acc in (select ac.acc
                                       from nd_acc   n,
                                            accounts ac
                                      where nd = hh.nd
                                        and ac.acc = n.acc)
                       and a.nbs in (select nbs
                                       from nbs_deb_pog)
                       and s.acc = a.acc
                       and o.fdat = s.fdat
                       and s.dos > 0

                       and s.fdat >= p_date_from
                       and s.fdat <= p_date_to) d,
                   (select o.fdat,
                           o.ref,
                           o.stmt,
                           o.s,
                           a.nbs,
                           a.tip,
                           a.kv,
                           (select lcv from tabval$global t where t.kv=a.kv) lcv,
                           a.nls,
                           o.tt,
                           oo.nazn
                      from accounts a,
                           opldok   o,
                           saldoa   s,
                           oper    oo
                     where o.dk = 1
                       and a.acc = o.acc
                       and o.ref=oo.ref
                       and a.acc in (select ac.acc
                                       from nd_acc   n,
                                            accounts ac
                                      where nd = hh.nd
                                        and ac.acc = n.acc
                                        and ac.tip in ('SS','SP')
                                        and ac.kv = nvl(l_crd_kv, ac.kv)
                                        )
                       and a.nbs in (select nbs
                                       from nbs_krd_pogt)
                       and s.acc = a.acc
                       and o.fdat = s.fdat
                       and s.kos > 0
                       and s.fdat >= p_date_from
                       and s.fdat <= p_date_to) k
             where k.ref = d.ref
               and k.stmt = d.stmt
               and d.fdat = k.fdat
      union all
      select k.*
              from (select o.fdat,
                           o.ref,
                           o.stmt,
                           o.s,
                           a.kv,
                           a.nls
                      from opldok   o,
                           accounts a,
                           saldoa   s
                     where o.dk = 0
                       and a.acc = o.acc
                       and a.acc in (select ac.acc
                                       from nd_acc   n,
                                            accounts ac
                                      where nd = hh.nd
                                        and ac.acc = n.acc)
                       and a.nbs in (select nbs
                                       from nbs_deb_pog)
                       and s.acc = a.acc
                       and o.fdat = s.fdat
                       and s.dos > 0

                       and s.fdat >= p_date_from
                       and s.fdat <= p_date_to) d,
                   (select o.fdat,
                           o.ref,
                           o.stmt,
                           o.s,
                           a.nbs,
                           a.tip,
                           a.kv,
                           (select lcv from tabval$global t where t.kv=a.kv) lcv,
                           a.nls,
                           o.tt,
                           oo.nazn
                      from accounts a,
                           opldok   o,
                           saldoa   s,
                           oper    oo
                     where o.dk = 1
                       and a.acc = o.acc
                       and o.ref=oo.ref
                       and a.acc in (select ac.acc
                                       from nd_acc   n,
                                            accounts ac
                                      where nd = hh.nd
                                        and ac.acc = n.acc
                                        and ac.tip in ('SN','SPN')
                                        and ac.kv = nvl(l_crd_kv, ac.kv)
                                        )
                       and a.nbs in (select nbs
                                       from nbs_krd_pogp)
                       and s.acc = a.acc
                       and o.fdat = s.fdat
                       and s.kos > 0
                       and s.fdat >= p_date_from
                       and s.fdat <= p_date_to) k
             where k.ref = d.ref
               and k.stmt = d.stmt
               and d.fdat = k.fdat)
           order by 1
    )
    loop
      if jj.fdat is not null then
        l_iterator:=l_iterator+1;
        l_res:=l_res||
        '    <tr>'||chr(10)||
        '  <td width="41" rowspan="'||to_char(jj.cc)||'" valign="top"><p>'||to_char(l_iterator)||'. </p></td>'||chr(10)||
        '  <td width="101" rowspan="'||to_char(jj.cc)||'" valign="top"><p>'||to_char(jj.fdat,G_MW_DATE_FORMAT)||'</p></td>'||chr(10)||
        '  <td width="111" rowspan="'||to_char(jj.cc)||'" valign="top"><p>'||to_char(jj.fdat,G_MW_DATE_FORMAT)||'</p></td>'||chr(10)||
        '  <td width="497" colspan="2" valign="top"><p><strong>Всього погашено (в т.ч.):</strong></p></td>'||chr(10)||
        '  <td width="133" valign="top"><p align="center">'||num2str1000(jj.ss)||'</p></td>'||chr(10)||
        '  <td width="103" rowspan="'||to_char(jj.cc)||'" valign="top"><p align="center">'||jj.lcv||'</p></td>'||chr(10)||
        '</tr>'||chr(10);
      end if;

      l_res:=l_res||
      '<tr>'||chr(10)||
      '  <td width="137" valign="top"><p>'||jj.nls||'</p></td>'||chr(10)||
      '  <td width="360" valign="top"><p>'||jj.nazn||'</p></td>'||chr(10)||
      '  <td width="133" valign="top"><p align="center">'||num2str1000(jj.s)||'</p></td>'||chr(10)||
      '</tr>';

    end loop;
  end loop;

  l_res:=l_res||'<p><strong>Погашення заборгованості за кредитом:</strong></p>'||chr(10);
  l_res:=l_res||
  '</table>'||chr(10)||
  '<p> </p>'||chr(10)||
  '</body>'||chr(10)||
  '</html>';
    return l_res;
  end get_crdhtml;

  --------------------------------------------------------------------------------
  -- get_vyp_rs -  возвращает элемент DataRs с выписками
  --
  --
  function get_vyp_rs(
    p_nls in accounts.nls%type,
    p_lcv  in char,
    p_mfo in varchar2,
    p_date_from in date default null,
    p_date_to in date default null
  ) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_vyp_rs';
    l_res xmltype;
    l_html clob;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_nls=%s, p_lcv=%s, p_date_from=%s, p_date_to=%s', l_th, to_char(p_nls),p_lcv,to_char(p_date_from,'DD/MM/YYYY'),to_char(p_date_to,'DD/MM/YYYY'));

    l_html:=nvl(get_crdhtml(p_nls,p_lcv,p_mfo,p_date_from,p_date_to),nvl(get_dpthtml(p_nls,p_lcv,p_mfo,p_date_from,p_date_to),get_acchtml(p_nls,p_lcv,p_mfo,p_date_from,p_date_to)));

    if l_html is null
       then
         bars_audit.error(l_th || ' № '||p_nls||' не относится к депозитному, кредитном и текущем счету');
         l_html := '<div>No list</div>';
    end if;

    select XmlElement("DataRs",
                      XmlElement("Stmt",
                                 XmlElement("CustomStmt",
                                            XmlElement("html",
                                                       XmlElement("text", XMLCdata(xmltype(l_html).getclobval()))
                                                      ) -- Html
                                            ) -- CustomStmt
                                  ) -- Stmt
                     ) -- DataRs
    into l_res
    from dual;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_vyp_rs;



  --------------------------------------------------------------------------------
  -- get_data_rs -  формирует элемент DataRs для ответного xml для запроса списка счетов----295512
  --
  function get_data_rs(
    p_type in varchar2,
    p_rnk in customer.rnk%type) return xmltype
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_data_rs';
    l_res xmltype;
    l_contracts xmltype;
    l_accounts xmltype;
    l_deposits xmltype;
    l_deposits_refill xmltype;
    l_credits xmltype;
  begin
    bars_audit.trace('%s: entry point', l_th);

    l_accounts:= (case
                  when regexp_like(p_type,'(('||G_ABS_ACCOUNT||',)|('||G_ABS_ACCOUNT||')$)')
                  then get_acclist(p_rnk)
                   end);

    l_deposits:= (case
                  when regexp_like(p_type,'(('||G_ABS_DEPOSIT||',)|('||G_ABS_DEPOSIT||')$)')
                  then get_dptlist(p_rnk)
                   end);

    l_deposits_refill:= (case
                         when regexp_like(p_type,'(('||G_ABS_DEPOSIT_REFILL||',)|('||G_ABS_DEPOSIT_REFILL||')$)')
                         then get_dptlist(p_rnk,1)
                          end);

    l_credits:= (case
                 when regexp_like(p_type,'(('||G_ABS_CREDIT||',)|('||G_ABS_CREDIT||')$)')
                 then get_crdlist(p_rnk)
                 end);

  select XmlConcat(l_accounts,l_deposits,l_deposits_refill,l_credits)
    into l_contracts
    from dual;

  select XmlElement("DataRs",l_contracts) data_rs -- DataRs
    into l_res
    from dual;

    bars_audit.trace('%s: done', l_th);
    return l_res;
  end get_data_rs;

  --------------------------------------------------------------------------------
  -- get_open_deposit - открытие депозита и возврат по нему данных
  --
  procedure get_open_deposit(
    p_xml in xmltype,
    p_res out xmltype,
    p_error_code out number,
    p_error_message out varchar2)
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_open_deposit';
    l_res xmltype;
    l_tmp clob;
l_xml xmltype;
    l_str varchar2(256);
    l_rnk customer.rnk%type;
    l_lcv tabval.lcv%type;
    l_kv tabval.kv%type;
    l_product_code dpt_types.type_id%type;
    l_extra varchar2(4000);
    l_period varchar2(400);
    l_comproc number;
    l_freq_k varchar2(400);
    l_nls accounts.nls%type;
    l_amount dpt_deposit.limit%type;
    l_dpt_id dpt_deposit.deposit_id%type;
    l_acc accounts%rowtype;
    l_cust customer%rowtype;
    l_vidd dpt_vidd%rowtype;
    l_error_code decimal := 0;
    l_mfo varchar2(10);
    l_error_message varchar2(4000) := null;
  begin
    bars_audit.trace('%s: entry point', l_th);
    logger.trace('WAY4 logger: in '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'));
    savepoint sp_create_deposit;
    l_str := p_xml.extract('UFXMsg/MsgData/Application/ObjectFor/ClientIDT/CustomIDT/text()').getStringVal();
      l_rnk := to_number(substr(l_str,5, 8));
      l_rnk := bars_sqnc.rukey(l_rnk, l_mfo);
    l_lcv := p_xml.extract('UFXMsg/MsgData/Application/Data/Contract/Currency/text()').getStringVal();
    l_product_code := to_number(p_xml.extract('UFXMsg/MsgData/Application/Data/Contract/Product/ProductCode1/text()').getStringVal());
    l_extra := p_xml.extract('UFXMsg/MsgData/Application/Data/Contract/AddContractInfo/ExtraRs/text()').getStringVal();
    l_extra := trim(replace(replace(replace(l_extra, CHR(10), ''), CHR(13), ''), CHR(09), ''));
    l_str := p_xml.extract('UFXMsg/MsgData/Application/ObjectFor/ClientIDT/CustomCode/text()').getStringVal();
    l_nls := substr(l_str,0,instr(l_str,'$')-1);
    begin
      select * into l_cust from customer where rnk = l_rnk;
    exception
      when no_data_found then
        --721 Клієнта не існує
        rollback to savepoint sp_create_deposit;
        get_error(721,l_rnk,p_error_code,p_error_message);
        return;
    end;
    
    for c in (select regexp_substr(l_extra,'[^;]+', 1, level) as val from dual
              connect by regexp_substr(l_extra, '[^;]+', 1, level) is not null)
      loop
        declare
          l_par varchar2(400);
          l_val varchar2(400);
        begin
          select trim(replace(regexp_replace(val, '[^=]+$', '', 1, 1),'=','')) as par,
                 regexp_substr(val, '[^=]+$', 1, 1) as val
            into l_par, l_val
            from (select c.val as val from dual) t;
          if l_par = 'DEPOSIT_PERIOD' then
            l_period := l_val;
          end if;
          if l_par = 'DEPOSIT_AMOUNT' then
            l_amount := to_number(l_val) * 100;
          end if;
          if l_par = 'DEPOSIT_REINVEST_INTEREST' then
            if l_val = 'Y' then
              l_comproc := 1;
            else
              l_comproc := 0;
            end if;
          end if;
          if l_par = 'DEPOSIT_INTEREST_PAYMENT' then
            l_freq_k := l_val;
          end if;
          if l_par = 'DEPOSIT_TARGET_CONTRACT_NUMBER' then
            l_nls := substr(l_val,instr(l_val, '-')+1, length(l_val));
          end if;
        end;
      end loop;
    begin
      select * into l_acc from accounts where rnk = l_rnk and nls = l_nls and dazs is null and rownum = 1;
    exception
      when no_data_found then
        --701 Рахунок не належить клієнту
        rollback to savepoint sp_create_deposit;
        get_error(701,l_nls,p_error_code,p_error_message);
        return;
    end;
    begin
       intg_wb.header_mode(2);
      select * into l_vidd from table(INTG_WB.get_dpt_vidd(l_product_code, l_period, l_lcv, l_comproc, l_freq_k));
    exception
      when no_data_found then
        --722 Ia ciaeaaii aea aaiiceoo
        rollback to savepoint sp_create_deposit;
        get_error(722,'code='||l_product_code||',period='||l_period||',currency='||l_lcv,p_error_code,p_error_message);
        return;
    end;

    begin
      select t.kv into l_kv from tabval t where t.lcv = l_lcv;
    exception
      when no_data_found then
        --723 Не знайдено валюту
        rollback to savepoint sp_create_deposit;
        get_error(723,l_lcv,p_error_code,p_error_message);
        return;
    end;

    /*******************************************************************/
    bc.subst_branch(l_acc.branch);
    bars_audit.info('l_acc.nls = ' || l_acc.nls);
    dpt_web.create_deposit(p_vidd => l_vidd.vidd,--l_vidd.vidd,
                           p_rnk => l_cust.rnk,
                           p_nd => null,--p_doc_number,
                           p_sum => l_amount,
                           p_nocash => 1,
                           p_datz => trunc(sysdate),
                           p_namep => l_cust.nmk,
                           p_okpop => l_cust.okpo,
                           p_nlsp => l_acc.nls,
                           p_mfop => l_acc.kf,
                           p_fl_perekr => 0,
                           p_name_perekr => l_cust.nmk,
                           p_okpo_perekr => l_cust.okpo,
                           p_nls_perekr => l_acc.nls,
                           p_mfo_perekr => l_acc.kf,
                           p_comment => null,
                           p_dpt_id => l_dpt_id,
                           p_wb => 'Y');
    /*******************************************************************/

    l_res := get_dpt(l_cust.rnk, l_dpt_id);

    select XmlElement("DataRs",l_res) data_rs -- DataRs
      into l_res
      from dual;

    p_res := l_res;
    p_error_code := l_error_code;
    p_error_message := l_error_message;
  exception
    when others then
      rollback to savepoint sp_create_deposit;
      bars_audit.error(l_th||sqlcode||' : '||sqlerrm);
      get_error(700,l_th,p_error_code,p_error_message);
      return;
  end get_open_deposit;

  --------------------------------------------------------------------------------
  -- get_edit_deposit - изменение условий депозита
  --
  procedure get_edit_deposit(
    p_xml in xmltype,
    p_res out xmltype,
    p_error_code out number,
    p_error_message out varchar2)
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_edit_deposit';
    l_res xmltype;
    l_param xmltype;
    l_str varchar2(256);
    l_rnk customer.rnk%type;
    l_extra varchar2(4000);
    l_autoprol varchar2(1);
    l_nls varchar2(15);
    l_nls_p dpt_deposit.nls_p%type;
    l_nls_d dpt_deposit.nls_d%type;
    l_dpt_deposit dpt_deposit.deposit_id%type;
    l_agrmtid dpt_agreements.agrmnt_id%type;
    l_cust customer%rowtype;
    l_acc accounts%rowtype;
    l_error_code decimal := 0;
    l_error_message varchar2(4000) := null;
  begin
    savepoint sp_edit_deposit;
    l_extra := p_xml.extract('UFXMsg/MsgData/Application/Data/Contract/AddContractInfo/ExtraRs/text()').getStringVal();
    l_extra := trim(replace(replace(replace(l_extra, CHR(10), ''), CHR(13), ''), CHR(09), ''));
    l_str := p_xml.extract('UFXMsg/MsgData/Application/ObjectFor/ContractIDT/Client/CustomIDT/text()').getStringVal();
    l_rnk := to_number(substr(l_str,5, 8));
    l_dpt_deposit := to_number(p_xml.extract('UFXMsg/MsgData/Application/ObjectFor/ContractIDT/ContractNumber/text()').getStringVal());
    for c in (select regexp_substr(l_extra,'[^;]+', 1, level) as val from dual
              connect by regexp_substr(l_extra, '[^;]+', 1, level) is not null)
      loop
        declare
          l_par varchar2(400);
          l_val varchar2(400);
        begin
          select trim(replace(regexp_replace(val, '[^=]+$', '', 1, 1),'=','')) as par,
                 regexp_substr(val, '[^=]+$', 1, 1) as val
            into l_par, l_val
            from (select c.val as val from dual) t;
          if l_par = 'DEPOSIT_AUTOPROLONGATION' then
            l_autoprol := l_val;
          end if;
          if l_par = 'DEPOSIT_TARGET_CONTRACT_NUMBER' then
            l_nls := substr(l_val,instr(l_val, '-')+1, length(l_val));
          end if;
        end;
      end loop;
    begin
      select * into l_cust from customer where rnk = l_rnk;
    exception
      when no_data_found then
        --721 Клієнта не існує
        rollback to savepoint sp_edit_deposit;
        get_error(721,l_rnk,p_error_code,p_error_message);
        return;
    end;
    begin
      select * into l_acc from accounts where rnk = l_rnk and nls = l_nls and dazs is null;
    exception
      when no_data_found then
        --701 Рахунок не належить клієнту
        rollback to savepoint sp_edit_deposit;
        get_error(701,l_nls,p_error_code,p_error_message);
        return;
    end;
    begin
      select nls_p, nls_d into l_nls_p, l_nls_d from dpt_deposit where deposit_id = l_dpt_deposit and rnk = l_cust.rnk;
    exception
      when no_data_found then
        --703 Депозит не належить клієнту
        rollback to savepoint sp_edit_deposit;
        get_error(703,l_dpt_deposit,p_error_code,p_error_message);
        return;
    end;
    if l_autoprol = 'N' then
     begin
     dpt_web.create_agreement(p_dptid          => l_dpt_deposit,
                              p_agrmnttype     => 17,
                              p_initcustid     => l_cust.rnk,
                              p_trustcustid    => null,
                              p_trustid        => null,
                              p_transferdpt    => null,
                              p_transferint    => null,
                              p_amountcash     => null,
                              p_amountcashless => null,
                              p_datbegin       => null,
                              p_datend         => null,
                              p_ratereqid      => null,
                              p_ratevalue      => null,
                              p_ratedate       => null,
                              p_denomamount    => null,
                              p_denomcount     => null,
                              p_denomref       => null,
                              p_comissref      => null,
                              p_docref         => null,
                              p_comissreqid    => null,
                              p_agrmntid       => l_agrmtid);
      exception when others then bars_audit.info(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
      end;
    end if;
    if l_nls not in (l_nls_p, l_nls_d) and l_nls is not null then
     begin
      select XmlElement("doc",
                 XmlElement("nls",l_acc.nls),
                 XmlElement("mfo",l_acc.kf),
                 XmlElement("okpo",l_cust.okpo),
                 XmlElement("nmk",l_cust.nmk)) param
        into l_param
        from dual;
      dpt_web.create_agreement(p_dptid          => l_dpt_deposit,
                              p_agrmnttype     => 11,
                              p_initcustid     => l_cust.rnk,
                              p_trustcustid    => null,
                              p_trustid        => null,
                              p_transferdpt    => l_param.getClobVal(),
                              p_transferint    => l_param.getClobVal(),
                              p_amountcash     => null,
                              p_amountcashless => null,
                              p_datbegin       => null,
                              p_datend         => null,
                              p_ratereqid      => null,
                              p_ratevalue      => null,
                              p_ratedate       => null,
                              p_denomamount    => null,
                              p_denomcount     => null,
                              p_denomref       => null,
                              p_comissref      => null,
                              p_docref         => null,
                              p_comissreqid    => null,
                              p_agrmntid       => l_agrmtid);
      exception when others then bars_audit.info(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
      end;
    end if;

    l_res := get_dpt(l_cust.rnk, l_dpt_deposit);

    select XmlElement("DataRs",l_res) data_rs -- DataRs
      into l_res
      from dual;

    p_res := l_res;
    p_error_code := l_error_code;
    p_error_message := l_error_message;
  exception
    when others then
      rollback to savepoint sp_edit_deposit;
      bars_audit.error(l_th||sqlcode||' : '||sqlerrm);
      bars_audit.info(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
      get_error(700,l_th,p_error_code,p_error_message);
      return;
  end get_edit_deposit;

  --------------------------------------------------------------------------------
  -- get_response_int - внутренняя функция для получения ответа
  --
  -- @p_request_xml - входящий xml
  --


  --------------------------------------------------------------------------------
  -- get_response_int - внутренняя функция для получения ответа
  --
  -- @p_request_xml - входящий xml
  --
  function get_response_int(
    p_request_xml in clob) return clob
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_response_int';
    l_res xmltype;
    l_xml xmltype;
    l_data_rs xmltype;
    l_parm_code varchar2(256);
    l_parm_value varchar2(256);
    l_str varchar2(256);
    l_rnk customer.rnk%type;
    l_target varchar2(20);
    l_msg_type varchar2(15);
    l_nls number;
    l_contract varchar2(20);
    l_lcv varchar2(3);
    l_kv number;
    l_date_from date;
    l_date_to date;
    l_impdoc xml_impdocs%rowtype;
    l_type varchar2(25); --перевірка виписка чи історія операцій
    l_transcode varchar2(25);--тип повідомлення для операцій
    l_type_nls number;--тип рахунку 1-деп, 2 - текущий, 3 кредит
    l_app_code varchar2(8);
    l_role_code varchar2(1);
    l_mfo varchar2(10);
    l_key_err number := 1;
    l_error_code number := 0;
    l_error_message varchar2(4000) := null;
    l_request_type varchar2(200) := null;
  begin

    bars_audit.trace('%s: entry point', l_th);
    logger.trace('WAY4 logger: in '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'));
    --TODO: в целях отладки временно работаем с обычной таблицей
    --delete from test_mway;
    --insert into test_mway(x) values (p_request_xml);

    l_xml := xmltype(p_request_xml);
    begin
      l_msg_type:=l_xml.extract('UFXMsg/@msg_type').getStringVal();
      /***********MMFO************/
      l_app_code := l_xml.extract('UFXMsg/Target/@app').getStringVal();
      begin
        l_role_code := l_xml.extract('UFXMsg/Target/@role').getStringVal();
      exception
        when others then
          l_role_code := null;
      end;
      if l_msg_type = 'Doc' then
        l_transcode := l_xml.extract('UFXMsg/MsgData/'||l_msg_type||'/TransType/TransCode/MsgCode/text()').getStringVal();
      end if;
      l_parm_code := l_xml.extract('UFXMsg/MsgData/'||l_msg_type||'/ResultDtls/Filter/ParmsInfo/Parm/ParmCode/text()').getStringVal();
      l_parm_value := l_xml.extract('UFXMsg/MsgData/'||l_msg_type||'/ResultDtls/Filter/ParmsInfo/Parm/Value/text()').getStringVal();
      l_target:= l_xml.extract('UFXMsg/Target/@app').getStringVal();
    exception when others then
      --bars_audit.error(l_th || ' ошибка определения типа запроса - ' || sqlerrm);
      null;
    end;
    begin
      if l_app_code = 'Way4U' and l_role_code is not null then
        select mfo into l_mfo from mway_mapping_branch where rolecode = l_role_code;
      else
        select mfo into l_mfo from mway_mapping_branch where appcode = l_app_code;
      end if;
      bc.subst_branch('/'||l_mfo||'/');
    exception
      when no_data_found then
        get_error(721,l_rnk,l_error_code,l_error_message);
        l_key_err := 0;
        null;
    end;
    begin
      l_str := l_xml.extract('UFXMsg/MsgData/'||l_msg_type||'/Requestor/Client/CustomIDT/text()').getStringVal();
      /***********MMFO************/
      l_rnk := to_number(substr(l_str,5, 8));
      l_rnk := bars_sqnc.rukey(l_rnk, l_mfo);
    exception when others then
      --bars_audit.error(l_th || ' ошибка определения RNK ('||l_str||')- ' || sqlerrm);
      null;
    end;
    begin
      l_request_type := l_xml.extract('UFXMsg/ExtRefSet/Ref/text()').getStringVal();
    exception when others then
      l_request_type := null;
    end;
    -- сохраняем реквест в журнал
    log(G_DIRECTION_INPUT, p_request_xml, l_rnk, l_transcode);
    /*****запрос списка счетов****/
    if l_parm_value is not null and l_key_err = 1 then
      l_data_rs := get_data_rs(upper(l_parm_value), l_rnk);
    /*****************************/
    /***********операции**********/
    elsif l_key_err = 1 then
      if l_transcode in ('01000P','01000F','01000F_AUTH','04200P','04200F') and l_request_type is null then
      get_payord(l_xml, l_rnk, l_transcode, l_mfo, l_error_code, l_error_message);
      dbms_lock.sleep(45);  -- COBUSUPABS-6410  Встановити таймаут обробки UFX запитів з процесінгової системи на стороні АБС «БАРС» на рівні 45 секунд
    else
        if l_request_type is not null and l_request_type in ('OPEN_DEPOSIT','EDIT_DEPOSIT') then
          case l_request_type
            when 'OPEN_DEPOSIT' then
              get_open_deposit(l_xml, l_data_rs, l_error_code, l_error_message);
            when 'EDIT_DEPOSIT' then
              get_edit_deposit(l_xml, l_data_rs, l_error_code, l_error_message);
          end case;
          select DELETEXML(l_xml,'/UFXMsg/MsgData/Application/Data') into l_xml from dual;
        else
    /*****************************/
    /*історія операцій та виписки*/
    begin
      --Nls счета
      l_contract:=l_xml.extract('UFXMsg/MsgData/Doc/Requestor/ContractNumber/text()').getStringVal();

      begin
        select a.nls,
               t.lcv
          into l_nls,
               l_lcv
          from accounts a,
               tabval$global t
         where a.nls = l_contract
           and a.kv = t.kv
           and a.kf = l_mfo
           and rownum = 1;
      exception
        when no_data_found then
          begin
            select a.nls,
                   t.lcv
              into l_nls,
                   l_lcv
              from accounts a,
                   cc_deal c,
                   nd_acc n,
                   tabval$global t
             where c.nd = n.nd
               and n.acc = a.acc
               and c.cc_id = l_contract
               and a.tip = 'SS '
               and a.kf = l_mfo
               and a.kv = t.kv;
          exception
            when no_data_found then
              begin
                --l_contract := bars_sqnc.rukey(l_contract, l_mfo);
                select a.nls,
                       t.lcv
                  into l_nls,
                       l_lcv
                  from accounts a,
                       dpt_accounts d,
                       tabval$global t
                 where a.acc = d.accid
                   and d.dptid = l_contract
                   and a.tip = 'DEP'
                   and a.kv = t.kv
                   and a.kf = l_mfo;
              exception
                when no_data_found then
                  l_nls := l_contract;
              end;
          end;
      end;

      -- Дата с
        select (
                select to_date(value,G_MW_DATE_FORMAT)
                  from (select (column_value).extract('Parm/ParmCode/text()').getStringVal() parm,
                               (column_value).extract('Parm/Value/text()').getStringVal() value
                          from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/ResultDtls/Parm'))
                                       from dual
                                    )
                       )
                 where lower(parm) = lower('DateFrom')
                )
           into l_date_from
           from dual;
        --Дата по
        select (
                select to_date(value,G_MW_DATE_FORMAT)
                  from (select (column_value).extract('Parm/ParmCode/text()').getStringVal() parm,
                               (column_value).extract('Parm/Value/text()').getStringVal() value
                          from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/ResultDtls/Parm'))
                                       from dual
                                    )
                       )
                 where lower(parm) = lower('DateTo')
                )
           into l_date_to
           from dual;

        select (
                select value
                  from (select (column_value).extract('Parm/ParmCode/text()').getStringVal() parm,
                               (column_value).extract('Parm/Value/text()').getStringVal() value
                          from table(select XMLSequence(l_xml.extract('UFXMsg/MsgData/Doc/ResultDtls/Parm'))
                                       from dual
                                    )
                       )
                 where lower(parm) = lower('StmtCustomType')
                )
           into l_type
           from dual;

      exception when others then
        bars_audit.error(l_th || ' ошибка определения параметров ' || sqlerrm);
      end;
      if l_type is null then
        l_data_rs:=get_hist_operation(l_nls,l_lcv,l_mfo,l_date_from,l_date_to);
      else
        l_data_rs:=get_vyp_rs(l_nls,l_lcv,l_mfo,l_date_from,l_date_to);
      end if;
      /*****************************/
    end if;
    end if;
    end if;
    -- модифицируем входящий XML
    -- делаем из него исходящий
    with t as
    (
      select
        updatexml(x,
          'UFXMsg/@direction', 'Rs'
        ) x,
        l_error_code as resp_code,
        l_msg_type as resp_class,
        decode(l_error_code, 0, 'Successfully processed', l_error_message) as resp_text
--      from (select p_request_xml x from dual)
      from (select l_xml x from dual)
    )
    select XMLRoot(
    insertchildxml(
      insertchildxml(
        insertchildxml(
            insertchildxml(
              insertchildxml(
                t.x,
                '/UFXMsg/MsgData/'||l_msg_type,
                'Status',
                XmlElement("Status",
                       XmlElement("RespClass",'Information'),
                       XmlElement("RespCode",resp_code),
                       XmlElement("RespText",resp_text)
                )),
            '/UFXMsg/MsgData/'||l_msg_type, 'DataRs', l_data_rs),
        '/UFXMsg', '@resp_code', resp_code),
      '/UFXMsg', '@resp_class', resp_class),
    'UFXMsg/MsgData/'||l_msg_type||'/DataRs/ContractRs/Contract/ContractIDT','MemberId',
    XmlElement("MemberId",l_target)),version '1.0" encoding="utf-8')
    into l_res
    from t;

    bars_audit.trace('%s: done', l_th);
    -- сохраняем ответ в журнал
    log(G_DIRECTION_OUTPUT,  l_res.getClobVal, l_rnk, l_transcode);
    logger.trace('WAY4 logger: out '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'));
    return l_res.getClobVal;
  end get_response_int;


  --------------------------------------------------------------------------------
  -- get_response - точка входа для обработки входящих запросов через PL/SQL
  --
  -- @p_request_xml - входящий xml (295512)
  --
  function get_response(
    p_request_xml in clob) return clob
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_response';
    l_res clob;
    l_recid number;

  begin
    select id into l_tech_user from staff$base where logname = G_TECH_USER;
    execute immediate 'alter session set current_schema=BARS';
    bars.bars_login.login_user(substr(sys_guid(), 1, 32), l_tech_user, null, null);
    --execute immediate 'alter session set current_schema=BARS';
    --bars.bars_login.login_user('w4session', 20094, null, null);

    bars_audit.trace('%s: entry point', l_th);
    logger.trace('WAY4 logger: in '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'));
    -- сохраняем реквест в журнал
    --log(G_DIRECTION_INPUT, p_request_xml);


    l_res := get_response_int(p_request_xml);

    -- сохраняем ответ в журнал
    --log(G_DIRECTION_OUTPUT,  l_res);
    logger.trace('WAY4 logger: out '||l_th||' time: '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'));
    bars_audit.trace('%s: done', l_th);
    bars.bars_login.logout_user;

    return l_res;

  end get_response;

  --------------------------------------------------------------------------------
  -- get_response_http - точка входа для обработки входящих запросов через HTTP
  --
  -- @p_request_head - заголовок http-запроса
  -- @p_request_body - тело http-запроса
  --
  function get_response_http(
    p_request_head in clob,
    p_request_body in clob) return clob
  is
    l_th constant varchar2(100) := g_dbgcode || 'get_response_http';
  begin
    bars_audit.trace('%s: entry point', l_th);

    -- возврат ответа
    return get_response(p_request_body);

    bars_audit.trace('%s: done', l_th);
  end get_response_http;

begin
  select id into l_tech_user from staff$base where logname = G_TECH_USER;
  execute immediate 'alter session set current_schema=BARS';
  bars.bars_login.login_user(substr(sys_guid(), 1, 32), l_tech_user, null, null);
end mway_mgr;
/

show errors;

exec sys.utl_recomp.recomp_serial('BARS');

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/mway_mgr.sql =========*** End *** ==
PROMPT ===================================================================================== 
