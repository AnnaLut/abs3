
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/clb2autokassa.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CLB2AUTOKASSA is

  -- Author  : VOLODYMYR.POHODA
  -- Created : 18.08.2017 12:38:52
  -- Purpose : Інтеграція заявок Інтернет Клієнт-банка з ПЗ "Автокасса"
  g_package_name    constant varchar2(20)  := 'CLB2AutoKassa';
  g_header_version  constant varchar2(64)  := 'version 1.2 23/10/2017';

  ----
  -- Возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- Возвращает версию тела пакета
  --
  function body_version return varchar2;



/* Процедура для вказаного документа генерує xml тело запиту до ПЗ "Автокасса"
   Сформоване тіло записується до таблиці cl_2_ac в поле doc_body.
   Одночасно документ переводиться в статус "готовий до відправки"
*/
procedure GenBodyRequest (p_doc_ref in oper.ref%type);

/* Процедура відправки даних через WS до АРМ "Автокасса"
   Используется собственный WS, который пробрасывает запрос на WS, выставленный разработчиками "Автокассы"
*/
procedure SendRequest (p_doc_ref in number);

/*
  Процедура для джоба, обрабатывающего очередь документов
*/
procedure process_queue;

function check_autokassa (p_doc_ref in number)
  return integer;

procedure get_ref (p_doc_ref in number);


end CLB2AutoKassa;


/
CREATE OR REPLACE PACKAGE BODY BARS.CLB2AUTOKASSA is

  G_BODY_VERSION constant varchar2(64) := 'version 1.6 20/03/2019';
  g_dl_interval  constant integer := 60; -- минимальное время между циклами обработки для документов, по которым были ошибки

  ----
  -- Возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'package header CLB2AutoKassa ' || g_header_version;
  end header_version;

  ----
  -- Возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'package body CLB2AutoKassa ' || g_body_version;
  end body_version;

  procedure raise_error (p_doc_ref in number
                        ,p_err_txt in varchar2
                        ,p_need_raise in integer);

  procedure raise_error (p_doc_ref in number
                        ,p_err_txt in varchar2
                        ,p_need_raise in integer)
    is
--  pragma autonomous_transaction;
  begin
    bars_audit.error(p_err_txt);
    update cl_2_ac
      set last_err_txt = p_err_txt,
          status       = decode(status,'2S','DL',status),
          last_date    = sysdate,
          last_user    = user
      where doc_ref = p_doc_ref;
    commit;
    if p_need_raise = 1 then
      raise_application_error(-20100,p_err_txt);
    end if;
  end;


Procedure GenBodyRequest (p_doc_ref in oper.ref%type)
  is
  v_progname     varchar2(100) := g_package_name||'.'||'GenBodyRequest';

  v_nominal t_arr_nom := t_arr_nom();
  v_enq t_arr_enq     := t_arr_enq();
  v_rec t_enq_record  := t_enq_record(null,null,null,null,null,null,null,null,null);

  v_message_text xmltype;
  v_clob         varchar2(2000);
  v_bir_text     varchar2(2000);

  v_currency     integer := -1;
  v_amount       number  := 0;
  v_cnt          number;
  v_divider      number;
  v_amn          number;
  v_doc_amount   oper.s%type;
  v_doc_status   cl_2_ac.status%type;

  v_err          varchar2(2000);



  procedure p_nominal_add(p_nominal in out t_arr_nom, p_value in integer, p_ischange in integer, p_count in integer, p_enq_id in integer)
    is
  -- добавление новой строки с номиналом валюты
  begin
    p_nominal.extend;
    p_nominal(nvl(p_nominal.last,1)) := t_nominal(null,null,null,null);
    p_nominal(nvl(p_nominal.last,1)).r_value := p_value;
    p_nominal(p_nominal.last).r_ischange := p_ischange;
    p_nominal(p_nominal.last).r_count    := p_count;
    p_nominal(p_nominal.last).r_enq_id   := nvl(p_enq_id,0)+1;
  end p_nominal_add;

  -- добавление в структуру новой валюты
  procedure p_enquiry_add(p_enquiry in out t_arr_enq, p_currency in integer, p_amount in number, p_nominal in t_arr_nom)
    is
  begin
    p_enquiry.extend;
    p_enquiry(nvl(p_enquiry.last,1))          := t_EnquiryData(null,null,null,null);
    p_enquiry(p_enquiry.last).r_enq_id        := p_enquiry.last;
    p_enquiry(p_enquiry.last).r_currencycode  := p_currency;
    p_enquiry(p_enquiry.last).r_amount        := p_amount;
    p_enquiry(p_enquiry.last).r_nominal       := p_nominal;
  end p_enquiry_add;


begin

  select o.ref
         ,o.id_a
         ,o.nlsa
         ,o.mfoa
         ,o.nd
         ,'Normal'
         ,o.s
         ,c.status
    into v_rec.ExternalId
         ,v_rec.ClientRegisterCode
         ,v_rec.ClientAccountNum
         ,v_rec.ClientAccountMfo
         ,v_rec.Document
         ,v_rec.Priority
         ,v_doc_amount
         ,v_doc_status
    from oper o, cl_2_ac c
    where o.ref = p_doc_ref
      and c.doc_ref = o.ref;

  if v_doc_status not in ('IN','DL') then
    v_err := v_progname||'.: Поточний статус документа для обробки ['||v_doc_status||']не відповідає очікуваному (IN, DL)';
    raise_error(p_doc_ref, v_err,0);
    return;
  end if;

  for c_bir in (select ow.tag,
                       ow.value,
                       case
                         when value like '%грн%' or value like '%коп%' then 980
                         when value like '%дол%'                       then 840
                         when value like '%.%.%'                       then 1000 -- тэг с датой
                         else -1
                       end curr_code,
                       case
                         when value like '% коп%' then 1
                         else 0
                       end coin_flag
                  from
                  (select tag,
                          value
                from operw
                where ref = p_doc_ref
                  and tag like 'C%') ow
                order by trim(substr(tag,2))+0
             )
  loop
/* надо пройти по всем доп.реквизитам платежа, в которых может быть валюта или дата.
   как только происходит смена валюты (если это не самый первый тег, то надо:
    - записать данные в enquiry,
    - обнулить номиналы,
    - начать заполнять следующую валюту.
   как только встретили дату (curr_code = 1000) надо :
    - записать данные в enquiry по предыдущей валюте,
    - записать данные в v_rec с датой подкрепления
*/
    v_bir_text := v_bir_text||chr(10)||c_bir.tag||'='||c_bir.value;

    if c_bir.curr_code != v_currency then
      if v_currency = -1 then -- первый заход в цикл, массивы только инициализируем
        v_nominal := t_arr_nom();
      else                    -- не первый заход
        p_enquiry_add(v_enq, v_currency, v_amount, v_nominal);
      end if; -- v_currency = -1
      v_currency := c_bir.curr_code;
      if v_currency = 1000 then  -- после получения даты выходим из цикла
        v_rec.ExpectedDate := to_char(to_date(c_bir.value,'dd.mm.yyyy'),'yyyy-mm-dd');
        exit;
      end if;
    end if;
    if substr(c_bir.value,instr(c_bir.value,':')+1) != '0' then  -- кол-во единиц валюты не 0. Надо добавить данные по номиналам
      begin
        v_amn := to_number(substr(c_bir.value,1,instr(c_bir.value,' ')-1));

        case c_bir.coin_flag
          when 0 then
            v_cnt := to_number(substr(c_bir.value,instr(c_bir.value,':')+1)) * 100;
            v_divider := 1;
          when 1 then
            v_cnt := to_number(substr(c_bir.value,instr(c_bir.value,':')+1)) * 1000;
            v_divider := 100;
        end case;

        v_amn := v_amn / v_divider;
        p_nominal_add(v_nominal,v_amn,c_bir.coin_flag,v_cnt,v_enq.last);
        v_amount := v_amount + v_amn * v_cnt;
      exception
        when value_error then
          v_err := v_progname||': Не вдалось визначити номінал валюти або кількість банкнот/монет';
          raise_error(p_doc_ref, v_err, 0);
        when others then
          v_err := v_progname||': Помилка при обробці рядків БІР для документу з ref = '||p_doc_ref||'. '||sqlerrm;
          raise_error(p_doc_ref, v_err, 0);
      end;
    end if;
  end loop; -- с_bir


  if v_amount*100 != v_doc_amount then
    v_err := v_progname||': Сума сплаченого документа (REF = '||p_doc_ref||') ['||to_char(v_doc_amount/100,'FM999999999999D00')||'] не відповідає загальній сумі замовлених банкнот/купюр ['||to_char(v_amount,'FM999999999999D00')||']';
    raise_error(p_doc_ref, v_err, 1);
  end if;

  for q in v_enq.first..v_enq.last loop

    select xmlagg(xmlelement("EnquiryData",xmlconcat(
                                                  xmlelement("CurrencyCode",r_CurrencyCode),
                                                             xmlelement("Amount", r_amount),
                                                             xmlelement("NominalBreakdown",xmlagg(xmlelement("Nominal",
                                                                                                             xmlconcat(xmlelement("Value",n.r_value),
                                                                                                                       xmlelement("IsChange",n.r_IsChange),
                                                                                                                       xmlelement("Count",n.r_Count)
                                                                                                                       )
--                                                                                                                       ,xmlelement("CountOfDoubtful",1)
                                                                                                            )
                                                                                                  )
                                                                       )
                                                   )
                             )
                 )
      into v_message_text
      from table (cast (v_enq as t_arr_enq)) v,
           table (cast (v_nominal as t_arr_nom)) n
        where v.r_enq_id = n.r_enq_id
          and v.r_enq_id = q
        group by r_CurrencyCode, r_amount ;
    v_clob := v_message_text.getStringVal();
  end loop;


  select xmlelement("enquiry",
                    xmlforest(v.ClientAccountMfo "ClientAccountMfo",
                              v.ClientAccountNum "ClientAccountNum",
                              v.ClientRegisterCode "ClientRegisterCode",
                              v.CollectionPointCode "CollectionPointCode",
                              v.ExternalId "ExternalId",
                              v.Document "Document",
                              v.Notes "Notes",
                              v.ExpectedDate "ExpectedDate",
                              v.Priority "Priority",
                              v_clob "Data")
                  )
    into v_message_text
    from (select v_rec.ExternalId, v_rec.ClientRegisterCode, v_rec.ClientAccountNum,v_rec.ClientAccountMfo,
                 v_rec.CollectionPointCode, v_rec.Document, v_rec.Notes, v_rec.ExpectedDate, v_rec.Priority
            from dual) v;
/*    v_message_text := xmltype(replace(
                                replace(
                                  replace(
                                    replace(v_message_text.getClobVal(),'<','<int:')
                                    ,'<int:/','</int:')
                                  ,'</int:enquiry>','</enquiry>')
                                 ,'<int:enquiry>','<enquiry '||'xmlns:int="http://avtokassa.com/CashDepartment.v4/Integration/"'||'>'));*/
   update cl_2_ac
    set doc_body     = replace(replace(v_message_text,chr(38)||'lt;','<'),chr(38)||'gt;','>')
       ,BIR_TEXT     = v_bir_text
       ,status       = '2S'
       ,last_err_txt = null
    where doc_ref = p_doc_ref;
--  commit;
exception
  when no_data_found then
    v_err := v_progname||'. Помилка пошуку документа з REF = '||p_doc_ref;
    raise_error(p_doc_ref, v_err, 0);
  when others then
    v_err := v_progname||'. Помилка при роботі процедури: '||sqlerrm;
    raise_error(p_doc_ref, v_err, 0);

end GenBodyRequest;

/*
вызов WS для передачи структуры заявки в модуль "Автокасса"

*/
procedure SendRequest (p_doc_ref in number)
  is
  v_sta         varchar2(2);
  v_progname    varchar2(100) := g_package_name||'SendRequest';
/*  $if $$debug_flag $then
    v_url         varchar2(100) := 'http://10.10.10.105:4000'||getglobaloption('WS_AUTOKASSA');
  $else*/
    v_url         varchar2(100) := getglobaloption('LINK_FOR_ABSBARS_WEBROZDRIB')||getglobaloption('WS_AUTOKASSA');
--  $end
  v_response    wsm_mgr.t_response;
  v_req_body    clob;
  v_err         varchar2(2000);
  v_step        varchar2(2000);
  v_http        varchar2(20);
  v_w_path      varchar2(100) := parameter_utl.get_value_from_config(p_param_code => 'SMPP.Wallet_dir');
  v_w_pass      varchar2(100) := parameter_utl.get_value_from_config(p_param_code => 'SMPP.Wallet_pass');
begin
  v_err := v_progname ||'. Виклик WS для відправки даних в модуль "Автокаса". Адреса WS - '||v_url;
  bars_audit.info(v_err);
  select status, c.doc_body.getclobval()
    into v_sta , v_req_body
    from cl_2_ac c
    where c.doc_ref = p_doc_ref
    for update;
  if v_sta not in ('2S','DL') then
    bars_audit.info('Виклик процедури '||v_progname||' для документу, що знаходиться в статусі '||v_sta);
   return;
  end if;
  v_req_body := v_req_body||'<url>'||getglobaloption('WS_EXT_AUTOKASSA')||'</url>';
--bars_audit.info(v_url);
--  UTL_HTTP.set_detailed_excp_support(true);
  wsm_mgr.prepare_request(p_url         => v_url,
                          p_action      => '',
                          p_http_method => wsm_mgr.g_http_post,
                          p_wallet_path => v_w_path,
                          p_wallet_pwd  =>  v_w_pass,
                          p_content_type => wsm_mgr.g_ct_xml,
                          p_body        => v_req_body
                          ,p_soap_method => 'SaveClientOutcashEnquiry'
                          ,p_namespace => 'http://tempuri.org/'
                          );


  wsm_mgr.execute_soap(v_response);
  v_err := replace(replace(replace(v_response.cdoc,' mlns=',' xmlns='),chr(38)||'gt;','<'),chr(38)||'lt;','>');
  if instr(v_err,'s:Envelope') > 0 then
    v_err := null;
  else
    select replace(xmltype(v_err).extract('//SaveClientOutcashEnquiryResponse//SaveClientOutcashEnquiryResult/text()',
                                          'xmlns="http://tempuri.org/"'),
                 chr(38)||'apos;',
                 '''')
      into v_err
      from dual;
  end if;
--  bars_audit.info('CLB: v_err = '||v_err);
  if v_err is null then
    v_sta := 'OK';
  else
    v_sta := 'DL';
  end if;
  update cl_2_ac
    set status = v_sta
       ,WS_RESPONSE = v_response.xdoc
       ,LAST_ERR_TXT = v_err
    where doc_ref = p_doc_ref;
  commit;
exception
  when no_data_found then
    v_err := v_progname||': Не знайдено документ з REF = '||p_doc_ref||' в таблиці CL_2_AC';
--    rollback;
    raise_error(p_doc_ref, v_err, 0);
  when others then
    v_err := v_progname||': Помилка при роботі : '||sqlerrm;
--    rollback;
    raise_error(p_doc_ref, v_err, 0);
end SendRequest;

procedure process_queue
  is
  v_progname varchar2(30) := g_package_name||'.process_queue';
  v_err      varchar2(2000);
  v_int      integer := 0;
  v_doc_ref  oper.ref%type;
  v_sta      varchar2(2);
  v_dt       date := systimestamp;
--  pragma autonomous_transaction;
begin

  delete from cl_2_ac_scan
    where trunc(last_dt) != trunc(sysdate);

  update cl_2_ac t
    set status = 'ER'
    where nvl(status,'IN') in ('DL','IN')
      and (to_date(t.doc_body.extract('//enquiry/ExpectedDate/text()'),'yyyy-mm-dd') < gl.bDATE
           or
           t.doc_body is null);

  if sql%rowcount >0 then
    bars_audit.info('CHECK_AUTOKASSA: clear date for scanning');
  end if;

  for r in (
            select ref
              from oper
              where pdat > (select last_dt-0.01 from cl_2_ac_scan
                           union
                           select trunc(sysdate)-5 from dual where not exists (select 1 from cl_2_ac_scan)
                          )
                and pdat < v_dt
                and tt in ('R01','IB1')
--                and not exists (select 1 from cl_2_ac where doc_ref = oper.ref)
           )
  loop
    if clb2autokassa.check_autokassa(r.ref) = 1 then
      insert into cl_2_ac (doc_ref)
        select r.ref from dual
          where not exists (select 1 from cl_2_ac where doc_ref = r.ref);
      v_int := v_int + sql%rowcount;
    end if;
  end loop;
--  v_int := sql%rowcount;
  if  v_int > 0 then
    bars_audit.info('CHECK_AUTOKASSA: add new '||v_int||' documents');
  end if;

  update cl_2_ac_scan
    set last_dt = v_dt;

  for r in (select doc_ref, create_date from (select doc_ref, create_date, rank() over (partition by doc_ref order by create_date) rnk from cl_2_ac) where rnk >1)
  loop
    delete from cl_2_ac where doc_ref = r.doc_ref and create_date = r.create_date;
  end loop;


  if sql%rowcount = 0 then
    insert into cl_2_ac_scan values (v_dt);
  end if;

  bars_audit.info('CHECK_AUTOKASSA: set date for next scanning '||to_char(v_dt,'dd.mm hh24:mi:ss'));


  for c_docs in (select doc_ref, c.last_date, c.status
                   from cl_2_ac c, oper o
                   where c.status in ('IN','2S','DL')
                     and c.doc_ref = o.ref
                     and o.sos = 5
                )
  loop
    v_doc_ref := c_docs.doc_ref;
    v_err := v_progname||'. Початок роботи процессу обробки документів на підкріплення каси';
    bars_audit.info(v_err);
    if c_docs.status = 'IN' then        -- новый документ. Надо сгенерить тело
      GenBodyRequest(c_docs.doc_ref);
    elsif c_docs.status ='DL' and (sysdate-c_docs.last_date)*24*60 < g_dl_interval then
     -- документ, по которому была ошибка, со времени ошибки прошло время меньше интервала G_DL_Interval. Мы его пропускаем
      continue;
    end if;
    select status
      into v_sta
      from cl_2_ac
      where doc_ref = c_docs.doc_ref;
    if v_sta in ('2S','DL') then
      SendRequest(c_docs.doc_ref);  -- отправляем данные в Автокассу.
    end if;
    v_int := v_int + 1;
  end loop; -- c_docs
  if v_int > 0 then
    v_err := v_progname ||'. Оброблено '||v_int||' документів.';
    bars_audit.info(v_err);
  end if;
  commit;
exception
  when others then
    v_err := v_progname ||'. Помилка в процесі обробки : '||sqlerrm;
    raise_error(v_doc_ref, v_err, 0);
end;

function check_autokassa (p_doc_ref in number)
  return integer
  is
  v_ret integer;
--  pragma autonomous_transaction;
begin


    bars.bars_audit.info('CHECK_AUTOKASSA: start_check (doc_ref = '||p_doc_ref||')');
  for r in (select d.nls deb, c.nls crd, o.mfoa, o.mfob, o.tt, d.ob22 d_ob22, c.ob22 c_ob22
              from oper o, accounts d, accounts c
                where o.sos = 5
                  and o.ref  = p_doc_ref
                  and o.mfoa   = d.kf and o.nlsa = d.nls
                  and o.nlsb = c.nls and o.mfob = c.kf
                  and exists (select 1 from operw ow where ow.ref = o.ref and ow.tag like 'C1%')
--                  and not exists (select 1 from cl_2_ac where doc_ref = o.ref)
           )
  loop
    bars.bars_audit.info('CHECK_AUTOKASSA: select document type');
    if r.mfoa != r.mfob and r.tt = 'R01' and r.c_ob22 = '67' then
      v_ret := 1;
    elsif r.tt = 'IB1' and r.mfoa = r.mfob and r.d_ob22 = '67' and r.c_ob22 = '67' then
      v_ret := 1;
    else
      v_ret := 0;
    end if;
  end loop;
  return v_ret;
exception
  when others then
    bars.bars_audit.info('CHECK_AUTOKASSA: error'||sqlerrm);
    return 0;
end;

procedure get_ref (p_doc_ref in number)
  is
--  pragma autonomous_transaction;
begin
  merge into cl_2_ac c
  using (select p_doc_ref doc_ref from dual) u
  on (c.doc_ref = u.doc_ref)
  when matched then update set c.status = 'IN'
  when not matched then insert (doc_ref) values (u.doc_ref);

--  commit;
exception
  when others then
    bars_audit.info('CLB2AUTOKASSA.GET_REF :'||sqlerrm);
end get_ref;

end CLB2AutoKassa;
/
 show err;
 
PROMPT *** Create  grants  CLB2AUTOKASSA ***
grant EXECUTE                                                                on CLB2AUTOKASSA   to BARSAQ;
grant EXECUTE                                                                on CLB2AUTOKASSA   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/clb2autokassa.sql =========*** End *
 PROMPT ===================================================================================== 
 