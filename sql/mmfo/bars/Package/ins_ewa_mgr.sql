 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ins_ewa_mgr.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.ins_ewa_mgr is

  -- Author  : VITALIY.LEBEDINSKIY
  -- Created : 01.02.2016 12:57:33
  -- Purpose : Інтеграція із зовнішньою системою EWA

  -- Public type declarations

  -- Public constant declarations
  g_header_version  constant varchar2(64)  := 'version 3.22 13/03/2018';

  -- Public function and procedure declarations

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

--------------------------------------------------------------------------------------------------------------------------------------------
--get_prodpack_ins_k Дание для продуктових пакетов

procedure get_prodpack_ins_k(p_ext_id in  number,
                             ins_nls  out varchar2,
                             ins_mfo  out varchar2,
                             ext_code out varchar2,
                             ins_okpo out customer.okpo%type,
                             ins_name out ins_partners.name%type);

  --------------------------------------------------------------------------------
  -- get_purpose - получение назначения платежа
  --
  procedure get_purpose(p_branch         in varchar2,
                    p_user_name      in varchar2,
                    p_mfob           in varchar2,
                    p_nameb          in varchar2,
                    p_accountb       in varchar2,
                    p_okpob          in varchar2,
                    p_ammount        in number,
                    p_commission     in number,
                    p_number         in varchar2,
                    p_date_from      in date,
                    p_date_to        in date,
                    p_date           in date,
                    p_cust_name_last in varchar2,
                    p_cust_name_first in varchar2,
                    p_cust_name_middle in varchar2,
                    p_cust_okpo      in varchar2,
                    p_cust_series    in varchar2,
                    p_cust_number    in varchar2,
                    p_cust_birthdate in date,
                    p_cust_phone     in varchar2,
                    p_cust_address   in varchar2,
                    p_external_id    in varchar2,
                    p_purpose            out varchar2,
                    p_errcode        out decimal,
                    p_errmessage     out varchar2,
                    p_ext_idn        in number default null
                    );
                    
  procedure get_purpose(p_xml            in  xmltype,
                        p_purpose        out varchar2,
                        p_errcode        out decimal,
                        p_errmessage     out varchar2
                        );

  --------------------------------------------------------------------------------
  -- pay_isu - создание платежного документа
  --
  procedure pay_isu(p_branch in varchar2,
                    p_user_name in varchar2,
                    p_mfob in varchar2,
                    p_nameb in varchar2,
                    p_accountb in varchar2,
                    p_okpob in varchar2,
                    p_ammount in number,
                    p_commission in number,
                    p_commission_type in varchar2,
                    p_number in varchar2,
                    p_date_from in date,
                    p_date_to in date,
                    p_date in date,
                    p_purpose in varchar2,
                    p_cust_name in varchar2,
                    p_cust_okpo in varchar2,
                    p_cust_doc_type in varchar2,
                    p_cust_series in varchar2,
                    p_cust_number in varchar2,
                    p_cust_doc_date in date,
                    p_cust_doc_issued in varchar2,
                    p_cust_birthdate in date,
                    p_cust_phone in varchar2,
                    p_cust_address in varchar2,
                    p_external_id in varchar2,
                    p_external_id_tariff in varchar2,
                 p_email           in varchar2,
                    p_ref out decimal,
                    p_errcode out decimal,
                    p_errmessage out varchar2);
                    
   procedure pay_isu(p_xml            in  xmltype,
                     p_ref            out decimal,
                     p_errcode        out decimal,
                     p_errmessage     out varchar2
                     );

  --------------------------------------------------------------------------------
  -- pay_storno - сторнирование платежного документа
  --
  /*procedure pay_storno(p_ref decimal,
                       p_account varchar2,
                       p_ammount decimal,
                       p_errcode out decimal,
                       p_errmessage out varchar2);*/

  --------------------------------------------------------------------------------
  -- get_pay_status - получение статуса документа
  --
  procedure get_pay_status(p_ref decimal,
                           p_account varchar2,
                           p_ammount decimal,
                           p_status out varchar2,
                           p_errcode out decimal,
                           p_errmessage out varchar2);

  --------------------------------------------------------------------------------
  -- create_deal - создание страхового договора
  --
  procedure create_deal(p_params in xmltype,
                        p_deal_number out ins_deals.id%type,
                        p_errcode out number,
                        p_errmessage out varchar2);
  procedure send_sos;
end ins_ewa_mgr;
/
CREATE OR REPLACE PACKAGE BODY BARS.ins_ewa_mgr is

  -- Private type declarations
type gt_imp_val is table of varchar2(255) index by pls_integer;

type gt_paydat is record(id                 number, 
                         branch             varchar2(255),
                         user_name          varchar2(255),
                         mfob               varchar2(255),
                         nameb              varchar2(255),
                         accountb           varchar2(255),
                         okpob              varchar2(255),
                         ammount            number,
                         commission         number,
                         commission_type    varchar2(255),
                         d_number           varchar2(255),
                         date_from          date,
                         date_to            date,
                         d_date             date,
                         purpose            varchar2(500),
                         cust_name          varchar2(255),
                         cust_okpo          varchar2(255),
                         cust_doc_type      varchar2(255),
                         cust_series        varchar2(255),
                         cust_number        varchar2(255),
                         cust_doc_date      date,
                         cust_doc_issued    varchar2(255),
                         cust_birthdate     date,
                         cust_phone         varchar2(255),
                         cust_address       varchar2(255),
                         external_id        varchar2(255),
                         cu_external_id     varchar2(255),
                         external_id_tariff varchar2(255),
                         email              varchar2(255),
                         ref                number(38),
                         ewa_id             number,
                         ins_code           varchar2(20),
                         insuranceAmount    number,
                         payment            number,
                         ext_state          varchar2(255)
                         );

type gt_response is record(
                           purpose        varchar2(255),
                           ref            decimal,
                           status         varchar2(255),
                           deal_number    ins_deals.id%type,
                           errcode        decimal,
                           errmessage     varchar2(255)
);

  -- Private constant declarations
  g_package_name constant varchar2(160) := 'ins_ewa_mgr';
  g_body_version  constant varchar2(64)  := 'version 3.31 12/09/2018';

  --3.0
--исправлены мелкие ошибки при создании договоров страхования (формат полей таблиц модуля страхования, проверкуи на корректность данных и и.п.)
--добавлен функционал " продуктовые пакеты"
--добавлен функционал для передачи статусов платежа в ПО ЕВА
--добавлена операция для ЦА EW3



  g_tt constant varchar(3 byte) := 'EW1'; -- операція для РУ
  g_tt_ch constant varchar2(3 byte) := 'EW2'; --Операція перерахунку з каси на транзитний рахунок
  g_tt_ca constant varchar2(3 byte) := 'EW3'; -- операція для ЦА
  g_tt_rko constant varchar2(3 byte) := 'RKO'; -- операція для РКО

  -- Function and procedure implementations

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header ins_ewa_mgr '||g_header_version||'.';
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body ins_ewa_mgr '||g_body_version||'.';
  end body_version;

--------------------------------------------------------------------------------------------------------------------------------------------
-- call_logger Конкатенація строки помилки
-- 
  procedure call_logger(p_paydat gt_paydat, p_error varchar2) is
    
  begin
    
  logger.error(g_package_name || ' in params p_branch=' || p_paydat.branch || ',p_user_name=' || p_paydat.user_name ||
                       ',p_mfob=' || p_paydat.mfob || ',p_nameb=' || p_paydat.nameb || ',p_accountb=' || p_paydat.accountb || ',p_okpob=' ||
                       p_paydat.okpob || ',p_ammount=' || to_char(p_paydat.ammount) || ', p_errmessage=' || p_error);
    
  end call_logger;
  
------------------------------------------------------------------------------------------------------------------------------------------
-- get_branch перевірка бранча
-- 
function get_branch(p_branch varchar2) return varchar2 is
  l_retval varchar2(255);
  begin
     select regexp_replace(decode(instr(name,' ',1,2),0,name,substr(name,0,instr(name,' ',1,2))),'[^[:digit:]/]','')
     into l_retval
     from branch
     where branch = p_branch;
  return l_retval;
end get_branch;
 
--------------------------------------------------------------------------------------------------------------------------------------------
-- l_xml_extract обробка помилок та конвертація в дату xml значень
-- 
  function l_xml_extract(pl_xml xmltype, pl_xpath varchar2, p_to_date number default 0) return varchar2 is
  retval varchar2(32000);
  begin
    if pl_xml.existSNode(pl_xpath) > 0 then
    retval:= utl_i18n.unescape_reference(pl_xml.extract(pl_xpath).GetStringVal());
    else
      retval:=null;
    end if;
    IF regexp_like(retval,'^\d{4}-\d{2}-\d{2}$') and p_to_date = 1 then --дата типу yyyy-mm-dd
       retval:= to_char(to_date(retval,'yyyy-mm-dd'),'dd.mm.yyyy'); 
    elsif regexp_like(retval,'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}\+\d{4}$') and p_to_date = 1 then --дата типу yyyy-mm-ddThh24:mi:ss.000+0000
          retval:= to_char(cast(to_timestamp_tz(retval,'YYYY-MM-DD"T"HH24:MI:SS.FF3TZHTZM') at time zone 'Europe/Kiev' as date),'dd.mm.yyyy');
  end if;
    return retval;
  end l_xml_extract;
 
--------------------------------------------------------------------------------------------------------------------------------------------
-- l_xml_extract розбор XML документа
--  
  procedure l_pars_xml(p_xml         xmltype,             --xml
                       p_imp_val out gt_imp_val,          --параметри для конструктора
                       p_paydat  out gt_paydat,           --параметри для створення договору, надання референсу, логування точо.
                       p_resp    out gt_response,         --відповідь (помилки)
                       p_mode        number default 1,    --1 передавати параметри конструктора, 2 -не передавати
                       p_type        number default 0) is --0 JSON для отримання призначення платежу та референсу, 1 JSON для створення договору
  l_paydat gt_paydat;  
  l_imp_val gt_imp_val;
  l_deal_id number;
  l_deal_number varchar2(50);
  l_str varchar2(3200);
  l_path varchar2(255);
  l_test_path varchar2(255);
  l_test_zn varchar2(255);
  l_contr_path varchar2(255);
  l_pay_path varchar2(255);
  begin
     if p_type = 0 then
             l_contr_path:= 'root/contract/';
             l_pay_path:='root/payment/';
        elsif p_type = 1 then
             l_contr_path:= 'root/';
             l_pay_path:='root/payments/item[1]/';
        end if;    

    if p_mode = 1 then
    --Цикл заповнення колекції l_imp_val значеннями з XML документу по Xpath з таблиці ins_ewa_purp_mval
  for i in (select id, purp_val, alt_path, alt_path_cond, def_val from ins_ewa_purp_mval order by id) 
     
     loop
        --Отримання значення по якому перевіряється умова використання альтернативного Xpath
        l_test_path:=nvl(l_xml_extract(p_xml,substr(i.alt_path_cond,1,instr(i.alt_path_cond,'|')-1),1),'null');
        --Значення для порівняння
        l_test_zn:=substr(i.alt_path_cond,instr(i.alt_path_cond,'|')+1);
        --Якщо умова отримання альтернативного Xpath не порожня та виконується беремо альтернативний Xpath інакше основний.
       if i.alt_path_cond is not null and upper(l_test_path) = upper(l_test_zn) then
          l_path:=i.alt_path;
       else
          l_path:=i.purp_val;
       end if;
       --Перевірка бранча
        if upper(l_path) = upper(l_contr_path||'salePoint/code/text()')
        then
          begin
            l_str:=nvl(get_branch(l_xml_extract(p_xml,l_path,1)),i.def_val);
            exception when no_data_found then
              p_resp.purpose    := null;
              p_resp.errcode    := -20001;
              p_resp.errmessage := upper(g_package_name)||'. Не знайдено номер відділення';
              return;
          end;
        else
            l_str:=nvl(l_xml_extract(p_xml,l_path,1),i.def_val);
        end if;    
      l_imp_val(i.id):=l_str;
  
  end loop;  
  
  p_imp_val:=l_imp_val;
  end if;
                l_deal_id:=to_number(l_xml_extract(p_xml, l_contr_path||'id/text()')); --ід договора
                l_paydat.id:=l_deal_id; --ід договора
                l_paydat.branch:=l_xml_extract(p_xml, l_contr_path||'salePoint/code/text()'); --бранч
                l_paydat.user_name:=l_xml_extract(p_xml, l_contr_path||'customFields/item[code="m1"]/value/text()'); --табельний номер
                l_paydat.mfob:=l_xml_extract(p_xml, l_pay_path||'recipientBankMfo/text()'); --МФО банку страхової
                l_paydat.nameb:=l_xml_extract(p_xml, l_pay_path||'recipientName/text()'); --назва страхової
                l_paydat.accountb:=l_xml_extract(p_xml, l_pay_path||'recipientAccountNumber/text()'); --рахунок страхової
                l_paydat.okpob:=l_xml_extract(p_xml, l_pay_path||'recipientCode/text()'); --ОКПО страхової
                l_paydat.ammount:=to_number(l_xml_extract(p_xml, l_pay_path||'payment/text()'))*100; --Сума(вартість) страховкі
                l_paydat.commission:=to_number(l_xml_extract(p_xml, l_pay_path||'commission/text()'))*100; --Сума комісії
                l_paydat.commission_type:=l_xml_extract(p_xml, l_pay_path||'commissionType/text()'); --тип комісії
                l_deal_number:=l_xml_extract(p_xml, l_contr_path||'number/text()'); --№ документу
                    if l_deal_number is null then
                    l_deal_number:=l_xml_extract(p_xml, l_contr_path||'code/text()'); --символьний № документу
                    end if;
                l_paydat.d_number:=l_deal_number;
             begin
                l_paydat.date_from:=to_date(l_xml_extract(p_xml, l_contr_path||'dateFrom/text()',1),'dd.mm.yyyy'); --дата початоку дії страховкі
                    exception when others then
                    p_resp.purpose    := null;
                    p_resp.errcode    := -20001;
                    p_resp.errmessage := upper(g_package_name)||'. Помилка при конвертації дати початоку дії договору "'||l_xml_extract(p_xml, l_contr_path||'dateFrom/text()')||'".';
                    p_paydat.id:=l_deal_id;
                    p_paydat.d_number:=l_deal_number;
                    return;
             end;
             begin
                l_paydat.date_to:=to_date(l_xml_extract(p_xml, l_contr_path||'dateTo/text()',1),'dd.mm.yyyy'); --дата кінця дії страховкі
                     exception when others then
                    p_resp.purpose    := null;
                    p_resp.errcode    := -20001;
                    p_resp.errmessage := upper(g_package_name)||'. Помилка при конвертації дати кінця дії договору "'||l_xml_extract(p_xml, l_contr_path||'dateTo/text()')||'".';
                    p_paydat.id:=l_deal_id;
                    p_paydat.d_number:=l_deal_number;
                    return;
             end;
             begin
                l_paydat.d_date:=to_date(l_xml_extract(p_xml, l_pay_path||'date/text()',1),'dd.mm.yyyy'); --дата заключення договору
                     exception when others then
                    p_resp.purpose    := null;
                    p_resp.errcode    := -20001;
                    p_resp.errmessage := upper(g_package_name)||'. Помилка при конвертації дати заключення договору "'||l_xml_extract(p_xml, l_contr_path||'date/text()')||'".';
                    p_paydat.id:=l_deal_id;
                    p_paydat.d_number:=l_deal_number;
                    return;
             end;
                l_paydat.purpose:=l_xml_extract(p_xml, l_pay_path||'purpose/text()'); --рпизначення платежу
                l_paydat.cust_name:=l_xml_extract(p_xml, l_contr_path||'customer/name/text()'); --імя клієнта
                l_paydat.cust_okpo:=nvl(l_xml_extract(p_xml, l_contr_path||'customer/code/text()'),'0000000000'); --ОКПО клієнта
                l_paydat.cust_doc_type:=l_xml_extract(p_xml, l_contr_path||'customer/document/type/text()'); --Тип документу клієнта
                l_paydat.cust_series:=l_xml_extract(p_xml, l_contr_path||'customer/document/series/text()'); --серія песпорта
                l_paydat.cust_number:=l_xml_extract(p_xml, l_contr_path||'customer/document/number/text()'); --№ паснорта
             begin
                l_paydat.cust_doc_date:=to_date(l_xml_extract(p_xml, l_contr_path||'customer/document/date/text()',1),'dd.mm.yyyy'); --дата видачі паспорта
                    exception when others then
                    p_resp.purpose    := null;
                    p_resp.errcode    := -20001;
                    p_resp.errmessage := upper(g_package_name)||'. Помилка при конвертації дати заключення договору "'||l_xml_extract(p_xml, l_contr_path||'customer/document/date/text()')||'".';
                    p_paydat.id:=l_deal_id;
                    p_paydat.d_number:=l_deal_number;
                    return;
             end;
                l_paydat.cust_doc_issued:=l_xml_extract(p_xml, l_contr_path||'customer/document/issuedBy/text()'); --ким виданий паспорт
             begin
                l_paydat.cust_birthdate:=to_date(l_xml_extract(p_xml, l_contr_path||'customer/birthDate/text()',1),'dd.mm.yyyy'); --дата народження
                    exception when others then
                    p_resp.purpose    := null;
                    p_resp.errcode    := -20001;
                    p_resp.errmessage := upper(g_package_name)||'. Помилка при конвертації дати народження "'||l_xml_extract(p_xml, l_contr_path||'customer/birthDate/text()')||'".';
                    p_paydat.id:=l_deal_id;
                    p_paydat.d_number:=l_deal_number;
                    return;
             end;
                l_paydat.cust_phone:=l_xml_extract(p_xml, l_contr_path||'customer/phone/text()'); --№ телефону клієнта
                l_paydat.cust_address:=l_xml_extract(p_xml, l_contr_path||'customer/address/text()'); --адреса клієнта
                    if l_paydat.cust_address is null then
                    l_paydat.cust_address:=l_xml_extract(p_xml, l_contr_path||'insuranceObject/address/text()'); --адреса клієнта
                    end if;
                l_paydat.external_id:=l_xml_extract(p_xml, l_contr_path||'user/externalId/text()'); --логін касира
                l_paydat.cu_external_id:=l_xml_extract(p_xml, 'root/currentUserExternalId/text()'); --логін користувача від якого створюється документ
                l_paydat.external_id_tariff:=l_xml_extract(p_xml, l_contr_path||'tariff/externalId/text()'); --тип страховки EWA
                l_paydat.email:=l_xml_extract(p_xml, l_contr_path||'user/email/text()');  --email касира
                ----для create_deal
                l_paydat.ref:=to_number(l_xml_extract(p_xml, l_pay_path||'number/text()')); --референс
                l_paydat.ewa_id:=to_number(l_xml_extract(p_xml, l_pay_path||'id/text()')); --ід платежу EWA
                l_paydat.ins_code:=l_xml_extract(p_xml, l_contr_path||'tariff/insurer/code/text()'); --код страховкі
                l_paydat.insuranceAmount:=nvl(to_number(l_xml_extract(p_xml, l_contr_path||'insuranceAmount/text()')),300000); --страхова сума
                l_paydat.payment:=to_number(l_xml_extract(p_xml, l_contr_path||'payment/text()')); --Загальна Сума(вартість) страховкі
                l_paydat.ext_state:=l_xml_extract(p_xml, l_contr_path||'state/text()'); --статус договора




   p_paydat:=l_paydat;
  end l_pars_xml;
--------------------------------------------------------------------------------------------------------------------------------------------
--get_ins_data Дание для продуктових пакетов

procedure get_prodpack_ins_k(p_ext_id in  number,
                             ins_nls  out varchar2,
                             ins_mfo  out varchar2,
                             ext_code out varchar2,
                             ins_okpo out customer.okpo%type,
                             ins_name out ins_partners.name%type) is
begin
  --отримання реквізитів страхової компанії
  select p.nls, p.mfo, im.ewa_type_id, c.okpo, p.name
    into ins_nls, ins_mfo, ext_code, ins_okpo, ins_name
    from ins_partners p
    join customer c on p.rnk = c.rnk
    join ins_ewa_prod_pack im on im.okpo = c.okpo 
	where p.custtype = 3 and im.ext_code = p_ext_id;
 exception when no_data_found then
    raise_application_error(-20000, 'Страхову компанію не знайдено.');
end get_prodpack_ins_k;

--------------------------------------------------------------------------------------------------------------------------------------------
--purp_creator Створення призначення платежу 
  
  procedure purp_creator(p_params         in  gt_imp_val, 
                         p_peydat         in gt_paydat, 
                         p_resp           out gt_response,
                         p_ext_idn        in  number default null) is
                         
    l_func_args varchar2(255);
    l_nazn varchar2(4000);
    l_mask_id number;
    l_err varchar2(255);                    
    function l_func_ex(p_zn varchar2,p_func varchar2 default 'math') return varchar2 is
    l_ret_val varchar2(40);
    l_exp varchar2(255);
    l_func varchar2(30);    
    begin
      if lower(l_func) = 'math' then
        l_func:='';
        else
        l_func:=lower(p_func);
        end if;
        if regexp_like(p_zn,'(\d{2}.\d{2}.\d{4})') then
           l_exp:= regexp_replace(p_zn,'(\d{2}.\d{2}.\d{4})','to_date(''\1'',''dd.mm.yyyy'')');
        else
           l_exp:= p_zn;
        end if;
        begin
        execute immediate'select substr(to_char('||l_func||'('||l_exp||')),1,40) from dual' into l_ret_val;
        exception when others then
                p_resp.purpose    := null;
                p_resp.errcode    := -20003;
                l_err:= substr('Помилка при виконанні функції: '||l_func||'('||l_exp||')',1,255);
                p_resp.errmessage := l_err;
                call_logger(p_peydat, l_err);
                return null;
        end;
    return l_ret_val;
    end;

    begin
    if p_ext_idn is null then
        begin
        --Get mask id if a.ewa_type_id=p_peydat.external_id_tariff;
        select MASK_ID into l_mask_id from ins_ewa_purp a
        where A.INS_OKPO = p_peydat.okpob and a.ewa_type_id=p_peydat.external_id_tariff;
        exception when no_data_found then
            --Get mask id if a.ewa_type_id<>p_peydat.external_id_tariff
            begin
            select MASK_ID into l_mask_id from ins_ewa_purp a
            where A.INS_OKPO = p_peydat.okpob and a.ewa_type_id = '000000000000000000000000000000';
            exception when no_data_found then
                p_resp.purpose        := null;
                p_resp.errcode    := -20002;
                l_err:= substr('Не знайдено відповідність ОКПО страхової компанії '||p_peydat.okpob||' та типу страхування '||p_peydat.external_id_tariff||' або типу за замовчуванням в довіднику призначення платежу EWA!',1,255);
                p_resp.errmessage := l_err;
                call_logger(p_peydat, l_err);
                return;
            end;
              
        end;
    else
          --Get MASK_ID for prod pack
         begin
         select a.MASK_ID into l_mask_id from ins_ewa_prod_pack a
         where a.okpo = p_peydat.okpob and a.ext_code = p_ext_idn;
            exception when no_data_found then
                p_resp.purpose        := null;
                p_resp.errcode    := -20002;
                l_err:= substr('Не знайдено відповідність ОКПО '||p_peydat.okpob||' та типу страхування '||p_ext_idn||' в довіднику типів страхування для прдуктових пакетів!',1,255);
                p_resp.errmessage := l_err;
                call_logger(p_peydat, l_err);
                return;
         end;
    end if;
    for i in (select b.mval_id, b.stat_val, b.split_s, b.func_use 
                    from ins_ewa_purp_m b where b.id = l_mask_id
                    order by b.id, B.R_ID) loop
------------------------------------------------------------------------------------------------------
--обробка функції                                                                                   --|
    if i.func_use is not null then                                                                  --|
    begin                                                                                           --|  
      if i.mval_id is not null then                                                                 --|
    l_func_args:=l_func_args||p_params(i.mval_id);                                                  --|
      else                                                                                          --|
    l_func_args:=l_func_args||i.stat_val;                                                           --|
      end if;                                                                                       --|
    exception when no_data_found then null;                                                         --|
    end;                                                                                            --|
    if i.split_s in (',','/','*','+','-') then                                                      --|
    l_func_args:=l_func_args||i.split_s;                                                            --|
    else                                                                                            --|
    l_nazn:=l_nazn||l_func_ex(l_func_args, i.func_use)||i.split_s;                                  --|
    if p_resp.errcode is not null then                                                              --|
      return;                                                                                       --|
    end if;                                                                                         --|
    l_func_args:=null;                                                                              --|
    end if;                                                                                         --|
------------------------------------------------------------------------------------------------------
    else
    if i.mval_id is not null then
    begin
    l_nazn:=l_nazn||p_params(i.mval_id);
    exception when no_data_found then null;
    end;
    else
    l_nazn:=l_nazn||i.stat_val;
    end if;
    l_nazn:=l_nazn||i.split_s;
    end if;
    end loop;
    if l_nazn is null then
        p_resp.purpose        := null;
        p_resp.errcode    := -20001;
        l_err:= 'Не знайдено шаблон призначення платежу для СК ОКПО '||p_peydat.okpob;
        p_resp.errmessage := l_err;
        call_logger(p_peydat, l_err);
        return;
      end if;
         p_resp.purpose := l_nazn;
    end;
--------------------------------------------------------------------------------
  -- get_purpose - получение назначения платежа для продуктових пакетів
  --    
procedure get_purpose(p_branch         in varchar2,
                      p_user_name      in varchar2,
                      p_mfob           in varchar2,
                      p_nameb          in varchar2,
                      p_accountb       in varchar2,
                      p_okpob          in varchar2,
                      p_ammount        in number,
                      p_commission     in number,
                      p_number         in varchar2,
                      p_date_from      in date,
                      p_date_to        in date,
                      p_date           in date,
                      p_cust_name_last in varchar2,
                      p_cust_name_first in varchar2,
                      p_cust_name_middle in varchar2,
                      
                      p_cust_okpo      in varchar2,
                      p_cust_series    in varchar2,
                      p_cust_number    in varchar2,
                      p_cust_birthdate in date,
                      p_cust_phone     in varchar2,
                      p_cust_address   in varchar2,
                      p_external_id    in varchar2,
                      p_purpose        out varchar2,
                      p_errcode        out decimal,
                      p_errmessage     out varchar2,
                      p_ext_idn        in number default null
                      ) is
      l_imp_val gt_imp_val;
      l_paydat gt_paydat;
      l_resp gt_response;
	  l_start_time timestamp:=localtimestamp;
begin
    logger.info('INS get_purpose datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
    
    begin
    l_imp_val(1):=get_branch(p_branch);
    exception when no_data_found then
          p_purpose    := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено номер відділення';
          return;
    end;
    l_imp_val(2):=p_user_name;
    l_imp_val(3):=trim(to_char(round(p_ammount/100,2),'9999999999990D00'));
    l_imp_val(4):=trim(to_char(round(p_commission/100,2),'9999999999990D00'));
    l_imp_val(5):=p_number;
    l_imp_val(6):=to_char(p_date_from, 'dd.mm.yyyy');
    l_imp_val(7):=to_char(p_date_to, 'dd.mm.yyyy');
    l_imp_val(8):=to_char(p_date, 'dd.mm.yyyy');
    l_imp_val(9):=p_cust_name_last;
    l_imp_val(10):=p_cust_name_first;
    l_imp_val(11):=p_cust_name_middle;
    l_imp_val(12):=p_cust_okpo;
    l_imp_val(13):=p_cust_series;
    l_imp_val(14):=p_cust_number;
    l_imp_val(15):=to_char(p_cust_birthdate, 'dd.mm.yyyy');
    l_imp_val(16):=p_cust_phone;
    l_imp_val(17):=p_cust_address;
    l_imp_val(18):=p_external_id;
    
    l_paydat.branch:=get_branch(p_branch);
    l_paydat.user_name:=p_user_name;
    l_paydat.mfob:=p_mfob;
    l_paydat.nameb:=p_nameb;
    l_paydat.accountb:=p_accountb;
    l_paydat.okpob:=p_okpob;
    l_paydat.ammount:=p_ammount;
    l_paydat.commission:=p_commission;
    l_paydat.d_number:=p_number;
    l_paydat.date_from:=p_date_from;
    l_paydat.date_to:=p_date_to;
    l_paydat.d_date:=p_date_to;
    l_paydat.purpose:=p_date;
    l_paydat.cust_okpo:=p_cust_okpo;
    l_paydat.cust_series:=p_cust_series;
    l_paydat.cust_number:=p_cust_number;
    l_paydat.cust_birthdate:=p_cust_birthdate;
    l_paydat.cust_phone:=p_cust_phone;
    l_paydat.cust_address:=p_cust_address;
    l_paydat.external_id_tariff:=p_external_id; 
    
    purp_creator(l_imp_val, l_paydat, l_resp, p_ext_idn);
    p_purpose:=l_resp.purpose;
    p_errcode:=l_resp.errcode;
    p_errmessage:=l_resp.errmessage;
	logger.info('INS get_purpose created in '||to_char(localtimestamp -l_start_time)||' for code: '||l_paydat.d_number||'.PURPOSE :'||l_resp.purpose);
  
  end get_purpose;
  --------------------------------------------------------------------------------
  -- get_purpose - получение назначения платежа для EWA
  --   
  procedure get_purpose(p_xml            in  xmltype,
                        p_purpose        out varchar2,
                        p_errcode        out decimal,
                        p_errmessage     out varchar2
                        ) is                     
  l_imp_val gt_imp_val;
  l_paydat gt_paydat;
  l_resp gt_response;
  l_start_time timestamp:=localtimestamp;
    
begin
  l_pars_xml(p_xml, l_imp_val, l_paydat, l_resp,1,0);
   if l_resp.errcode is null then
      purp_creator(l_imp_val, l_paydat, l_resp); 
      p_purpose:=l_resp.purpose;
      p_errcode:=l_resp.errcode;
      p_errmessage:=l_resp.errmessage;

      logger.info('INS get_purpose created in '||to_char(localtimestamp -l_start_time)||' for deal id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.PURPOSE :'||l_resp.purpose);
  else
    p_purpose:=l_resp.purpose;
    p_errcode:=l_resp.errcode;
    p_errmessage:=l_resp.errmessage;
	logger.error(substr('INS get_purpose error for deal id '||l_resp.errmessage||' deal id '||to_char(l_paydat.id)||' deal_code '||l_paydat.d_number,1,4000));
  end if;
  exception when others then
  p_purpose:=null;
    p_errcode:=-20001;
    p_errmessage:=sqlerrm;
    logger.error(substr('INS get_purpose error for deal id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||' '||sqlerrm,1,4000));  
end get_purpose;

  --------------------------------------------------------------------------------
  -- pay_isu - создание платежного документа
  --
  procedure pay_isu(p_branch          in varchar2,
                    p_user_name       in varchar2,
                    p_mfob            in varchar2,
                    p_nameb           in varchar2,
                    p_accountb        in varchar2,
                    p_okpob           in varchar2,
                    p_ammount         in number,
                    p_commission      in number,
                    p_commission_type in varchar2,
                    p_number          in varchar2,
                    p_date_from       in date,
                    p_date_to         in date,
                    p_date            in date,
                    p_purpose         in varchar2,
                    p_cust_name       in varchar2,
                    p_cust_okpo       in varchar2,
                    p_cust_doc_type   in varchar2,
                    p_cust_series     in varchar2,
                    p_cust_number     in varchar2,
                    p_cust_doc_date   in date,
                    p_cust_doc_issued in varchar2,
                    p_cust_birthdate  in date,
                    p_cust_phone      in varchar2,
                    p_cust_address    in varchar2,
                    p_external_id     in varchar2,
                    p_external_id_tariff in varchar2,
                    p_email           in varchar2,
                    p_ref             out decimal,
                    p_errcode         out decimal,
                    p_errmessage      out varchar2) is
    l_errcode decimal := null;
    l_errmsg  varchar2(4000) := null;
    l_doc     bars_xmlklb_imp.t_doc;
    l_impdoc  xml_impdocs%rowtype;
    l_tt      varchar2(3 Byte);
    l_vob     decimal;
    l_uid     staff$base.id%type;
    l_acca    accounts%rowtype;
    l_cusa    customer%rowtype;
    l_nls     accounts.nls%type;
    l_dk      int;
    l_branch  branch.branch%type;
    l_recid   number;
    l_nazn    varchar2(160);
    l_random varchar2(10);
    /*****************************/
    --l_item_txt      varchar2(4000);
--    l_item_name_txt varchar2(4000);
--    l_item_name     varchar2(4000);
    --l_date_months   varchar2(4000);
    --l_date_etalon   varchar2(4000);
    --l_months_cnt    int;
    --l_mask          varchar2(4000);
    --sql_stmt        varchar2(4000);
  begin
    logger.info('INS pay_isu datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
    savepoint sp_paystart;
    begin
      -- вибір операції
      begin
        select tt
          into l_tt
          from tts
         where tt = decode(substr(p_branch, 2, 6), '300465', g_tt_ca, g_tt);
        select vob
          into l_vob
          from tts_vob
         where tt = l_tt
           and rownum = 1;
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено код операції';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return;
      end;
      -- вибір користувача від якого створюється документ
      begin
        select id, branch
          into l_uid, l_branch
          from staff$base
         where logname = upper(p_user_name);
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено користувача';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return;
      end;
      bc.subst_branch(l_branch);
      -- вибір транзитного рахунку
      begin
        l_nls := nbs_ob22('2902', '02');
        select *
          into l_acca
          from accounts
         where nls = l_nls
           and dazs is null
           and kv = 980;
        select * into l_cusa from customer where rnk = l_acca.rnk;
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено транзитний рахунок';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return;
      end;
      -- будуємо призначення платежу
      /*for c in (select * from ins_mapping_purpose where okpo_ic = p_okpob) loop
        l_mask := c.mask;
        while (regexp_instr(l_mask, '=#\S+#') > 0) loop
          l_item_txt      := regexp_substr(l_mask, '=#[^#]+#');
          l_item_name_txt := regexp_substr(l_item_txt, '=#[^%#]+');
          l_item_name := replace(l_item_name_txt, '=#', '');
          if l_item_name = 'contract.externalId' then
            l_item_name := p_external_id;
          elsif l_item_name = 'contract.code' then
            l_item_name := p_number;
          elsif l_item_name = 'contract.customer.name' then
            l_item_name := p_cust_name;
          elsif l_item_name = 'contract.customer.code' then
            l_item_name := p_cust_okpo;
          elsif l_item_name = 'payment.payment' then
            l_item_name := trim(to_char(round(p_ammount/100,2),'9999999999990D00'));
          elsif l_item_name = 'contract.salePoint.code' then
            l_item_name := trim(replace(substr(p_branch, -8), '/', ' '));
          elsif l_item_name = 'contract.customer.phone' then
            l_item_name := p_cust_phone;
          elsif l_item_name = 'contract.user.externalId' then
            l_item_name := l_uid;
          elsif l_item_name = 'contract.dateFrom' then
            l_item_name := to_date(p_date_from, 'dd.mm.yyyy');
          elsif l_item_name = 'contract.customer.series' then
            l_item_name := p_cust_series;
          elsif l_item_name = 'contract.customer.number' then
            l_item_name := p_cust_number;
          elsif l_item_name = 'contract.customer.birthDate' then
            l_item_name := to_date(p_cust_birthdate,'dd.mm.yyyy');
          elsif l_item_name = 'contract.customer.address' then
            l_item_name := p_cust_address;
          elsif l_item_name = 'contract.dateTo' then
            l_item_name := to_date(p_date_to, 'dd.mm.yyyy');
          end if;
          l_mask := replace(l_mask, l_item_txt, l_item_name);
        end loop;
      end loop;
      l_date_etalon := substr(regexp_substr(l_mask,'months_between(\S+,\S+)'),0,instr(regexp_substr(l_mask,'months_between(\S+,\S+)'),';') - 1);
      if l_date_etalon is not null then
        l_date_months := regexp_replace(l_date_etalon,'(\d{2}.\d{2}.\d{4})','to_date(''\1'',''dd.mm.yyyy'')');
        sql_stmt := 'select ' || l_date_months || ' from dual';
        execute immediate sql_stmt into l_months_cnt;
        l_mask := replace(l_mask, l_date_etalon, l_months_cnt);
      end if;
      if substr(l_mask,0,2) = '/=' then
        l_mask := l_mask||'=/';
      end if;*/
      -- параметри платіжного документа
      --select to_char(sysdate, 'HH24MISS') into l_random from dual;
      l_random := p_number;
      l_dk            := 1;
      l_nazn          := substr(p_purpose, 0, 160);
      l_impdoc.ref_a  := null;
      l_impdoc.impref := null;
      l_impdoc.nd     := l_random;
      l_impdoc.datd   := trunc(gl.bd);
      l_impdoc.vdat   := trunc(gl.bd);
      l_impdoc.nam_a  := l_cusa.nmkk;
      l_impdoc.mfoa   := l_acca.kf;
      l_impdoc.nlsa   := l_acca.nls;
      l_impdoc.id_a   := l_cusa.okpo;
      l_impdoc.nam_b  := p_nameb;
      l_impdoc.mfob   := p_mfob;
      l_impdoc.nlsb   := p_accountb;
      l_impdoc.id_b   := p_okpob;
      l_impdoc.s      := (case when p_commission_type = 'IMMEDIATE' then p_ammount - nvl(p_commission, 0) else p_ammount end);
      l_impdoc.kv     := l_acca.kv;
      l_impdoc.s2     := (case when p_commission_type = 'IMMEDIATE' then p_ammount - nvl(p_commission, 0) else p_ammount end);
      l_impdoc.kv2    := l_acca.kv;
      l_impdoc.sk     := 5;
      l_impdoc.dk     := l_dk;
      l_impdoc.tt     := l_tt;
      l_impdoc.vob    := l_vob;
      l_impdoc.nazn   := l_nazn; --p_purpose;
      l_impdoc.datp   := trunc(gl.bd);

      l_impdoc.userid := l_uid;

      l_impdoc.d_rec := null;

      l_doc.doc := l_impdoc;
      bars_login.login_user(p_sessionid => sys_guid(),
                            p_userid    => l_uid,
                            p_hostname  => null,
                            p_appname   => null);
      --Доп параметер "Документ"
        l_doc.drec(0).tag := 'PASP';
        select name into l_doc.drec(0).val from passp where passp = (case when p_cust_doc_type = 'PASSPORT' then 1 else 99 end);
      --Доп параметер "Серія, номер"
        l_doc.drec(1).tag := 'PASPN';
        l_doc.drec(1).val := p_cust_series||' '||p_cust_number;
      --Доп параметер "Адреса"
        l_doc.drec(2).tag := 'ADRES';
        l_doc.drec(2).val := p_cust_address;
      --Доп параметер "Дата видачі і ким"
        l_doc.drec(3).tag := 'ATRT';
        l_doc.drec(3).val := p_cust_doc_issued||' від '|| to_char(p_cust_doc_date,'dd.mm.yyyy')||'р.';
      --Доп параметер "Платник"
        l_doc.drec(4).tag := 'FIO';
        l_doc.drec(4).val := p_cust_name;
      --Доп параметер "Код платника"
        l_doc.drec(5).tag := 'IDA';
        l_doc.drec(5).val := p_cust_okpo;
      --Доп параметер "Отримувач"
        l_doc.drec(6).tag := 'OTRIM';
        l_doc.drec(6).val := p_nameb;
      --Доп параметер "Код отримувача"
        l_doc.drec(7).tag := 'OOKPO';
        l_doc.drec(7).val := p_okpob;
      --Доп параметер "Комісія по договору страхування"
        l_doc.drec(8).tag := 'EWCOM';
        l_doc.drec(8).val := p_commission/100;
      --Доп параметер "Ідентификатор продавця (EWA)"
        l_doc.drec(9).tag := 'EWATN';
        l_doc.drec(9).val := p_external_id;
      --Доп параметер "Зовн. ідент. стр. продукту (EWA)"
        l_doc.drec(10).tag:= 'EWEXT';
        l_doc.drec(10).val:= p_external_id_tariff;
     --Доп параметер "Email кор-ча, що створ. дог(EWA)"
        l_doc.drec(11).tag:= 'EWAML';
        l_doc.drec(11).val:= p_email;
      ------------------------------
      bars_xmlklb_imp.pay_extern_doc(p_doc     => l_doc,
                                     p_errcode => l_errcode,
                                     p_errmsg  => l_errmsg);
      if l_errcode <> 0 then
        p_ref        := -1;
        p_errcode    := l_errcode;
        p_errmessage := l_errmsg;
        logger.error(g_package_name || ' in params p_branch=' || p_branch ||
                     ',p_user_name=' || p_user_name || ',p_mfob=' ||
                     p_mfob || ',p_nameb=' || p_nameb || ',p_accountb=' ||
                     p_accountb || ',p_okpob=' || p_okpob || ',p_ammount=' ||
                     p_ammount || ', p_errmessage=' || p_errmessage);
        bars_login.logout_user;
        rollback to savepoint sp_paystart;
        return;
      else
        p_ref        := l_doc.doc.ref;
        p_errcode    := l_errcode;
        p_errmessage := null;
        declare
          l_nls_param2 accounts.nls%type;
          l_sum oper.s%type;
        begin
          l_sum := p_ammount;
          if p_commission > 0 and p_commission_type = 'IMMEDIATE' then
            paytt (flg_  => 0,          -- флаг оплаты
                   ref_  => l_doc.doc.ref,    -- референция
                   datv_ => trunc(gl.bd),   -- дата валютировния
                   tt_   => g_tt_rko,     -- тип транзакции
                   dk0_  => 1,          -- признак дебет-кредит
                   kva_  => l_acca.kv, -- код валюты А
                   nls1_ => l_acca.nls,   -- номер счета А
                   sa_   => p_commission,      -- сумма в валюте А
                   kvb_  => l_acca.kv, -- код валюты Б
                   nls2_ => p_accountb  ,  -- номер счета Б
                   sb_   => p_commission    -- сумма в валюте Б
                  );
            --l_sum := l_sum + p_commission;
          end if;
          l_nls_param2 := get_proc_nls('T00',l_acca.kv);
          paytt (flg_  => 0,          -- флаг оплаты
                 ref_  => l_doc.doc.ref,    -- референция
                 datv_ => trunc(gl.bd),   -- дата валютировния
                 tt_   => g_tt_ch,     -- тип транзакции
                 dk0_  => 1,          -- признак дебет-кредит
                 kva_  => l_acca.kv, -- код валюты А
                 nls1_ => l_acca.nls,   -- номер счета А
                 sa_   => l_sum,      -- сумма в валюте А
                 kvb_  => l_acca.kv, -- код валюты Б
                 nls2_ => l_nls_param2,  -- номер счета Б
                 sb_   => p_commission    -- сумма в валюте Б
                );
        exception
          when others then
            p_ref        := -1;
            p_errcode    := sqlcode;
            p_errmessage := substr(sqlerrm, 1, 4000);
            logger.error(g_package_name || ' in params p_branch=' || p_branch ||
                         ',p_user_name=' || p_user_name || ',p_mfob=' ||
                         p_mfob || ',p_nameb=' || p_nameb || ',p_accountb=' ||
                         p_accountb || ',p_okpob=' || p_okpob || ',p_ammount=' ||
                         p_ammount || ', p_errmessage=' || p_errmessage);
            bars_login.logout_user;
            rollback to savepoint sp_paystart;
            return;
        end;
      end if;
      logger.info('INS pay_isu datetime_out='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
      bars_login.logout_user;
    exception
      when others then
        p_ref        := -1;
        p_errcode    := sqlcode;
        p_errmessage := substr(sqlerrm, 1, 4000);
        logger.error(g_package_name || ' in params p_branch=' || p_branch ||
                     ',p_user_name=' || p_user_name || ',p_mfob=' ||
                     p_mfob || ',p_nameb=' || p_nameb || ',p_accountb=' ||
                     p_accountb || ',p_okpob=' || p_okpob || ',p_ammount=' ||
                     p_ammount || ', p_errmessage=' || p_errmessage);
        bars_login.logout_user;
        rollback to savepoint sp_paystart;
        return;
    end;
  end;
 ---------------------------------------------------------------------------------------------------------------------------------------------- 
  procedure pay_isu(p_xml            in  xmltype,
                     p_ref            out decimal,
                     p_errcode        out decimal,
                     p_errmessage     out varchar2
                     ) is  
    l_errcode decimal := null;
    l_errmsg  varchar2(4000) := null;
    l_doc     bars_xmlklb_imp.t_doc;
    l_impdoc  xml_impdocs%rowtype;
    l_tt      varchar2(3 Byte);
    l_vob     decimal;
    l_uid     staff$base.id%type;
    l_acca    accounts%rowtype;
    l_cusa    customer%rowtype;
    l_nls     accounts.nls%type;
    l_dk      int;
    l_branch  branch.branch%type;
    l_nazn    varchar2(160);
    l_random varchar2(10);                 
                     
                     
                     
                                
    l_params gt_imp_val;
    l_paydat gt_paydat;
    l_resp gt_response;
    l_err varchar2(255);
    l_ref_exists number;
	l_start_time timestamp:=localtimestamp; 
               
      
      begin
      l_pars_xml(p_xml, l_params, l_paydat, l_resp,0,0);
        if l_resp.errcode is not null then
        p_ref        := -1;
        p_errcode    := l_resp.errcode;
        l_err  := l_resp.errmessage;
        p_errmessage:=l_err;
        call_logger(l_paydat, l_err||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
        return;
        end if;
	  logger.info('INS pay_isu datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')||'. Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
      select count(*) into l_ref_exists from ins_ewa_refs a where a.ewa_id = l_paydat.id and (a.ref is not null or a.ref<>-1);
      if l_ref_exists <> 0 then
        p_ref        := -1;
        p_errcode    := -20000;
        l_err  := 'Повторний запит в рамках договору:'||l_paydat.id;
        p_errmessage:=l_err;
        call_logger(l_paydat, l_err||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
        return;
      end if;
      
    savepoint sp_paystart;
    begin
      -- вибір операції
      begin
        select tt
          into l_tt
          from tts
         where tt = decode(substr(l_paydat.branch, 2, 6), '300465', g_tt_ca, g_tt);
        select vob
          into l_vob
          from tts_vob
         where tt = l_tt
           and rownum = 1;
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          l_err := upper(g_package_name)||'. Не знайдено код операції';
          p_errmessage:=l_err;
          call_logger(l_paydat, l_err||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
          return;
      end;
      -- вибір користувача від якого створюється документ
      begin
        select id, branch
          into l_uid, l_branch
          from staff$base
         where logname = upper(l_paydat.cu_external_id);
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          l_err := upper(g_package_name)||'. Не знайдено користувача';
          p_errmessage:=l_err;
          call_logger(l_paydat, l_err||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
          return;
      end;
      bc.subst_branch(l_branch);
      -- вибір транзитного рахунку
      begin
        l_nls := nbs_ob22('2902', '02');
        select *
          into l_acca
          from accounts
         where nls = l_nls
           and dazs is null
           and kv = 980;
        select * into l_cusa from customer where rnk = l_acca.rnk;
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          l_err := upper(g_package_name)||'. Не знайдено транзитний рахунок';
          p_errmessage:=l_err;
          call_logger(l_paydat, l_err||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
          return;
      end;
      l_random := l_paydat.d_number;
      l_dk            := 1;
      l_nazn          := substr(l_paydat.purpose, 0, 160);
      l_impdoc.ref_a  := null;
      l_impdoc.impref := null;
      l_impdoc.nd     := l_random;
      l_impdoc.datd   := trunc(gl.bd);
      l_impdoc.vdat   := trunc(gl.bd);
      l_impdoc.nam_a  := l_cusa.nmkk;
      l_impdoc.mfoa   := l_acca.kf;
      l_impdoc.nlsa   := l_acca.nls;
      l_impdoc.id_a   := l_cusa.okpo;
      l_impdoc.nam_b  := l_paydat.nameb;
      l_impdoc.mfob   := l_paydat.mfob;
      l_impdoc.nlsb   := l_paydat.accountb;
      l_impdoc.id_b   := l_paydat.okpob;
      l_impdoc.s      := (case when l_paydat.commission_type = 'IMMEDIATE' then l_paydat.ammount - nvl(l_paydat.commission, 0) else l_paydat.ammount end);
      l_impdoc.kv     := l_acca.kv;
      l_impdoc.s2     := (case when l_paydat.commission_type = 'IMMEDIATE' then l_paydat.ammount - nvl(l_paydat.commission, 0) else l_paydat.ammount end);
      l_impdoc.kv2    := l_acca.kv;
      l_impdoc.sk     := 5;
      l_impdoc.dk     := l_dk;
      l_impdoc.tt     := l_tt;
      l_impdoc.vob    := l_vob;
      l_impdoc.nazn   := l_nazn; --p_purpose;
      l_impdoc.datp   := trunc(gl.bd);

      l_impdoc.userid := l_uid;

      l_impdoc.d_rec := null;

      l_doc.doc := l_impdoc;
      bars_login.login_user(p_sessionid => sys_guid(),
                            p_userid    => l_uid,
                            p_hostname  => null,
                            p_appname   => null);
      --Доп параметер "Документ"
        l_doc.drec(0).tag := 'PASP';
        select name into l_doc.drec(0).val from passp where passp = (case when l_paydat.cust_doc_type = 'PASSPORT' then 1 else 99 end);
      --Доп параметер "Серія, номер"
        l_doc.drec(1).tag := 'PASPN';
        l_doc.drec(1).val := l_paydat.cust_series||' '||l_paydat.cust_number;
      --Доп параметер "Адреса"
        l_doc.drec(2).tag := 'ADRES';
        l_doc.drec(2).val := l_paydat.cust_address;
      --Доп параметер "Дата видачі і ким"
        l_doc.drec(3).tag := 'ATRT';
        l_doc.drec(3).val := l_paydat.cust_doc_issued||' від '|| to_char(l_paydat.cust_doc_date,'dd.mm.yyyy')||'р.';
      --Доп параметер "Платник"
        l_doc.drec(4).tag := 'FIO';
        l_doc.drec(4).val := l_paydat.cust_name;
      --Доп параметер "Код платника"
        l_doc.drec(5).tag := 'IDA';
        l_doc.drec(5).val := l_paydat.cust_okpo;
      --Доп параметер "Отримувач"
        l_doc.drec(6).tag := 'OTRIM';
        l_doc.drec(6).val := l_paydat.nameb;
      --Доп параметер "Код отримувача"
        l_doc.drec(7).tag := 'OOKPO';
        l_doc.drec(7).val := l_paydat.okpob;
      --Доп параметер "Комісія по договору страхування"
        l_doc.drec(8).tag := 'EWCOM';
        l_doc.drec(8).val := l_paydat.commission/100;
      --Доп параметер "Ідентификатор продавця (EWA)"
        l_doc.drec(9).tag := 'EWATN';
        l_doc.drec(9).val := l_paydat.external_id;
      --Доп параметер "Зовн. ідент. стр. продукту (EWA)"
        l_doc.drec(10).tag:= 'EWEXT';
        l_doc.drec(10).val:= l_paydat.external_id_tariff;
     --Доп параметер "Email кор-ча, що створ. дог(EWA)"
        l_doc.drec(11).tag:= 'EWAML';
        l_doc.drec(11).val:= l_paydat.email;
      ------------------------------
      bars_xmlklb_imp.pay_extern_doc(p_doc     => l_doc,
                                     p_errcode => l_errcode,
                                     p_errmsg  => l_errmsg);
      if l_errcode <> 0 then
        p_ref        := -1;
        p_errcode    := l_errcode;
        p_errmessage:=l_errmsg;
        call_logger(l_paydat, l_errmsg||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
        bars_login.logout_user;
        rollback to savepoint sp_paystart;
        return;
      else
        p_ref        := l_doc.doc.ref;
        p_errcode    := l_errcode;
        p_errmessage := null;
        declare
          l_nls_param2 accounts.nls%type;
          l_sum oper.s%type;
        begin
          l_sum := l_paydat.ammount;
          if l_paydat.commission > 0 and l_paydat.commission_type = 'IMMEDIATE' then
            paytt (flg_  => 0,          -- флаг оплаты
                   ref_  => l_doc.doc.ref,    -- референция
                   datv_ => trunc(gl.bd),   -- дата валютировния
                   tt_   => g_tt_rko,     -- тип транзакции
                   dk0_  => 1,          -- признак дебет-кредит
                   kva_  => l_acca.kv, -- код валюты А
                   nls1_ => l_acca.nls,   -- номер счета А
                   sa_   => l_paydat.commission,      -- сумма в валюте А
                   kvb_  => l_acca.kv, -- код валюты Б
                   nls2_ => l_paydat.accountb  ,  -- номер счета Б
                   sb_   => l_paydat.commission    -- сумма в валюте Б
                  );
            --l_sum := l_sum + p_commission;
          end if;
          l_nls_param2 := get_proc_nls('T00',l_acca.kv);
          paytt (flg_  => 0,          -- флаг оплаты
                 ref_  => l_doc.doc.ref,    -- референция
                 datv_ => trunc(gl.bd),   -- дата валютировния
                 tt_   => g_tt_ch,     -- тип транзакции
                 dk0_  => 1,          -- признак дебет-кредит
                 kva_  => l_acca.kv, -- код валюты А
                 nls1_ => l_acca.nls,   -- номер счета А
                 sa_   => l_sum,      -- сумма в валюте А
                 kvb_  => l_acca.kv, -- код валюты Б
                 nls2_ => l_nls_param2,  -- номер счета Б
                 sb_   => l_paydat.commission    -- сумма в валюте Б
                );
        exception
          when others then
            p_ref        := -1;
            p_errcode    := sqlcode;
            p_errmessage := substr(sqlerrm, 1, 4000);
            call_logger(l_paydat, l_errmsg||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
            bars_login.logout_user;
            rollback to savepoint sp_paystart;
            return;
        end;
      end if;
      insert into ins_ewa_refs(ewa_id,ref) values (l_paydat.id, l_doc.doc.ref);
      logger.info('INS pay_isu payment_created  in '||to_char(localtimestamp -l_start_time)||' for deal id: '||l_paydat.id||' code: '||l_paydat.d_number||'. ref '||l_doc.doc.ref);
      bars_login.logout_user;
    exception
      when others then
        p_ref        := -1;
        p_errcode    := sqlcode;
        l_err  := substr(sqlerrm, 1, 4000);
        p_errmessage:=l_err;
        call_logger(l_paydat, substr(' deal_id '||to_char(l_paydat.id)||' code '||l_paydat.d_number||' err '||l_err,1,4000));
        bars_login.logout_user;
        rollback to savepoint sp_paystart;
        return;
    end;
  end;

  --------------------------------------------------------------------------------
  -- get_pay_status - получение статуса документа
  --
  procedure get_pay_status(p_ref decimal,
                           p_account varchar2,
                           p_ammount decimal,
                           p_status out varchar2,
                           p_errcode out decimal,
                           p_errmessage out varchar2) is
    l_sos varchar2(10);
    l_done varchar2(10) := 'PAID';
    l_in varchar2(10) := 'PENDING';
    l_storno varchar2(10) := 'CANCELED';
  begin
    begin
      select (case
                when sos in (0,1,3) then l_in
                when sos = 5 then l_done
                when sos in (-1,-2,99) then l_storno
              end) as sos
        into l_sos
        from oper
       where ref = p_ref
         and nlsb = p_account
         and s = p_ammount;
      p_status := l_sos;
      p_errcode := 0;
      p_errmessage := null;
    exception
      when no_data_found then
        p_status := null;
        p_errcode := -20001;
        p_errmessage := 'Платіжний документ не знайдено';
        logger.error(g_package_name||' in params p_ref='||p_ref||',p_account='||p_account||',p_ammount='||p_ammount||', p_errmessage='||p_errmessage);
        return;
    end;
  end;

  --------------------------------------------------------------------------------
  -- create_deal - создание страхового договора
  --
  procedure create_deal(p_params in xmltype,
                        p_deal_number out ins_deals.id%type,
                        p_errcode out number,
                        p_errmessage out varchar2) is
    l_deal_id ins_deals.id%type := null;
    l_partner ins_partners%rowtype;
    l_user_id staff$base.id%type;
    l_rnk customer.rnk%type;
    l_ourcountry number(38);
    l_parname params.par%type := 'KOD_G';
    l_currancy tabval.kv%type := 980;
    l_payment_id ins_payments_schedule.id%type;
    l_ise customer.ise%type;
    l_fs customer.fs%type;
    l_ved customer.ved%type;
    l_k050 customer.k050%type;
    l_freq freq.freq%type := 360;
    l_type_id ins_types.id%type;
    l_passp passp.passp%type;


    l_params gt_imp_val;
    l_paydat gt_paydat;
    l_err varchar2(255);
    l_resp gt_response;



  begin

    l_pars_xml(p_params, l_params, l_paydat, l_resp,0,1);
        if l_resp.errcode is not null then
        p_deal_number:= null;
        p_errcode    := l_resp.errcode;
        l_err        := l_resp.errmessage;
        p_errmessage :=l_err;
        call_logger(l_paydat, l_err||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
        return;
        end if; 
	logger.info('INS create_deal datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')||' Договір id: '||to_char(l_paydat.id)||' code: '||l_paydat.d_number||'.');
    -----------------------------------------------
    ---Добавлена проверка на присутствие рефа в json.
    ---Если есть, то загружаем в табличку для дальнейшей передачи статусов платежей в EWA.
    if nvl(l_paydat.ref,0)=0
    then
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'В договорі відсутній документ';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
    else
        delete ins_ewa_refs t where t.ewa_id = l_paydat.id;
            commit;
       begin
         insert into ins_ewa_ref_sos(ref,id_ewa,crt_date,kf) values (l_paydat.ref,l_paydat.ewa_id,sysdate,f_ourmfo());
       exception
       when dup_val_on_index then
         null;
       end;

    end if;

    ----------------------------------------------
    savepoint create_start;

    begin
      select to_number(val) into l_ourcountry from params where par = l_parname;
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено код країни "'||l_parname||'".';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
    end;
    begin
      select p.* into l_partner from ins_partners p, customer c where p.rnk = c.rnk and c.okpo = l_paydat.ins_code and p.custtype = 3 and date_off is null;--p_params.extract('/CreateDealParams/tariff/insurer/code/text()').GetStringVal();
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено страхову компанію з ОКПО "'||l_paydat.ins_code||'".';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
    end;
    begin
      select id into l_user_id from staff$base where upper(logname) = upper(l_paydat.external_id);/*p_params.extract('/CreateDealParams/user/lastName/text()').GetStringVal()*/
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено користувача "'||l_paydat.external_id||'".';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
    end;
    begin
      select ext_id into l_type_id from ins_ewa_types where id = l_paydat.external_id_tariff;
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено відповідний тип страхового договору "'||l_paydat.external_id_tariff||'".';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
    end;
    begin
      select ext_id into l_passp from ins_ewa_document_types where id = l_paydat.cust_doc_type;
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено відповідний тип документу, що посвідчує особу "'||l_paydat.cust_doc_type||'".';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
    end;
    ----
    begin
        if nvl(l_paydat.cust_doc_date,l_paydat.cust_birthdate)<l_paydat.cust_birthdate
        then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Дата документу, що посвідчує особу "'||to_char(l_paydat.cust_doc_date,'dd.mm.yyyy')||'" меньше дати народження "'||to_char(l_paydat.cust_doc_date,'dd.mm.yyyy')||'".';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetClobVal(),0,4000));
        return;
        end if;
    end;


    /*begin
      select kv into l_currancy from tabval where d_close is null and lcv = p_params.extract('/CreateDealParams/currancy/text()').GetStringVal();
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено код валюти';
        return;
    end;*/
    select p050.k050, p070.k070, p080.k080, p110.k110
      into l_k050,l_ise,l_fs,l_ved
      from (select min(val) as k050 from params where par = 'CUSTK050') p050,
           (select min(val) as k070 from params where par = 'CUSTK070') p070,
           (select min(val) as k080 from params where par = 'CUSTK080') p080,
           (select min(val) as k110 from params where par = 'CUSTK110') p110;
    bc.subst_branch(l_paydat.branch);
    --l_bday_tmp := get_xml_val(p_params,'/CreateDealParams/customer/birthDate/text()');
    --l_bday := to_date(substr(l_bday_tmp,0,instr(l_bday_tmp,'T') - 1),'yyyy-mm-dd');
    logger.info('INS '||l_paydat.payment);
    begin
      select rnk
      into l_rnk
      from
          (select c.*, row_number() over (partition by okpo order by nvl(sed,'00')) rn -- приоритет физики
            --into l_customer
            from customer c,
                 person p
           where c.rnk = p.rnk
             and ((c.okpo = l_paydat.cust_okpo and c.okpo != '0000000000')
              or (p.ser = l_paydat.cust_series and p.numdoc = l_paydat.cust_number and p.bday = l_paydat.cust_birthdate and c.okpo = l_paydat.cust_okpo)
			  or (l_paydat.cust_doc_type = 'ID_PASSPORT' and p.numdoc = l_paydat.cust_number and p.bday = l_paydat.cust_birthdate and c.okpo = l_paydat.cust_okpo))
             and c.custtype = 3
             and c.date_off is null)
       where rn=1;
     -- l_rnk := l_customer.rnk;
    exception
      when no_data_found then
        begin
          kl.setCustomerAttr(Rnk_          => l_rnk,
                             Custtype_     => 3,
                             Nd_           => null,
                             Nmk_          => substr(l_paydat.cust_name,1,70),
                             Nmkv_         => SubStr(F_TRANSLATE_KMU(l_paydat.cust_name),1,70),
                             Nmkk_         => substr(l_paydat.cust_name,1,38),
                             Adr_          => null,
                             Codcagent_    => 5,
                             Country_      => l_ourcountry,
                             Prinsider_    => 99,
                             Tgr_          => 2,
                             Okpo_         => l_paydat.cust_okpo,
                             Stmt_         => null,
                             Sab_          => null,
                             DateOn_       => trunc(sysdate),
                             Taxf_         => null,
                             CReg_         => null,
                             CDst_         => null,
                             Adm_          => null,
                             RgTax_        => null,
                             RgAdm_        => null,
                             DateT_        => null,
                             DateA_        => null,
                             Ise_          => l_ise,
                             Fs_           => l_fs,
                             Oe_           => null,
                             Ved_          => l_ved,
                             Sed_          => '00',
                             Notes_        => null,
                             Notesec_      => null,
                             CRisk_        => null,
                             Pincode_      => null,
                             RnkP_         => null,
                             Lim_          => null,
                             NomPDV_       => null,
                             MB_           => null,
                             BC_           => null,
                             Tobo_         => l_paydat.branch,
                             Isp_          => null);
          kl.setPersonAttrEx(Rnk_    => l_rnk,
                             Sex_    => 0,
                             Passp_  => l_passp,
                             Ser_    => l_paydat.cust_series,
                             Numdoc_ => l_paydat.cust_number,
                             --Pdate_  => to_date(get_xml_val(p_params,'/CreateDealParams/customer/document/date/text()'),'yyyy-mm-dd'),
                             Pdate_  => l_paydat.cust_doc_date,
                             Organ_  => substr(l_paydat.cust_doc_issued,0,70),
                             Fdate_  => null,
                             Bday_   => l_paydat.cust_birthdate,
                             Bplace_ => null,
                             TelD_   => null,
                             TelW_   => null,
                             TelM_   => l_paydat.cust_phone);
          kl.setCustomerElement(l_rnk, 'K013' , '5', 0);
          kl.setCustomerElement(l_rnk, 'PUBLP' , 'Ні', 0);
          kl.setCustomerEN( p_rnk  => l_rnk,
                          p_k070 => l_ise,
                          p_k080 => l_fs,
                          p_k110 => l_ved,
                          p_k090 => null,
                          p_k050 => l_k050,
                          p_k051 => '00');
        end;
    end;
    logger.info('INS STATE = '||l_paydat.ext_state);
    declare
      l_ins_state ins_deals.status_id%type;
    begin
      select a.deal_id, d.status_id
        into l_deal_id, l_ins_state
        from ins_deal_attrs a, ins_deals d
       where a.deal_id = d.id
         and a.attr_id = 'EXT_SYSTEM'
         and a.val = l_paydat.id;
      if (l_paydat.ext_state = 'DRAFT' or l_paydat.ext_state = 'DELETED') and l_ins_state not in ('STORNO') then
        begin
          ins_pack.storno_deal(p_deal_id => l_deal_id, p_status_comm => 'Сторновано із зовнішньої системи');
          p_deal_number := l_deal_id;
          p_errcode := 0;
          p_errmessage := null;
          return;
        exception
          when others then
            rollback to savepoint create_start;
            p_deal_number := null;
            p_errcode := -20001;
            p_errmessage := 'Не вдалось сторнувати договір';
            logger.error(g_package_name||' p_errmessage='||sqlerrm||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
            return;
        end;
      end if;
    exception
      when no_data_found then
        null;
    end;
    if l_paydat.ext_state = 'SIGNED' then
      if l_deal_id is null then
        l_deal_id := ins_pack.create_deal(p_partner_id  => l_partner.id,
                                          p_type_id     => l_type_id,
                                          p_ins_rnk     => l_rnk,
                                          p_ser         => null,
                                          p_num         => l_paydat.d_number,
                                          /*p_sdate       => to_date(substr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),0,instr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),'T')-1),'yyyy-mm-dd'),
                                          p_edate       => to_date(get_xml_val(p_params,'/CreateDealParams/dateTo/text()'),'yyyy-mm-dd'),*/
                                          p_sdate       => l_paydat.date_from,
                                          p_edate       => l_paydat.date_to,
                                          p_sum         => l_paydat.insuranceAmount,
                                          p_sum_kv      => l_currancy,
                                          p_insu_tariff => null,
                                          p_insu_sum    => l_paydat.payment,
                                          p_object_type => 'CL',
                                          p_rnk         => l_rnk,
                                          p_grt_id      => null,
                                          p_nd          => null,
                                          p_pay_freq    => l_freq,
                                          p_renew_need  => 1);
        begin
          select ps.id
            into l_payment_id
            from ins_payments_schedule ps
           where ps.deal_id = l_deal_id
             and ps.plan_date = (select min(plan_date)
                                   from ins_payments_schedule
                                  where deal_id = ps.deal_id
                                    and fact_date is null);
          update ins_payments_schedule
             set plan_sum = l_paydat.payment
           where id = l_payment_id;
        exception
          when no_data_found then
            rollback to savepoint create_start;
            p_deal_number := null;
            p_errcode := -20001;
            p_errmessage := 'Не знайденно документ згідно плану';
            logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
            return;
        end;
        ins_pack.pay_deal_pmt(p_id        => l_payment_id,
                              p_fact_date => trunc(sysdate),
                              p_fact_sum  => l_paydat.payment,
                              p_pmt_num   => l_paydat.ref,
                              p_pmt_comm  => substr(l_paydat.purpose,1,500));
      else
        ins_pack.update_deal(p_deal_id     => l_deal_id,
                             p_branch      => l_paydat.branch,
                             p_partner_id  => l_partner.id,
                             p_type_id     => l_type_id,
                             p_ins_rnk     => l_rnk,
                             p_ser         => null,
                             p_num         => l_paydat.d_number,
                             /*p_sdate       => to_date(substr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),0,instr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),'T')-1),'yyyy-mm-dd'),
                             p_edate       => to_date(get_xml_val(p_params,'/CreateDealParams/dateTo/text()'),'yyyy-mm-dd'),*/
                             p_sdate       => l_paydat.date_from,
                             p_edate       => l_paydat.date_to,
                             p_sum         => l_paydat.insuranceAmount,
                             p_sum_kv      => l_currancy,
                             p_insu_tariff => null,
                             p_insu_sum    => l_paydat.payment,
                             p_rnk         => l_rnk,
                             p_grt_id      => null,
                             p_nd          => null,
                             p_renew_need  => 1);
      end if;

      logger.info('INS create_deal datetime_out='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
      ins_pack.set_deal_attr_s(p_deal_id => l_deal_id,
                               p_attr_id => 'EXT_SYSTEM',
                               p_val     => l_paydat.id);
      ins_pack.set_status(p_deal_id     => l_deal_id,
                          p_status_id   => 'ON',
                          p_status_comm => 'Договір створено із зовнішньої системи');
    else
      l_deal_id := -99;
    end if;
    p_deal_number := l_deal_id;
    p_errcode := 0;
    p_errmessage := null;
  exception
    when others then
      logger.error(g_package_name||'.create_deal error <params>' 
                                 || '<partner_id>' || to_char(l_partner.id) || '</partner_id>'
                                 || '<type_id>' || to_char(l_type_id) || '</type_id>'
                                 || '<ins_rnk>' || to_char(l_rnk) || '</ins_rnk>'
                                 || '<num>' || l_paydat.d_number || '</num>'
                                 || '<branch>' || sys_context('bars_context','user_branch') || '</branch>' || '</params>'
                                 || ' backtrace: '||dbms_utility.format_error_backtrace||'; sqlerrm: '||sqlerrm);
      raise;
  end create_deal;



procedure send_sos
is

    l_ins_ewa_ref_sos ins_ewa_ref_sos%rowtype;
    l_url             web_barsconfig.val%type;
    l_dir             web_barsconfig.val%type;
    l_pass            web_barsconfig.val%type;
    l_request         soap_rpc.t_request;
    l_response        soap_rpc.t_response;
    l_clob            clob;
    l_error           varchar2(2000);
    l_parser          dbms_xmlparser.parser;
    l_doc             dbms_xmldom.domdocument;
    l_reslist         dbms_xmldom.DOMNodeList;
    l_res             dbms_xmldom.DOMNode;
    l_str             varchar2(4000);
    l_status          varchar2(4000);
    l_tmp             xmltype;


begin

    logger.info(g_package_name||'.send_sos datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));

    select val into l_url from web_barsconfig where  key='EWA.URL_SEND_REF_STATUS';
    select val into l_dir from web_barsconfig where  key='EWA.Wallet_dir';
    select val into l_pass from web_barsconfig where key='EWA.Wallet_pass';


   --удаляем все позавчерашние операции,кроме тех по кому небыло успешных передач
    delete ins_ewa_ref_sos c
    where  trunc(c.crt_date)<trunc(sysdate)-1 and nvl(c.sos,999)<>999;

    logger.info(g_package_name||'.send_sos.several refs were deleted from queue - '||sql%rowcount);

    for c in  (select s.ref,s.id_ewa,s.crt_date,o.sos,s.sos ewa_sos,
                case when o.sos<0 then 'CANCELED' when o.sos between 0 and 4 then 'PENDING' when o.sos=5 then 'PAID' else null end ewa_status
                 from ins_ewa_ref_sos s, oper o
                where s.ref=o.ref
                and (s.sos is null or s.sos<>o.sos))
    loop
        l_request := soap_rpc.new_request  (p_url       => l_url,
                                        p_namespace => 'http://ws.unity-bars-utl.com.ua/',
                                        p_method    => 'SendAccStatus',
                                        p_wallet_dir =>  l_dir,
                                        p_wallet_pass => l_pass);

        soap_rpc.add_parameter(l_request, 'id',    to_char(c.id_ewa));

        soap_rpc.add_parameter(l_request, 'state', to_char(c.ewa_status));

        begin
            l_response := soap_rpc.invoke(l_request);

            --разбираем ответ
            --l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
            l_clob := l_response.doc.getClobVal();
            l_parser := dbms_xmlparser.newparser;
            dbms_xmlparser.parseclob(l_parser, l_clob);
            l_doc := dbms_xmlparser.getdocument(l_parser);
            l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                          'SendAccStatusResult');
            l_res     := dbms_xmldom.item(l_reslist, 0);
            dbms_xslprocessor.valueof(l_res, 'status/text()', l_str);
            l_status := substr(l_str, 1, 200);

            if lower(l_status)='ok' then

                update ins_ewa_ref_sos
                set sos=c.sos
                where ref=c.ref;

                logger.info(g_package_name||'.send_sos. ref status was sent - '||c.ref);

            else

                dbms_xslprocessor.valueof(l_res, 'message/text()', l_str);
                l_status := substr(l_str, 1, 4000);

                update ins_ewa_ref_sos
                set sos=999
                where ref=c.ref;

                bars_audit.error(g_package_name||'.send_sos. ref- '||c.ref|| '. ERROR:' || l_status);

                --если какой-то ерор то ставим статус 999, для повтрной передачи.

            end if;

        exception
            when others then
              dbms_xmlparser.freeparser(l_parser);
              DBMS_XMLDOM.freeDocument(l_doc);
              l_error := substr(sqlerrm, 1, 900);
              bars_audit.error(g_package_name||'.send_sos. ref- '||c.ref|| '.OTHER ERROR:' || l_error);
              update ins_ewa_ref_sos
              set sos=999
              where ref=c.ref;
        end;
        dbms_xmlparser.freeparser(l_parser);
        DBMS_XMLDOM.freeDocument(l_doc);

    end loop;

end send_sos;

end ins_ewa_mgr;
/
 show err;
 
PROMPT *** Create  grants  INS_EWA_MGR ***
grant EXECUTE                                                                on INS_EWA_MGR     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ins_ewa_mgr.sql =========*** End ***
 PROMPT ===================================================================================== 
 /
