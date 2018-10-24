
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ibx_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.IBX_PACK is

  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 2.2.0 16.05.2018';
  -- Имя пакета
  g_pack constant varchar2(100) := 'ibx_pack';
  -- Имя модуля для работы с ошибками
  g_mod constant varchar2(3) := 'IBX';
  --
  -- возвращает версию заголовка пакета
  function header_version return varchar2;
  -- возвращает версию тела пакета
  function body_version return varchar2;
  -- ===============================================================================================

---
-- Получение сумы %% к оплате
--
 

   type varchar2_list_pck is table of varchar2(4000) index by binary_integer;

   function get_sha1(p_string varchar2) return varchar2;

   function get_md5 (input_string varchar2) return varchar2;

  --Процедура оплати по всем правилам через PAYTT
  procedure pay_gl(
                   p_deal_id  in varchar2,
                   p_sum      in number,
                   p_date     in date,
                   p_receipt_num varchar2,
                   p_res_code out number,
                   p_res_text out varchar2,
                   p_res_ref  out oper.ref%type,
                   p_trade_point in varchar2                    
                   );


  procedure ins_log_xml(p_in_xml clob, p_out_xml clob, p_ref varchar2);

  procedure ins_trade_point(p_in_tdname varchar2,p_in_tdmfo varchar2,p_in_comm varchar2 );
  procedure ins_tp_params_pack (p_in_tdname varchar2);
  procedure upd_trade_point(p_in_tdname varchar2,p_in_tdmfo varchar2,p_in_comm varchar2 );
  procedure ins_tp_params (p_in_tdname varchar2,p_in_paramcode varchar2,p_in_paramvalue varchar2);
  procedure upd_tp_params (p_in_tdname varchar2,p_in_paramcode varchar2,p_in_paramvalue varchar2);
  procedure del_tp_params (p_in_tdname varchar2);
  procedure del_trade_point(p_in_tdname varchar2);
  function  get_tp_param(p_in_tp varchar2 ,p_in_code varchar2) return varchar2;
  
  procedure Pay_1 (p_params  in clob, p_result  out clob);--tomas  -проверка платежа
  procedure Pay_4 (p_params  in clob, p_result  out clob);--tomas  -проплата платежа
  procedure Pay_7 (p_params  in clob, p_result  out clob);--tomas  -проверка состояния платежа
  procedure Pay_10 (p_params  in clob, p_result  out clob);--tomas 2 -проплата платежа на св. рекв.
  procedure Pay_20 (p_params  in clob, p_result  out clob);--tomas 3 -проверка платежей списком
  procedure Pay_30 (p_params  in clob, p_result  out clob);--tomas 4 -проплата платежей списком    

  procedure pay_account_attr(p_pay_account in varchar2, p_kf out accounts.kf%TYPE, --разбор реквизитов счета
                             p_nls  out accounts.nls%TYPE, p_kv out accounts.kv%TYPE); 
  --общая процедура проверки платежа
   procedure info_common (p_pay_account in varchar2,
                          p_min_amount out varchar2,
                          p_max_amount out varchar2,
                          p_comment    out varchar2,
                          p_status_code out number,
                          p_fio out  varchar2,
                          p_nls out varchar2,
                          p_okpo out customer.okpo%TYPE) ; 
   --1-for-all  - Обмен между веб-сервисом и БД                 
   procedure ExchangeData (p_params  in clob, p_result  out clob );
   --межфилиальній платеж через СЕП
   procedure pay_to_sep ( p_ref in oper.ref%type
                       ,p_trans_nls oper.nlsb%type
                       ,p_pay_amount number
                       ,p_mfo_term accounts.kf%TYPE);
end ibx_pack;
/
CREATE OR REPLACE PACKAGE BODY BARS.IBX_PACK is
  -- ================================== Константы ===============================================
  g_body_version constant varchar2(64) := 'version 2.2.2 30.05.2018'; 

  -- ===============================================================================================
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header wcs_exchange ' || g_header_version || '.';
  end header_version;
  -- возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body wcs_exchange ' || g_body_version || '.';
  end body_version;
  -- ===============================================================================================

  function get_nd(p_agr_num w4_acc.acc_pk%type)
    return w4_acc.nd%type
    is
        l_nd w4_acc.nd%type;
    begin
      begin
        select nd into l_nd
            from w4_acc
        where acc_pk=p_agr_num;
        exception when no_data_found then
            l_nd:=null;
      end;
        return l_nd;
    end;

---

---функция получения НЛС транзита для расчета по картам внутри РУ 
 function get_trans_nls (p_nls_credit accounts.nls%TYPE ) return accounts.nls%TYPE
   is
    l_trans accounts.nls%TYPE;
 begin  
     select ba.attribute_value into l_trans
     from Branch_attribute_value ba 
          inner join accounts a on substr(a.branch,1,15)=ba.branch_code     
          and a.nls=p_nls_credit
     where ba.attribute_code='TR2924_WAY4';
     return  l_trans;
 end;



---получение значения лимитов по платежу

  procedure get_limits_pay( p_nls in accounts.nls%TYPE,
                            p_kf in  accounts.kf%TYPE,
                            p_kv in  accounts.kv%TYPE,
                            p_min_amount out ibx_limits.min_amount%TYPE,
                            p_max_amount out ibx_limits.max_amount%TYPE )  is
  l_proc     varchar2(100) := 'get_limits_pay';
  begin
   select min_amount*100,max_amount*100
    into p_min_amount,p_max_amount
    from ibx_limits l
    where l.nbs = substr(p_nls,1,4);
    exception
      when no_data_found then
          select v.limit*100 min_limit ,v.max_limit*100
          into p_min_amount,p_max_amount
          from accounts acc
               inner join dpt_deposit dd on dd.acc=acc.acc
               inner join dpt_vidd v on v.vidd=dd.vidd
          where
          acc.nls = p_nls
          and acc.kf=p_kf
          and acc.kv=p_kv;
  end;
-------------парсинг строки счета типа MFO.ACCOUNT.980
 procedure pay_account_attr(p_pay_account in varchar2,
                           p_kf out accounts.kf%TYPE,
                           p_nls  out accounts.nls%TYPE,
                           p_kv   out accounts.kv%TYPE
                          ) is
 begin
      select REGEXP_SUBSTR(s, '[^.]+', 1, 1) kf,
             REGEXP_SUBSTR(s, '[^.]+', 1, 2) nd,
             REGEXP_SUBSTR(s, '[^.]+', 1, 3) kv
         into p_kf, p_nls, p_kv
         from (select p_pay_account s from dual);
 end;  
-------Export XML-----
 --  add_text_node_utl
  --
  --    Функція добавляє тег в xml документ, і повертає його екземпляр dbms_xmldom.DOMNode
  --
  function add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2)
    return dbms_xmldom.DOMNode is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := dbms_xmldom.appendChild(p_host_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(p_document, p_node_name)));
    if p_node_text is not null then 
     l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document, p_node_text)));
    end if;
    return l_node;
  end add_text_node_utl;
 
------------
 --  add_txt_node_utl
  --
  --    Метод добавляє тег в xml документ
  --
  procedure add_txt_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2)
  is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := add_text_node_utl(p_document,
                                p_host_node,
                                p_node_name,
                                p_node_text);
  end add_txt_node_utl;

----------   
  procedure free_lob(p_buff in out nocopy clob)
  is
  begin
    if dbms_lob.isopen(lob_loc => p_buff) > 0 then
      dbms_lob.close(p_buff);
    end if;

    if p_buff is not null then
      dbms_lob.freetemporary(p_buff);
    end if;
  end free_lob;


    -----------------------------------------------------------------
    --     Функция получения SHA1
    -----------------------------------------------------------------
    function get_sha1(p_string varchar2) return varchar2
    is
     --
     l_stmt varchar2(4000);
     --
    begin
     --
        l_stmt:= lower (to_char (rawtohex (dbms_crypto.hash (src   => utl_raw.cast_to_raw (p_string),
                                                             typ   => dbms_crypto.hash_sh1))));
     --
        return l_stmt;
     --
    end;

---
-- Получение MD5
--
function get_md5 (input_string varchar2) return varchar2
  is
  begin
    return dbms_obfuscation_toolkit.md5(input_string => input_string);
  end;



--
--Платеж на счет (ACT=4, service_id=TOMAS)
-- 
 procedure Pay_4 ( p_params  in clob,    -- XML c входящими параметрами
                   p_result  out clob    -- XML c результатом выполнения
                 ) is
    l_proc varchar2(30) := 'ibx_pack.Pay_4';                 
  	p dbms_xmlparser.parser;
		v_Doc    dbms_xmldom.domdocument;
    v_Child_Nodes  Dbms_Xmldom.Domnodelist;
    v_Child_Node   Dbms_Xmldom.Domnode;
    
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_head_node    dbms_xmldom.domnode;   
    
    v_pay_account varchar2(25);
    v_pay_amount  number;
    v_comment     varchar2(1000);
    v_status_code number:=22;
    v_res_code number;
    v_service_id varchar(10);
    v_pay_id varchar2(100);
    v_receipt_num number;
    v_trade_point varchar2(26);
    v_receiver_nls accounts.nls%TYPE;
    v_receiver_kf  accounts.kf%TYPE;
    v_receiver_kv  accounts.kv%TYPE;
    v_pay_purpose varchar2(160);
    v_ibx_rec ibx_recs.abs_ref%TYPE;
    v_res_ref   oper.ref%TYPE;            
    v_ext_date date;
    v_rs_clob clob; --xml  с ответом на платеж , если дубль  

   

    l_recid number;
    --функция формирования результатирующего XML в зависимости от v_status_code 
    function get_res_xml return clob 
      is      -- v_xml_text clob;
    begin
        --создаем док. на экспорт
     l_domDoc    := dbms_xmldom.newdomdocument;
     l_root_node := dbms_xmldom.makenode(l_domDoc);
     l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'pay-response')));
     dbms_xmldom.setcharset(l_domDoc, 'UTF-8');
     dbms_xmldom.setVersion(l_domDoc, '1.0" encoding="UTF-8' );
      
     if v_status_code=22 then
      add_txt_node_utl( l_domdoc,l_head_node,'pay_id',v_pay_id);
      add_txt_node_utl( l_domdoc,l_head_node,'amount',v_pay_amount);
      add_txt_node_utl( l_domdoc,l_head_node,'pay_purpose',v_pay_purpose);        
     end if;            
     add_txt_node_utl( l_domdoc,l_head_node,'description',v_comment);
     add_txt_node_utl( l_domdoc,l_head_node,'status_code',v_status_code);            
     add_txt_node_utl( l_domdoc,l_head_node,'service_id','TOMAS');                                
     add_txt_node_utl( l_domdoc,l_head_node,'time-stamp',to_char(sysdate,'dd.mm.yyyy HH24:MI:SS'));                                
    ---
     dbms_lob.createtemporary(p_result, true, 12);
     dbms_xmldom.writetoclob(l_domdoc, p_result);
     
   --отпускаем объекты ...
    dbms_xmlparser.freeParser(p);
    dbms_xmldom.freeDocument(v_doc);
    dbms_xmldom.freedocument(l_domdoc);              
     return p_result;
 end;  
      
 begin
   /*
<pay-request>
  <act>4</act>
  <service_id>TOMAS</service_id>
  <pay_id>907rt354-f1a6-411d-b884-571e51ddac8c</pay_id>
  <sign></sign>
  <pay_account>300465.29245000005037.980</pay_account>
  <pay_amount>25000</pay_amount>
  <receipt_num>410</receipt_num>
  <trade_point>00000002322669</trade_point>
</pay-request>
 
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
    <pay_id>9341t13-f1a6-411d-b884-571e51ddac8c</pay_id>
    <service_id>TOMAS</service_id>
    <amount>15000</amount>
    <description>122440510800</description>
    <pay_purpose>Поповнення рахунку № 26308046300465 через платіжний сейф</pay_purpose>
    <status_code>22</status_code>
    <time_stamp>10.04.2018 15:48:07</time_stamp>
</pay-response>

<?xml version="1.0" encoding="utf-8"?>
<pay-response>
    <description>FAILED(передали неверные данные)</description>
    <status_code>-101</status_code>
    <time_stamp>11.04.2018 12:55:40</time_stamp>
</pay-response>
  */
   
-----------------------------
   --читаем вх. док. 
		p := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(p, p_params);
		v_Doc := dbms_xmlparser.getdocument(p);
		v_Child_Nodes := dbms_xmldom.getelementsbytagname(v_Doc, 'pay-request');
		v_Child_Node:=dbms_xmldom.item(v_Child_Nodes, 0);

    v_service_id:=dbms_xslprocessor.valueof(v_Child_Node, 'service_id/text()');
    v_pay_account:=dbms_xslprocessor.valueof(v_Child_Node, 'pay_account/text()');   
    v_pay_id:=dbms_xslprocessor.valueof(v_Child_Node, 'pay_id/text()');   
    v_pay_account:=dbms_xslprocessor.valueof(v_Child_Node, 'pay_account/text()'); 
    v_pay_amount:=to_number(dbms_xslprocessor.valueof(v_Child_Node, 'pay_amount/text()'));   
    v_receipt_num:=to_number(dbms_xslprocessor.valueof(v_Child_Node, 'receipt_num/text()'));
    v_trade_point:=dbms_xslprocessor.valueof(v_Child_Node, 'trade_point/text()');   
-----------------------------   
--    v_ext_date:=to_date(sysdate,'YYYY-MM-DD HH24:MI:SS');
    v_ext_date:=trunc(sysdate);
    v_trade_point := substr(v_trade_point, 0, length(v_trade_point)-6); --код терминала из вх. файла
    pay_account_attr(p_pay_account =>v_pay_account , p_kf=>v_receiver_kf, p_nls=>v_receiver_nls,p_kv=>v_receiver_kv);--разбираем счет получателя
    v_pay_purpose:='Поповнення рахунку № '||v_receiver_nls||' через платіжний сейф';

    -- отсекаем нулевые и отрицательные суммы
    if (v_pay_amount <= 0) then
      v_status_code := 3;
      v_comment := 'FAILED(передали неверные данные)';
      p_result:=get_res_xml;
      return;
    end if;

    -- поиск документа в уже принятых
    begin
      select ir.abs_ref
        into v_ibx_rec
        from ibx_recs ir
       where ir.type_id = v_service_id
         and ir.ext_ref = v_pay_id
         for update;
      -- оплачен ли уже документ
      if (v_ibx_rec is not null) then
           -- возврщаем XML с прошлым ответом
           select * into  v_rs_clob            
           from ( select rs_clob from v_ibx_xml_log where pay_id =v_pay_id and dbms_lob.getlength(rs_clob)>0
                  order by date_in desc
                )            
           where rownum=1;
      --      
        v_status_code := 1;
      --  v_comment := 'DUPLICATE(дублюючий платіж)';
--        p_result:=get_res_xml;
        p_result:=v_rs_clob;
        return;
      end if;
    exception
      when no_data_found then
        null;
    end;
    begin
      savepoint sp_before_pay;

  --  формируем платеж
              pay_gl( p_deal_id  =>v_receiver_nls,                       --номер счета
                      p_sum      =>v_pay_amount,                         --сумма
                      p_date     =>v_ext_date,                           --дата на терминале
                      p_receipt_num=>v_receipt_num,                      --номер чека
                      p_res_code   =>v_res_code,                         --код результата
                      p_res_text   =>v_comment,                          --коммент результата 
                      p_res_ref    =>v_res_ref,                          --ref созданного дока
                      p_trade_point =>v_trade_point                      --номер терминала
                      );
     /*     pay_common (
                          p_trade_point in varchar2,--код терминала +МФО его
                          p_payer_name in varchar2,--наименование плательщика
                          p_receiver_acc in varchar2,-- счет получателя
                          p_receiver_mfo in varchar2,-- МФО получателя
                          p_receiver_curr in varchar2,--валюта счета получателя
                          p_receiver_okpo in integer,--код получателя
                          p_receiver_name in varchar2,--наименование получателя
                          p_cash_symb in varchar2,--касовий символ
                          p_payment_purpose in varchar2,--призначення платежу
                          p_res_code out number, --код ответа 
                          p_res_text out varchar2, --текст ответа                        
                          p_res_ref  out oper.ref%type,                          
                          p_receipt_num number, --номер чека
                          p_pay_id Varchar2,  --пай его ид
                          p_pay_amount number, --сумма платежа 
                          p_fee_amount number, --сумма комиссии                          
                          p_ref out number,     
                          p_deal_id  in varchar2,
                          p_sum      in number, --сумма платежа
                          p_date     in date                          
                     );      */      
-----------------------------------------------------------
      -- добавляем документ в таблицу квитовки
      if v_res_code <> 0 then
        p_result:=get_res_xml;
        return;
      else     
        insert into ibx_recs
          (type_id, ext_ref, ext_date, deal_id, summ, abs_ref)
        values
          (v_service_id,
           v_pay_id,
           v_ext_date,
           v_pay_account,
           v_pay_amount,
           v_res_ref);
       end if;
-- raise_application_error(-20001,'ERROR');
    exception
      when others then
        rollback to savepoint sp_before_pay;
        v_status_code := 5;
        v_comment := 'ERR(Проблеми з системою) ';
                               
       bars_audit.error(sqlerrm);
       bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
          dbms_utility.format_error_backtrace(), '', null, l_recid);
       p_result:=get_res_xml;          
       return;
    end;



    bars_audit.info(g_pack || '.' || l_proc || ': Finish. p_res_ref = ' ||
                    to_char(v_pay_id) || ' p_res_code => ' ||
                    to_char(v_status_code) || ', p_res_text => ' ||
                    v_comment);
-- успешно                    
    v_comment:=v_res_ref;
    p_result:=get_res_xml;  

 end Pay_4;
 
 
 --Процедура оплати по всем правилам через PAYTT (ACT=4)
 procedure pay_gl(p_deal_id  in varchar2,
                  p_sum      in number,
                  p_date     in date,
                  p_receipt_num varchar2,
                  p_res_code out number,
                  p_res_text out varchar2,
                  p_res_ref  out oper.ref%type,
                  p_trade_point in varchar2 
                  )
    is

       l_acc        accounts.acc%type; 
       l_acc_tip    accounts.tip%TYPE;
       l_nd         oper.nd%type := substr(p_deal_id, -10);
       l_debit_nls  oper.nlsa%type;
       l_nls_credit oper.nlsb%type;
       l_debit_name oper.nam_a%type;
       l_nms_credit oper.nam_b%type;
       l_dk         number:=1;
       l_ref        oper.ref%type;
       l_kv         tabval.kv%type:=980;
       l_bdate      date;
       l_tt         tts.tt%type:='328';
       l_nazn       varchar2(160);
       l_okpo       customer.okpo%type; --код ЕДРПОУ получателя
       l_mfo_cust   banks.mfo%type; --МФО получателя
       l_mfo_term   banks.mfo%type; --МФО терминала
       l_nls_t00    oper.nlsb%type;
       l_trans      oper.nlsb%type;
       l_pay_amount number;
       l_trans_nm   accounts.nms%type;
 
 begin
        -- обнуляем результат
        p_res_code := 0;
        p_res_text := null;
        p_res_ref  := null;

    -- проверка суммы на корректность
    if (p_sum is null or p_sum < 1) then
      p_res_code := 1;
      p_res_text := 'Помилка суми погашення';
      return;
    end if;

     -- получение параметров счета источника
    begin
      select a.nls, substr(a.nms, 1, 38),a.kf
        into l_debit_nls, l_debit_name,l_mfo_term
        from accounts a
       where a.nls = get_tp_param(p_trade_point,'NLS_ACC')--p_src_nls
         and a.kv = l_kv
         and a.dazs is null;
    exception
      when no_data_found then
        p_res_code := 2;
        p_res_text := 'Рахунок джерела для списання не найдено nls=' ||get_tp_param(p_trade_point,'NLS_ACC');
        return;
    end;

    -- ищем счет получателя
    begin
       select a.acc
         into l_acc
         from accounts a
        where a.nls = p_deal_id
          and a.kv = 980;
    exception
      when no_data_found then
        p_res_code := 3;
        p_res_text := 'Рахунок отримувача №' || p_deal_id || ' не знайдено';
        return;
    end;


    --ищем счет 2625 и ОКПО клиента
    begin
      select a.nls, substr(a.nms,1,38), c.okpo,a.kf,a.tip
        into l_nls_credit,l_nms_credit, l_okpo,l_mfo_cust,l_acc_tip
      from accounts a, customer c
        where c.rnk=a.rnk
          and a.acc=l_acc;
    exception
      when no_data_found then
        p_res_code:=4;
        p_res_text:='Рахунок №'||l_nls_credit||' не знайдено!';
        return;
    end;




  l_bdate := gl.bdate;
  l_nazn := 'Поповнення рахунку № '||l_nls_credit||' через платіжний сейф';
  p_res_text := l_nazn;

  --Оплата документа
  bc.go(l_mfo_term);
  gl.ref(l_ref);
  if l_mfo_cust != l_mfo_term
          then l_tt:='TO1';
          else l_tt:='328';
  end if;



  gl.in_doc3 (ref_    => l_ref,
              tt_     => l_tt,
              vob_    => 6,
              nd_     => l_nd,
              pdat_   => sysdate,
              vdat_   => l_bdate,
              dk_     => l_dk,
              kv_     => l_kv,
              s_      => p_sum,
              kv2_    => l_kv,
              s2_     =>p_sum,
              sk_     => 5,
              data_   => l_bdate,
              datp_   => p_date,
              nam_a_  => l_debit_name,
              nlsa_   => l_debit_nls,
              mfoa_   => l_mfo_term,--l_mfo,
              nam_b_  => l_nms_credit,
              nlsb_   => l_nls_credit,
              mfob_   => l_mfo_cust,--l_mfo,
              nazn_   => l_nazn,
              d_rec_  => null,
              id_a_   => f_ourokpo,
              id_b_   => l_okpo,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => null);

  if l_mfo_cust = l_mfo_term then         --в пределах одного МФО
    if substr(l_acc_tip,1,2) != 'W4' then --платежи НЕ на карточный счет
        paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => l_debit_nls, 
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => l_nls_credit, 
           sb_ => p_sum );
    else    --платежи НА карточный счет    
      --1004 - 2924
      --выбор транзитного счета для бренча карточного счета 
      -- l_trans:=get_tp_param(p_trade_point,'TRANS_CARD_ACC');
         l_trans:= get_trans_nls(l_nls_credit);  
       paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => l_debit_nls, 
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => l_trans , 
           sb_ => p_sum );
    end if;

        gl.pay( 2, l_ref,l_bdate);
  else    --в пределах РАЗНЫХ МФО
         select get_proc_nls('T00',980)
         into l_nls_t00 from dual;
    --на любой счет
       -- Дт1004-Кт2902
       l_trans:=get_tp_param(p_trade_point,'TRANS_ACC');
           paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => l_debit_nls, 
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => l_trans , 
           sb_ => p_sum );
        --Дт2902-Кт3739 
          paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => l_trans, 
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => l_nls_t00 , 
           sb_ => p_sum );


          gl.pay( 2, l_ref,l_bdate);     

       begin
          select ac.nms
            into l_trans_nm
            from accounts ac
           where ac.nls = l_trans 
             and ac.kv =l_kv
             and ac.dazs is null
             and ac.kf = l_mfo_term
             and ac.branch = ibx_pack.get_tp_param(p_trade_point,'TRANS_BR');
        exception
          when no_data_found then
            p_res_code := 101;
            p_res_text := 'Рахунок TRANS_ACC для терміналу '||p_trade_point ||' не знайдено';
            return;
        end;
       -- отправка через СЕП

          pay_to_sep (p_ref =>l_ref ,p_trans_nls=>l_trans,p_pay_amount=>l_pay_amount,p_mfo_term=>l_mfo_term);

  end if ;   
       --Добавляем в доп. реквезит документа номер чека ТОМАС
        insert into OPERW ( REF, TAG, VALUE ) values ( l_ref, 'NUMCH', p_receipt_num );

        if substr(l_acc_tip,1,2) = 'W4' then --если карточный счет
          --добавляем в доп. реквизит документа сообщение для СМ 
          insert into OPERW ( REF, TAG, VALUE ) values ( l_ref, 'W4MSG', 'PAYTOMAS' );        
        end if;        
    p_res_ref := l_ref;
 end;
 
 --процедура отправки платежа через CЕП для межфилиала
procedure pay_to_sep (
                        p_ref in oper.ref%type
                       ,p_trans_nls oper.nlsb%type                      
                       ,p_pay_amount number
                       ,p_mfo_term accounts.kf%TYPE
                       )
   is
       err_   NUMBER;    -- Return code
       rec_   NUMBER;    -- Record number
       mfoa_  VARCHAR2(12);   -- Sender's MFOs
       nlsa_  VARCHAR2(15);   -- Sender's account number
       mfob_  VARCHAR2(12);   -- Destination MFO
       nlsb_  VARCHAR2(15);   -- Target account number
       dk_    NUMBER;         -- Debet/Credit code
       s_     DECIMAL(24);    -- Amount
       vob_   NUMBER;         -- Document type
       nd_    VARCHAR2(10);   -- Document number
       kv_    NUMBER;         -- Currency code
       datD_  DATE;           -- Document date
       datP_  DATE;           -- Posting date
       nam_a_  VARCHAR2(38);  -- Sender's customer name
       nam_b_  VARCHAR2(38);  -- Target customer name
       nazn_   VARCHAR(160);  -- Narrative
       nazns_ CHAR(2);        -- Narrative contens type
       id_a_  VARCHAR2(14);   -- Sender's customer identifier
       id_b_  VARCHAR2(14);   -- Target's customer identifier
       datA_  DATE;           -- Input file date/time
       d_rec_ VARCHAR2(80);   -- Additional parameters
       sos_   NUMBER;
       refA_  VARCHAR2(9);
       prty_  NUMBER;
       l_trans_nms  accounts.nms%type;
 begin
  SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
         datd, datp, nam_a, nam_b, nazn, id_a, id_b,
         d_rec, sos, ref_a, prty
  INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
       datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
       d_rec_, sos_, refA_, prty_
  FROM oper WHERE ref=p_ref;

       if (sos_ = 5 ) then
          IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
           nazns_ := '11';
          ELSE
           nazns_ := '10';
          END IF;
       end if;

----------------
       begin
          select ac.nms
            into l_trans_nms
            from accounts ac
           where ac.nls = p_trans_nls
             and ac.dazs is null
             and ac.kf = p_mfo_term;
        exception
          when no_data_found then 
            raise;
            return;
        end;
----------------

       logger.info('ibx_pack.pay_to_sep.sep.in_sep DATP='||to_char(datP_,'dd.mm.yyyy')||' DATD='||to_char(datD_,'dd.mm.yyyy')||' p_ref='||to_char(p_ref));

       sep.in_sep(err_,rec_,mfoa_,p_trans_nls,mfob_,nlsb_,dk_,p_pay_amount,
                  vob_,nd_,kv_,datD_,datP_,substr(l_trans_nms,1,38),nam_b_,nazn_,
                  NULL,nazns_,id_a_,id_b_,'******',refA_,0,'0123',
                  NULL,NULL,datA_,d_rec_,0,p_ref,0);

 end pay_to_sep; 
 

 procedure ins_log_xml(p_in_xml clob, p_out_xml clob, p_ref varchar2) is
   begin
     merge into test_ibx_xml t
      using (select * from dual) on (t.ext_ref = p_ref)
      when matched then update set rq_clob = p_in_xml, rs_clob = p_out_xml
      when not matched then insert values (p_ref, p_in_xml, p_out_xml);
   end;

/*-----Параметры терминалов---   */
 procedure ins_tp_params_pack (p_in_tdname varchar2) is  
  l_p_value ibx_tp_params.paramvalue%TYPE;
 begin
    for rec in (select * from ibx_tp_params_lst )
    loop
     if rec.defvalue='[MFO]' then
        select '/'||tp.mfo||'/' into l_p_value
        from ibx_trade_point tp         
        where tp.trade_point=ins_tp_params_pack.p_in_tdname;
      else l_p_value:=rec.defvalue;
     end if;
     ins_tp_params(p_in_tdname => p_in_tdname,p_in_paramcode => rec.paramcode,p_in_paramvalue =>l_p_value );
    end loop;  
 end;
--вставка записи параметра терминала
 procedure ins_tp_params (p_in_tdname varchar2,p_in_paramcode varchar2,p_in_paramvalue varchar2) is
  l_proc     varchar2(100) := 'ins_tp_params';
 begin
    insert into ibx_tp_params (trade_point,paramcode,paramvalue)
    values (ins_tp_params.p_in_tdname,ins_tp_params.p_in_paramcode,ins_tp_params.p_in_paramvalue);
 end;
--обновление значения параметра терминала
 procedure upd_tp_params (p_in_tdname varchar2,p_in_paramcode varchar2,p_in_paramvalue varchar2)is
  l_proc     varchar2(100) := 'upd_tp_params';
 begin
    update ibx_tp_params
    set   ibx_tp_params.paramvalue=upd_tp_params.p_in_paramvalue
    where ibx_tp_params.trade_point=upd_tp_params.p_in_tdname
    and   ibx_tp_params.paramcode=upd_tp_params.p_in_paramcode ;
 end;
--удаление записи параметров терминала
 procedure del_tp_params (p_in_tdname varchar2) is
  l_proc     varchar2(100) := 'del_tp_params';
 begin
    delete from ibx_tp_params where ibx_tp_params.trade_point=del_tp_params.p_in_tdname;
 end;
--вставка записи терминала
 procedure ins_trade_point(p_in_tdname varchar2,p_in_tdmfo varchar2,p_in_comm varchar2 ) is
  l_proc     varchar2(100) := 'ins_trade_point';
 begin
    insert into ibx_trade_point(trade_point,mfo,comm)
    values (ins_trade_point.p_in_tdname,ins_trade_point.p_in_tdmfo,ins_trade_point.p_in_comm);
    -- ins params pack
    ins_tp_params_pack(p_in_tdname);
 end;
--обновление записи терминала
 procedure upd_trade_point(p_in_tdname varchar2,p_in_tdmfo varchar2,p_in_comm varchar2 ) is
  l_proc     varchar2(100) := 'upd_trade_point';
 begin
    update ibx_trade_point
    set mfo=upd_trade_point.p_in_tdmfo  ,comm=upd_trade_point.p_in_comm
    where ibx_trade_point.trade_point=upd_trade_point.p_in_tdname;
 end;
--получение значения параметра терминала
 function get_tp_param(p_in_tp varchar2 ,p_in_code varchar2) return varchar2 is
  l_paramvalue ibx_tp_params.paramvalue%TYPE;
  l_proc     varchar2(100) := 'get_tp_param';
 begin
  begin 
   select paramvalue into l_paramvalue from ibx_tp_params
    where ibx_tp_params.trade_point=p_in_tp and ibx_tp_params.paramcode=p_in_code;
  exception 
   when no_data_found then    
    return p_in_code; 
  end;   
    return l_paramvalue;
 end;
--удаление записи терминала
 procedure del_trade_point(p_in_tdname varchar2) is 
    l_proc     varchar2(100) := 'del_trade_point';
 begin
    del_tp_params (p_in_tdname);
    delete from ibx_trade_point where  trade_point =p_in_tdname;
 end;

------------------ TOMAS 3,4------------------------------------
--
--общая процедура проплаты платежа(платежей)    
--
 procedure pay_common
   -- переработанная pay_legal_pers  для общего платежа
                         (p_trade_point in varchar2,--код терминала +МФО его
                          p_payer_name in varchar2,--наименование плательщика
                          p_pay_account in varchar2,-- счет получателя MFO.ACCOUNT.980
                          p_receiver_okpo in integer,--код получателя
                          p_receiver_name in varchar2,--наименование получателя
                          p_cash_symb in varchar2,--касовий символ
                          p_payment_purpose in varchar2,--призначення платежу
                          p_res_code out number,       --код ответа
                          p_res_text out varchar2,     --текст ответа
                          p_receipt_num number,        --номер чека
                          p_pay_id Varchar2,           --пай его ид
                          p_pay_amount number,         --сумма платежа
                          p_fee_amount number,         --сумма комиссии
                          p_ref out number
                          )
    is

       l_debit_nls  oper.nlsa%type;
       l_trans_2902 oper.nlsb%type;
       l_trans_2902_nm accounts.nms%type;
       l_acc_tip    accounts.tip%TYPE;
       l_6110 oper.nlsb%type;
       l_nls_t00 oper.nlsb%type;
       l_debit_name oper.nam_a%type;
       l_dk         number:=1;
       l_trade_point  ibx_trade_point.trade_point%type;
       l_mfo          banks.mfo%type;
       l_bdate        date;
       l_tt           tts.tt%type:='TO1';
       l_nazn         varchar2(160);
       l_pay_amount   number(32);
       l_fee_amount   number(32);
       l_pay_id       varchar2(300);
       l_receipt_num  varchar2(220);
       v_receiver_acc  varchar2(14);
       v_receiver_mfo  varchar2(6);
       v_receiver_curr  varchar2(3);
       v_count number;




 begin
-- обнуляем результат
    p_res_code := 22;
    p_res_text := null;
    l_mfo   := substr(p_trade_point,-6,6);
    l_bdate := gl.bdate;
    l_trade_point := substr(p_trade_point, 0, length(p_trade_point)-6);
    pay_account_attr(p_pay_account,v_receiver_mfo,v_receiver_acc ,v_receiver_curr);

    begin
-- сверка номера терминали из XML и справочника IBX_TRADE_POINT
        select 'x'
        into l_debit_nls
        from ibx_trade_point tp
        where tp.trade_point=l_trade_point
        and tp.mfo= l_mfo;
      exception
        when no_data_found then
          p_res_code := 101;
          p_res_text := 'Код устройства Томас в указанном МФО не найден';
          return;
     end;
-- сверка счета из справочника IBX_TP_PARAMS-NLS_ACC и открытых счетов
     begin
         select ac.nls, ac.nms,ac.tip
         into l_debit_nls, l_debit_name,l_acc_tip
         from accounts ac
         where ac.nls = get_tp_param(l_trade_point,'NLS_ACC')
          and ac.kf=l_mfo
          and ac.kv = v_receiver_curr;
      exception
        when no_data_found then
          p_res_code := 101;
          p_res_text := 'Счет NLS_ACC для устройства Томас не найден';
          return;
     end;

    l_nazn  := nvl(p_payment_purpose, 'Поповнення рахунку від '||p_payer_name);
    p_res_text := l_nazn;
    l_receipt_num:=p_receipt_num ;
    l_pay_id:= p_pay_id ;
    l_pay_amount:=p_pay_amount ;
    l_fee_amount:=p_fee_amount ;
--------------------------
    --проверка на дубль платежа
    begin
      select i.ref
      into p_ref
      from ibx_legal_pers_paym i
      where i.pay_id = l_pay_id;
          p_res_code := 102;
          p_res_text := 'Дублюючий платіж для '||l_pay_id;
          return;
    exception when no_data_found then
          p_ref := null;
    end;
    --проверка МФО получателя
    begin
      select 1  into v_count
      from banks$base
      where mfo =v_receiver_mfo;
    exception
      when no_data_found then
        p_res_code := 100;
        p_res_text := 'МФО банка отримувача  відсутне у довіднику: '||v_receiver_mfo;
        return;
    end;
    
    --
    if (p_ref is null) then
          --Оплата документа
          bc.go(l_mfo);
          gl.ref (p_ref);
        if l_mfo != v_receiver_mfo
          then l_tt:='TO1';
          else l_tt:='328';
        end if;
--logger.info ('ibx_pack.pay_common:l_mfo = '||l_mfo||'-'||v_receiver_mfo||',date=');          
       begin
          gl.in_doc3 (ref_    => p_ref,
                      tt_     => l_tt,
                      vob_    => 6,
                      nd_     => substr(to_char(p_ref), 1, 10),
                      pdat_   => sysdate,
                      vdat_   => l_bdate,
                      dk_     => l_dk,
                      kv_     => v_receiver_curr,
                      s_      => l_pay_amount + l_fee_amount,
                      kv2_    => v_receiver_curr,
                      s2_     => l_pay_amount + l_fee_amount,
                      sk_     => p_cash_symb,
                      data_   => l_bdate,
                      datp_   => l_bdate,
                      nam_a_  => l_debit_name,
                      nlsa_   => l_debit_nls,
                      mfoa_   => l_mfo,
                      nam_b_  => p_receiver_name,
                      nlsb_   => v_receiver_acc,
                      mfob_   => v_receiver_mfo,
                      nazn_   => l_nazn,
                      d_rec_  => null,
                      id_a_   => f_ourokpo,
                      id_b_   => p_receiver_okpo,
                      id_o_   => null,
                      sign_   => null,
                      sos_    => null,
                      prty_   => 0,
                      uid_    => null);
         --  exception when others then  
--             logger.info ('ibx_pack.pay_common:l_mfo = '||l_mfo||'-'||v_receiver_mfo||',date='||sysdate);                     
         end;             
          --Добавляем в доп. реквезит документа номер чека ТОМАС
        insert into OPERW ( REF, TAG, VALUE ) values ( p_ref, 'NUMCH', l_receipt_num );
        
         begin
          select ac.nls, ac.nms
            into l_trans_2902, l_trans_2902_nm
            from accounts ac
           where ac.nls = get_tp_param(l_trade_point,'TRANS_ACC')
             and ac.kv = v_receiver_curr
             and ac.dazs is null
             and ac.kf = l_mfo
             and ac.branch = ibx_pack.get_tp_param(l_trade_point,'TRANS_BR');
         exception
          when no_data_found then
            p_res_code := 101;
            p_res_text := 'Счет TRANS_ACC для устройства Томас не найден';
            return;
         end;        
         
------------если есть комисиия
           if (l_fee_amount > 0) then
              begin
                select ac.nls
                into l_6110
                from accounts ac
               where ac.nls =  ibx_pack.get_tp_param(l_trade_point,'FEE_ACC')
                 and ac.kf = l_mfo
                 and ac.kv =v_receiver_curr
                 and ac.dazs is null
                 and ac.branch=ibx_pack.get_tp_param(l_trade_point,'FEE_BR');
              exception
               when no_data_found then
                p_res_code := 101;
                p_res_text := 'Счет FEE_ACC для устройства Томас не найден';
                return;
              end;
              paytt ( flg_ => 0,
                      ref_ => p_ref,
                     datv_ => l_bdate,
                       tt_ => l_tt,
                      dk0_ => l_dk,
                      kva_ => v_receiver_curr,
                     nls1_ => l_trans_2902,
                       sa_ => l_fee_amount,
                      kvb_ => v_receiver_curr,
                     nls2_ => l_6110,
                       sb_ => l_fee_amount);
           end if;
--------------------------------------

        if (l_mfo != v_receiver_mfo) then --разные РУ  
               select get_proc_nls('T00',980)into l_nls_t00 from dual;

                 paytt ( flg_ => 0,
                  ref_ => p_ref,
                 datv_ => l_bdate,
                   tt_ => l_tt,
                  dk0_ => l_dk,
                  kva_ => v_receiver_curr,
                 nls1_ => l_debit_nls,
                   sa_ => l_pay_amount + l_fee_amount,
                  kvb_ => v_receiver_curr,
                 nls2_ => l_trans_2902,
                   sb_ => l_pay_amount + l_fee_amount );
                                  
                paytt ( flg_ => 0,
                        ref_ => p_ref,
                       datv_ => l_bdate,
                         tt_ => l_tt,
                        dk0_ => l_dk,
                        kva_ => v_receiver_curr,
                       nls1_ => l_trans_2902,
                         sa_ => l_pay_amount,
                        kvb_ => v_receiver_curr,
                       nls2_ => l_nls_t00,
                         sb_ => l_pay_amount );

                gl.pay( 2,p_ref,l_bdate);
                --отправка по СЕП
                pay_to_sep (p_ref=>p_ref ,p_trans_nls=>l_trans_2902,p_pay_amount=>l_pay_amount,p_mfo_term=>l_mfo );
               
       else --- одно РУ
        --Достаем тип счета получателя  
          begin 
           select tip into l_acc_tip from accounts a where a.nls=v_receiver_acc;  
          exception 
          when no_data_found then  
            p_res_code := 102;
            p_res_text := 'Рахунок отримувача не знайдено';
            return;
          end ;
      
        if substr(l_acc_tip,1,2) = 'W4' then --если карточный счет
           --добавляем в доп. реквизит документа сообщение для СМ
          insert into OPERW ( REF, TAG, VALUE ) values ( p_ref, 'W4MSG', 'PAYTOMAS' );
          l_trans_2902:= get_trans_nls(v_receiver_acc);                                                                    
                paytt ( flg_ => null,
                        ref_ => p_ref,
                       datv_ => l_bdate,
                         tt_ => l_tt,
                        dk0_ => l_dk,
                        kva_ => v_receiver_curr,
                       nls1_ => l_debit_nls,
                         sa_ => l_pay_amount,
                        kvb_ => v_receiver_curr,
                       nls2_ =>  l_trans_2902,
                         sb_ => l_pay_amount);
                gl.pay( 2, p_ref,l_bdate); 
         else       
                paytt ( flg_ => null,
                        ref_ => p_ref,
                       datv_ => l_bdate,
                         tt_ => l_tt,
                        dk0_ => l_dk,
                        kva_ => v_receiver_curr,
                       nls1_ => l_debit_nls,
                         sa_ => l_pay_amount,
                        kvb_ => v_receiver_curr,
                       nls2_ => v_receiver_acc,
                         sb_ => l_pay_amount);
                gl.pay( 2, p_ref,l_bdate);                 
           end if;       
        end if;

        insert into ibx_legal_pers_paym (pay_id, ref)
        values (l_pay_id, p_ref);
       end if;
    commit;
    
    exception when others then
       p_res_code := 101;
       p_res_text := sqlerrm;
       rollback;

  end pay_common;----------------------------------------------------------------
--Пакетная проверка платежа на счет (ACT=30, service_id=TOMAS4)
-- 
 procedure Pay_30 (  p_params  in clob,  -- XML c входящими параметрами
                     p_result  out clob  -- XML c результатом выполнения
                  ) is
    l_proc varchar2(30) := 'ibx_pack.Pay_30';
    v_pay_id varchar2(100); -- идент. платежа
--
    p              Dbms_Xmlparser.Parser;
    v_Doc          Dbms_Xmldom.Domdocument;
    v_Root_Element Dbms_Xmldom.Domelement;
    v_Child_Nodes  Dbms_Xmldom.Domnodelist;
    v_Child_Node   Dbms_Xmldom.Domnode;
    v_Text_Node    Dbms_Xmldom.Domnode;
    v_Emp_Nodes    Dbms_Xmldom.Domnodelist;
    v_Emp_Node     Dbms_Xmldom.Domnode;   
 
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_head_node    dbms_xmldom.domnode;   
    l_head_node0   dbms_xmldom.domnode;   
    l_head_node1   dbms_xmldom.domnode;   

    v_pay_account varchar2(25);
    v_min_amount varchar2(20);
    v_max_amount varchar2(20);
    v_comment     varchar2(150);
    v_status_code number;
    v_receiver_fio varchar(256);
    v_receiver_okpo varchar(10);
    v_receiver_nls accounts.nls%TYPE;
    v_acc_res number;  -- результат проверки счета       
   
/*
----request
<?xml version="1.0" encoding="utf-8"?>
<pay-request>
  <act>30</act>
  <service_id>TOMAS4</service_id>
  <request_id>XXXXXXXXXXXXXXXXX</request_id>
  <accounts>
    <account>MFO.ACCOUNT.980</account>
    <account>MFO.ACCOUNT.980</account>
</accounts>
</pay-request>
    
----response 
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
  <accounts>
    <account>
      <number>MFO.ACCOUNT.980<number>
      <status>0(можна)</status>
    </account>
    <account>
      <number>MFO.ACCOUNT.980<number>
      <status>1(не можна)</status>
    </account>
  </accounts>
  <service_id>TOMAS4</service_id>
  <time_stamp>XXXXXX</time_stamp>
  <request_id>XXXXXXXXXXXXXXXXX</request_id>
</pay-response>
Або
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
  <service_id>TOMAS4</service_id>
  <description>XXXXX</description>
  <status_code>-100</status_code>
  <time_stamp>ХХХХХХХХХХХХХХ</time_stamp>
  <request_id>XXXXXXXXXXXXXXXXX</request_id>
</pay-response>

*/

-----------------------
 begin
    --читаем вх. док.
    p := Dbms_Xmlparser.Newparser; 
		dbms_xmlparser.parseclob(p, p_params);
    v_Doc := Dbms_Xmlparser.Getdocument(p);
		v_Emp_Nodes:= dbms_xmldom.getelementsbytagname(v_doc, 'pay-request');
		v_Emp_Node := dbms_xmldom.item(v_Emp_Nodes, 0);
    v_pay_id   := dbms_xslprocessor.valueof(v_Emp_Node, 'pay_id/text()');
    
        --создаем док. на экспорт
     l_domDoc    := dbms_xmldom.newdomdocument;
     l_root_node := dbms_xmldom.makenode(l_domDoc);
     l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'pay-response')));
     l_head_node0 := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'accounts')));
     dbms_xmldom.setcharset(l_domDoc, 'UTF-8');
     dbms_xmldom.setVersion(l_domDoc, '1.0" encoding="UTF-8' );
    
    
    --пишем заголовок ответа
    ------читаем блок счетов
    p := Dbms_Xmlparser.Newparser;                  
    Dbms_Xmlparser.Parsebuffer(p,p_params);
    v_Doc := Dbms_Xmlparser.Getdocument(p);
    v_Root_Element := Dbms_Xmldom.Getdocumentelement(v_Doc);
    v_Emp_Nodes := Dbms_Xmldom.Getelementsbytagname(v_Root_Element,'accounts');
    For j In  0 .. Dbms_Xmldom.Getlength(v_Emp_Nodes)-1 Loop
      v_Emp_Node := Dbms_Xmldom.Item(v_Emp_Nodes,j);
      v_Child_Nodes := Dbms_Xmldom.Getchildnodes(v_Emp_Node);
      For i In 0 .. Dbms_Xmldom.Getlength(v_Child_Nodes) - 1 Loop
         v_Child_Node := Dbms_Xmldom.Item(v_Child_Nodes,i);
         v_Text_Node  := Dbms_Xmldom.Getfirstchild(v_Child_Node);
         v_pay_account:= Dbms_Xmldom.Getnodevalue(v_Text_Node);      
 -----обрабатываем в info_common 
    ibx_pack.info_common(
    v_pay_account
    ,p_min_amount =>v_min_amount
    ,p_max_amount =>v_max_amount
    ,p_comment => v_comment
    ,p_status_code => v_status_code
    ,p_fio =>v_receiver_fio
    ,p_nls =>v_receiver_nls
    ,p_okpo =>v_receiver_okpo);   
 --------------------    
     if v_status_code =21 then  v_acc_res:=0 ; else  v_acc_res:=1;end if;
      l_head_node1 := dbms_xmldom.appendchild(l_head_node0, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,'account')));
      add_txt_node_utl( l_domdoc,l_head_node1,'description',v_comment);
      add_txt_node_utl( l_domdoc,l_head_node1,'number',v_pay_account);
      add_txt_node_utl( l_domdoc,l_head_node1,'status',v_acc_res);
     
    End Loop;        
   end loop;   
    ---завершение ответа------------
     add_txt_node_utl( l_domdoc,l_head_node,'pay_id',v_pay_id);
     add_txt_node_utl( l_domdoc,l_head_node,'service_id','TOMAS4');
     add_txt_node_utl( l_domdoc,l_head_node,'time_stamp',to_char(sysdate,'dd.mm.yyyy HH24:MI:SS'));     

     dbms_lob.createtemporary(p_result, true, 12);
     dbms_xmldom.writetoclob(l_domdoc, p_result);
     
   --отпускаем объекты ...
    dbms_xmlparser.freeParser(p);
    dbms_xmldom.freeDocument(v_doc);
    dbms_xmldom.freedocument(l_domdoc);              

 end Pay_30;


------------------------------------------------------
--Проверка состояния транзакции по АСТ 4 (АСТ=7)
--

procedure Pay_7(p_params in clob, -- XML c входящими параметрами
                p_result out clob -- XML c результатом выполнения
               )
    is
    l_proc varchar2(30) := 'ibx_pack.Pay_7';       
   	p dbms_xmlparser.parser;
		v_Doc    dbms_xmldom.domdocument;
    v_Child_Nodes  Dbms_Xmldom.Domnodelist;
    v_Child_Node   Dbms_Xmldom.Domnode;

    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_head_node    dbms_xmldom.domnode;   
    l_head_node0   dbms_xmldom.domnode;   
        l_status_code    number :=11;
        l_transaction_id varchar2(100);
        r_ibx_recs       ibx_recs%rowtype;
        l_comment        varchar2(256):='Статус транзакции определен';
        l_sos            oper.sos%type;
        l_s              oper.s%type;
        l_transaction_code number;
        l_xml_text clob;
    begin
        bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: p_params => %s',
                     p_params);

        --Описание статусов
        /*
        -101 Параметры запроса не корректны. Обратитесь к администратору.
        -100 В биллинговой системе найдено более одного платежа c данным Pay_id
        -90 Сервис недоступный
        -42 Платеж на данную сумму невозможен для данного клиента
        -41 Прием платежей для данного клиента невозможен
        -40 Клиента не найдено
        -10 Транзакцию не найдено
        11 Статус транзакции определен
        21 Платеж возможный
        22 Платеж принят
        */

        /*
        Таблица кодов transaction status
        111 Платеж успешно выполнен.
        120 Платеж находится в обработке
        130 Платеж отменен
        */

        --Пример входящего XML
        /*
        <pay-request>
        <act>7</act>
        <service_id>ХХХ</service_id>
        <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
        <sign>F454FR43DE32JHSAGDSSFS</sign>
        </pay-request>
        */
   --Пример исходящегоXML
    /*
    Код результата запроса:
        <?xml version="1.0" encoding="UTF-8" ?>
            <pay-response>
                <status_code>11</status_code>
                <time_stamp>27.01.2006 10:27:21</time_stamp>
                <transaction>
                <pay_id> XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id >
                <service_id>XXX</ service_id>
                <amount>10.20</amount>
                <status>111</status>
                <time_stamp>24.01.2006 10:27:21</time_stamp>
                </transaction>
                </pay-response>

                ИЛИ
                <?xml version="1.0" encoding="UTF-8" ?>
                <pay-response>
                <status_code>-10</status_code>
                <time_stamp>27.01.2006 10:27:21</time_stamp>
               </pay-response>
    */


        
            --читаем вх. док. 
   	  	p := dbms_xmlparser.newparser;
	   	  dbms_xmlparser.parseclob(p, p_params);
    		v_Doc := dbms_xmlparser.getdocument(p);
    		v_Child_Nodes := dbms_xmldom.getelementsbytagname(v_Doc, 'pay-request');  
    		v_Child_Node:=dbms_xmldom.item(v_Child_Nodes, 0);
        l_transaction_id:=dbms_xslprocessor.valueof(v_Child_Node, 'pay_id/text()');
             
        begin
            select ir.* into r_ibx_recs from ibx_recs ir
               where ir.type_id='TOMAS'
                 and ir.ext_ref=l_transaction_id;
            exception when no_data_found then
                l_status_code  := -10;
                l_comment:='Транзакцию не найдено';
          end;

     if (l_status_code = 11) then
      begin
        select  o.sos, o.s into l_sos, l_s
          from oper o
         where o.ref=r_ibx_recs.abs_ref ;
      exception
        when no_data_found then
          l_status_code  := -10;
          l_comment:='Транзакцию не найдено';
      end;
    end if;

    --Проверка статуса документа в АБС
    if l_sos=5 then
         l_transaction_code:=111;
    elsif l_sos<0 then
         l_transaction_code:=130;
    else
         l_transaction_code:=120;
    end if;

    bars_audit.info( g_pack||'.'||l_proc||': Запит інформації  по транзакции  ' || l_transaction_id ||
                    '. Код результату обробки - ' || to_char(l_status_code) || ' (' ||
                    l_comment || '). Статус платежа = '||l_transaction_code);

 

       --создаем док. на экспорт
     l_domDoc    := dbms_xmldom.newdomdocument;
     l_root_node := dbms_xmldom.makenode(l_domDoc);
     l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'pay-response')));
     dbms_xmldom.setcharset(l_domDoc, 'UTF-8');
     dbms_xmldom.setVersion(l_domDoc, '1.0" encoding="UTF-8' );
      
     if l_status_code =11 then
      l_head_node0 := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'transaction')));       
      add_txt_node_utl( l_domdoc,l_head_node0,'pay_id',to_char(l_transaction_id));
      add_txt_node_utl( l_domdoc,l_head_node0,'amount',to_char(l_s));
      add_txt_node_utl( l_domdoc,l_head_node0,'status',to_char(l_transaction_code));        
      add_txt_node_utl( l_domdoc,l_head_node,'service_id','TOMAS');                                       
     end if;            
     add_txt_node_utl( l_domdoc,l_head_node,'status_code',l_status_code);            
     add_txt_node_utl( l_domdoc,l_head_node,'time-stamp',to_char(sysdate,'dd.mm.yyyy HH24:MI:SS'));                                
    ---
     dbms_lob.createtemporary(p_result, true, 12);
     dbms_xmldom.writetoclob(l_domdoc, p_result);
     
   --отпускаем объекты ...
    dbms_xmlparser.freeParser(p);
    dbms_xmldom.freeDocument(v_doc);
    dbms_xmldom.freedocument(l_domdoc);      

         bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: l_status_code = ' ||
                     l_xml_text);
                   
 end Pay_7;

---------------------------------------------------------
--Проверка возможности платежа (ACT=1, service_id=TOMAS)
-- 
 procedure Pay_1  (p_params  in clob, -- XML c входящими параметрами
                   p_result  out clob -- XML c результатом выполнения
                   ) is
    l_proc varchar2(30) := 'ibx_pack.Pay_1';
 
  	p dbms_xmlparser.parser;
		v_Doc          dbms_xmldom.domdocument;
    v_Child_Nodes  Dbms_Xmldom.Domnodelist;
    v_Child_Node   Dbms_Xmldom.Domnode;
  
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_head_node    dbms_xmldom.domnode;

    v_pay_account varchar2(25);
    v_min_amount varchar2(20);
    v_max_amount varchar2(20);
    v_comment     varchar2(150);
    v_status_code number;
    v_fio varchar(256);
    v_okpo varchar(10);
    v_nls accounts.nls%TYPE;

 begin
    
  /*
  <?xml version="1.0" encoding="utf-8"?>
<pay-request>
 <act>1</act>
 <service_id>TOMAS</service_id>
 <pay_id>0ea5b445-476d-4626-9fcc-078ebbcfab99</pay_id>
 <sign></sign>
 <pay_account>300465.26308046323475.980</pay_account>
 <trade_point>00000001322669</trade_point>
</pay-request>

---- response
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
    <balance />
    <name>Клієнт RNK=93786401</name>
    <account>26250500937864</account>
    <okpo>3838103412</okpo>
    <service_id>TOMAS</service_id>
    <abonplata />
    <min_amount>100</min_amount>
    <max_amount>14999900</max_amount>
    <parameters>Платіж можливий</parameters>
    <status_code>21</status_code>
    <time_stamp>06.04.2018 11:08:10</time_stamp>
</pay-response>

error
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
    <parameters>Рахунок 300465.26250500937865.980 не знайдено</parameters>
    <status_code>-40</status_code>
    <time_stamp>06.04.2018 12:06:34</time_stamp>
</pay-response>

  */
    --читаем вх. док. 
		p := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(p, p_params);
		v_Doc := dbms_xmlparser.getdocument(p);
		v_Child_Nodes := dbms_xmldom.getelementsbytagname(v_Doc, 'pay-request');
		v_Child_Node:=dbms_xmldom.item(v_Child_Nodes, 0);   
    v_pay_account:=dbms_xslprocessor.valueof(v_Child_Node, 'pay_account/text()');


 -----обрабатываем в info_common 
    ibx_pack.info_common(p_pay_account=> v_pay_account
    ,p_min_amount  => v_min_amount
    ,p_max_amount  => v_max_amount
    ,p_comment     => v_comment
    ,p_status_code => v_status_code
    ,p_fio =>v_fio 
    ,p_nls =>v_nls 
    ,p_okpo =>v_okpo);   
    --создаем док. на экспорт
    l_domDoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domDoc);
    l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'pay-response')));
    dbms_xmldom.setcharset(l_domDoc, 'UTF-8');
    dbms_xmldom.setVersion(l_domDoc, '1.0" encoding="UTF-8' );
   if v_status_code=21 then

    add_txt_node_utl( l_domdoc,l_head_node,'balance',null);
    add_txt_node_utl( l_domdoc,l_head_node,'name',v_fio);
    add_txt_node_utl( l_domdoc,l_head_node,'account',v_nls);
    add_txt_node_utl( l_domdoc,l_head_node,'okpo',v_okpo);        
    add_txt_node_utl( l_domdoc,l_head_node,'abonplata',null);            
    add_txt_node_utl( l_domdoc,l_head_node,'min_amount',v_min_amount);            
    add_txt_node_utl( l_domdoc,l_head_node,'max_amount',v_max_amount); 
   end if;            
    add_txt_node_utl( l_domdoc,l_head_node,'parameters',v_comment);            
    add_txt_node_utl( l_domdoc,l_head_node,'status_code',v_status_code);            
    add_txt_node_utl( l_domdoc,l_head_node,'service_id','TOMAS');                                
    add_txt_node_utl( l_domdoc,l_head_node,'time-stamp',to_char(sysdate,'dd.mm.yyyy HH24:MI:SS'));                                
    ---
    dbms_lob.createtemporary(p_result, true, 12);
    dbms_xmldom.writetoclob(l_domdoc, p_result);
  
   --отпускаем объекты ...    
    dbms_xmlparser.freeParser(p);
    dbms_xmldom.freeDocument(v_doc);
    dbms_xmldom.freedocument(l_domdoc);    

  end Pay_1;         
 
 
-------------------------------------------------------------------------
--Платеж на свободные реквезиты (ACT=10, service_id=TOMAS2)
-- 
  procedure Pay_10 (   p_params  in clob, -- XML c входящими параметрами
                       p_result  out clob -- XML c результатом выполнения  
                    ) is
   l_proc varchar2(30) := 'ibx_pack.Pay_10';                    
   p dbms_xmlparser.parser;
	 v_Doc    dbms_xmldom.domdocument;
   v_Emp_Nodes    Dbms_Xmldom.Domnodelist;
   v_Child_Nodes  Dbms_Xmldom.Domnodelist;
   v_Child_Node   Dbms_Xmldom.Domnode;
   v_Emp_Node     Dbms_Xmldom.Domnode;
   v_Text_Node    Dbms_Xmldom.Domnode;
   
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_head_node    dbms_xmldom.domnode;     
    l_head_node1   dbms_xmldom.domnode;
    l_head_node0   dbms_xmldom.domnode;
    v_Node_Name      Varchar2(50);
    v_Node_Value     Varchar2(250);
                    
    v_trade_point  varchar2(26);--код терминала +МФО его
    v_payer_name  varchar2(100);--наименование плательщика
    v_receiver_okpo  integer(10);--код получателя
    v_receiver_name  varchar2(100);--наименование получателя
    v_payment_purpose  varchar2(160);--призначення платежу
    v_ref        oper.ref%type;
    v_pay_amount   number(32);
    v_fee_amount   number(32);
    v_pay_id       varchar2(300);
    v_receipt_num  varchar2(220);                    
    v_pay_account varchar2(25); 
    v_cash_symbol varchar2(3);
    v_status_code number;
    v_comment varchar2(160);
  begin
    
       /* 
         <pay-request>
          <act>10</act>
          <service_id>TOMAS2</service_id>
          <trade_point>TERMIDSSTMFO</trade_point>
          <payer_name>XXXXXXXXXXXXXXX</payer_name>
          <pay_account>MFO.ACCOUNT.980</pay_account>
          <okpo>NNNNNN</okpo>
          <receiver_name>XXXXXXXXXXXXXX</receiver_name>
          <cash_symbol>NN</cash_symbol>
          <payment_purpose>XXXXXXXXXXXXXXXXXXXXXX</payment_purpose>
          <transactions>
            <transaction>
              <receipt_num>NNNNNNNNN</receipt_num>
              <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
              <pay_amount>XX.XX</pay_amount>
              <fee_amount>XX.XX</fee_amount>     
            </transaction>
            [...
            <transaction>
              <receipt_num>NNNNNNNNN</receipt_num>
              <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
              <pay_amount>XX.XX</pay_amount>
              <fee_amount>XX.XX</fee_amount>
            </transaction>
            ...]
           </transactions>
          <payment_params>
            <parameter>
              <name/>
              <value/>
            </parameter>
          </payment_params>
          <sign>VEGA.SIGN</sign>
        </pay-request>

       Код результата запроса:

            1. Успешный запрос:
           <?xml version="1.0" encoding="utf-8"?>
            <pay-response>
                <transactions>
                    <transaction>
                        <pay_id>XXXX-XXXXXXXXX-XXXX</pay_id>
                        <ref>XXXXXXXXX</ref>
                        <status_code>22</status_code>
                    </transaction>
                    <transaction>
                        <pay_id>XXXX-XXXXXXXXX-XXXX</pay_id>
                        <ref>XXXXXXXXX</ref>
                        <status_code>22</status_code>
                    </transaction>
                </transactions>
                <service_id>TOMAS2</service_id>
                <time_stamp>22.09.2017 17:28:32</time_stamp>
            </pay-response>
          
           2. Ошибка при выполнении процедуры - не прошла ни одна операция:

                    <?xml version="1.0" encoding="utf-8"?>
                    <pay-response>
                        <service_id>TOMAS2</service_id>
                        <description>XXXXX</description>
                        <status_code>-100</status_code>    - в случае неправильной структуры xml в части транзакции - "-104"
                        <time_stamp>22.09.2017 17:24:21</time_stamp>
                    </pay-response>

         */  
       --создаем парсер и документ
     p := Dbms_Xmlparser.Newparser;
     Dbms_Xmlparser.Setvalidationmode(p,False);
     dbms_xmlparser.parseclob(p,p_params);
     v_Doc := Dbms_Xmlparser.Getdocument(p);  
     v_Child_Nodes:=dbms_xmldom.getelementsbytagname(v_Doc, 'pay-request');
     v_Child_Node :=dbms_xmldom.item(v_Child_Nodes, 0);
     v_pay_account:=dbms_xslprocessor.valueof(v_Child_Node,    'pay_account/text()');
     v_trade_point:=dbms_xslprocessor.valueof(v_Child_Node,    'trade_point/text()');   
     v_payer_name :=dbms_xslprocessor.valueof(v_Child_Node,    'payer_name/text()');     
     v_receiver_okpo:=dbms_xslprocessor.valueof(v_Child_Node,  'okpo/text()');     
     v_receiver_name:=dbms_xslprocessor.valueof(v_Child_Node,  'receiver_name/text()');               
     v_cash_symbol  :=dbms_xslprocessor.valueof(v_Child_Node,  'cash_symbol/text()');     
     v_payment_purpose:=dbms_xslprocessor.valueof(v_Child_Node,'payment_purpose/text()');                  
   --

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'pay-response')));
    l_head_node0:= dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'transactions')));
    dbms_xmldom.setcharset(l_domDoc, 'UTF-8');
    dbms_xmldom.setVersion(l_domDoc, '1.0" encoding="UTF-8' );

   --       
   -- читаем блок transactions -----    
   v_Emp_Nodes := Dbms_Xmldom.Getelementsbytagname(v_doc ,'transaction');
   For j In 0 .. Dbms_Xmldom.Getlength(v_Emp_Nodes)-1 Loop
      v_Emp_Node := Dbms_Xmldom.Item(v_Emp_Nodes ,j);
      v_Child_Nodes := Dbms_Xmldom.Getchildnodes(v_Emp_Node);
      --
      For i In 0 .. Dbms_Xmldom.Getlength(v_Child_Nodes) -1 Loop
         v_Child_Node := Dbms_Xmldom.Item(v_Child_Nodes ,i);
         v_Node_Name  := Dbms_Xmldom.Getnodename(v_Child_Node);
         v_Text_Node  := Dbms_Xmldom.Getfirstchild(v_Child_Node);
         v_Node_Value := Dbms_Xmldom.Getnodevalue(v_Text_Node);
         --                
        If       
               v_Node_Name = 'receipt_num' Then v_receipt_num:= v_Node_Value;
         Elsif v_Node_Name = 'pay_id'      Then v_pay_id     := v_Node_Value;
         Elsif v_Node_Name = 'pay_amount'  Then v_pay_amount := v_Node_Value;
         Elsif v_Node_Name = 'fee_amount'  Then v_fee_amount := v_Node_Value;  
        End If;
      End Loop;  
      -----------------------действие над  блоком transaction
      pay_common         (p_trade_point=>v_trade_point,    --код терминала +МФО его
                          p_payer_name =>v_payer_name,     --наименование плательщика
                          p_pay_account=>v_pay_account,    -- мфо.счет.валюта получателя  
                          p_receiver_okpo=>v_receiver_okpo,--код получателя
                          p_receiver_name=>v_receiver_name,--наименование получателя
                          p_cash_symb =>v_cash_symbol,     --касовий символ
                          p_payment_purpose=>v_payment_purpose, --призначення платежу
                          p_res_code =>v_status_code,      --код ответа 
                          p_res_text=>v_comment ,          --текст ответа                        
                          p_receipt_num =>v_receipt_num,   --номер чека
                          p_pay_id =>v_pay_id ,            --пай его ид
                          p_pay_amount => v_pay_amount,    --сумма платежа 
                          p_fee_amount => v_fee_amount,    --сумма комиссии                          
                          p_ref =>v_ref 
                          ) ;
      l_head_node1 := dbms_xmldom.appendchild(l_head_node0, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,'transaction')));
   if v_status_code in (22,102) then 
     add_txt_node_utl( l_domdoc,l_head_node1,'pay_id',v_pay_id);
     add_txt_node_utl( l_domdoc,l_head_node1,'ref',v_ref);
     add_txt_node_utl( l_domdoc,l_head_node1,'status_code','22');                      
   else 
     add_txt_node_utl( l_domdoc,l_head_node1,'pay_id',v_pay_id);
     add_txt_node_utl( l_domdoc,l_head_node1,'ref',v_ref);
     add_txt_node_utl( l_domdoc,l_head_node1,'status_code',to_char(v_status_code));                      
     add_txt_node_utl( l_domdoc,l_head_node1,'description',v_comment);
   end if;     
   end loop; 
      add_txt_node_utl( l_domdoc,l_head_node,'service_id','TOMAS2');
      add_txt_node_utl( l_domdoc,l_head_node,'time_stamp',to_char(sysdate,'dd.mm.yyyy HH24:MI:SS'));                                          
      dbms_lob.createtemporary(p_result, true, 12);
      dbms_xmldom.writetoclob(l_domdoc, p_result);

   --отпускаем объекты ...
    dbms_xmlparser.freeParser(p);
    dbms_xmldom.freeDocument(v_doc);
    dbms_xmldom.freedocument(l_domdoc);                         
      
  end;                     
------------------------------------------------------------------------
--Пакетный платеж на счет (ACT=20, service_id=TOMAS3)
-- 
  procedure Pay_20 (   p_params  in clob, -- XML c входящими параметрами
                       p_result  out clob -- XML c результатом выполнения  
                       ) is
   l_proc varchar2(30) := 'ibx_pack.Pay_20';
   -- для парсера
   p              Dbms_Xmlparser.Parser;
   v_Doc          Dbms_Xmldom.Domdocument;
   v_Child_Nodes  Dbms_Xmldom.Domnodelist;
   v_Child_Node   Dbms_Xmldom.Domnode;
   v_Text_Node    Dbms_Xmldom.Domnode;
   v_Emp_Nodes    Dbms_Xmldom.Domnodelist;
   v_Emp_Node     Dbms_Xmldom.Domnode;
   
   l_domdoc       dbms_xmldom.domdocument;
   l_root_node    dbms_xmldom.domnode;
   l_head_node    dbms_xmldom.domnode;   
   l_head_node0   dbms_xmldom.domnode;   
   l_head_node1   dbms_xmldom.domnode;   
      
   v_Node_Name      Varchar2(50);
   v_Node_Value     Varchar2(250);
   --
   v_payer_name     varchar2(100); --Назва отримувача 
   v_pay_account   varchar2(25);   --Мфо банку отримувача, номер рахунку отримувача
   v_receiver_okpo  varchar2(10);           --код отримувача 
   v_receiver_name varchar2(100);  --Назва отримувача
   v_cash_symbol varchar2(5);      --касовий символ
   v_payment_purpose varchar2(200);--Призначення платежу
   v_receipt_num varchar2(25);     --Номер чека який видається клієнту
   v_pay_id varchar2(100);         --Унікальний ідентифікатор транзакції  системи ToMaS
--   v_pay_id_main varchar2(100);    --Унікальний ідентифікатор операції внесення коштів по реєстру в системі ToMaS
   v_pay_amount number(32);        --Сума платежу по реєстру за вирахуванням комісії, якщо комісія з отримувача
   v_fee_amount number(32);        --Сума комісії за платіж 
   v_trade_point varchar2(20);     --Номер терміналу + МФО
--   v_amount varchar2(20);          --Сума внесених коштів в термінал під час операції
--   v_record varchar2(20);          --Згенерований системою код реєстру по якому виконувалося поповнення.
   v_status_code number;
   v_comment varchar2(160);
   v_ref oper.ref%TYPE;
    --
   

  begin
/* 

<?xml version="1.0" encoding="utf-8"?>
<pay-request>
  <act>20</act>
  <service_id>TOMAS3</service_id>
  <trade_point>TERMIDSSTMFO</trade_point>
  <main_transaction>
      <receipt_num>NNNNNNNNN</receipt_num>
      <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
      <amount>XXXX</amount
	<record>NNNNN</record>
  </main_transaction>
  <transactions>
    <transaction>
      <payer_name>XXXXXXXXXXXXXXX</payer_name>
      <pay_account>MFO.ACCOUNT.980</pay_account>
      <okpo>NNNNNN</okpo>
      <receiver_name>XXXXXXXXXXXXXX</receiver_name>
      <cash_symbol>NN</cash_symbol>
      <payment_purpose>XXXXXXXXXXXXXXXXXXXXXX</payment_purpose>
      <receipt_num>NNNNNNNNN</receipt_num>
      <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
      <pay_amount>XXXX</pay_amount>
      <fee_amount>XXXX</fee_amount>
    </transaction>
    <transaction>
      <payer_name>XXXXXXXXXXXXXXX</payer_name>
      <pay_account>MFO.ACCOUNT.980</pay_account>
      <okpo>NNNNNN</okpo>
      <receiver_name>XXXXXXXXXXXXXX</receiver_name>
      <cash_symbol>NN</cash_symbol>
      <payment_purpose>XXXXXXXXXXXXXXXXXXXXXX</payment_purpose>
      <receipt_num>NNNNNNNNN</receipt_num>
      <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
      <pay_amount>XXXX</pay_amount>
      <fee_amount>XXXX</fee_amount>
    </transaction>
  </transactions>
  <sign>VEGA.SIGN</sign>
</pay-request>



response
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
  <transactions>
    <transaction>
      <pay_id>XXXX-XXXXXXXXX-XXXX</pay_id>
      <ref>XXXXXXXXX</ref>
      <status_code>22</status_code>
    </transaction>
    <transaction>
      <pay_id>XXXX-XXXXXXXXX-XXXX</pay_id>
      <ref>XXXXXXXXX</ref>
      <status_code>22</status_code>
    </transaction>
  </transactions>
  <service_id>TOMAS3</service_id>
  <time_stamp>XXXXXX</time_stamp>
</pay-response>

ошибка : 
<?xml version="1.0" encoding="utf-8"?>
<pay-response>
  <service_id>TOMAS3</service_id>
  <description>XXXXX</description>
  <status_code>-100</status_code>
  <time_stamp>ХХХХХХХХХХХХХХ</time_stamp>
</pay-response>


*/     

     --создаем парсер и документ
     p := Dbms_Xmlparser.Newparser;
     Dbms_Xmlparser.Setvalidationmode(p,False);
     dbms_xmlparser.parseclob(p,p_params);
     v_Doc := Dbms_Xmlparser.Getdocument(p);

        --создаем док. на экспорт
     l_domDoc    := dbms_xmldom.newdomdocument;
     l_root_node := dbms_xmldom.makenode(l_domDoc);
     l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'pay-response')));
     l_head_node0 := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'transactions')));
     dbms_xmldom.setcharset(l_domDoc, 'UTF-8');
     dbms_xmldom.setVersion(l_domDoc, '1.0" encoding="UTF-8' );


     --читаем номер терминала (trade_point)
		 v_Emp_Nodes := dbms_xmldom.getelementsbytagname(v_doc, 'pay-request');
		 v_Emp_Node := dbms_xmldom.item(v_Emp_Nodes, 0);
     v_trade_point := dbms_xslprocessor.valueof(v_Emp_Node, 'trade_point/text()');
         
     --читаем данные главной транзакции -- для истории
		 v_Emp_Nodes := dbms_xmldom.getelementsbytagname(v_doc, 'main_transaction');
		 v_Emp_Node := dbms_xmldom.item(v_Emp_Nodes, 0);
     v_receipt_num := dbms_xslprocessor.valueof(v_Emp_Node, 'receipt_num/text()');
--     v_pay_id_main := dbms_xslprocessor.valueof(v_Emp_Node, 'pay_id/text()');
--     v_amount := dbms_xslprocessor.valueof(v_Emp_Node, 'amount/text()');     
--     v_record := dbms_xslprocessor.valueof(v_Emp_Node, 'record/text()');
     -- читаем блок transactions -----    
     v_Emp_Nodes := Dbms_Xmldom.Getelementsbytagname(v_doc ,'transaction');
     For j In 0 .. Dbms_Xmldom.Getlength(v_Emp_Nodes)-1 Loop
      v_Emp_Node := Dbms_Xmldom.Item(v_Emp_Nodes ,j);
      v_Child_Nodes := Dbms_Xmldom.Getchildnodes(v_Emp_Node);
      --
      For i In 0 .. Dbms_Xmldom.Getlength(v_Child_Nodes) -1 Loop
         v_Child_Node := Dbms_Xmldom.Item(v_Child_Nodes ,i);
         v_Node_Name  := Dbms_Xmldom.Getnodename(v_Child_Node);
         v_Text_Node  := Dbms_Xmldom.Getfirstchild(v_Child_Node);
         v_Node_Value := Dbms_Xmldom.Getnodevalue(v_Text_Node);
         --
        If       
               v_Node_Name = 'payer_name'     Then v_payer_name  := v_Node_Value;
         Elsif v_Node_Name = 'pay_account'    Then v_pay_account := v_Node_Value;
         Elsif v_Node_Name = 'okpo'           Then v_receiver_okpo := v_Node_Value;
         Elsif v_Node_Name = 'receiver_name'  Then v_receiver_name := v_Node_Value;
         Elsif v_Node_Name = 'cash_symbol'    Then v_cash_symbol   := v_Node_Value;
         Elsif v_Node_Name = 'payment_purpose'Then v_payment_purpose := v_Node_Value;
         Elsif v_Node_Name = 'receipt_num'    Then v_receipt_num := v_Node_Value;
         Elsif v_Node_Name = 'pay_id'         Then v_pay_id      := v_Node_Value;
         Elsif v_Node_Name = 'pay_amount'     Then v_pay_amount  := to_number(v_Node_Value);
         Elsif v_Node_Name = 'fee_amount'     Then v_fee_amount  := to_number(v_Node_Value);
    
        End If;
      End Loop;
      
       --действие с данными 
       
          pay_common     (p_trade_point=>v_trade_point,    --код терминала +МФО его
                          p_payer_name =>v_payer_name,     --наименование плательщика
                          p_pay_account=>v_pay_account,    -- мфо.счет.валюта получателя  
                          p_receiver_okpo=>v_receiver_okpo,--код получателя
                          p_receiver_name=>v_receiver_name,--наименование получателя
                          p_cash_symb =>v_cash_symbol,     --касовий символ
                          p_payment_purpose=>v_payment_purpose, --призначення платежу
                          p_res_code =>v_status_code,      --код ответа 
                          p_res_text=>v_comment ,          --текст ответа                        
                          p_receipt_num =>v_receipt_num,   --номер чека
                          p_pay_id =>v_pay_id ,            --пай его ид
                          p_pay_amount => v_pay_amount,    --сумма платежа 
                          p_fee_amount => v_fee_amount,    --сумма комиссии                          
                          p_ref =>v_ref 
                          ) ;

      l_head_node1 := dbms_xmldom.appendchild(l_head_node0, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,'transaction')));

   if v_status_code in (22,102) then 
     add_txt_node_utl( l_domdoc,l_head_node1,'pay_id',v_pay_id);
     add_txt_node_utl( l_domdoc,l_head_node1,'ref',v_ref);
     add_txt_node_utl( l_domdoc,l_head_node1,'status_code','22');                      
   else 
     add_txt_node_utl( l_domdoc,l_head_node1,'pay_id',v_pay_id);
     add_txt_node_utl( l_domdoc,l_head_node1,'ref',v_ref);
     add_txt_node_utl( l_domdoc,l_head_node1,'status_code',to_char(v_status_code));                      
     add_txt_node_utl( l_domdoc,l_head_node1,'description',v_comment);
   end if;     

   End Loop;
     add_txt_node_utl( l_domdoc,l_head_node,'service_id','TOMAS3');
     add_txt_node_utl( l_domdoc,l_head_node,'time_stamp',to_char(sysdate,'dd.mm.yyyy HH24:MI:SS'));     


     dbms_lob.createtemporary(p_result, true, 12);
     dbms_xmldom.writetoclob(l_domdoc, p_result);
     
   --отпускаем объекты ...
    dbms_xmlparser.freeParser(p);
    dbms_xmldom.freeDocument(v_doc);
    dbms_xmldom.freedocument(l_domdoc);  
  end Pay_20;
  
  --общая процедура проверки возможности платежа(платежей)
  procedure info_common  (p_pay_account in varchar2,
                          p_min_amount out varchar2,
                          p_max_amount out varchar2,
                          p_comment    out varchar2,
                          p_status_code out number,
                          p_fio out  varchar2,
                          p_nls out varchar2,
                          p_okpo out customer.okpo%TYPE) 
  is
   v_kf  accounts.kf%TYPE; --МФО
   v_kv  accounts.kv%TYPE;  --валюта
   v_close_date accounts.dazs%TYPE; --дата закриття рах. отримувача  
   v_rezid number; --признак резидента
  begin 
    p_status_code:=21;
    p_comment:='Платіж можливий';    
    pay_account_attr (p_pay_account,v_kf,p_nls,v_kv); -- разбор входящей строки МФО.СЧЕТ.ВАЛЮТА 

      begin --проверка на существование счета
        select c.nmk as fio,
               a.dazs as close_date,
               c.okpo
          into p_fio,
               v_close_date,
               p_okpo
          from accounts a, customer c
         where a.nls = p_nls
           and a.rnk = c.rnk
           and a.kv = v_kv
           and a.kf = v_kf;
       exception
        when others then
          p_status_code  := -40;
          p_comment := 'Рахунок ' || p_pay_account || ' не знайдено';
      end;

    -- проверка счета на закрытость
    if (p_status_code = 21) then
      if (v_close_date is not null) then
        p_status_code  := -41;
        p_comment := 'Прийом платежів для даного клієнта неможливо, рахунок '|| p_pay_account ||' закрито';
      end if;
    end if;
    -- проверка клиента на нерезидента
    if (p_status_code = 21) then
      select cc.rezid
      into v_rezid   --(1-резидент, 2-не резидент)
      from  CODCAGENT cc
      where cc.codcagent=(
      select c.codcagent from accounts a, customer c
      where a.nls = p_nls
           and a.rnk = c.rnk
           and a.kv = v_kv
           and a.kf = v_kf
                          );
      if (v_rezid<>1) then
       p_status_code  := -41;
       p_comment := 'Прийом платежів для даного клієнта неможливий (нерез.)';
      end if;
    end if;
    --достаем лимиты по платежам
    begin
     if (p_status_code = 21) then
       get_limits_pay( p_nls =>p_nls,
                       p_kf =>v_kf,
                       p_kv =>v_kv ,
                       p_min_amount =>p_min_amount,
                       p_max_amount =>p_max_amount);
     end if;
    exception
        when no_data_found then
         p_status_code  := -41;
         p_comment := 'Ліміт по рахунку ' || p_nls || ' не знайдено';
    end;


  end info_common;

----------------------------------------------------------
---1-for-ALL--разделение по процедурам в зависимости от АСТ и сервиса 
  procedure ExchangeData (
                       p_params  in clob, -- XML c входящими параметрами
                       p_result  out clob -- XML c результатом выполнения  
                       ) is
  -- для парсера
   p              Dbms_Xmlparser.Parser;
   v_Doc          Dbms_Xmldom.Domdocument;
   v_Emp_Nodes    Dbms_Xmldom.Domnodelist;
   v_Emp_Node     Dbms_Xmldom.Domnode;
   --                          
   v_act number; 
   v_service_id varchar(20);
   v_sql_exp varchar(100);
   l_proc varchar2(50):='ibx_pack.exchangedata.';
--------------   
  begin  
    /* error
    <?xml version="1.0" encoding="utf-8"?>
<pay-response>
    <description>ERR(Проблеми з системою) </description>
    <status_code>5</status_code>
    <service_id>TOMAS</service_id>
    <time-stamp>16.05.2018 17:00:05</time-stamp>
</pay-response>    
    */
   --создаем парсер и документ
   p := Dbms_Xmlparser.Newparser;
   Dbms_Xmlparser.Setvalidationmode(p,False);
   dbms_xmlparser.parseclob(p, p_params);
   v_Doc := Dbms_Xmlparser.Getdocument(p);

   --читаем номер операции (ACT) и service_id
 	 v_Emp_Nodes := dbms_xmldom.getelementsbytagname(v_doc, 'pay-request');
	 v_Emp_Node  := dbms_xmldom.item(v_Emp_Nodes, 0);
   v_act       := to_number(dbms_xslprocessor.valueof(v_Emp_Node, 'act/text()'));
   v_service_id:=dbms_xslprocessor.valueof(v_Emp_Node, 'service_id/text()');

   -- по act  определяем, чем обрабатывать   
   begin
--   if v_act in (1,4,7,10,20,30) then
     v_sql_exp:='begin ibx_pack.Pay_'||v_act||'(:p_params ,:v_xml_text);end;';
     execute immediate v_sql_exp  using p_params, out p_result;
   exception when others then 
     Logger.info('ibx_pack.exchangedata: ERROR!:'||sqlerrm);
     p_result:='<pay-response>';
     p_result:=p_result||'<description>ERR(Проблеми з системою)</description>';
     p_result:=p_result||'<status_code>5</status_code>';
     p_result:=p_result||'<service_id>'||v_service_id||'</service_id>';
     p_result:=p_result||'<time-stamp>'||to_char(sysdate,'dd.mm.yyyy HH24:MI:SS')||'</time-stamp>';                                
     p_result:=p_result||'</pay-response>';
--    end if;  
   end;   
   --отпускаем объекты ...
   dbms_xmlparser.freeParser(p);
   dbms_xmldom.freeDocument(v_doc);
  end ExchangeData;                     
------------------------- 
  
------------------------------------
end ibx_pack;
/
 show err;
 
PROMPT *** Create  grants  IBX_PACK ***
grant EXECUTE                                                                on IBX_PACK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ibx_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
