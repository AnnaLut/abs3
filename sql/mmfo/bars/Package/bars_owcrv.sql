
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_owcrv.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_OWCRV is

g_head_version constant varchar2(64)  := 'Version 2.2 27/02/2015';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

procedure parse_rxa_file (
  p_fileid    in number,
  p_filename  in varchar2,
  p_filebody  in clob );

procedure import_crvfile (
  p_filename  in     varchar2,
  p_fileid    in out number,
  p_err          out number );

procedure get_xafilebody (
  p_filetype  in number,
  p_filename out varchar2,
  p_filebody out clob );

procedure form_xa_file (
  p_filetype  in number,
  p_filename out varchar2 );

procedure unform_xa_acc (
  p_filename in varchar2,
  p_rnk      in number,
  p_acc      in number );

procedure unform_xa_file (
  p_filename in varchar2 );

procedure form_ticket ( p_fileid in out number );

procedure form_c_file (
  p_filename out varchar2,
  p_impid    out number );

procedure close_crvacc ( p_mode in number );

procedure form_request ( p_id in number, p_nd in number );

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_OWCRV is

g_body_version constant varchar2(64)  := 'Version 2.9 27/02/2015';
g_body_defs    constant varchar2(512) := '';

g_modcode      constant varchar2(3)   := 'WRV';

g_lc_nbs   accounts.nbs%type  := '2625';
g_lc_ob22  accounts.ob22%type := '22';
g_lc_tip   accounts.tip%type  := 'W4V';
g_lc_kv    accounts.kv%type   := 980;

subtype t_crvclient is ow_crvfiles_data%rowtype;

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header bars_owcrv ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body bars_owcrv ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-----------------------------------------------
-- EXTRACT()
--
--     безопаcно получает значение по XPath
--
--
function extract(p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
begin
  return p_xml.extract(p_xpath).getStringVal();
exception when others then
  if sqlcode = -30625 then
    return p_default;
  else
    raise;
  end if;
end extract;

-------------------------------------------------------------------------------
-- check_client
-- Процедура проверки данных для регистрации БПК по файлу
--
procedure check_client (p_crvclient in out t_crvclient)
is
  l_rnk number;
  i     number;
begin

  p_crvclient.str_err := null;
  p_crvclient.err_code := 0;

  if p_crvclient.branch        is null
  or p_crvclient.first_name    is null
  or p_crvclient.last_name     is null
  or p_crvclient.okpo          is null
  or p_crvclient.adr_city      is null
  or p_crvclient.adr_street    is null
  or p_crvclient.passp_ser     is null
  or p_crvclient.passp_num     is null
  or p_crvclient.passp_org     is null
  or p_crvclient.passp_date    is null
  or p_crvclient.bday          is null
  or p_crvclient.word          is null
  or p_crvclient.crv_rnk       is null
  or p_crvclient.crv_dbcode    is null then

     p_crvclient.str_err := 'Не заповнено обов''язкові реквізити';
     p_crvclient.err_code := 1;

  else

     -- проверка на дубль crv_rnk
     begin
        -- ищем клиента по crvrnk
        select w.rnk into l_rnk
          from customerw w, accounts a
         where w.tag = 'RVRNK' and w.value = to_char(p_crvclient.crv_rnk)
           and w.rnk = a.rnk
           and a.nbs = g_lc_nbs
           and a.ob22 = g_lc_ob22
           and a.tip = g_lc_tip
           and a.dazs is null;
        -- один клиент и один открытый счет НК у клиента
        p_crvclient.str_err := 'Клієнта ЦРВ ' || to_char(p_crvclient.crv_rnk) || ' вже зареєстровано, РНК ' || to_char(l_rnk);
        p_crvclient.err_code := 2;
     exception
        -- не нашли клиента crvrnk
        when no_data_found then null;
        -- нашли несколько клиентов или у клиента несколько открытых счетов НК
        when too_many_rows then
           -- сколько клиентов с открытыми счетами НК?
           select count(*) into i
             from customerw w
            where tag = 'RVRNK' and value = to_char(p_crvclient.crv_rnk)
              and exists ( select 1 from accounts a
                            where a.rnk = w.rnk
                              and a.nbs = g_lc_nbs
                              and a.ob22 = g_lc_ob22
                              and a.tip = g_lc_tip
                              and a.dazs is null );
           -- несколько клиентов
           if i > 1 then
              raise_application_error(-20000, 'Знайдено декілька клієнтів АБС для клієнта ЦРВ ' || to_char(p_crvclient.crv_rnk), true);
           -- несколько счетов
           else
              select w.rnk, count(*) into l_rnk, i
                from customerw w, accounts a
               where tag = 'RVRNK' and value = to_char(p_crvclient.crv_rnk)
                 and w.rnk = a.rnk
                 and a.nbs = g_lc_nbs
                 and a.ob22 = g_lc_ob22
                 and a.tip = g_lc_tip
                 and a.dazs is null
               group by w.rnk;
              raise_application_error(-20000, 'Для клієнта ЦРВ ' || to_char(p_crvclient.crv_rnk) || ' (РНК ' || to_char(l_rnk) || ')  відкрито ' || to_char(i) || ' рахунків НК', true);
           end if;
     end;

     if p_crvclient.err_code = 0 then
        -- проверка на существующий branch
        begin
           select 1 into i from branch where branch = p_crvclient.branch;
        exception when no_data_found then
           p_crvclient.str_err := 'Неіснуючуй код відділення';
           p_crvclient.err_code := 1;
        end;

        -- проверка дат
        if p_crvclient.passp_date < p_crvclient.bday then
           p_crvclient.str_err := 'Дата видачі паспорту менша за дату народження';
           p_crvclient.err_code := 1;
        end if;

        if nvl(p_crvclient.passp_doctype,1) = 1 and
           ( p_crvclient.passp_ser <> upper(p_crvclient.passp_ser) or length(p_crvclient.passp_ser) <> 2 ) then
           p_crvclient.str_err := 'Некоректна серія паспорту';
           p_crvclient.err_code := 1;
        end if;
     end if;

  end if;

end check_client;

-------------------------------------------------------------------------------
-- found_crvclient
-- Функция поиска клиента по значению RVRNK
--
function found_crvclient (p_crvrnk number) return number
is
  l_rnk      number := null;
  l_date_off date;
begin
   begin
      select c.rnk, c.date_off
        into l_rnk, l_date_off
        from customer c, customerw w
       where c.rnk = w.rnk
         and w.tag = 'RVRNK' and w.value = to_char(p_crvrnk);
      if l_date_off is not null then
         update customer set date_off = null where rnk = l_rnk;
      end if;
   exception when no_data_found then
      l_rnk := null;
   end;
   return l_rnk;
end found_crvclient;

-------------------------------------------------------------------------------
-- create_customer
-- Процедура регистрации клиента по файлу
--
procedure create_customer (p_crvclient in out t_crvclient)
is
  l_rnk  number := null;
  l_nmk  varchar2(70);
  l_nmkv varchar2(70);
  l_nmkk varchar2(38);
  l_adr  varchar2(70);
  l_bday date;
  l_cust_idx customerw.value%type;
  l_cust_obl customerw.value%type;
  l_cust_dst customerw.value%type;
  l_cust_twn customerw.value%type;
  l_cust_adr customerw.value%type;
  b_setadr   boolean := false;
begin

  l_rnk := found_crvclient(p_crvclient.crv_rnk);

  if l_rnk is null then
     if p_crvclient.okpo is not null and
        substr(p_crvclient.okpo,1,5) <> '99999' and
        substr(p_crvclient.okpo,1,5) <> '00000' then
        l_rnk := bars_ow.found_client(p_crvclient.okpo, p_crvclient.passp_ser, p_crvclient.passp_num);
     end if;
  end if;

  if l_rnk is not null then

     -- для существующего клиента меняем дату рождения и адрес, если они не заполнены
     if p_crvclient.bday is not null then
        begin
           select bday into l_bday from person where rnk = l_rnk;
           if l_bday is null then
              update person set bday = p_crvclient.bday where rnk = l_rnk;
           end if;
        exception when no_data_found then null;
        end;
     end if;

     begin
        select zip, domain, region, locality, address
          into l_cust_idx, l_cust_obl, l_cust_dst, l_cust_twn, l_cust_adr
          from customer_address
         where rnk = l_rnk
           and type_id = 1;
        if l_cust_idx is null and
           l_cust_obl is null and
           l_cust_dst is null and
           l_cust_twn is null and
           l_cust_adr is null then
           b_setadr := true;
        end if;
     exception when no_data_found then
        b_setadr := true;
     end;

  else

     -- LastName - фамилия, FirstName - имя
     l_nmk  := substr(trim(p_crvclient.last_name || ' ' || p_crvclient.first_name || ' ' || p_crvclient.mdl_name), 1, 70);
     l_nmkv := substr(f_translate_kmu(trim(l_nmk)),1,70);
     l_nmkk := substr(p_crvclient.last_name || ' ' || p_crvclient.first_name, 1, 38);

     select substr(trim(p_crvclient.adr_domain) ||
              nvl2(trim(p_crvclient.adr_region), ' ' || trim(p_crvclient.adr_region), '') ||
              nvl2(trim(p_crvclient.adr_city  ), ' ' || trim(p_crvclient.adr_city  ), '') ||
              nvl2(trim(p_crvclient.adr_street), ' ' || trim(p_crvclient.adr_street), ''), 1, 70)
       into l_adr from dual;

     kl.setCustomerAttr (
        Rnk_         => l_rnk,         -- Customer number
        Custtype_    => 3,             -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
        Nd_          => null,          -- № договора
        Nmk_         => l_nmk,         -- Наименование клиента
        Nmkv_        => l_nmkv,        -- Наименование клиента международное
        Nmkk_        => l_nmkk,        -- Наименование клиента краткое
        Adr_         => l_adr,                     -- Адрес клиента
        Codcagent_   => 5,                         -- Характеристика
        Country_     => 804,                       -- Страна
        Prinsider_   => 99,                        -- Признак инсайдера
        Tgr_         => 2,                         -- Тип гос.реестра
        Okpo_        => trim(p_crvclient.okpo),    -- ОКПО
        Stmt_        => 0,                         -- Формат выписки
        Sab_         => null,                      -- Эл.код
        DateOn_      => bankdate,                  -- Дата регистрации
        Taxf_        => null,                      -- Налоговый код
        CReg_        => -1,                        -- Код обл.НИ
        CDst_        => -1,                        -- Код район.НИ
        Adm_         => null,                      -- Админ.орган
        RgTax_       => null,                      -- Рег номер в НИ
        RgAdm_       => null,                      -- Рег номер в Адм.
        DateT_       => null,                      -- Дата рег в НИ
        DateA_       => null,                      -- Дата рег. в администрации
        Ise_         => null,                      -- Инст. сек. экономики
        Fs_          => null,                      -- Форма собственности
        Oe_          => null,                      -- Отрасль экономики
        Ved_         => null,                      -- Вид эк. деятельности
        Sed_         => null,                      -- Форма хозяйствования
        Notes_       => null,                      -- Примечание
        Notesec_     => null,                      -- Примечание для службы безопасности
        CRisk_       => 1,                         -- Категория риска
        Pincode_     => null,                      --
        RnkP_        => null,                      -- Рег. номер холдинга
        Lim_         => null,                      -- Лимит кассы
        NomPDV_      => null,                      -- № в реестре плат. ПДВ
        MB_          => 9,                         -- Принадл. малому бизнесу
        BC_          => 0,                         -- Признак НЕклиента банка
        Tobo_        => p_crvclient.branch,        -- Код безбалансового отделения
        Isp_         => null                       -- Менеджер клиента (ответ. исполнитель)
     );

     kl.setCustomerEN (
        p_rnk    => l_rnk,
        p_k070   => nvl(getglobaloption('CUSTK070'), '00000'),  -- ise
        p_k080   => nvl(getglobaloption('CUSTK080'), '00'),     -- fs
        p_k110   => '00000',                                    -- ved
        p_k090   => '00000',                                    -- oe
        p_k050   => '000',                                      -- k050
        p_k051   => '00'                                        -- sed
     );

     kl.setPersonAttr (
        Rnk_      => l_rnk,
        Sex_      => p_crvclient.sex,
        Passp_    => nvl(p_crvclient.passp_doctype,1),
        Ser_      => trim(p_crvclient.passp_ser),
        Numdoc_   => trim(p_crvclient.passp_num),
        Pdate_    => trim(p_crvclient.passp_date),
        Organ_    => trim(p_crvclient.passp_org),
        Bday_     => p_crvclient.bday,
        Bplace_   => p_crvclient.bplace,
        Teld_     => null,
        Telw_     => null
     );

     b_setadr := true;

  end if;

  if b_setadr then

     kl.setCustomerAddressByTerritory (
        Rnk_           => l_rnk,
        TypeId_        => 1,
        Country_       => 804,
        Zip_           => trim(p_crvclient.adr_pcode),
        Domain_        => trim(p_crvclient.adr_domain),
        Region_        => trim(p_crvclient.adr_region),
        Locality_      => trim(p_crvclient.adr_city),
        Address_       => trim(p_crvclient.adr_street),
        TerritoryId_   => null
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGIDX',
        Val_   => trim(p_crvclient.adr_pcode),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGOBL',
        Val_   => trim(p_crvclient.adr_domain),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGDST',
        Val_   => trim(p_crvclient.adr_region),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGTWN',
        Val_   => trim(p_crvclient.adr_city),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGADR',
        Val_   => trim(p_crvclient.adr_street),
        Otd_   => 0
     );

  end if;

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'SN_FN',
     Val_   => p_crvclient.first_name,
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'SN_LN',
     Val_   => p_crvclient.last_name,
     Otd_   => 0
  );

  if p_crvclient.mdl_name is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'SN_MN',
        Val_   => p_crvclient.mdl_name,
        Otd_   => 0
     );
  end if;

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'RVRNK',
     Val_   => to_char(p_crvclient.crv_rnk),
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'RVDBC',
     Val_   => p_crvclient.crv_dbcode,
     Otd_   => 0
  );

  if p_crvclient.card_issue_branch is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVIBR',
        Val_   => p_crvclient.card_issue_branch,
        Otd_   => 0
     );
  end if;
  if p_crvclient.card_issue_branch_abs is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVIBB',
        Val_   => p_crvclient.card_issue_branch_abs,
        Otd_   => 0
     );
  end if;
  if p_crvclient.card_issue_branch_adr is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVIBA',
        Val_   => p_crvclient.card_issue_branch_adr,
        Otd_   => 0
     );
  end if;
  if p_crvclient.card_issue_date is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVIDT',
        Val_   => to_char(p_crvclient.card_issue_date,'dd/MM/yyyy'),
        Otd_   => 0
     );
  end if;

  if p_crvclient.phone1 is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVPH1',
        Val_   => p_crvclient.phone1,
        Otd_   => 0
     );
  end if;
  if p_crvclient.phone2 is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVPH2',
        Val_   => p_crvclient.phone2,
        Otd_   => 0
     );
  end if;
  if p_crvclient.phone3 is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'RVPH3',
        Val_   => p_crvclient.phone3,
        Otd_   => 0
     );
  end if;

  -- установка параметра клиента К013 = 5 - Iншi фiзичнi особи (Сухов, для задачи ЦРВ2012)
  kl.setCustomerElement(
    Rnk_   => l_rnk,
    Tag_   => 'K013',
    Val_   => '5',
    Otd_   => 0
  );

  p_crvclient.rnk := l_rnk;

end create_customer;

-------------------------------------------------------------------------------
-- add_deal
-- добавление договора в портфель БПК
--
procedure add_deal (p_acc in number, p_nd out number)
is
  l_nd   number;
  l_term number;
begin

  begin
    select mm_max into l_term from cm_product where product_code = 'LOCAL_DEBIT_PROD';
  exception when no_data_found then
     l_term := 36;
  end;

  select bars_sqnc.get_nextval('S_OBPCDEAL') into l_nd from dual;
  insert into w4_acc (nd, acc_pk, card_code, dat_begin, dat_end)
  values (l_nd, p_acc, 'LOCAL_DEBIT_CARD', bankdate, add_months(bankdate, l_term));

  p_nd := l_nd;

end add_deal;

-------------------------------------------------------------------------------
-- create_bpk
-- Процедура регистрации карточки по файлу
--
procedure create_bpk (p_crvclient in out t_crvclient)
is
  l_mfo  varchar2(6);
  l_nls  varchar2(14);
  l_nms  varchar2(70);
  l_grp  number;
  l_vid  number;
  l_acc  number;
  l_nd   number;
  l_tmp  number;
  i      number;
  l_bpk_firstname varchar2(100);
  l_bpk_lastname  varchar2(100);
  l_trmask bars_ow.t_trmask;
begin

  l_mfo := gl.amfo;

  -- 1. карточный счет -------
  select f_newnls2(null, g_lc_tip, g_lc_nbs, p_crvclient.rnk, null, g_lc_kv),
         substr('БПК НК '|| trim(p_crvclient.last_name || ' ' || p_crvclient.first_name || ' ' || p_crvclient.mdl_name), 1, 70)
    into l_nls, l_nms
    from dual;

  -- проверка: счет не занят
  begin
     select 1 into l_tmp from accounts where nls = l_nls and kv = g_lc_kv;

     -- счет нашли, он занят, определяем свободный
     i := 0;
     loop
        -- ищем счет
        l_nls := vkrzn(substr(l_mfo,1,5),
          g_lc_nbs || '0' || lpad(to_char(i), 2, '0') || lpad(to_char(p_crvclient.rnk), 7, '0'));

        begin
           select 1 into l_tmp from accounts where nls = l_nls and kv = g_lc_kv;
        exception when no_data_found then
           -- такого счета еще нет, нужно открыть
           exit;
        end;
        i := i + 1;
        if i = 100 then
           exit;
        end if;
     end loop;
  exception when no_data_found then null;
  end;

  l_grp := null;
  l_vid := 0;

  -- открытие карточного счета
  op_reg_lock(99, 0, 0, l_grp, l_tmp, p_crvclient.rnk, l_nls, g_lc_kv, l_nms,
     g_lc_tip, user_id, l_acc, '1', 2,
     l_vid, null, null, null, null, null, null, null, null, null, p_crvclient.branch);

  -- добавление в портфель БПК
  add_deal(l_acc, l_nd);

  -- specparams:
  l_trmask.a_w4_acc := 'ACC_PK';
  l_trmask.nbs := substr(account_utl.read_account(l_acc).nls,1,4);  
  bars_ow.set_sparam('1', l_acc, l_trmask);

  -- specparam_int: OB22
  accreg.setAccountSParam(l_acc, 'OB22', g_lc_ob22);

  -- LastName - фамилия, FirstName - имя
  l_bpk_firstname := f_translate_kmu(trim(p_crvclient.first_name));
  l_bpk_lastname  := f_translate_kmu(trim(p_crvclient.last_name));
  accreg.setAccountwParam (
     p_acc  => l_acc,
     p_tag  => 'W4_EFN',
     p_val  => l_bpk_firstname );
  accreg.setAccountwParam (
     p_acc  => l_acc,
     p_tag  => 'W4_ELN',
     p_val  => l_bpk_lastname );
  accreg.setAccountwParam (
     p_acc  => l_acc,
     p_tag  => 'W4_SEC',
     p_val  => p_crvclient.word );

  p_crvclient.nd := l_nd;

exception when no_data_found then null;
end create_bpk;

-------------------------------------------------------------------------------
-- create crvdeal
-- Процедура регистрации клиента и карты по файлу
--
procedure create_crvdeal (p_fileid number)
is
  l_crvclient t_crvclient;
  l_w4_lc     ow_params.val%type;
  p varchar2(100) := 'bars_owcrv.create_crvdeal ';
  i number := 0;
  y number := 0;
begin

  bars_audit.trace(p || 'Start.');

  select nvl(max(val),'0') into l_w4_lc from ow_params where par = 'W4_LC';

  for z in ( select idn from ow_crvfiles_data where id = p_fileid and err_code = 0 )
  loop

     i := i + 1;

     select * into l_crvclient from ow_crvfiles_data where id = p_fileid and idn = z.idn;

     -- регистрация клиента
     create_customer(l_crvclient);

     -- регистрация БПК
     create_bpk(l_crvclient);

     -- если маршрут создания карт через CardMake, создаем запрос
     if l_w4_lc = '1' then
        bars_ow.add_deal_to_cmque(
           p_nd         => l_crvclient.nd,
           p_opertype   => 1 );
     end if;

     -- сохранение данных по новому клиенту
     update ow_crvfiles_data
        set rnk = l_crvclient.rnk,
            nd = l_crvclient.nd
      where id = p_fileid and idn = z.idn;

     y := y + 1;
     if y > 100 then
        commit;
        y := 0;
        bars_audit.trace(p || i || ' rows processed.');
      end if;

  end loop;

  bars_audit.trace(p || 'Finish.');

end create_crvdeal;

-------------------------------------------------------------------------------
-- iparse_crv_file
-- процедура разбора файла
--
procedure iparse_crv_file (
  p_fileid  in number,
  p_xml     in xmltype,
  p_count  out number,
  p_err    out number )
is
  i number;

  l_crvclient t_crvclient;

  c_cardinfo     varchar2(100) := '/cardinfo/';
  c_card         varchar2(100);
  l_xml      xmltype;

  p varchar2(100) := 'bars_owcrv.iparse_crv_file. ';
  y number := 0;

begin

  bars_audit.trace(p || 'Start.');

  p_err := 0;

  i := 0;

  loop

     -- счетчик счетов
     i := i + 1;

     c_card := c_cardinfo || 'card[' || i || ']';

     -- выход при отсутствии транзакций
     if p_xml.existsnode(c_card) = 0 then
        exit;
     end if;

     l_xml := xmltype(extract(p_xml,c_card,null));

     l_crvclient.branch        :=         extract(l_xml, '/card/branch/text()', null);
     l_crvclient.b040          :=         extract(l_xml, '/card/b040/text()', null);
     l_crvclient.first_name    :=  substr(extract(l_xml, '/card/first_name/text()', null),1,70);
     l_crvclient.last_name     :=  substr(extract(l_xml, '/card/last_name/text()', null),1,70);
     l_crvclient.mdl_name      :=  substr(extract(l_xml, '/card/middle_name/text()', null),1,70);
     l_crvclient.okpo          :=  substr(extract(l_xml, '/card/okpo/text()', null),1,14);
     l_crvclient.sex           :=         extract(l_xml, '/card/sex/text()', null);
     l_crvclient.adr_pcode     :=  substr(extract(l_xml, '/card/adr_pcode/text()', null),1,20);
     l_crvclient.adr_domain    :=  substr(extract(l_xml, '/card/adr_domain/text()', null),1,30);
     l_crvclient.adr_region    :=  substr(extract(l_xml, '/card/adr_region/text()', null),1,30);
     l_crvclient.adr_city      :=  substr(extract(l_xml, '/card/adr_city/text()', null),1,30);
     l_crvclient.adr_street    :=  substr(extract(l_xml, '/card/adr_street/text()', null),1,100);
     l_crvclient.phone1        :=  substr(extract(l_xml, '/card/phone1/text()', null),1,20);
     l_crvclient.phone2        :=  substr(extract(l_xml, '/card/phone2/text()', null),1,20);
     l_crvclient.phone3        :=  substr(extract(l_xml, '/card/phone3/text()', null),1,20);
     l_crvclient.passp_doctype :=  substr(extract(l_xml, '/card/passp_doctype/text()', null),1,10);
     l_crvclient.passp_ser     :=  substr(extract(l_xml, '/card/passp_ser/text()', null),1,10);
     l_crvclient.passp_num     :=  substr(extract(l_xml, '/card/passp_num/text()', null),1,20);
     l_crvclient.passp_org     :=  substr(extract(l_xml, '/card/passp_org/text()', null),1,50);
     l_crvclient.passp_date    := to_date(extract(l_xml, '/card/passp_date/text()', null),'dd/MM/yyyy');
     l_crvclient.bday          := to_date(extract(l_xml, '/card/bday/text()', null),'dd/MM/yyyy');
     l_crvclient.bplace        :=  substr(extract(l_xml, '/card/bplace/text()', null),1,10);
     l_crvclient.word          :=  substr(extract(l_xml, '/card/word/text()', null),1,20);
     l_crvclient.crv_rnk       :=         extract(l_xml, '/card/crv_rnk/text()', null);
     l_crvclient.crv_dbcode    :=  substr(extract(l_xml, '/card/crv_dbcode/text()', null),1,14);
     l_crvclient.card_issue_branch     :=  substr(extract(l_xml, '/card/card_issue_branch/text()', null),1,30);
     l_crvclient.card_issue_branch_abs :=  substr(extract(l_xml, '/card/card_issue_branch_abs/text()', null),1,30);
     l_crvclient.card_issue_branch_adr :=  substr(extract(l_xml, '/card/card_issue_branch_adr/text()', null),1,100);
     l_crvclient.card_issue_date       := to_date(extract(l_xml, '/card/card_issue_date/text()', null),'dd/MM/yyyy');

     -- конвертация строковых значений
     l_crvclient.first_name := trim(dbms_xmlgen.convert(l_crvclient.first_name,1));
     l_crvclient.last_name  := trim(dbms_xmlgen.convert(l_crvclient.last_name,1));
     l_crvclient.mdl_name   := trim(dbms_xmlgen.convert(l_crvclient.mdl_name,1));

     l_crvclient.okpo       := trim(dbms_xmlgen.convert(l_crvclient.okpo,1));
     l_crvclient.adr_pcode  := trim(dbms_xmlgen.convert(l_crvclient.adr_pcode,1));
     l_crvclient.adr_domain := trim(dbms_xmlgen.convert(l_crvclient.adr_domain,1));
     l_crvclient.adr_region := trim(dbms_xmlgen.convert(l_crvclient.adr_region,1));
     l_crvclient.adr_city   := trim(dbms_xmlgen.convert(l_crvclient.adr_city,1));
     l_crvclient.adr_street := trim(dbms_xmlgen.convert(l_crvclient.adr_street,1));
     l_crvclient.phone1     := trim(dbms_xmlgen.convert(l_crvclient.phone1,1));
     l_crvclient.phone2     := trim(dbms_xmlgen.convert(l_crvclient.phone2,1));
     l_crvclient.phone3     := trim(dbms_xmlgen.convert(l_crvclient.phone3,1));
     l_crvclient.passp_ser  := trim(dbms_xmlgen.convert(l_crvclient.passp_ser,1));
     l_crvclient.passp_num  := trim(dbms_xmlgen.convert(l_crvclient.passp_num,1));
     l_crvclient.passp_org  := trim(dbms_xmlgen.convert(l_crvclient.passp_org,1));
     l_crvclient.bplace     := trim(dbms_xmlgen.convert(l_crvclient.bplace,1));
     l_crvclient.word       := trim(dbms_xmlgen.convert(l_crvclient.word,1));
     l_crvclient.crv_dbcode := trim(dbms_xmlgen.convert(l_crvclient.crv_dbcode,1));
     l_crvclient.card_issue_branch := trim(dbms_xmlgen.convert(l_crvclient.card_issue_branch,1));
     l_crvclient.card_issue_branch_abs := trim(dbms_xmlgen.convert(l_crvclient.card_issue_branch_abs,1));
     l_crvclient.card_issue_branch_adr := trim(dbms_xmlgen.convert(l_crvclient.card_issue_branch_adr,1));

     check_client(l_crvclient);

     -- вставка в таблицу
     insert into ow_crvfiles_data (id, idn, b040, branch, first_name, last_name, mdl_name, okpo, sex,
            adr_pcode, adr_domain, adr_region, adr_city, adr_street,
            phone1, phone2, phone3,
            passp_doctype, passp_ser, passp_num, passp_org, passp_date,
            bday, bplace, word, crv_rnk, crv_dbcode, card_issue_branch, card_issue_branch_abs,
            card_issue_branch_adr, card_issue_date, str_err, err_code)
     values (p_fileid, i, l_crvclient.b040, l_crvclient.branch, l_crvclient.first_name, l_crvclient.last_name, l_crvclient.mdl_name, l_crvclient.okpo, l_crvclient.sex,
            l_crvclient.adr_pcode, l_crvclient.adr_domain, l_crvclient.adr_region, l_crvclient.adr_city, l_crvclient.adr_street,
            l_crvclient.phone1, l_crvclient.phone2, l_crvclient.phone3,
            l_crvclient.passp_doctype, l_crvclient.passp_ser, l_crvclient.passp_num, l_crvclient.passp_org, l_crvclient.passp_date,
            l_crvclient.bday, l_crvclient.bplace, l_crvclient.word, l_crvclient.crv_rnk, l_crvclient.crv_dbcode,
            l_crvclient.card_issue_branch, l_crvclient.card_issue_branch_abs, l_crvclient.card_issue_branch_adr,
            l_crvclient.card_issue_date, l_crvclient.str_err, l_crvclient.err_code);

     -- ставим признак ошибки
     if l_crvclient.err_code > 0 then
        p_err := 1;
     end if;

     y := y + 1;
     if y > 100 then
        commit;
        y := 0;
        bars_audit.trace(p || i || ' rows parsed.');
     end if;

  end loop;

  p_count := i-1;

  bars_audit.trace(p || 'Finish.');

end iparse_crv_file;

-------------------------------------------------------------------------------
-- import_crvfile
-- Процедура импорта файла для регистрации клиентов и карт по файлу ЦРВ
--
procedure import_crvfile (
  p_filename  in     varchar2,
  p_fileid    in out number,
  p_err          out number )
is
  l_fileid    number;
  l_count     number := 0;
  l_err       number := 0;
  l_clob      clob;
  l_xml_full  xmltype;
  p varchar2(100) := 'bars_owcrv.import_crvfile. ';
begin

  bars_audit.trace(p || 'Start.');

  delete from ow_crvfiles_data where id in ( select id from ow_crvfiles where trunc(file_date) < trunc(sysdate)-30 );

  select nvl(max(id),0) + 1 into l_fileid from ow_crvfiles;

  insert into ow_crvfiles (id, file_name, file_date, err_code)
  values (l_fileid, p_filename, sysdate, 0);

  select file_data into l_clob from ow_impfile where id = p_fileid;

  l_xml_full := xmltype(l_clob);

  iparse_crv_file(l_fileid, l_xml_full, l_count, l_err);

  update ow_crvfiles set file_n = l_count, err_code = l_err where id = l_fileid;

  commit;

  create_crvdeal(l_fileid);

  delete from ow_impfile where id = p_fileid;

  p_fileid := l_fileid;
  p_err := l_err;

  bars_audit.trace(p || 'Finish.');

end import_crvfile;

-------------------------------------------------------------------------------
-- get_xafile_num - возвращает номер файла за день
--
function get_xafile_num return number
is
--  l_filename ow_xafiles.file_name%type;
  l_counter number;
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  begin
     select file_name into l_filename
       from ow_xafiles
      where rownum = 1
        for update wait 5;
  exception when no_data_found then null;
  end;

  select nvl(max(to_number(substr(file_name,15,5))),0)+1 into l_counter
    from ow_xafiles
   where trunc(file_date) = trunc(sysdate);
*/
  return l_counter;

end get_xafile_num;

-------------------------------------------------------------------------------
-- get_xafile_header - возвращает заголовок файла
--
function get_xafile_header ( p_filename out varchar2 ) return xmltype
is
  l_counter  number;
  l_header   xmltype;
  l_xabranch varchar2(6);
begin

  l_counter := get_xafile_num;
  begin
     select substr(val,1,6) into l_xabranch from ow_params where par = 'W4_BRANCH';
  exception when no_data_found then
     l_xabranch := '0000';
  end;

  select
     XmlElement("FileHeader",
        XmlForest(
           '1.0' "FormatVersion",
           l_xabranch "Sender",
           to_char(sysdate, 'yyyy-MM-dd') "CreationDate",
           to_char(sysdate, 'hh24:mi:ss') "CreationTime",
           l_counter "Number",
           l_xabranch "Institution"
         )
     )
  into l_header from dual;

  p_filename := 'XADVAPL' || rpad(l_xabranch,6,'0') || '_' || lpad(l_counter,5,'0') || '.' || to_char(sysdate,'DDD');

  return l_header;

end get_xafile_header;

-------------------------------------------------------------------------------
-- get_xafile_data - возвращает тело файла
--
function get_xafile_data (
  p_requestid  in number,
  p_file_name  in varchar2,
  p_count     out number ) return xmltype
is
  l_count          number  := 0;
  l_data           xmltype := null;
  l_xml_tmp        xmltype := null;
  l_xabranch       varchar2(6);
  l_xanum          number;
  l_regnumber      number;
  l_pa_regnumber   varchar2(32);
  l_pu_regnumber   varchar2(32);
  l_ia_regnumber   varchar2(32);
  l_ia_regnumber1  varchar2(32);
  l_ia_regnumber2  varchar2(32);
  l_cu_regnumber   varchar2(32);
  l_ca_regnumber   varchar2(32);
  l_ea_regnumber   varchar2(32);
  i                number;
  p varchar2(100) := 'bars_owcrv.get_xafile_data. ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.info(p || 'Start. p_requestid=>' || p_requestid);

  begin
     select substr(val,1,6) into l_xabranch from ow_params where par = 'W4_BRANCH';
  exception when no_data_found then
     l_xabranch := '0000';
  end;

  begin
     select to_number(nvl(val,'100')) into l_xanum from ow_params where par = 'CRV_XANUM';
  exception when no_data_found then
     l_xanum := 100;
  end;

  -- 1. формирование файла XADVAPL на открытие счетов
  if p_requestid = 1 then

     for v in ( select * from v_ow_xa_accounts where rownum <= l_xanum )
     loop

        begin
        select rnk into i from customerw where rnk = v.rnk and tag = 'RVRNK' for update skip locked;

        l_count := l_count + 1;

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_pa_regnumber  := 'PA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_ia_regnumber1 := 'IA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_ia_regnumber2 := 'IA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_cu_regnumber  := 'CU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select
           XmlElement("Application",
              XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
              XmlElement("ObjectType", 'Client'),
              XmlElement("ActionType", 'Add'),
              XmlElement("ProductGroup", 'ISSDEB'),
              XmlElement("RegNumber", Convert(l_pa_regnumber,'UTF8','CL8MSWIN1251')),
              XmlElement("Data",
                 XmlElement("Client",
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("ClientType", 'PR'),
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumber", Convert(v.passp,'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumberDetails", Convert(v.organ,'UTF8','CL8MSWIN1251'))
                    ), --"ClientIDT"
                    XmlElement("ClientInfo",
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("FathersName", Convert(v.mdl_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("SecurityName", Convert(v.sec_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Language", 'UKR'),
                       XmlElement("Country", 'UKR'),
                       XmlElement("BirthDate", Convert(v.bday,'UTF8','CL8MSWIN1251'))
                    ), --"ClientInfo"
                    XmlElement("PlasticInfo",
                       XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                    ), --"PlasticInfo"
                    XmlElement("BaseAddress",
                       XmlElement("AddressType",'STMT'),
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Country", 'UKR'),
                       XmlElement("City", Convert(v.adr_city,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine1", Convert(v.adr_pcode,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine2", Convert(v.adr_obl,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine3", Convert(v.adr_dst,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine4", Convert(v.adr_street,'UTF8','CL8MSWIN1251'))
                    ), --"BaseAddress"
                    XmlElement("AddInfo",
                       XmlElement("AddInfo01", Convert(v.okpo,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddInfo03", v.crv_rnk),
                       XmlElement("AddDate01", Convert(v.card_issue_date,'UTF8','CL8MSWIN1251'))
                    ) -- AddInfo
                 ) --"Client"
              ), --end "Data"
              XmlElement("SubApplList",
                 -- первый блок "Application" не заполняем
                 --XmlElement("Application",
                 --   XmlElement("ObjectType", ),
                 --   XmlElement("ActionType", ),
                 --   XmlElement("RegNumber", ),
                 --   XmlElement("Data",
                 --      XmlElement("Address",
                 --         XmlElement("AddressType", ),
                 --         XmlElement("AddressLine1", ),
                 --         XmlElement("AddressLine2", )
                 --      )
                 --   )
                 --),
                 XmlElement("Application",
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("ObjectType", 'Contract'),
                    XmlElement("ActionType", 'Add'),
                    XmlElement("RegNumber", Convert(l_ia_regnumber1,'UTF8','CL8MSWIN1251')),
                    XmlElement("Data",
                       XmlElement("Contract",
                          XmlElement("ContractName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                          XmlElement("ContractIDT",
                             XmlElement("ContractNumber", Convert(l_xabranch||'-'||v.nls,'UTF8','CL8MSWIN1251')),
                             XmlElement("RBSNumber", Convert(v.nls,'UTF8','CL8MSWIN1251'))
                          ), --"ContractIDT"
                          XmlElement("Product",
                             XmlElement("ProductCode1", 'LOCAL_DEBIT_PROD')
                          ) --"Product"
                       ) --"Contract"
                    ), --"Data"
                    XmlElement("SubApplList",
                       XmlElement("Application",
                          XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                          XmlElement("ObjectType", 'Contract'),
                          XmlElement("ActionType", 'Add'),
                          XmlElement("RegNumber", Convert(l_ia_regnumber2,'UTF8','CL8MSWIN1251')),
                          XmlElement("Data",
                             XmlElement("Contract",
                                XmlElement("ContractName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                                XmlElement("Product",
                                   XmlElement("ProductCode1", 'LOCAL_DEBIT_CARD')
                                ), --"Product"
                                XmlElement("PlasticInfo",
                                   XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                                   XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                                ), --"PlasticInfo"
                                XmlElement("AddContractInfo",
                                   XmlElement("AddInfo01", Convert(v.card_issue_branch,'UTF8','CL8MSWIN1251')),
                                   XmlElement("AddInfo02", Convert(v.card_issue_branch_adr,'UTF8','CL8MSWIN1251'))
                                ) --"AddContractInfo"
                             ) --"Contract"
                          ), --"Data"
                          XmlElement("SubApplList",
                             XmlElement("Application",
                                XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                                XmlElement("ObjectType", 'Card'),
                                XmlElement("ActionType", 'Update'),
                                XmlElement("RegNumber", Convert(l_cu_regnumber,'UTF8','CL8MSWIN1251')),
                                XmlElement("Data",
                                   XmlElement("ProduceCard",
                                      XmlElement("ProductionParms",
                                         XmlElement("DeliveryDprt", Convert(v.card_issue_branch_abs,'UTF8','CL8MSWIN1251')),
                                         XmlElement("ProductionType", 'PlasticAndPIN'),
                                         XmlElement("CardExpiry", Convert(v.cardexpiry,'UTF8','CL8MSWIN1251'))
                                      ) --"ProductionParms"
                                   ) --"ProduceCard"
                                ) --"Data"
                             ) --"Application"
                          ) --"SubApplList"
                       ) -- "Application"
                    ) --"SubApplList"
                 ) -- "Application"
              ) --"SubApplList"
           ) --"Application"
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        -- делаем просто вставку, чтоб была ошибка, если файл формируют вертушка и пользователь вручную
        insert into customerw (rnk, tag, value, isp)
        values (v.rnk, 'RV_XA', p_file_name, 0);

        insert into ow_xadata (file_name, acc, regnumber)
        values (p_file_name, v.acc, l_pa_regnumber);

        -- строка занята другим пользователем
        exception when no_data_found then null;
        end;

     end loop;

  -- 2. формирование файла XADVAPL на закрытие счетов
  elsif p_requestid = 2 then

     for v in ( select *
                  from v_ow_xaclose_accounts
                 where file_name is null
                   and rownum <= l_xanum )
     loop

        begin
        select acc into i from ow_crvacc_close where acc = v.acc and file_name is null for update skip locked;

        l_count := l_count + 1;

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_cu_regnumber := 'CU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_ea_regnumber := 'EA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select
           XmlElement("Application",
              XmlElement("ObjectType", 'Contract'),
              XmlElement("ActionType", 'Update'),
              XmlElement("RegNumber", Convert(l_cu_regnumber,'UTF8','CL8MSWIN1251')),
              XmlElement("OrderDprt", v.branch),
              XmlElement("ObjectFor",
                 XmlElement("Contract",
                    XmlElement("ContractIDT",
                       XmlElement("Client",
                          XmlElement("ClientIDT",
                             XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                             XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251'))
                          ) -- ClientIDT
                       ), -- "Client"
                    XmlElement("ContractNumber", Convert(l_xabranch||'-'||v.nls,'UTF8','CL8MSWIN1251'))
                    ) -- "Contract"
                 ) -- "Contract"
              ), -- "ObjectFor"
              XmlElement("Data",
                 XmlElement("Contract",
                    XmlElement("DateExpiry", Convert(v.dateexpiry,'UTF8','CL8MSWIN1251'))
                 ) -- "Contract"
              ), -- "Data"
              XmlElement("SubApplList",
                 XmlElement("Application",
                    XmlElement("ObjectType", 'Event'),
                    XmlElement("ActionType", 'Add'),
                    XmlElement("RegNumber", Convert(l_ea_regnumber,'UTF8','CL8MSWIN1251')),
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("Data",
                       XmlElement("QueEvent",
                          XmlElement("ActionCode", 'ACC_CLOSE')
                       ) -- "QueEvent"
                    ) -- "Data"
                 ) -- "Application"
              ) -- "SubApplList"
           ) -- "Application"
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        insert into ow_xadata (file_name, acc, regnumber)
        values (p_file_name, v.acc, l_cu_regnumber);

        update ow_crvacc_close set file_name = p_file_name where acc = v.acc;

        -- строка занята другим пользователем
        exception when no_data_found then null;
        end;

     end loop;

  -- 3. Перевыпуск карточки при потере
  elsif p_requestid = 3 then

     for v in ( select * from v_ow_crvacc_request where request_id = p_requestid )
     loop

        begin
        select acc into i from ow_crvacc_request where acc = v.acc for update skip locked;

        l_count := l_count + 1;

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_ca_regnumber := 'CA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_cu_regnumber := 'CU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select
           XmlElement("Application",
              XmlElement("OrderDprt", v.branch),
              XmlElement("ObjectType", 'Contract'),
              XmlElement("ActionType", 'Add'),
              XmlElement("RegNumber", Convert(l_ca_regnumber,'UTF8','CL8MSWIN1251')),
              XmlElement("ObjectFor",
                 XmlElement("Contract",
                    XmlElement("ContractIDT",
                       XmlElement("Client",
                          XmlElement("ClientIDT",
                             XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                             XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251'))
                          ) -- ClientIDT
                       ), -- "Client"
                    XmlElement("ContractNumber", Convert(l_xabranch||'-'||v.nls,'UTF8','CL8MSWIN1251'))
                    ) -- "Contract"
                 ) -- "Contract"
              ), -- "ObjectFor"
              XmlElement("Data",
                 XmlElement("Contract",
                    XmlElement("ContractName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                    XmlElement("Product",
                       XmlElement("ProductCode1", 'LOCAL_DEBIT_CARD')),
                    XmlElement("PlasticInfo",
                       XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))),
                    XmlElement("AddContractInfo",
                       XmlElement("AddInfo01", Convert(v.card_issue_branch,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddInfo02", Convert(v.card_issue_branch_adr,'UTF8','CL8MSWIN1251')))
                 ) -- "Contract"
              ), -- "Data"
              XmlElement("SubApplList",
                 XmlElement("Application",
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("ObjectType", 'Card'),
                    XmlElement("ActionType", 'Update'),
                    XmlElement("RegNumber", Convert(l_cu_regnumber,'UTF8','CL8MSWIN1251')),
                    XmlElement("Data",
                       XmlElement("ProduceCard",
                          XmlElement("ProductionParms",
                             XmlElement("DeliveryDprt", Convert(v.card_issue_branch_abs,'UTF8','CL8MSWIN1251')),
                             XmlElement("ProductionType", 'PlasticAndPIN'),
                             XmlElement("CardExpiry", Convert(v.cardexpiry,'UTF8','CL8MSWIN1251')),
                             XmlElement("ProductionEvent", 'NCRDLOST')
                          ) --"ProductionParms"
                       ) --"ProduceCard"
                    ) --"Data"
                 ) -- "Application"
              ) -- "SubApplList"
           ) -- "Application"
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        insert into ow_xadata (file_name, acc, regnumber)
        values (p_file_name, v.acc, l_ca_regnumber);

        delete from ow_crvacc_request where acc = v.acc and request_id = p_requestid;

        -- строка занята другим пользователем
        exception when no_data_found then null;
        end;

     end loop;

  -- 4,5. Изменение данных клиента с перевыпуском карточки
  --   с комиссией
  --   без комиссии
  elsif p_requestid = 4 or p_requestid = 5 then

     for v in ( select * from v_ow_crvacc_request where request_id = p_requestid )
     loop

        begin
        select acc into i from ow_crvacc_request where acc = v.acc for update skip locked;

        l_count := l_count + 1;

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_pu_regnumber := 'PU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_ia_regnumber := 'IA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_cu_regnumber := 'CU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select
           XmlElement("Application",
              XmlElement("OrderDprt", v.branch),
              XmlElement("ObjectType", 'Client'),
              XmlElement("ActionType", 'Update'),
              XmlElement("ProductGroup", 'ISSDEB'),
              XmlElement("RegNumber", Convert(l_pu_regnumber,'UTF8','CL8MSWIN1251')),
              XmlElement("ObjectFor",
                 XmlElement("Client",
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251'))
                    ) --"ClientIDT"
                 ) -- "Client"
              ), -- "ObjectFor"
              XmlElement("Data",
                 XmlElement("Client",
                    XmlElement("OrderDprt", v.branch),
                    XmlElement("ClientType", 'PR'),
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumber", Convert(v.passp,'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumberDetails", Convert(v.organ,'UTF8','CL8MSWIN1251'))
                    ), --"ClientIDT"
                    XmlElement("ClientInfo",
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("FathersName", Convert(v.mdl_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("SecurityName", Convert(v.sec_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Language", 'UKR'),
                       XmlElement("Country", 'UKR'),
                       XmlElement("BirthDate", Convert(v.bday,'UTF8','CL8MSWIN1251'))
                    ), --"ClientInfo"
                    XmlElement("PlasticInfo",
                       XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                    ), --"PlasticInfo"
                    XmlElement("BaseAddress",
                       XmlElement("AddressType",'STMT'),
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Country", 'UKR'),
                       XmlElement("City", Convert(v.adr_city,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine1", Convert(v.adr_pcode,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine2", Convert(v.adr_obl,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine3", Convert(v.adr_dst,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine4", Convert(v.adr_street,'UTF8','CL8MSWIN1251'))
                    ), --"BaseAddress"
                    XmlElement("AddInfo",
                       XmlElement("AddInfo01", Convert(v.okpo,'UTF8','CL8MSWIN1251'))
                    ) -- AddInfo
                 ) --"Client"
              ), -- "Data"
              XmlElement("SubApplList",
                 XmlElement("Application",
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("ObjectType", 'Contract'),
                    XmlElement("ActionType", 'Add'),
                    XmlElement("RegNumber", Convert(l_ia_regnumber,'UTF8','CL8MSWIN1251')),
                    XmlElement("ObjectFor",
                       XmlElement("Contract",
                          XmlElement("ContractIDT",
                             XmlElement("Client",
                                XmlElement("ClientIDT",
                                   XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                                   XmlElement("ShortName", '<<<NONE>>>')
                                ) -- ClientIDT
                             ), -- "Client"
                          XmlElement("ContractNumber", Convert(l_xabranch||'-'||v.nls,'UTF8','CL8MSWIN1251'))
                          ) -- "Contract"
                       ) -- "Contract"
                    ), -- "ObjectFor"
                    XmlElement("Data",
                       XmlElement("Contract",
                          XmlElement("ContractName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                          XmlElement("Product",
                             XmlElement("ProductCode1", 'LOCAL_DEBIT_CARD')
                          ), --"Product"
                          XmlElement("PlasticInfo",
                             XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                             XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                          ) --"PlasticInfo"
                       ) --"Contract"
                    ), --"Data"
                    XmlElement("SubApplList",
                       XmlElement("Application",
                          XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                          XmlElement("ObjectType", 'Card'),
                          XmlElement("ActionType", 'Update'),
                          XmlElement("RegNumber", Convert(l_cu_regnumber,'UTF8','CL8MSWIN1251')),
                          XmlElement("Data",
                             XmlElement("ProduceCard",
                                XmlElement("ProductionParms",
                                   XmlElement("DeliveryDprt", Convert(v.card_issue_branch_abs,'UTF8','CL8MSWIN1251')),
                                   XmlElement("ProductionType", 'PlasticAndPIN'),
                                   XmlElement("CardExpiry", Convert(v.cardexpiry,'UTF8','CL8MSWIN1251')),
                                   XmlElement("ProductionEvent", decode(p_requestid,4,'NCRDLOST',null))
                                ) --"ProductionParms"
                             ) --"ProduceCard"
                          ) --"Data"
                       ) --"Application"
                    ) --"SubApplList"
                 ) -- "Application"
              ) -- "SubApplList"
           ) -- "Application"
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        insert into ow_xadata (file_name, acc, regnumber)
        values (p_file_name, v.acc, l_pu_regnumber);

        delete from ow_crvacc_request where acc = v.acc and request_id = p_requestid;

        -- строка занята другим пользователем
        exception when no_data_found then null;
        end;

     end loop;

  -- 6. Изменение данных клиента
  elsif p_requestid = 6 then

     for v in ( select * from v_ow_crvacc_request where request_id = p_requestid )
     loop

        begin
        select acc into i from ow_crvacc_request where acc = v.acc for update skip locked;

        l_count := l_count + 1;

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_pu_regnumber := 'PU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select
           XmlElement("Application",
              XmlElement("OrderDprt", v.branch),
              XmlElement("ObjectType", 'Client'),
              XmlElement("ActionType", 'Update'),
              XmlElement("ProductGroup", 'ISSDEB'),
              XmlElement("RegNumber", Convert(l_pu_regnumber,'UTF8','CL8MSWIN1251')),
              XmlElement("ObjectFor",
                 XmlElement("Client",
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251'))
                    ) --"ClientIDT"
                 ) -- "Client"
              ), -- "ObjectFor"
              XmlElement("Data",
                 XmlElement("Client",
                    XmlElement("OrderDprt", v.branch),
                    XmlElement("ClientType", 'PR'),
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumber", Convert(v.passp,'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumberDetails", Convert(v.organ,'UTF8','CL8MSWIN1251'))
                    ), --"ClientIDT"
                    XmlElement("ClientInfo",
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("FathersName", Convert(v.mdl_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("SecurityName", Convert(v.sec_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Language", 'UKR'),
                       XmlElement("Country", 'UKR'),
                       XmlElement("BirthDate", Convert(v.bday,'UTF8','CL8MSWIN1251'))
                    ), --"ClientInfo"
                    XmlElement("PlasticInfo",
                       XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                    ), --"PlasticInfo"
                    XmlElement("BaseAddress",
                       XmlElement("AddressType",'STMT'),
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Country", 'UKR'),
                       XmlElement("City", Convert(v.adr_city,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine1", Convert(v.adr_pcode,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine2", Convert(v.adr_obl,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine3", Convert(v.adr_dst,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine4", Convert(v.adr_street,'UTF8','CL8MSWIN1251'))
                    ), --"BaseAddress"
                    XmlElement("AddInfo",
                       XmlElement("AddInfo01", Convert(v.okpo,'UTF8','CL8MSWIN1251'))
                    ) -- AddInfo
                 ) --"Client"
              ) -- "Data"
           ) -- "Application"
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        insert into ow_xadata (file_name, acc, regnumber)
        values (p_file_name, v.acc, l_pu_regnumber);

        delete from ow_crvacc_request where acc = v.acc and request_id = p_requestid;

        -- строка занята другим пользователем
        exception when no_data_found then null;
        end;

     end loop;

  -- 7. Виправлення помилки Duplicate client registration number
  elsif p_requestid = 1 or p_requestid = 7 then

     for v in ( select * from v_ow_crvacc_request where request_id = p_requestid )
     loop

        begin
        select acc into i from ow_crvacc_request where acc = v.acc for update skip locked;

        l_count := l_count + 1;

        select s_xa_regnumber.nextval into l_regnumber  from dual;
        l_pu_regnumber  := 'PU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_ia_regnumber1 := 'IA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_ia_regnumber2 := 'IA-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select s_xa_regnumber.nextval into l_regnumber from dual;
        l_cu_regnumber  := 'CU-'||l_xabranch||'-'||lpad(to_char(l_regnumber),12,'0');

        select
           XmlElement("Application",
              XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
              XmlElement("ObjectType", 'Client'),
              XmlElement("ActionType", 'Update'),
              XmlElement("ProductGroup", 'ISSDEB'),
              XmlElement("RegNumber", Convert(l_pu_regnumber,'UTF8','CL8MSWIN1251')),
              XmlElement("ObjectFor",
                 XmlElement("Client",
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber",Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName",Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')) ) ) ),
              XmlElement("Data",
                 XmlElement("Client",
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("ClientType", 'PR'),
                    XmlElement("ClientIDT",
                       XmlElement("ClientNumber", Convert(l_xabranch||lpad(to_char(v.rnk),8,'0'),'UTF8','CL8MSWIN1251')),
                       XmlElement("ShortName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumber", Convert(v.passp,'UTF8','CL8MSWIN1251')),
                       XmlElement("RegNumberDetails", Convert(v.organ,'UTF8','CL8MSWIN1251'))
                    ), --"ClientIDT"
                    XmlElement("ClientInfo",
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("FathersName", Convert(v.mdl_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("SecurityName", Convert(v.sec_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Language", 'UKR'),
                       XmlElement("Country", 'UKR'),
                       XmlElement("BirthDate", Convert(v.bday,'UTF8','CL8MSWIN1251'))
                    ), --"ClientInfo"
                    XmlElement("PlasticInfo",
                       XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                    ), --"PlasticInfo"
                    XmlElement("BaseAddress",
                       XmlElement("AddressType",'STMT'),
                       XmlElement("FirstName", Convert(v.first_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("LastName", Convert(v.last_name,'UTF8','CL8MSWIN1251')),
                       XmlElement("Country", 'UKR'),
                       XmlElement("City", Convert(v.adr_city,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine1", Convert(v.adr_pcode,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine2", Convert(v.adr_obl,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine3", Convert(v.adr_dst,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddressLine4", Convert(v.adr_street,'UTF8','CL8MSWIN1251'))
                    ), --"BaseAddress"
                    XmlElement("AddInfo",
                       XmlElement("AddInfo01", Convert(v.okpo,'UTF8','CL8MSWIN1251')),
                       XmlElement("AddInfo03", v.crv_rnk),
                       XmlElement("AddDate01", Convert(v.card_issue_date,'UTF8','CL8MSWIN1251'))
                    ) -- AddInfo
                 ) --"Client"
              ), --end "Data"
              XmlElement("SubApplList",
                 -- первый блок "Application" не заполняем
                 --XmlElement("Application",
                 -- XmlElement("ObjectType", ),
                 -- XmlElement("ActionType", ),
                 -- XmlElement("RegNumber", ),
                 -- XmlElement("Data",
                 --    XmlElement("Address",
                 --       XmlElement("AddressType", ),
                 --       XmlElement("AddressLine1", ),
                 --       XmlElement("AddressLine2", )
                 --    )
                 -- )
                 --),
                 XmlElement("Application",
                    XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                    XmlElement("ObjectType", 'Contract'),
                    XmlElement("ActionType", 'Add'),
                    XmlElement("RegNumber", Convert(l_ia_regnumber1,'UTF8','CL8MSWIN1251')),
                    XmlElement("Data",
                       XmlElement("Contract",
                          XmlElement("ContractName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                          XmlElement("ContractIDT",
                             XmlElement("ContractNumber", Convert(l_xabranch||'-'||v.nls,'UTF8','CL8MSWIN1251')),
                             XmlElement("RBSNumber", Convert(v.nls,'UTF8','CL8MSWIN1251'))
                          ), --"ContractIDT"
                          XmlElement("Product",
                             XmlElement("ProductCode1", 'LOCAL_DEBIT_PROD')
                          ) --"Product"
                       ) --"Contract"
                    ), --"Data"
                    XmlElement("SubApplList",
                       XmlElement("Application",
                          XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                          XmlElement("ObjectType", 'Contract'),
                          XmlElement("ActionType", 'Add'),
                          XmlElement("RegNumber", Convert(l_ia_regnumber2,'UTF8','CL8MSWIN1251')),
                          XmlElement("Data",
                             XmlElement("Contract",
                                XmlElement("ContractName", Convert(substr(fio(v.nmk,2),1,1)||substr(fio(v.nmk,3),1,1)||fio(v.nmk,1),'UTF8','CL8MSWIN1251')),
                                XmlElement("Product",
                                   XmlElement("ProductCode1", 'LOCAL_DEBIT_CARD')
                                ), --"Product"
                                XmlElement("PlasticInfo",
                                   XmlElement("FirstName", Convert(v.emb_first_name,'UTF8','CL8MSWIN1251')),
                                   XmlElement("LastName", Convert(v.emb_last_name,'UTF8','CL8MSWIN1251'))
                                ), --"PlasticInfo"
                                XmlElement("AddContractInfo",
                                   XmlElement("AddInfo01", Convert(v.card_issue_branch,'UTF8','CL8MSWIN1251')),
                                   XmlElement("AddInfo02", Convert(v.card_issue_branch_adr,'UTF8','CL8MSWIN1251'))
                                ) --"AddContractInfo"
                             ) --"Contract"
                          ), --"Data"
                          XmlElement("SubApplList",
                             XmlElement("Application",
                                XmlElement("OrderDprt", Convert(v.branch,'UTF8','CL8MSWIN1251')),
                                XmlElement("ObjectType", 'Card'),
                                XmlElement("ActionType", 'Update'),
                                XmlElement("RegNumber", Convert(l_cu_regnumber,'UTF8','CL8MSWIN1251')),
                                XmlElement("Data",
                                   XmlElement("ProduceCard",
                                      XmlElement("ProductionParms",
                                         XmlElement("DeliveryDprt", Convert(v.card_issue_branch_abs,'UTF8','CL8MSWIN1251')),
                                         XmlElement("ProductionType", 'PlasticAndPIN'),
                                         XmlElement("CardExpiry", Convert(v.cardexpiry,'UTF8','CL8MSWIN1251'))
                                      ) --"ProductionParms"
                                   ) --"ProduceCard"
                                ) --"Data"
                             ) --"Application"
                          ) --"SubApplList"
                       ) -- "Application"
                    ) --"SubApplList"
                 ) -- "Application"
              ) --"SubApplList"
           ) --"Application"
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        insert into ow_xadata (file_name, acc, regnumber)
        values (p_file_name, v.acc, l_pu_regnumber);

        delete from ow_crvacc_request where acc = v.acc and request_id = p_requestid;

        -- строка занята другим пользователем
        exception when no_data_found then null;
        end;

     end loop;

  end if;

  if l_count > 0 then
     select XmlElement("ApplicationsList", l_data) into l_data from dual;
  end if;

  p_count := l_count;

  bars_audit.info(p || 'Finish. l_count=>' || to_char(l_count));
*/
  return l_data;

end get_xafile_data;

-------------------------------------------------------------------------------
procedure get_xafilebody (
  p_filetype  in number,
  p_filename out varchar2,
  p_filebody out clob )
is
  l_file_name    varchar2(100);
  l_file_header  xmltype;
  l_file_data    xmltype;
  l_xml_data     xmltype;
  l_clob_data    clob;
  l_count        number;
  h varchar2(100) := 'bars_owcrv.get_xafilebody. ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.info(h || 'Start.');

  -- FileHeader
  l_file_header := get_xafile_header(l_file_name);
  bars_audit.info(h || 'l_file_name=>' || l_file_name);

  -- резервируем имя файла, если будет работать несколько пользователей
  insert into ow_xafiles (file_name, file_n, file_type) values (l_file_name, 0, p_filetype);
  commit;

  -- FileData
  l_file_data := get_xafile_data(p_filetype, l_file_name, l_count);

  if l_count = 0 then

     delete from ow_xafiles where file_name = l_file_name;
     l_file_name := null;
--     l_clob_data := empty_clob();
     l_clob_data := ' ';

  else

     -- компоновка всего отчета
     select XmlElement("ApplicationFile",
               XmlConcat(
                  l_file_header,
                  l_file_data
               )
            )
       into l_xml_data
       from dual;

     dbms_lob.createtemporary(l_clob_data,FALSE);
     dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="UTF-8"?>');
     dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

     update ow_xafiles set file_n = l_count where file_name = l_file_name;
--     insert into ow_xafiles (file_name, file_n, file_type) values (l_file_name, l_count, p_filetype);

  end if;

  l_file_header := null;
  l_file_data   := null;
  l_xml_data    := null;

  p_filename := l_file_name;
  p_filebody := l_clob_data;

  bars_audit.info(h || 'Finish. p_filename=>' || p_filename);
*/
end get_xafilebody;

-------------------------------------------------------------------------------
-- form_xa_file
--
procedure form_xa_file (
  p_filetype  in number,	-- 1-файл на открытие карт , 0/2-файл на закрытие карт
  p_filename out varchar2 )
is
  l_filename   varchar2(100);
  l_fileclob   clob;
  p varchar2(100) := 'bars_owcrv.form_xa_file. ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.info(p || 'Start. p_filetype=>' || p_filetype);

  delete from ow_impfile where id = g_xa_impid;

  for v in ( select id
               from ow_crv_request
              where id = p_filetype or p_filetype is null )
  loop

     get_xafilebody (v.id, l_filename, l_fileclob);

     if l_filename is not null then
        insert into ow_impfile (id, file_data) values (g_xa_impid, l_fileclob);
        exit;
     end if;

  end loop;

  p_filename := l_filename;

  bars_audit.info(p || 'Finish.');
*/
end form_xa_file;

/*
-------------------------------------------------------------------------------
-- form_xa_files
-- процедура формирования файлов XA
--
procedure form_xa_files ( p_filename out varchar2 )
is
  l_count       number := 0;
  l_file_name   varchar2(100);
  l_file_header xmltype;
  l_file_data   xmltype;
  l_xml_data    xmltype;
  l_clob_data   clob;
  p varchar2(100) := 'bars_owcrv.form_xa_files. ';
begin

  bars_audit.info(p || 'Start.');

  delete from ow_impfile where id = g_xa_impid;

  -- FileHeader
  l_file_header := get_xafile_header(l_file_name);
  bars_audit.info(p || 'l_file_name=>' || l_file_name);

  -- FileData
  for v in ( select id from ow_crv_request )
  loop

     l_file_data := get_xafile_data(v.id, l_file_name, l_count);

     if l_count > 0 then

        -- компоновка всего отчета
        select XmlElement("ApplicationFile",
                  XmlConcat(
                     l_file_header,
                     l_file_data
                  )
               )
          into l_xml_data
          from dual;

        dbms_lob.createtemporary(l_clob_data,FALSE);
        dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="UTF-8"?>');
        dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

        insert into ow_xafiles (file_name, file_n, file_type) values (l_file_name, l_count, v.id);
        insert into ow_impfile (id, file_data) values (g_xa_impid, l_clob_data);

        exit;

     end if;

  end loop;

  if l_count = 0 then
     l_file_name := null;
  end if;

  l_file_header := null;
  l_file_data   := null;
  l_xml_data    := null;

  p_filename := l_file_name;

  bars_audit.info(p || 'Finish.');

end form_xa_files;
*/

-------------------------------------------------------------------------------
-- unform_xa_acc
--
procedure unform_xa_acc (
  p_filename in varchar2,
  p_rnk      in number,
  p_acc      in number )
is
begin
  raise_application_error(-20000, 'Нерабочая процедура');
/*
   delete from customerw where rnk = p_rnk and tag = 'RV_XA';
   update ow_xadata
      set unform_flag = 1,
          unform_user = user_id,
          unform_date = sysdate
    where file_name = p_filename
      and acc = p_acc
      and nvl(unform_flag,0) = 0;
*/
end unform_xa_acc;

-------------------------------------------------------------------------------
-- unform_xa_file
--
procedure unform_xa_file ( p_filename in varchar2 )
is
begin
  raise_application_error(-20000, 'Нерабочая процедура');
/*
   for z in ( select a.rnk, a.acc
                from ow_xadata x, accounts a
               where x.file_name = p_filename
                 and x.acc = a.acc
                 and nvl(x.unform_flag,0) = 0 )
   loop
      unform_xa_acc(p_filename, z.rnk, z.acc);
   end loop;
   update ow_xafiles
      set unform_flag = 1,
          unform_user = user_id,
          unform_date = sysdate
    where file_name = p_filename;
*/
end unform_xa_file;

-------------------------------------------------------------------------------
-- parse_rxa_file
-- процедура разбора квитанции RXA*.*
--
procedure parse_rxa_file (
  p_fileid    in number,
  p_filename  in varchar2,
  p_filebody  in clob )
is

  l_filebody     xmltype;

--  l_xa_filename ow_xafiles.file_name%type;
--  l_xa_n        ow_xafiles.file_n%type;
  l_filestatus  ow_files.file_status%type := 2;
  l_status      varchar2(23);
  l_acceptrec   number;
  l_rejectrec   number;
  l_regnumber   varchar2(30);
  l_resp_class  varchar2(100);
  l_resp_code   varchar2(100);
  l_resp_text   varchar2(254);

  c_filetrailer  varchar2(48)  := '/ApplicationResponseFile/FileTrailer/';
  c_nlist        varchar2(100) := '/ApplicationResponseFile/NotificationsList/';
  c_notification varchar2(100);
  c_application  varchar2(100);

  l_err varchar2(254);
  l_msg varchar2(254);

  i number := null;

  h varchar2(100) := 'bars_owcrv.parse_rxa_file. ';

begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.info(h || 'Start: p_filename=>' || p_filename);

  begin
     select file_name, file_n into l_xa_filename, l_xa_n
       from ow_xafiles
      where upper(file_name) = upper(substr(p_filename,2));
  exception when no_data_found then
     l_filestatus := 3;
     l_msg := 'Квитанція на неіснуючий файл';
     bars_audit.info(h || p_filename || ': ' || l_msg);
  end;

  if l_msg is null then

  l_filebody := xmltype(p_filebody);

  l_status    :=    substr(extract(l_filebody, c_filetrailer || '/LoadingStatus/text()', null),1,23);
  l_acceptrec := to_number(extract(l_filebody, c_filetrailer || '/NOfAcceptedRecs/text()', null));
  l_rejectrec := to_number(extract(l_filebody, c_filetrailer || '/NOfRejectedRecs/text()', null));

  if l_status = 'FILE BROKEN' then

     null;

  elsif l_status = 'FILE REJECTED' then

     i := 0;

     loop

        -- счетчик счетов
        i := i + 1;

        c_notification := c_nlist || 'Notification[' || i || ']';

        -- выход при отсутствии транзакций
        if l_filebody.existsnode(c_notification) = 0 then
           exit;
        end if;

        l_regnumber  :=        extract(l_filebody, c_notification || '/RegNumber/text()', null);
        l_resp_code  := substr(extract(l_filebody, c_notification || '/ErrorCode/text()', null),1,100);
        l_resp_text  := substr(extract(l_filebody, c_notification || '/ErrorText/text()', null),1,254);

        if l_resp_code <> '0' then
           -- квитовка строки
           update ow_xadata
              set resp_code  = l_resp_code,
                  resp_text  = l_resp_text
            where file_name = l_xa_filename
              and regnumber = l_regnumber;
        end if;

     end loop;

     -- квитовка строк
     update ow_xadata
        set resp_text = 'FILE REJECTED'
      where file_name = l_xa_filename
        and resp_code is null;

  else

     if l_xa_n <> l_acceptrec + l_rejectrec then
        l_filestatus := 3;
        l_msg := 'Кількість заяв квитанції не відповідає кількості заяв файла';
        bars_audit.info(h || p_filename || ': ' || l_msg);
     end if;

     if l_msg is null then

     i := 0;

     loop

        -- счетчик счетов
        i := i + 1;

        c_notification := c_nlist || 'Notification[' || i || ']';
        c_application  := c_notification || '/Application';

        -- выход при отсутствии транзакций
        if l_filebody.existsnode(c_application) = 0 then
           exit;
        end if;

        l_regnumber  :=        extract(l_filebody, c_notification || '/RegNumber/text()', null);
        l_resp_class := substr(extract(l_filebody, c_application  || '/Status/RespClass/text()', null),1,100);
        l_resp_code  := substr(extract(l_filebody, c_application  || '/Status/RespCode/text()', null),1,100);
        l_resp_text  := substr(extract(l_filebody, c_application  || '/Status/RespText/text()', null),1,254);

        -- квитовка строки
        update ow_xadata
           set resp_class = l_resp_class,
               resp_code  = l_resp_code,
               resp_text  = l_resp_text
         where file_name = l_xa_filename
           and regnumber = l_regnumber;
        if sql%rowcount = 0 then
           l_err := 'Квитовка заяви ' || l_regnumber || ' - заява не відправлялась в файлі ' || l_xa_filename;
           bars_audit.info(h || p_filename || ': ' || l_err);
           l_msg := substr(l_msg || l_err, 1, 254);
        end if;

     end loop;

     end if;

  end if;

  -- квитовка файла
  update ow_xafiles
     set tick_name = p_filename,
         tick_date = sysdate,
         tick_status = l_status,
         tick_accept_rec = l_acceptrec,
         tick_reject_rec = l_rejectrec
   where file_name = l_xa_filename;

  end if;

  -- ставим статус
  bars_ow.set_file_status(p_fileid, (case when i is null then null else i-1 end), l_filestatus, l_msg);

  bars_audit.info(h || 'Finish.');
*/
end parse_rxa_file;

-------------------------------------------------------------------------------
-- get_ticket_data - возвращает тело файла
--
function get_ticket_data (
  p_fileid in number ) return xmltype
is
  l_data      xmltype := null;
  l_xml_tmp   xmltype := null;
  l_nls       accounts.nls%type;
  l_err       ow_crvfiles_data.str_err%type;
begin

  for v in ( select v.crv_rnk, v.branch, v.err_code, v.str_err, a.nls
               from ow_crvfiles_data v, w4_acc w, accounts a
              where v.id = p_fileid
                and v.nd = w.nd(+)
                and w.acc_pk = a.acc(+) )
  loop

     l_err := v.str_err;
     l_nls := v.nls;

     -- если err_code=2 (повторная загрузка) - найдем ранее открытый счет
     if l_nls is null and (nvl(v.err_code,-1) != 1) then

        begin
           select a.nls into l_nls
             from customerw w, accounts a
            where tag = 'RVRNK' and value = to_char(v.crv_rnk)
              and w.rnk = a.rnk
              and a.nbs = g_lc_nbs
              and a.ob22 = g_lc_ob22
              and a.tip = g_lc_tip
              and a.dazs is null;
        exception when no_data_found then
           l_err := 'Клієнта або рахунок не знайдено, rnk = '||to_char(v.crv_rnk);
        end;

     end if;

     select XmlElement("card",
               XmlElement("crv_rnk", v.crv_rnk),
               XmlElement("branch", v.branch),
               XmlElement("res_code", v.err_code),
               XmlElement("res_msg", l_err),
               XmlElement("res_nls", l_nls)
            )
       into l_xml_tmp
       from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

  end loop;

  return l_data;

end get_ticket_data;

-------------------------------------------------------------------------------
-- form_ticket
-- процедура формирования квитанции на файл ЦРВ
--
procedure form_ticket ( p_fileid in out number )
is
  l_file_data   xmltype;
  l_xml_data    xmltype;
  l_clob_data   clob;
begin

  -- FileData
  l_file_data := get_ticket_data(p_fileid);

  -- компоновка отчета
  select XmlElement("cardinfo", l_file_data) into l_xml_data from dual;

  dbms_lob.createtemporary(l_clob_data,FALSE);
  dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251" ?>');
  dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

  p_fileid := bars_ow.get_impid;
  insert into ow_impfile (id, file_data) values (p_fileid, l_clob_data);

  l_file_data := null;
  l_xml_data  := null;

end form_ticket;

-------------------------------------------------------------------------------
-- get_cfile_body
--
--
procedure get_cfile_body (p_filename out varchar2, p_fileclob out clob)
is
  l_filename  varchar2(100) := null;
  l_data      xmltype := null;
  l_xml_tmp   xmltype := null;
  l_xml_data  xmltype := null;
  l_clob_data clob;
  l_err       varchar2(100);
  l_res_code  number := 3;
begin

  for v in ( select crv_rnk, nls, branch from w4_crv_acc_close )
  loop

     l_err := 'Рахунок ' || v.nls || ' закрито';

     select XmlElement("card",
               XmlElement("crv_rnk", v.crv_rnk),
               XmlElement("branch", v.branch),
               XmlElement("res_code", l_res_code),
               XmlElement("res_msg", l_err),
               XmlElement("res_nls", v.nls)
            )
       into l_xml_tmp
       from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

  end loop;

  if l_data is not null then

     -- компоновка отчета
     select XmlElement("cardinfo", l_data) into l_xml_data from dual;

     dbms_lob.createtemporary(l_clob_data,FALSE);
     dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251" ?>');
     dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

     l_filename := 'C_CARDINFO_' || gl.amfo || '_' || to_char(bankdate, 'ddmmyyyy') || '.xml';

  end if;

  p_filename := l_filename;
  p_fileclob := l_clob_data;

end get_cfile_body;

-------------------------------------------------------------------------------
-- form_c_file
-- процедура формирования файла по закрытым счетам C_CARDINFO*.xml для ЦРВ
--
procedure form_c_file (
  p_filename out varchar2,
  p_impid    out number )
is
  l_filename  varchar2(100);
  l_fileclob  clob;
  h varchar2(100) := 'bars_owcrv.form_c_file. ';
begin

  bars_audit.info(h || 'Start.');

  get_cfile_body (l_filename, l_fileclob);

  if l_filename is not null then

     p_impid := bars_ow.get_impid;
     insert into ow_impfile (id, file_data) values (p_impid, l_fileclob);

     -- сохраняем дату формирования файла
     update ow_params
        set val = to_char(bankdate, 'dd.mm.yyyy')
      where par = 'CRV_CDAT';

  else

     p_impid := null;

  end if;

  p_filename := l_filename;

  bars_audit.info(h || 'Finish. p_filename=>' || p_filename);

end form_c_file;

-------------------------------------------------------------------------------
procedure close_crvacc ( p_mode in number )
is
begin

   -- отбираем счета для закрытия
   for z in ( select a.acc
                from accounts a, ow_crvacc_close c
               where a.acc  = c.acc
                  -- счета с нулевым остатком
                 and a.ostc = 0
                 and a.ostb = 0
                 and a.ostf = 0
                  -- открытые счета
                 and a.dazs is null
                  -- наступила плановая дата закрытия
                 and c.dat <= bankdate
                  -- счет отправлен в ПЦ
                 and c.file_name is not null )
  loop

     -- закрываем счет
     update accounts set dazs = bankdate where acc = z.acc;

     -- удаляем закрытый счет из обработки
     delete from ow_crvacc_close where acc = z.acc;

  end loop;

end close_crvacc;

-------------------------------------------------------------------------------
procedure form_request ( p_id in number, p_nd in number )
is
  l_acc  accounts.acc%type;
  l_nls  accounts.nls%type;
  l_tip  accounts.tip%type;
  l_dazs accounts.dazs%type;
  h varchar2(100) := 'bars_owcrv.form_request. ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.info(h || 'Start. p_id=>' || to_char(p_id) || ' p_nd=>' || to_char(p_nd));

  begin
     select a.acc, a.nls, a.tip, a.dazs
       into l_acc, l_nls, l_tip, l_dazs
       from w4_acc w, accounts a
      where w.nd = p_nd
        and w.acc_pk = a.acc;
  exception when no_data_found then
     -- Счет ACC=p_pk_acc не найден в портфеле БПК-Way4
     bars_audit.info(h || 'Счет не найден в портфеле БПК-Way4 (nd=' || to_char(p_nd) || ')');
     bars_error.raise_nerror(g_modcode, 'W4ACC_NOT_FOUND');
  end;
  if l_tip <> 'W4V' then
     bars_audit.info(h || 'Рахунок ' || l_nls || ' не є нац.карткою');
     raise_application_error(-20000, 'Рахунок ' || l_nls || ' не є нац.карткою', true);
  end if;
  if l_dazs is not null then
     bars_audit.info(h || 'Рахунок ' || l_nls || ' вже закрито');
     raise_application_error(-20000, 'Рахунок ' || l_nls || ' вже закрито', true);
  end if;

  insert into ow_crvacc_request (acc, request_id)
  values (l_acc, p_id);

  bars_audit.info(h || 'Finish.');
*/
exception when dup_val_on_index then null;
end form_request;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_OWCRV ***
grant EXECUTE                                                                on BARS_OWCRV      to ABS_ADMIN;
grant EXECUTE                                                                on BARS_OWCRV      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_OWCRV      to OW;
grant EXECUTE                                                                on BARS_OWCRV      to TECH005;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_owcrv.sql =========*** End *** 
 PROMPT ===================================================================================== 
 