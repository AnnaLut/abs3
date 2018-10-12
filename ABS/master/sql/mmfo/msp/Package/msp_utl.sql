PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/package/msp_utl.sql =========*** Run *** 
PROMPT ===================================================================================== 
 
create or replace package msp.msp_utl is

  gc_header_version constant varchar2(64)  := 'version 1.33 16.08.2018';

  -- тип для роботи з масивом файлів архіву
  type r_file_array is record (
    file_name    varchar2(50),
    file_buff    blob
    );
  type t_file_array is table of r_file_array;

  -- тип для роботи з масивом файлів квитанцій
  type r_match_array is record (
    id     msp_envelopes.id%type,
    bvalue blob
    );
  type t_match_array is table of r_match_array;

  -----------------------------------------------------------------------------------------
  --  add_text_node_utl
  --
  --    Функція добавляє тег в xml документ, і повертає його екземпляр dbms_xmldom.DOMNode
  --
  function add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2) return dbms_xmldom.DOMNode;

  -----------------------------------------------------------------------------------------
  --  add_txt_node_utl
  --
  --    Метод добавляє тег в xml документ
  --
  procedure add_txt_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2);

  -----------------------------------------------------------------------------------------
  --  add_clob_node_utl
  --
  --    Функція добавляє тег формату clob в xml документ, і повертає його екземпляр dbms_xmldom.DOMNode
  --
  function add_clob_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob) return dbms_xmldom.DOMNode;

  -----------------------------------------------------------------------------------------
  --  add_clb_node_utl
  --
  --    Метод добавляє тег формату clob в xml документ
  --
  procedure add_clb_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob);

  -----------------------------------------------------------------------------------------
  --  header_version
  --
  --    Версія заголовка пакету
  --
  function header_version return varchar2;

  -----------------------------------------------------------------------------------------
  --  body_version
  --
  --    Версія тіла пакету
  --
  function body_version return varchar2;

  -----------------------------------------------------------------------------------------
  --  replace_ukrsmb2dos
  --
  --    Заміна укр символів для cp OEM 866
  --
  function replace_ukrsmb2dos(l_txt clob) return clob;

  -----------------------------------------------------------------------------------------
  --  set_state
  --
  --    Оновлення стану запиту/конверта
  --
  --      p_id    - id запиту / конвертв
  --      p_state - новий стан запиту / конвертв
  --      p_comm  - коментар
  --      p_obj   - 0 - request (запит), 1 - envelope (конверт)
  --
  procedure set_state (p_id in number, p_state in number, p_comm in varchar2, p_obj in number);

  -----------------------------------------------------------------------------------------
  --  set_file_state
  --
  --    Оновлення стану файла
  --
  --      p_file_id       - id файлу
  --      p_state_id      - id стану
  --      p_comment       - коментар
  --      p_send_pay_date - дата відправки файла на оплату
  --
  procedure set_file_state(p_file_id  in msp_files.id%type,
                           p_state_id in msp_files.state_id%type,
                           p_comment  in msp_files.comm%type default null,
                           p_send_pay_date in msp_files.send_pay_date%type default null);

  -----------------------------------------------------------------------------------------
  --  create_parsing_file
  --
  --    Парсинг і запис табличних даних файлів (точка входу в методі parse_files)
  --
  --      p_envelope_file_id - id конверта
  --      p_id_file          - id реєстра
  --
  procedure create_parsing_file(p_envelope_file_id in msp_envelope_files_info.id%type,
                                p_id_file          in msp_envelope_files_info.id_file%type);

  -----------------------------------------------------------------------------------------
  --  make_matching
  --
  --    Функція формує та повертає ZIP архів квитанції 1/2
  --
  --      p_envelope_id - id конверту
  --      p_matching_tp - тип квитанції (1/2)
  --      p_is_convert2dos - ознака 1 - конвертувати в cp866 / 0 - ні
  --
  function make_matching(p_envelope_id    in msp_envelopes.id%type,
                         p_matching_tp    in simple_integer default 1,
                         p_is_convert2dos in simple_integer default 1
                         ) return blob;

  -----------------------------------------------------------------------------------------
  --  get_matching2sign
  --
  --    Функція формує та повертає таблицю яка містить в полях ZIP архів квитанції 1/2
  --    Використовується у view, які підхватує TOSS для підписання і шифрування: 
  --    v_msp_sign_file        - Список квитанцій конвертів на формування підпису
  --    v_msp_encrypt_envelope - Список квитанцій конвертів на шифрування
  --
  --      p_stage          - етап   - 1 - підписання файлу, 2 - шифрування файлу
  --      p_is_convert2dos - ознака - 1 - конвертувати в cp866 / 0 - ні
  --
  function get_matching2sign(p_stage          in simple_integer,
                             p_is_convert2dos in simple_integer default 1) return t_match_array pipelined;

  -----------------------------------------------------------------------------------------
  --  save_matching
  --
  --    Процедура зберігає зашифрований архів квитанції 1/2. Точка входу: TOSS 
  --
  --      p_envelope_id - id конверту
  --      p_file_buff   - clob буфер файлу
  --      p_ecp         - використовується у випадку накладання ЕЦП 2 на готовий файл до відправки
  --
  procedure save_matching(p_envelope_id in msp_envelopes.id%type,
                          p_file_buff   in clob,
                          p_ecp         in clob default null);

  -----------------------------------------------------------------------------------------
  --  set_match_processing
  --
  --    Установка стану "Квитанція 1/2 в процесі формування" для конверту
  --
  --      p_envelope_id - id конверта
  --      p_matching_tp - тип квитанції - 1/2
  --
  procedure set_match_processing(p_envelope_id in msp_envelopes.id%type,
                                 p_matching_tp in simple_integer);

  -----------------------------------------------------------------------------------------
  --  set_match_processing
  --
  --    Установка стану "Квитанція 2 в процесі формування" для конверту - перегружений метод - Точка входу із веба
  --    
  --      p_payment_type   - тип оплати    (атрибут v_msp_envelopes_match2.payment_type - динамічно оприділяється із назви файлу)
  --      p_payment_period - період оплати (атрибут v_msp_envelopes_match2.payment_period - динамічно оприділяється із назви файлу)
  --
  procedure set_match_processing(p_payment_type   in v_msp_envelopes_match2.payment_type%type,
                                 p_payment_period in v_msp_envelopes_match2.payment_period%type);

  -----------------------------------------------------------------------------------------
  --  process_file
  --
  --    Парсинг та валідація нових файлів. Метод періодично запускається в джобі msp.parse_files
  --
  procedure process_files;

  -----------------------------------------------------------------------------------------
  --  encode_data
  --
  --    Метод приймає на вхід та повертає шифрований вміст файла запиту конверта
  --
  --      p_data - вміст файла запиту конверта
  --
  procedure encode_data(p_data in out nocopy clob);

  -----------------------------------------------------------------------------------------
  --  decode_data
  --
  --    Метод приймає на вхід та повертає розшифрований вміст файла запиту конверта
  --
  --      p_data - вміст файла запиту конверта
  --
  procedure decode_data(p_data in out nocopy clob);

  -----------------------------------------------------------------------------------------
  -- перекодування clob із utf8 в базове кодування
  --
  function utf8todeflang(p_clob in clob) return clob;

  -----------------------------------------------------------------------------------------
  --  set_file_record2pay
  --
  --    Включення інформаційного рядка в оплату
  --
  --      p_file_record_id - id інформаційного рядка, що включається в оплату
  --
  procedure set_file_record2pay(p_file_record_id in msp_file_records.id%type);

  -----------------------------------------------------------------------------------------
  --  set_file_record_payed
  --
  --    Оновлення статуса інформаційного рядка файла на сплачено
  --
  --      p_file_record_id  - id інформаційного рядка файла
  --      p_payed_date      - дата оплати
  --
  procedure set_file_record_payed(p_file_record_id in msp_file_records.id%type,
                                  p_payed_date in date);

  -----------------------------------------------------------------------------------------
  --  set_file_record_error
  --
  --    Оновлення статуса інформаційного рядка файла на повернуто в МСП
  --
  --      p_file_record_id - id інформаційного рядка, що повертається в МСП
  --
  procedure set_file_record_error(p_file_record_id in msp_file_records.id%type);

  -----------------------------------------------------------------------------------------
  --  set_file_for_pay
  --
  --    Передати реєстр на оплату
  --
  --      p_file_id - id реєстра, що передається на оплату
  --
  procedure set_file_for_pay(p_file_id in msp_files.id%type);

  -----------------------------------------------------------------------------------------
  --  set_file_record_blocked
  --
  --    Виключити інформаційний рядок з оплати
  --
  --      p_file_record_id - id інформаційного рядка, що блокується
  --      p_comment        - коментар користувача
  --      p_block_type_id  - тип блокування
  --
  procedure set_file_record_blocked(p_file_record_id in msp_file_records.id%type,
                                    p_comment        in msp_file_records.comm%type,
                                    p_block_type_id  in msp_file_records.block_type_id%type);

  -----------------------------------------------------------------------------------------
  --  create_request
  --
  --    Процедура записує запит в базу даних і формує відповідь
  --    TOSS розшифровує запит і визиває метод і отримує відповідь p_xml
  --
  --      p_req_xml  - xml запит
  --      p_act_type - тип запиту
  --      p_xml      - відповідь на запит
  --
  procedure create_request(p_req_xml  in clob,
                           p_act_type in number,
                           p_xml      out clob);

  -----------------------------------------------------------------------------------------
  --  prepare_check_state
  --
  --    підготовка запиту для РУ-шок на перевірку станів оплати референсів по ЕБП (точка входу job msp.get_check_state)
  --
  procedure prepare_check_state;

  -----------------------------------------------------------------------------------------
  --  prepare_get_rest_request
  --
  --    підготовка запиту на перевірку станів оплати референсів по ЕБП (використовується на вебі, навішено на кнопку)
  --
  --      p_acc    - рахунок 2909
  --      p_fileid - id реєстра
  --      p_kf     - відділення
  --
  procedure prepare_get_rest_request(p_acc    in msp_acc_trans_2909.acc_num%type,
                                     p_fileid in msp_files.id%type,
                                     p_kf     in msp_acc_trans_2909.kf%type);

  -----------------------------------------------------------------------------------------
  --  create_envelope
  --
  --    Процедура записує розібрані дані конверта в базу даних
  --    TOSS іде по списку нових запитів в бд (стан запиту = -1), розшифровує запит, парсить і зберігає відповідні дані
  --
  --      p_id          - id запиту
  --      p_idenv       - id конверта ІОЦ
  --      p_code        - Код запиту від ІОЦ
  --      p_sender      - Відправник пакету
  --      p_recipient   - Отримувач пакету
  --      p_part_number - Порядковий номер частини конверту
  --      p_part_total  - Загальна к-ть частин конверту
  --      p_ecp         - ЕЦП, який був накладений в ІОЦ
  --      p_data        - Зашифрований конверт
  --      p_data_decode - Розшифрований конверт (base64)
  --
  procedure create_envelope(
    p_id          in msp_requests.id%type,
    p_idenv       in msp_envelopes.id_msp_env%type default null,
    p_code        in msp_envelopes.code%type       default null,
    p_sender      in msp_envelopes.sender%type     default null,
    p_recipient   in msp_envelopes.recipient%type  default null,
    p_part_number in msp_envelopes.partnumber%type default null,
    p_part_total  in msp_envelopes.parttotal%type  default null,
    p_ecp         in clob default null,
    p_data        in clob default null,
    p_data_decode in clob default null);

  -----------------------------------------------------------------------------------------
  --  create_envelope_file
  --
  --    Процедура записує розібрані дані реєстрів конверта в базу даних
  --    TOSS іде по списку нових конвертів в бд (стан конверта = -1), парсить конверти і записує параметри реєстрів конверта
  --
  --      p_id       - id запиту / конверта
  --      p_id_msp   - id конверта ІОЦ
  --      p_filedata - текстовий файл реєстра
  --      p_filename - назва файлу реєстра
  --      p_filedate - дата файлу реєстра (ІОЦ)
  --      p_filepath - назва файлу в архіві
  --
  procedure create_envelope_file(
    p_id       in msp_envelopes.id%type,
    p_id_msp   in msp_envelope_files_info.id_msp%type, 
    p_filedata in msp_envelope_files.filedata%type, 
    p_filename in msp_envelope_files_info.filename%type, 
    p_filedate in varchar2, -- в TOSS прописано string
    p_filepath in msp_envelope_files_info.filepath%type);

  -----------------------------------------------------------------------------------------
  --  process_receipt
  --
  --    Оновлення залишку та оновлення стану оплати референсів по ЕБП (точка входу job msp.process_transport)
  --
  procedure process_receipt;

  -----------------------------------------------------------------------------------------
  --  prepare_request_xml
  --
  --    Функція готує xml відповідь на запит
  --
  --    p_request_id - id запиту
  --
  function prepare_request_xml(p_request_id in msp_requests.id%type) return clob;

end msp_utl;
/
create or replace package body msp.msp_utl is

  gc_body_version constant varchar2(64) := 'version 1.45 19.09.2018';
  gc_mod_code     constant varchar2(3)  := 'MSP';
  -----------------------------------------------------------------------------------------

  ex_no_file exception;

  -----------------------------------------------------------------------------------------
  --  header_version
  --
  --    Версія заголовка пакету
  --
  function header_version return varchar2
  is
  begin
     return 'package header msp_utl: ' || gc_header_version;
  end header_version;

  -----------------------------------------------------------------------------------------
  --  body_version
  --
  --    Версія тіла пакету
  --
  function body_version return varchar2
  is
  begin
     return 'package body msp_utl: ' || gc_body_version || chr(10);
  end body_version;

  -----------------------------------------------------------------------------------------
  --  get_context_user
  --
  --    Функція повертає ФІО та логін поточного користувача системи
  --
  function get_context_user return varchar2
  is
    l_user varchar2(4000);
  begin
    select fio || ' (' || logname || ')' into l_user from bars.staff$base where id = bars.gl.aUID;
    return l_user;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_CONTEXT_USER');
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERR_CONTEXT_USER', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end get_context_user;

  -----------------------------------------------------------------------------------------
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
    l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document, p_node_text)));
    return l_node;
  end add_text_node_utl;

  -----------------------------------------------------------------------------------------
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

  -----------------------------------------------------------------------------------------
  --  add_clob_node_utl
  --
  --    Функція добавляє тег формату clob в xml документ, і повертає його екземпляр dbms_xmldom.DOMNode
  --
  function add_clob_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob)
    return dbms_xmldom.DOMNode is
    l_node      dbms_xmldom.DOMNode;
    l_textclob  clob := p_node_text_clob;
    l_node_text clob := '';
    l_domnode   xmldom.DOMNode;
    l_count     integer;
  begin
    l_node    := dbms_xmldom.appendChild(p_host_node,
                                         dbms_xmldom.makeNode(dbms_xmldom.createElement(p_document,
                                                                                        p_node_name)));
    l_domnode := dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document,
                                                                 l_node_text));
    l_node    := dbms_xmldom.appendChild(l_node, l_domnode);
    loop
      l_count     := dbms_lob.getlength(l_textclob);
      l_node_text := substr(l_textclob, 1, 32767);
      l_textclob  := substr(l_textclob, 32768, l_count - 32767);
      xmldom.appendData(xmldom.makeCharacterData(l_domnode), l_node_text);
      EXIT WHEN l_count < 32767 or l_count is null;
    end loop;
    return l_node;
  end add_clob_node_utl;

  -----------------------------------------------------------------------------------------
  --  add_clb_node_utl
  --
  --    Метод добавляє тег формату clob в xml документ
  --
  procedure add_clb_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob) is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := add_clob_node_utl(p_document,
                                p_host_node,
                                p_node_name,
                                p_node_text_clob);
  end add_clb_node_utl;

  -----------------------------------------------------------------------------------------
  --  replace_ukrsmb2dos
  --
  --    Заміна укр символів для cp OEM 866
  --
  function replace_ukrsmb2dos(l_txt clob) return clob
  is
  begin
    return
      replace(replace(replace(replace(
      replace(replace(replace(replace(
        l_txt,
        'І', chr(ascii('І')+239)),
        'і', chr(ascii('і')+239)),
        'Ї', chr(ascii('Ї')+1)),
        'ї', chr(ascii('ї')+248)),
        'Є', chr(ascii('Є')+5)),
        'є', chr(ascii('є')+5)),
        'Ґ', chr(ascii('Ґ')+5)),
        'ґ', chr(ascii('ґ')+6));
  end replace_ukrsmb2dos;

  -----------------------------------------------------------------------------------------
  --  set_state_request
  --
  --    Оновлення стану запиту
  --
  procedure set_state_request(p_id in number, p_state in number, p_comment in varchar2 default null)
  is
  begin
    update msp_requests mr
       set mr.state = p_state,
           mr.comm = p_comment
     where mr.id = p_id;

  end set_state_request;

  -----------------------------------------------------------------------------------------
  --  set_state_envelope
  --
  --    Оновлення стану конверта
  --
  procedure set_state_envelope(p_id number, p_state in number, p_comm in varchar2 default null)
  is
  begin
    update msp_envelopes e
       set e.state = p_state,
           e.comm = p_comm
     where e.id = p_id;
  end set_state_envelope;

  -----------------------------------------------------------------------------------------
  --  set_state_envelope_async
  --
  --    Оновлення стану конверта в автономній транзакції
  --
  procedure set_state_envelope_async(p_id number, p_state in number, p_comm in varchar2 default null)
  is
    pragma autonomous_transaction;
  begin
    update msp_envelopes e
       set e.state = p_state,
           e.comm = p_comm
     where e.id = p_id;
     commit;
  end set_state_envelope_async;

  -----------------------------------------------------------------------------------------
  --  set_state
  --
  --    Оновлення стану запиту/конверта
  --
  --      p_id    - id запиту / конвертв
  --      p_state - новий стан запиту / конвертв
  --      p_comm  - коментар
  --      p_obj   - 0 - request (запит), 1 - envelope (конверт)
  --
  procedure set_state (p_id in number, p_state in number, p_comm in varchar2, p_obj in number)
  is
  begin
    if p_obj = 0 then
      set_state_request(p_id, p_state, p_comm);
    elsif p_obj = 1 then
      set_state_envelope(p_id, p_state, p_comm);
    end if;
  end set_state;

  -----------------------------------------------------------------------------------------
  --  set_envelope_file_state
  --
  --    Оновлення стану msp_envelope_files_info
  --
  procedure set_envelope_file_state(p_envelope_id in msp_envelope_files_info.id%type,
                                    p_state       in msp_envelope_files_info.state%type,
                                    p_comment     in msp_envelope_files_info.comm%type default null)
  is
  begin
    update msp_envelope_files_info set state = p_state, comm = p_comment where id = p_envelope_id;
    if sql%rowcount = 0 then
      raise no_data_found;
    end if;
  exception
    when no_data_found then
      raise_application_error(-20000, 'Не знайдено текстовий файл з таким кодом p_envelope_file_id='||to_char(p_envelope_id));
    when others then
      raise_application_error(-20000, 'Помилка запису стану текстового файлу p_envelope_file_id='||to_char(p_envelope_id)||'. '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_envelope_file_state;

  -----------------------------------------------------------------------------------------
  --  set_file_state
  --
  --    Оновлення стану файла
  --
  --      p_file_id       - id файлу
  --      p_state_id      - id стану
  --      p_comment       - коментар
  --      p_send_pay_date - дата відправки файла на оплату
  --
  procedure set_file_state(p_file_id  in msp_files.id%type,
                           p_state_id in msp_files.state_id%type,
                           p_comment  in msp_files.comm%type default null,
                           p_send_pay_date in msp_files.send_pay_date%type default null)
  is
  begin
    update msp_files
       set state_id      = p_state_id,
           comm          = coalesce(p_comment, comm),
           send_pay_date = coalesce(p_send_pay_date, send_pay_date)
    where id = p_file_id;
    if sql%rowcount = 0 then
      raise ex_no_file;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILE_STATUS', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRUPD_FILE_STATUS', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_state;

  -----------------------------------------------------------------------------------------
  --  set_file_record_state
  --
  --    Оновлення стану інформаційного рядка файла
  --
  --      p_file_record_id   - id інформаційного рядка файла
  --      p_state_id         - id стану
  --      p_comment          - коментар рядка
  --      p_validation_state - id стану валідації
  --      p_state_comment    - коментар зміни стану інформаційного рядка
  --
  procedure set_file_record_state(p_file_record_id in msp_file_records.id%type,
                                  p_state_id       in msp_file_records.state_id%type,
                                  p_comment        in msp_file_records.comm%type default null,
                                  p_validation_state in msp_file_records.validation_state%type default null,
                                  p_state_comment    in msp_file_records.state_comment%type default null)
  is
  begin
    update msp_file_records
       set state_id         = p_state_id,
           comm             = coalesce(p_comment, comm),
           validation_state = coalesce(p_validation_state, validation_state),
           state_comment    = coalesce(p_state_comment, state_comment)
    where id = p_file_record_id;

    if sql%rowcount = 0 then
      raise ex_no_file;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILEREC_STATUS', to_char(p_file_record_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRUPD_FILEREC_STATUS', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_record_state;

  -----------------------------------------------------------------------------------------
  --  set_file_record_payed
  --
  --    Оновлення статуса інформаційного рядка файла на сплачено
  --
  --      p_file_record_id  - id інформаційного рядка файла
  --      p_payed_date      - дата оплати
  --
  procedure set_file_record_payed(p_file_record_id in msp_file_records.id%type,
                                  p_payed_date in date)
    is
      l_file_id   msp_files.id%type;
      l_comment   msp_file_records.state_comment%type;
  begin
    l_comment := 'Змінено стан інформаційного рядка на "Сплачений". Користувач: '||get_context_user;

    update msp_file_records
       set state_id = 10,
           fact_pay_date = p_payed_date,
           state_comment = l_comment
     where id = p_file_record_id
    returning file_id into l_file_id;

     update msp_files mf
         set mf.state_id = 9 --'PAYED'
       where mf.id = l_file_id
         and not exists (select 1
                           from msp_file_records mfr
                          where mfr.file_id = mf.id
                            and mfr.state_id in (17,19,20,99));
    bars_audit.info('msp.msp_utl.set_file_record_payed, p_file_record_id='||to_char(p_file_record_id)||', p_payed_date='||to_char(p_payed_date,'dd.mm.yyyy'));
  exception
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERR_SET_RECORD_PAYED', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end;

  -----------------------------------------------------------------------------------------
  --  set_file_record_error
  --
  --    Оновлення статуса інформаційного рядка файла на повернуто в МСП
  --
  --      p_file_record_id - id інформаційного рядка, що повертається в МСП
  --
  procedure set_file_record_error(p_file_record_id in msp_file_records.id%type)
    is
      l_file_id   msp_files.id%type;
      l_comment   msp_file_records.state_comment%type;
  begin
    l_comment := 'Змінено стан інформаційного рядка на "Повернуто в МСП". Користувач: '||get_context_user;

    update msp_file_records
       set state_id = 3,
           state_comment = l_comment
     where id = p_file_record_id
    returning file_id into l_file_id;

     update msp_files mf
         set mf.state_id = 9 --'PAYED'
       where mf.id = l_file_id
         and not exists (select 1
                           from msp_file_records mfr
                          where mfr.file_id = mf.id
                            and mfr.state_id in (17,19,20));
    bars_audit.info('msp.msp_utl.set_file_record_error, p_file_record_id='||to_char(p_file_record_id));
  exception
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERR_SET_RECORD_ERROR', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end;

  -----------------------------------------------------------------------------------------
  --  checking_record2
  --
  --    Валідація 2
  --
  /*procedure checking_record2(p_file_id in _file.id%type) is
    l_dazs date;
    l_ebp_state integer;
  begin
    for rec_frec in (select *
                       from pfu_file_records pfr
                      where pfr.file_id = p_file_id
                        and pfr.state = 0) loop
       begin
          select pp.dazs into l_dazs
            from pfu_pensacc pp
           where pp.nls = ltrim(rec_frec.num_acc, 0)
             and pp.kf = rec_frec.mfo;
          if l_dazs is not null then
             update pfu_file_records pfr
                set pfr.state = 3
              where pfr.id = rec_frec.id;
          end if;
          exception
             when no_data_found then
               null;
       end;

       begin
          select pp.block_type into l_ebp_state
            from pfu_pensioner pp
           where pp.okpo = rec_frec.numident
             and pp.kf = rec_frec.mfo
             and pp.rnk = (select pa.rnk from pfu_pensacc pa where pa.nls = rec_frec.num_acc and pa.kf = rec_frec.mfo)
             and pp.date_off is null;
          if l_ebp_state is not null then
             update pfu_file_records pfr
                set pfr.state = case l_ebp_state when 4 then 14
                                                 when 5 then 15
                                                 when 6 then 16
                                                 end
              where pfr.id = rec_frec.id;
          end if;
          exception
             when no_data_found then
                null;
       end;
    end loop;

  end checking_record2;*/

  -----------------------------------------------------------------------------------------
  --  checking_file_record
  --
  --    Процедура перевірки нового файла (валідація)
  --
  --      p_file_record_id  - id інформаційного рядка файла
  --      p_numident        - ідент.код отримувача
  --      p_deposit_acc     - Номер рахунку отримувача
  --      p_full_name       - ПІБ отримувача
  --      p_receiver_mfo    - МФО отримувача
  --
  procedure check_file_record(p_file_record_id in msp_file_records.id%type,
                              p_numident       in msp_file_records.numident%type,
                              p_deposit_acc    in msp_file_records.deposit_acc%type,
                              p_full_name      in msp_file_records.full_name %type,
                              p_receiver_mfo   in msp_files.receiver_mfo%type)
  is
    ex_err_record       exception;
    l_err_code          number;
    l_pensioner_row     pfu.pfu_pensioner%rowtype;
    l_pensacc_row       pfu.pfu_pensacc%rowtype;
    l_c_pens            pls_integer;
    l_block_type_id     msp_file_records.block_type_id%type;
  begin
    -- наявність пенсіонера
    select count(1)
    into l_c_pens
    from pfu.pfu_pensioner p
    where p.okpo = p_numident and p.kf = to_char(p_receiver_mfo)
          and p.date_off is null and rownum = 1;

    if (p_numident is not null) then
      if (l_c_pens = 0) then
         l_err_code := 5;
         --l_err_message := 'Пенсіонера не знайдено по ОКПО';
         raise ex_err_record;
      end if;
    end if;

    -- наявність рахунку
    begin
      select * into l_pensacc_row from pfu.pfu_pensacc pa
      where (pa.nls = to_char(p_deposit_acc) or pa.nlsalt = to_char(p_deposit_acc)) -- COBUMMFO-7501
            and pa.kf = to_char(p_receiver_mfo);
    exception
      when no_data_found then
        l_err_code    := 4;
        --l_err_message := 'Рахунок не знайдено';
        raise ex_err_record;
      when others then
        raise;
    end;

    -- рахунок закритий
    if l_pensacc_row.dazs is not null then
      l_err_code := 3;
      --l_err_message := 'Рахунок закритий';
      raise ex_err_record;
    end if;

    -- наявність пенсіонера (по рахунку)
    begin
      select * into l_pensioner_row from pfu.pfu_pensioner p
      where p.rnk = l_pensacc_row.rnk and p.kf = l_pensacc_row.kf;
    exception
      when no_data_found then
        l_err_code := 1;
        --l_err_message := 'Пенсіонера не знайдено (по рахунку)';
        raise ex_err_record;
      when others then
        raise;
    end;

    -- Пенсіонер блокований
    /*
    if l_pensioner_row.block_type is not null then -- if l_pensioner_row.state = 'BLOCKED' then
      l_block_type_id := l_pensioner_row.block_type;
      l_err_code := 0; -- TODO: пока проставляю запис опрацьовано
      --l_err_message := 'Пенсіонер блокований';
      raise ex_err_record;
    end if;
    */

    -- невідповідність ОКПО
    if l_pensioner_row.okpo != p_numident then
      l_err_code    := 1;
      --l_err_message := 'Рахунок не відповідає по ОКПО';
      raise ex_err_record;
    end if;

    -- невідповідність ПІБ
    if utl_match.edit_distance_similarity(UPPER(l_pensioner_row.nmk),UPPER(p_full_name)) < 80 then
      l_err_code    := 2;
      --l_err_message := 'Рахунок не відповідає по ПІБ';
      raise ex_err_record;
    end if;

    -- якщо дійшли сюди то валідація ОК (state_id = 0)
    update msp_file_records set state_id = 0, validation_state = 0, comm = null where id = p_file_record_id;
  exception
    when ex_err_record then
      -- оновлення коду помилки валідації
      update msp_file_records set state_id = l_err_code, validation_state = l_err_code, comm = null, block_type_id = l_block_type_id where id = p_file_record_id;
    when others then
      raise_application_error(-20000, 'Помилка валідації: ' || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end check_file_record;

  -----------------------------------------------------------------------------------------
  --  create_parsing_file
  --
  --    Парсинг і запис табличних даних файлів (точка входу в методі parse_files)
  --
  --      p_envelope_file_id - id конверта
  --      p_id_file          - id реєстра
  --
  procedure create_parsing_file(p_envelope_file_id in msp_envelope_files_info.id%type,
                                p_id_file          in msp_envelope_files_info.id_file%type)
  is
    l_filedata msp_envelope_files.filedata%type;
  begin
    -- отримаємо вихідний файл (clob) для парсингу
    select filedata into l_filedata from msp_envelope_files t where id = p_envelope_file_id;

    -- парсинг clob - розбиття на рядки і поміщення вихідних даних в темп таблицю bars.tmp_imp_file (парсить java)
    bars.import_flat_file(l_filedata);

    -- очистка реєстрів
    delete from msp_file_records where file_id = p_id_file;
    delete from msp_files where id = p_id_file;

    -- insert into msp_files - вставка в заголовок реєстру
    -- bars.tmp_imp_file.id = 0 - перший рядок файлу, містить заголовок
    insert into msp_files (id, state_id, envelope_file_id,
                           file_bank_num, file_filia_num, file_pay_day, file_separator, file_upszn_code, header_lenght, file_date,
                           rec_count, payer_mfo, payer_acc, receiver_mfo, receiver_acc, debit_kredit, pay_sum, pay_type, pay_oper_num,
                           attach_flag, payer_name, receiver_name, payment_purpose, filia_num, deposit_code, process_mode, checksum)
    select p_id_file, -1, p_envelope_file_id,
           trim(substr(line,  1, 5)), --file_bank_num,
           trim(substr(line,  6, 5)), --file_filia_num,
           trim(substr(line, 11, 2)), --file_pay_day,
           trim(substr(line, 13, 1)), --file_separator,
           trim(substr(line, 14, 3)), --file_upszn_code,
           to_number(trim(substr(line, 17, 3))), --header_lenght,
           trim(substr(line, 20, 8)), --file_date,
           to_number(trim(substr(line, 28, 6))), --rec_count,
           to_number(trim(substr(line, 34, 9))), --payer_mfo,
           to_number(trim(substr(line, 43, 14))), --payer_acc,
           to_number(trim(substr(line, 57, 9))), --receiver_mfo,
           to_number(trim(substr(line, 66, 14))), --receiver_acc,
           trim(substr(line, 80, 1)), --debit_kredit,
           to_number(trim(substr(line, 81, 19))), --pay_sum,
           to_number(trim(substr(line, 100, 2))), --pay_type,
           trim(substr(line, 102, 10)), --pay_oper_num,
           trim(substr(line, 112, 1)), --attach_flag,
           trim(substr(line, 113, 27)), --payer_name,
           trim(substr(line, 140, 27)), --receiver_name,
           trim(substr(line, 167, 160)), --payment_purpose,
           to_number(trim(substr(line, 327, 5))), --filia_num,
           to_number(trim(substr(line, 332, 3))), --deposit_code,
           trim(substr(line, 335, 10)), --process_mode,
           trim(substr(line, 345, 32)) --checksum
    from bars.tmp_imp_file t where id = 0;

    -- insert into msp_file_records - вставка інформаційних рядків
    insert into msp_file_records (id, file_id, state_id, block_type_id, block_comment, rec_no,
                                  deposit_acc, filia_num, deposit_code, pay_sum,
                                  full_name, numident, pay_day, displaced, pers_acc_num)
    select msp_file_record_seq.nextval, p_id_file, -1, null, null, id,
           to_number(trim(substr(line, 1, 19))), --deposit_acc,
           to_number(trim(substr(line, 20, 5))), --filia_num,
           to_number(trim(substr(line, 25, 3))), --deposit_code,
           to_number(trim(substr(line, 28, 19))), --pay_sum,
           translate(trim(substr(line, 47, 100)), 'Ii', 'Іі'), --full_name,
           trim(substr(line, 147, 10)), --numident,
           trim(substr(line, 157, 2)), --pay_day,
           trim(substr(line, 159, 1)), --displaced
           trim(substr(line, 160, 6)) --pers_acc_num
    from bars.tmp_imp_file t where id <> 0;
  exception
    when others then
      raise_application_error(-20000, 'Неможливо розпарсити файл. Не коректна структура файлу. ' || chr(10) || chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end create_parsing_file;

  -----------------------------------------------------------------------------------------
  --  parse_files
  --
  --    Парсинг нових файлів (точка входу в методі process_files, який періодично запускає джоб)
  --
  procedure parse_files
  is
    l_err_state msp_envelope_files_info.state%type;
    l_err_msg   varchar2(4000);
  begin
    -- Відбір всіх нових файлів
    for r in (select distinct id from msp_envelope_files_info where state in (-1))
    loop
      -- Оновлення стану на: 1 - IN_PARSE - Виконується парсинг
      set_envelope_file_state(r.id, 1);-- 1 - IN_PARSE - Виконується парсинг
    end loop;

    commit;

    -- parse and insert data
    for r in (select distinct id from msp_envelope_files_info where state in (1))
    loop
      l_err_state := null;

      for i in (select id_file from msp_envelope_files_info where id = r.id)
      loop
        begin
          create_parsing_file(p_envelope_file_id => r.id, p_id_file => i.id_file);
        exception
          when others then
            l_err_state := 2; -- 2 - PARSE_ERROR - Помилка парсингу
            l_err_msg   := sqlerrm;
            exit;
        end;
      end loop;

      set_envelope_file_state(r.id, coalesce(l_err_state, 3), l_err_msg); -- 2 - PARSE_ERROR - Помилка парсингу / 3 - PARSED - Файл розібраний 
      commit;
    end loop;
  end parse_files;

  -----------------------------------------------------------------------------------------
  --  validate_file_records
  --
  --    Валідація інформаційних рядків нового файла (точка входу в методі process_files, який періодично запускає джоб)
  --
  procedure validate_file_records
  is
    l_check_state simple_integer := 0; -- статус валідації, за замовчуванням = 0 - Ок
  begin
    -- check file_records
    for ef in (select distinct ef.id
               from msp_envelope_files_info ef
               where ef.state in (3,5)
               order by ef.id)
    loop
      for i in (select f.receiver_mfo, f.id file_id
                from msp_files f
                where f.envelope_file_id = ef.id
                      and f.state_id in (-1,5) -- -1 - NEW / 5 - якщо системна помилка валідації то запускаю процес повторно
                order by ef.id)
      loop
        begin
          set_envelope_file_state(ef.id, 4);-- 4  IN_CHECK Виконується валідація
          set_file_state(i.file_id, 4);    -- 4 IN_CHECK Виконується валідація
          commit;

          for rec in (select * from msp_file_records where file_id = i.file_id)
          loop
            check_file_record(p_file_record_id => rec.id,
                              p_numident       => rec.numident,
                              p_deposit_acc    => rec.deposit_acc,
                              p_full_name      => rec.full_name,
                              p_receiver_mfo   => i.receiver_mfo);
          end loop;
          set_file_state(i.file_id, 0);    -- 0 CHECKED Перевірено
        exception
          when others then
            set_file_state(i.file_id, 5, sqlerrm); -- 5 CHECK_ERROR Системна помилка валідації
            l_check_state := 5;
        end;
      end loop;

      set_envelope_file_state(ef.id, l_check_state); -- 0 CHECKED Перевірено / 5  CHECK_ERROR Системна помилка валідації
      commit;
    end loop;

  end validate_file_records;

  -----------------------------------------------------------------------------------------
  --  process_file
  --
  --    Парсинг та валідація нових файлів. Метод періодично запускається в джобі msp.parse_files
  --
  procedure process_files
  is
  begin
    -- парсинг всіх нових файлів
    parse_files;
    -- валідація інформаційних рядків файлів, які успішно розпарсені, або повторно, що мають системну помилку
    validate_file_records;
  end process_files;


  -----------------------------------------------------------------------------------------
  --  do_matching1_header
  --
  --    Побудова заголовку файла квитанції 1
  --
  --      p_file_id   - id заголовка файлу
  --      p_file_buff - буфер зформованого заголовка файла (out parameter)
  --
  procedure do_matching1_header(
    p_file_id   in msp_files.id%type,
    p_file_buff in out nocopy clob
    )
  is
    l_file        msp_files%rowtype;
    l_create_date char(8) := to_char(sysdate,'dd\mm\yy');
    l_crlp        char(2) := chr(13)||chr(10);
    l_file_name   varchar2(17 char);
  begin
    select * into l_file from msp_files where id = p_file_id;
    l_file_name   := lpad(coalesce(trim(l_file.file_bank_num),'0'),5,'0')||'\'||lpad(coalesce(trim(l_file.file_filia_num),'0'),5,'0')||lpad(coalesce(trim(l_file.file_pay_day),'0'),2,'0')||coalesce(trim(l_file.file_separator),'.')||lpad(coalesce(trim(l_file.file_upszn_code),'0'),3,'0');

    p_file_buff := replace(l_file_name, '\', '')||
      to_char(l_file.header_lenght,'FM000')||
      l_create_date||
      to_char(l_file.rec_count,'FM000000')||
      to_char(l_file.payer_mfo,'FM000000000')||
      to_char(l_file.payer_acc,'FM00000000000000')||
      to_char(l_file.receiver_mfo,'FM000000000')||
      to_char(l_file.receiver_acc,'FM00000000000000')||
      coalesce(l_file.debit_kredit,' ')||
      to_char(l_file.pay_sum,'FM0000000000000000000')||
      to_char(l_file.pay_type,'FM00')||
      rpad(coalesce(l_file.pay_oper_num,' '),10,' ')||
      coalesce(l_file.attach_flag,' ')||
      rpad(coalesce(l_file.payer_name,' '),27,' ')||
      rpad(coalesce(l_file.receiver_name,' '),27,' ')||
      rpad(coalesce(l_file.payment_purpose,' '),160,' ')||
      to_char(l_file.filia_num,'FM00000')||
      rpad(coalesce(to_char(l_file.deposit_code),' '),3,' ')||
      rpad(coalesce(l_file.process_mode,' '),10,' ')||
      rpad(coalesce(l_file.checksum,' '),32,' ')||
      l_crlp;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_HEADER', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_HEADER', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching1_header;

  -----------------------------------------------------------------------------------------
  --  do_matching1_body
  --
  --    Побудова файла квитанції 1
  --
  --      p_file_id   - id заголовка файлу
  --      p_file_buff - буфер зформованої квитанції 1 інформаційних рядків файла (out parameter)
  --
  procedure do_matching1_body(
    p_file_id        in msp_files.id%type,
    p_file_buff      in out nocopy clob
    )
  is
    l_crlp char(2) := chr(13)||chr(10);
  begin
    for c_rec in (select * from msp_file_records where file_id = p_file_id order by id)
      loop
        p_file_buff := p_file_buff||
          to_char(c_rec.deposit_acc,'FM0000000000000000000')||
          to_char(c_rec.filia_num,'FM00000')||
          to_char(c_rec.deposit_code,'FM000')||
          to_char(c_rec.pay_sum,'FM0000000000000000000')||
          rpad(coalesce(c_rec.full_name,' '),100,' ')||
          rpad(coalesce(c_rec.numident,' '),10,' ')||
          rpad(coalesce(c_rec.pay_day,' '),2,' ')||
          coalesce(c_rec.displaced,' ')||
          to_char(c_rec.pers_acc_num,'FM000000')||
          to_char(case when c_rec.state_id < 6 then c_rec.state_id else 0 end ,'FM0')||
          l_crlp;
      end loop;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_BODY', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_BODY', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching1_body;

  -----------------------------------------------------------------------------------------
  --  do_matching2_header
  --
  --    Побудова заголовку файла квитанції 2
  --
  --      p_file_id   - id заголовка файлу
  --      p_file_buff - буфер зформованого заголовка файла (out parameter)
  --
  procedure do_matching2_header(
    p_file_id   in msp_files.id%type,
    p_file_buff in out nocopy clob
    )
  is
    l_file            msp_files%rowtype;
    l_create_date     char(8) := to_char(sysdate,'dd\mm\yy');
    l_crlp            char(2) := chr(13)||chr(10);
    l_file_name       varchar2(17 char);
    l_count_payed     number(6);
    l_sum_payed       number(14);
    l_count_not_payed number(6);
    l_sum_not_payed   number(14);
  begin
    select * into l_file from msp_files where id = p_file_id;

    select sum(case when state_id in (10) then 1 else 0 end) count_payed,
           sum(case when state_id in (10) then pay_sum else 0 end) sum_payed,
           sum(case when state_id not in (10) then 1 else 0 end) count_not_payed,
           sum(case when state_id not in (10) then pay_sum else 0 end) sum_not_payed
    into l_count_payed, l_sum_payed, l_count_not_payed, l_sum_not_payed
    from msp_file_records
    where file_id = p_file_id;

    --l_file_name := substr(lpad(l_file.file_bank_num,5,'0'),1,5)||'\'||substr(lpad(l_file.file_filia_num,5,'0'),1,5)||substr(lpad(l_file.file_pay_day,2,'0'),1,2)||'.'||substr(lpad(l_file.file_upszn_code,3,'0'),1,3);
    l_file_name   := lpad(trim(l_file.file_bank_num),5,'0')||'\'||lpad(trim(l_file.file_filia_num),5,'0')||lpad(trim(l_file.file_pay_day),2,'0')||coalesce(trim(l_file.file_separator),'.')||lpad(trim(l_file.file_upszn_code),3,'0');

    p_file_buff := replace(l_file_name, '\', '')||
      to_char(l_file.header_lenght,'FM000')||
      l_create_date||
      to_char(l_file.rec_count,'FM000000')||
      to_char(l_file.payer_mfo,'FM000000000')||
      --to_char(l_file.payer_acc,'FM000000000')||
      to_char(l_file.payer_acc,'FM00000000000000')||
      to_char(l_file.receiver_mfo,'FM000000000')||
      --to_char(l_file.receiver_acc,'FM000000000')||
      to_char(l_file.receiver_acc,'FM00000000000000')||
      coalesce(l_file.debit_kredit,' ')||
      to_char(l_file.pay_sum,'FM0000000000000000000')||
      to_char(l_file.pay_type,'FM00')||
      rpad(coalesce(l_file.pay_oper_num,' '),10,' ')||
      coalesce(l_file.attach_flag,' ')||
      rpad(coalesce(l_file.payer_name,' '),27,' ')||
      rpad(coalesce(l_file.receiver_name,' '),27,' ')||
      rpad(coalesce(l_file.payment_purpose,' '),160,' ')||
      to_char(l_file.filia_num,'FM00000')||
      rpad(coalesce(to_char(l_file.deposit_code),' '),3,' ')||
      rpad(coalesce(l_file.process_mode,' '),10,' ')||
      rpad(coalesce(l_file.checksum,' '),32,' ')||
      to_char(l_count_payed,'FM000000')||           -- number(6)  -- Зараховано кількість
      to_char(l_sum_payed,'FM00000000000000')||     -- number(14) -- Зараховано сума (в коп.)
      to_char(l_count_not_payed,'FM000000')||       -- number(6)  -- Не зараховано кількість
      to_char(l_sum_not_payed,'FM00000000000000')|| -- number(14) -- Не зараховано сума (в коп.)
      --
      l_crlp;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_HEADER', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_HEADER', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching2_header;

  -----------------------------------------------------------------------------------------
  --  do_matching2_body
  --
  --    Побудова файла квитанції 2
  --
  --      p_file_id   - id заголовка файлу
  --      p_file_buff - буфер зформованої квитанції 2 інформаційних рядків файла (out parameter)
  --
  procedure do_matching2_body(
    p_file_id        in msp_files.id%type,
    p_file_buff      in out nocopy clob
    )
  is
    l_crlp       char(2) := chr(13)||chr(10);
    l_cnt_err    number;
    ex_err_state exception;
  begin
    select count(1) into l_cnt_err from msp_file_records where file_id = p_file_id and state_id not in (1, 2, 3, 4, 5, 14, 10) and rownum = 1;

    if l_cnt_err > 0 then
      raise ex_err_state;
    end if;

    for c_rec in (select * from msp_file_records where file_id = p_file_id order by id)
      loop
        p_file_buff := p_file_buff||
          to_char(c_rec.deposit_acc,'FM0000000000000000000')||
          to_char(c_rec.filia_num,'FM00000')||
          to_char(c_rec.deposit_code,'FM000')||
          to_char(c_rec.pay_sum,'FM0000000000000000000')||
          rpad(coalesce(c_rec.full_name,' '),100,' ')||
          rpad(coalesce(c_rec.numident,' '),10,' ')||
          rpad(coalesce(c_rec.pay_day,' '),2,' ')||
          coalesce(c_rec.displaced,' ')||
          to_char(c_rec.pers_acc_num,'FM000000')||
          case c_rec.state_id
               when  1 then '1'
               when  2 then '2'
               when  3 then '5'
               when  4 then '5'
               when  5 then '3'
               when 14 then '6'
               when 10 then '0'
               else         ' '
          end||-- VARCHAR(1) -- Причина не зарахування
          coalesce(to_char(c_rec.fact_pay_date,'ddmmyyyy'),'        ')||-- Фактична дата зарахування коштів
          --
          l_crlp;
      end loop;
  exception
    when ex_err_state then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_BODY', 'Реєстр містить інформаційні рядки із помилковими станами');
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_BODY', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_BODY', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching2_body;

  -----------------------------------------------------------------------------------------
  --  do_matching
  --
  --    Квитанція 1,2
  --
  --      p_file_id        - id заголовка файла
  --      p_file_buff      - буфер зформованої квитанції 1/2 (out parameter)
  --      p_matching_tp    - тип квитанції: 1/2
  --      p_is_convert2dos - ознака чи конвертувати в dos кодування cp866 (1 - так, 0 - ні)
  --
  procedure do_matching(
    p_file_id     in msp_files.id%type,
    p_file_buff   in out nocopy blob,
    p_matching_tp in simple_integer default 1,
    p_is_convert2dos in simple_integer default 1
    )
  is
    ex_unknown_matching exception;
    l_buff clob;
  begin
    if p_matching_tp = 1 then -- квитанція 1
      do_matching1_header(p_file_id, l_buff);
      do_matching1_body(p_file_id, l_buff);
    elsif p_matching_tp = 2 then -- квитанція 2
      do_matching2_header(p_file_id, l_buff);
      do_matching2_body(p_file_id, l_buff);
    else
      raise ex_unknown_matching;
    end if;

    -- перекодування в OEM 866
    if p_is_convert2dos = 1 then
      l_buff := convert(replace_ukrsmb2dos(l_buff), 'RU8PC866', 'CL8MSWIN1251');
    end if;

    p_file_buff := bars.lob_utl.clob_to_blob(l_buff);
  exception
    when ex_unknown_matching then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING', to_char(p_matching_tp));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING', to_char(p_matching_tp), dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching;

  -----------------------------------------------------------------------------------------
  --  set_env_content
  --
  --    Запис зформованих даних по файлу (квитанція 1/2)
  --
  --      p_id        - id конверта
  --      p_value     - clob файл
  --      p_type_id   - тип контенту (msp_env_content_type.id - квитанція 1/2)
  --
  procedure set_env_content(p_id      in msp_env_content.id%type,
                            p_value   in clob,
                            p_type_id in msp_env_content.type_id%type,
                            p_ecp     in clob)
  is
    ex_no_parameter exception;
    ct_fname        constant varchar2(20 char) := '_OBU_[FNAME].ZIP.P7S';
    l_filename      msp_env_content.filename%type := case p_type_id when 1 then 'CTLPAY'||ct_fname when 2 then 'RESPAY'||ct_fname else null end;
    l_start         number(2) := 12;
  begin
    if p_type_id is null then
      -- не вірно вказано тип
      raise ex_no_parameter;
    end if;

    -- запис даних
    merge into msp_env_content e
    using (select * from msp_envelopes t where t.id = p_id) t on (e.id = t.id and e.type_id = p_type_id)
    when matched then
      update set e.cvalue = p_value,
                 e.ecp = p_ecp,
                 e.filename = replace(l_filename, '[FNAME]', substr(upper(t.filename),l_start,instr(t.filename,'.')-l_start)),
                 e.insert_dttm = sysdate
    when not matched then
      insert values (p_id, p_type_id, null, replace(l_filename, '[FNAME]', substr(upper(t.filename),l_start,instr(t.filename,'.')-l_start)), sysdate, p_ecp, p_value);

    if sql%rowcount = 0 then
      raise ex_no_file;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILE_CONTENT', to_char(p_id));
    when ex_no_parameter then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILECONTENT_PARAMETER', to_char(p_type_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRWRITE_FILE_CONTENT', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_env_content;

  -----------------------------------------------------------------------------------------
  --  read_env_content
  --
  --    Фунція повертає запис збережених даних по конверту
  --
  function read_env_content(p_id      in msp_env_content.id%type,
                            p_type_id in msp_env_content.type_id%type) return msp_env_content%rowtype
  is
    l_msp_env_content msp_env_content%rowtype;
  begin
    select * into l_msp_env_content from msp_env_content where id = p_id and type_id = p_type_id;
    return l_msp_env_content;
  end read_env_content;

  -----------------------------------------------------------------------------------------
  --  set_file_record2pay
  --
  --    Включення інформаційного рядка в оплату
  --
  --      p_file_record_id - id інформаційного рядка, що включається в оплату
  --
  procedure set_file_record2pay(p_file_record_id in msp_file_records.id%type)
  is
    l_state_id           msp_file_records.state_id%type;
    ex_include_violation exception;
    l_state_comment      msp_file_records.state_comment%type;
  begin
    l_state_comment := 'Включено інформаційний рядок в оплату. Користувач: '||get_context_user;

    select state_id into l_state_id from msp_file_records where id = p_file_record_id;

    if l_state_id in (0) then
      raise ex_include_violation;
    else
      set_file_record_state(p_file_record_id   => p_file_record_id,
                            p_state_id         => 0,
                            p_state_comment    => l_state_comment);
      bars_audit.info('msp.msp_utl.set_file_record2pay, p_file_record_id='||to_char(p_file_record_id)||', l_state_id='||to_char(l_state_id));
    end if;
  exception
    when ex_include_violation then
      raise_application_error(-20000, 'Заборонено включати в оплату рядки із статусом '||to_char(l_state_id));
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILEREC_STATUS', to_char(p_file_record_id));
    when others then
      raise;
  end set_file_record2pay;

  -----------------------------------------------------------------------------------------
  --  set_file_for_pay
  --
  --    Передати реєстр на оплату
  --
  --      p_file_id - id реєстра, що передається на оплату
  --
  procedure set_file_for_pay(p_file_id in msp_files.id%type)
  is
    l_state_id           msp_file_records.state_id%type;
    ex_include_violation exception;
  begin
    update msp_file_records set state_id = 19 where file_id = p_file_id and state_id = 0;
    set_file_state(p_file_id       => p_file_id,
                   p_state_id      => 8,
                   p_send_pay_date => sysdate);
    bars_audit.info('msp.msp_utl.set_file_for_pay, p_file_id='||to_char(p_file_id));
  exception
    when no_data_found then
      raise_application_error(-20000, 'Відсутні дані для оплати для файлу file_id='||to_char(p_file_id));
    when others then
      raise_application_error(-20000, 'Помилка оплати file_id='||to_char(p_file_id)||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_for_pay;

  -----------------------------------------------------------------------------------------
  --  set_file_record_blocked
  --
  --    Виключити інформаційний рядок з оплати
  --
  --      p_file_record_id - id інформаційного рядка, що блокується
  --      p_comment        - коментар користувача
  --      p_block_type_id  - тип блокування
  --
  procedure set_file_record_blocked(p_file_record_id in msp_file_records.id%type,
                                    p_comment        in msp_file_records.comm%type,
                                    p_block_type_id  in msp_file_records.block_type_id%type)
  is
    l_new_state msp_file_record_state.id%type;
  begin
    -- згідно уточнення в банку, поки може бути тільки одна причина блокування 5 - За письмовою вимогою органів УПСЗН
    if p_block_type_id in (5) then
      l_new_state := 14; -- Заблоковано згідно письмової вимоги органу Пенсійного фонду або органу УПСЗН
    else
      raise_application_error(-20000, 'Хибна причина блокування оплати');
    end if;
    set_file_record_state(p_file_record_id => p_file_record_id,
                          p_state_id       => l_new_state,
                          p_comment        => p_comment);
  end set_file_record_blocked;

  -----------------------------------------------------------------------------------------
  --  set_match_create
  --
  --    Установка стану "Квитанція 1/2 зформована" для конверту
  --
  procedure set_match_create(p_envelope_id in msp_envelopes.id%type,
                             p_matching_tp in number)
  is
  begin
    set_state_envelope(p_id    => p_envelope_id,
                       p_state => case p_matching_tp when 1 then msp_const.st_env_MATCH1_CREATED/*11 - Квитанція 1 зформована*/
                                                     when 2 then msp_const.st_env_MATCH2_CREATED/*16 - Квитанція 2 зформована*/
                                  end);
  end set_match_create;

  -----------------------------------------------------------------------------------------
  --  set_match_processing
  --
  --    Установка стану "Квитанція 1/2 в процесі формування" для конверту
  --
  --      p_envelope_id - id конверта
  --      p_matching_tp - тип квитанції - 1/2
  --
  procedure set_match_processing(p_envelope_id in msp_envelopes.id%type,
                                 p_matching_tp in simple_integer)
  is
    l_state      msp_envelopes.state%type;
    l_state_name msp_envelope_state.name%type;
    l_new_state  msp_envelopes.state%type;
    l_cnt        number;
    l_cnt_10     number;
  begin
    select s.id, s.name
    into l_state, l_state_name
    from msp_envelopes e
         inner join msp_envelope_state s on s.id = e.state
    where e.id = p_envelope_id;

    -- l_cnt_10 - кількість реєстрів які оплачені в конверті
    -- l_cnt    - всього реєстрів в конверті
    select sum(case when f.state_id in (9) then 1 else 0 end) cnt_10,
           count(1) cnt
    into l_cnt_10, l_cnt
    from msp_envelope_files_info fi
         inner join msp_files f on f.id = fi.id_file
    where fi.id = p_envelope_id;

    -- не всі стани конвертів дозволяють формувати квитанції 1/2, спочатку перевірка перед формуванням
    case
      when p_matching_tp = 1 and l_state in (0,11,13,14,15) and l_cnt_10 = 0 /*відсутні оплачені реєстри*/ then
        l_new_state := msp_const.st_env_MATCH1_PROCESSING; /*9 - Квитанція 1 в процесі формування*/
      when p_matching_tp = 2 and l_state in (0,11,13,14,15,16,18,19,20) and l_cnt_10 = l_cnt /*всі реєстри оплачені*/ then
        l_new_state := msp_const.st_env_MATCH2_PROCESSING; /*10 - Квитанція 2 в процесі формування*/
      else
        raise_application_error(-20000, 'Формування квитанції заборонено в такому статусі ("' || l_state_name || '") конверта ("'||to_char(p_envelope_id)||'")');
    end case;

    set_state_envelope(p_id    => p_envelope_id,
                       p_state => l_new_state);
  end set_match_processing;

  -----------------------------------------------------------------------------------------
  --  set_match_processing
  --
  --    Установка стану "Квитанція 2 в процесі формування" для конверту - перегружений метод - Точка входу із веба
  --
  --      p_payment_type   - тип оплати    (атрибут v_msp_envelopes_match2.payment_type - динамічно оприділяється із назви файлу)
  --      p_payment_period - період оплати (атрибут v_msp_envelopes_match2.payment_period - динамічно оприділяється із назви файлу)
  --
  procedure set_match_processing(p_payment_type   in v_msp_envelopes_match2.payment_type%type,
                                 p_payment_period in v_msp_envelopes_match2.payment_period%type)
  is
  begin
    for i in (select id from v_msp_envelopes_match2 t where payment_type = p_payment_type and payment_period = p_payment_period)
    loop
      set_match_processing(p_envelope_id => i.id,
                           p_matching_tp => 2);
    end loop;
  end set_match_processing;

  -----------------------------------------------------------------------------------------
  --  make_zip
  --
  --    Функція формує zip архів із списку файлів та повертає готовий буфер zip файлу (blob)
  --
  --
  function make_zip(p_files in t_file_array) return blob
  is
    l_buff blob;
  begin
    for i in p_files.first..p_files.last
    loop
      bars.as_zip.add1file(p_zipped_blob => l_buff,
                           p_name        => p_files(i).file_name,
                           p_content     => p_files(i).file_buff);
    end loop;
    bars.as_zip.finish_zip(p_zipped_blob => l_buff);
    return l_buff;
  end;


  -----------------------------------------------------------------------------------------
  --  make_matching
  --
  --    Функція формує та повертає ZIP архів квитанції 1/2
  --
  --      p_envelope_id - id конверту
  --      p_matching_tp - тип квитанції (1/2)
  --      p_is_convert2dos - ознака 1 - конвертувати в cp866 / 0 - ні
  --
  function make_matching(p_envelope_id    in msp_envelopes.id%type,
                         p_matching_tp    in simple_integer default 1,
                         p_is_convert2dos in simple_integer default 1
                         ) return blob
  is
    l_buff blob;
    l_file_array t_file_array := t_file_array();
  begin
    dbms_lob.createtemporary(l_buff, true);

    -- створення масиву l_file_array квитанцій конверта
    for i in (select id_file id, filename, filepath from msp_envelope_files_info t where t.id = p_envelope_id)
    loop
      do_matching(p_file_id        => i.id,
                  p_file_buff      => l_buff,
                  p_matching_tp    => p_matching_tp,
                  p_is_convert2dos => p_is_convert2dos);

      l_file_array.extend;
      l_file_array(l_file_array.last).file_name := i.filepath;
      l_file_array(l_file_array.last).file_buff := l_buff;
    end loop;

    if l_file_array.count = 0 then
      -- відсутні дані
      raise no_data_found;
    else
      -- архівація файлів в zip
      l_buff := make_zip(p_files => l_file_array);
    end if;

    return l_buff;
  exception
    when no_data_found then
      raise_application_error(-20000, 'Помилка формування архіву квитанції '||to_char(p_matching_tp)||' Відсутні дані для формування квитанції.');
    when others then
      raise_application_error(-20000, 'Помилка формування архіву квитанції '||to_char(p_matching_tp)||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end make_matching;

  -----------------------------------------------------------------------------------------
  --  get_matching_xml
  --
  --    Функція готує xml файл квитанції для шифрування
  --
  --      p_matching_tp    - тип квитанції (1/2)
  --      p_id_msp         - id ІОЦ
  --      p_filename       - назва файлу
  --      p_file           -
  --      p_filedate       - дата
  --      p_ecp            -
  --      p_count_verified -
  --      p_count_total    -
  --      p_count_error    -
  --      p_count_paid     -
  --
  function get_matching_xml(p_matching_tp    in simple_integer,
                            p_id_msp         in msp_envelopes.id_msp_env%type,
                            p_filename       in varchar2,
                            p_file           in clob,
                            p_filedate       in date,
                            p_ecp            in clob,
                            p_count_verified in number,
                            p_count_total    in number default null,
                            p_count_error    in number default null,
                            p_count_paid     in number default null
                            ) return blob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    --
    l_buff         clob;
    l_retval       blob;
    --
    l_code         varchar2(30);
    l_from         varchar2(30);
    l_to           varchar2(30);
    l_partnumber   number(2);
    l_parttotal    number(2);
    l_filedate     varchar2(14) := to_char(p_filedate,'ddmmyyyy')||'000000';--18122017000000
  begin
    dbms_lob.createtemporary(l_buff, true, 12);
    l_buff := p_file;

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'upszn_issuess')));

    -- атрибути xml файла квитанції
    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'id_mcp',
                     p_node_text => p_id_msp);

    add_clb_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'file',
                     p_node_text_clob => l_buff);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'filename',
                     p_node_text => p_filename);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'filedate',
                     p_node_text => l_filedate);

    add_clb_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'file_ecp',
                     p_node_text_clob => p_ecp);

    if p_matching_tp in (1) then
      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'count_total',
                       p_node_text => to_char(p_count_total));

      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'count_error',
                       p_node_text => to_char(p_count_error));

    elsif p_matching_tp in (2) then
      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'count_paid',
                       p_node_text => to_char(p_count_paid));
    end if;

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'count_verified',
                     p_node_text => to_char(p_count_verified));

    dbms_lob.createtemporary(l_buff, true, 12);

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    l_buff := '<?xml version="1.0" encoding="utf-8"?>'||l_buff;

    l_retval := bars.lob_utl.clob_to_blob(l_buff);

    return l_retval;
  end get_matching_xml;

  -----------------------------------------------------------------------------------------
  --  get_matching2sign
  --
  --    Функція формує та повертає таблицю яка містить в полях ZIP архів квитанції 1/2
  --    Використовується у view, які підхватує TOSS для підписання і шифрування:
  --    v_msp_sign_file        - Список квитанцій конвертів на формування підпису
  --    v_msp_encrypt_envelope - Список квитанцій конвертів на шифрування
  --
  --      p_stage          - етап   - 1 - підписання файлу, 2 - шифрування файлу
  --      p_is_convert2dos - ознака - 1 - конвертувати в cp866 / 0 - ні
  --
  function get_matching2sign(p_stage          in simple_integer,
                             p_is_convert2dos in simple_integer default 1) return t_match_array pipelined
  is
    l_buff            blob;
    l_file_array      t_file_array;
    l_match_array     t_match_array := t_match_array();
    l_msp_env_content msp_env_content%rowtype;
    l_count_total     number(38,0);
    l_count_error     number(38,0);
    l_count_verified  number(38,0);
    l_count_paid      number(38,0);
  begin
    dbms_lob.createtemporary(l_buff, true);

    -- курсор конвертів що в стані на формування і підпис квитанції або шифрування квитанції
    for r in (select e.id,
                     case when e.state in (msp_const.st_env_MATCH1_PROCESSING/*9*/, msp_const.st_env_MATCH1_SIGN_WAIT/*12*/) then 1
                          when e.state in (msp_const.st_env_MATCH2_PROCESSING/*10*/, msp_const.st_env_MATCH2_SIGN_WAIT/*17*/) then 2
                     end matching_tp,
                     case e.state when msp_const.st_env_MATCH1_PROCESSING/*9*/ then msp_const.st_env_MATCH1_CREATE_ERROR /*13*/
                                  when msp_const.st_env_MATCH1_SIGN_WAIT /*12*/ then msp_const.st_env_MATCH1_ENV_CREATE_ERROR /*15*/
                                  when msp_const.st_env_MATCH2_PROCESSING/*10*/ then msp_const.st_env_MATCH2_CREATE_ERROR /*18*/
                                  when msp_const.st_env_MATCH2_SIGN_WAIT /*17*/ then msp_const.st_env_MATCH2_ENV_CREATE_ERROR /*20*/
                     end errst,
                     e.state,
                     e.id_msp_env
              from msp_envelopes e
                   inner join msp_envelope_state s on s.id = e.state
              where lower(e.code) in ('payment_data')
                    and e.state in (case p_stage when 1 then 9
                                                 when 2 then 12
                                    end,
                                    case p_stage when 1 then 10
                                                 when 2 then 17
                                    end)
             )
    loop
      l_file_array := t_file_array();

      -- квитанція 1/2 - створення zip і підпис
      if p_stage = 1 and r.state in (9,10) then --(0,11,13,14,16,18) then
        begin
          for i in (select id_file, filename, filepath
                    from msp_envelope_files_info t
                    where id = r.id)
          loop
            -- створення буферу l_buff квитанції
            do_matching(p_file_id        => i.id_file,
                        p_file_buff      => l_buff,
                        p_matching_tp    => r.matching_tp,
                        p_is_convert2dos => p_is_convert2dos);

            -- додати буфер l_buff квитанції в масив
            l_file_array.extend;
            l_file_array(l_file_array.last).file_name := i.filepath;
            l_file_array(l_file_array.last).file_buff := l_buff;
          end loop;
        exception
          when others then
            -- якщо помилка то проставляю відповідний стан конверта в автономній транзакції
            set_state_envelope_async(r.id, r.errst, dbms_utility.format_error_backtrace || ' ' || sqlerrm); -- Помилка формування квитанції 1 -- MATCH1_CREATE_ERROR
            -- очистка масива
            l_file_array := t_file_array();
        end;

        if l_file_array.count = 0 then
          l_buff := null;
        else
          -- архівування файлів квитанцій в zip
          l_buff := make_zip(p_files => l_file_array);
        end if;
      -- 12 -- Конверт квитанції 1 готовий до шифрування файлу
      -- 17 -- Конверт квитанції 2 готовий до шифрування файлу
      elsif p_stage = 2 and r.state in (12,17) then --(12,15,17,20) then
        l_msp_env_content := read_env_content(p_id      => r.id,
                                              p_type_id => r.matching_tp);
        -- атрибути xml файла відповіді на запит китанції 1/2
        select count(1) count_total,
               case when r.matching_tp in (1) then
                 sum(case when fr.state_id between 1 and 6 then 1 else 0 end)
                 else 0 end count_error,
               sum(case when r.matching_tp in (1) and fr.state_id not in (-1,1,2,3,4,5,6) /*in (0,19,20)*/  then 1 -- (1) Кількість рядків файлу, що опрацьовано успішно. Оплата здійснюватиметься по даним рядкам
                        when r.matching_tp in (2) and fr.state_id in (10,17,14) then 1 -- (2) Кількість рядків файлу, по яким здійснювалась оплата
                   else 0 end) count_verified,
               case when r.matching_tp in (2) then sum(case when fr.state_id in (10) then 1 else 0 end) else 0 end count_paid
        into l_count_total,    -- кількість позицій в квитанції (1/2)
             l_count_error,    -- кількість позицій з помилками валідації (для квитанції 1)
             l_count_verified, -- кількість рядків файлу, що опрацьовано успішно. Оплата здійснюватиметься по даним рядкам (для квитанції 1)
                               -- або Кількість рядків файлу, по яким здійснювалась оплата (для квитанції 2)
             l_count_paid      -- кількість оплачених рядків в квитанції 2
        from msp_envelope_files_info fi
             inner join msp_file_records fr on fr.file_id = fi.id_file
        where fi.id = r.id;

        -- отримую xml файл відповіді на запит китанції 1/2
        l_buff := get_matching_xml(p_matching_tp    => r.matching_tp,
                                   p_id_msp         => r.id_msp_env,
                                   p_filename       => l_msp_env_content.filename,
                                   p_file           => l_msp_env_content.cvalue,
                                   p_filedate       => l_msp_env_content.insert_dttm,
                                   p_ecp            => l_msp_env_content.ecp,
                                   p_count_verified => l_count_verified,
                                   p_count_total    => l_count_total,
                                   p_count_error    => l_count_error,
                                   p_count_paid     => l_count_paid);
      end if;

      l_match_array.extend;
      l_match_array(l_match_array.last).id := r.id;
      l_match_array(l_match_array.last).bvalue := l_buff;

      pipe row(l_match_array(l_match_array.last));
    end loop;
  exception
    when others then
      raise_application_error(-20000, 'Помилка в функції get_matching. '||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end get_matching2sign;

  -----------------------------------------------------------------------------------------
  --  save_matching
  --
  --    Процедура зберігає зашифрований архів квитанції 1/2. Точка входу: TOSS
  --
  --      p_envelope_id - id конверту
  --      p_file_buff   - clob буфер файлу
  --      p_ecp         - використовується у випадку накладання ЕЦП 2 на готовий файл до відправки
  --
  procedure save_matching(p_envelope_id in msp_envelopes.id%type,
                          p_file_buff   in clob,
                          p_ecp         in clob default null)
  is
    l_state       msp_envelopes.state%type;
    l_comm        msp_envelopes.comm%type;
    l_matching_tp number;
    l_errst       number;
    l_new_state   number;
    ex_unknown_matching exception;
    l_buff        blob;
  begin
    select state, comm into l_state, l_comm from msp_envelopes where id = p_envelope_id;

    l_errst := case when l_state = msp_const.st_env_MATCH1_PROCESSING then msp_const.st_env_MATCH1_CREATE_ERROR
                    when l_state = msp_const.st_env_MATCH1_SIGN_WAIT then msp_const.st_env_MATCH1_ENV_CREATE_ERROR
                    when l_state = msp_const.st_env_MATCH2_PROCESSING then msp_const.st_env_MATCH2_CREATE_ERROR
                    when l_state = msp_const.st_env_MATCH2_SIGN_WAIT then msp_const.st_env_MATCH2_ENV_CREATE_ERROR
               end;

    if l_state = msp_const.st_env_MATCH1_PROCESSING then
      l_new_state   := msp_const.st_env_MATCH1_SIGN_WAIT; -- 12 -- квитанція 1 готова до підписання
      l_matching_tp := 1;
    elsif l_state = msp_const.st_env_MATCH1_SIGN_WAIT then -- 12
      l_new_state   := msp_const.st_env_MATCH1_CREATED; -- 11 -- Квитанція 1 зформована
      l_matching_tp := 1;
    elsif l_state = msp_const.st_env_MATCH2_PROCESSING then
      l_new_state   := msp_const.st_env_MATCH2_SIGN_WAIT; -- 17 -- квитанція 2 готова до підписання
      l_matching_tp := 2;
    elsif l_state = msp_const.st_env_MATCH2_SIGN_WAIT then -- 17
      l_new_state   := msp_const.st_env_MATCH2_CREATED; -- 16 -- Квитанція 2 зформована
      l_matching_tp := 2;
    else
      raise ex_unknown_matching;
    end if;

    set_env_content(p_id      => p_envelope_id,
                    p_value   => p_file_buff,
                    p_type_id => l_matching_tp,
                    p_ecp     => p_ecp);

    set_state_envelope(p_envelope_id,l_new_state);
  exception
    when ex_unknown_matching then
      -- статус не міняю але пишу коментар
      set_state_envelope(p_envelope_id, l_state, 'Помилка збереження файлу квитанції. ' || chr(13) || l_comm);
    when others then
      -- міняю статус і пишу коментар
      set_state_envelope(p_envelope_id, l_errst, 'Помилка збереження файлу квитанції. '||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end save_matching;

  -----------------------------------------------------------------------------------------
  --  decodeclobfrombase64
  --
  --    decode clob from base64
  --
  function decodeclobfrombase64(p_clob clob) return clob is
    l_clob   clob;
    l_len    number;
    l_pos    number := 1;
    l_buf    varchar2(32767);
    l_amount number := 16000;
  begin
    l_len := dbms_lob.getlength(p_clob);
    dbms_lob.createtemporary(l_clob, true);

    while l_pos <= l_len
    loop
      dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
      l_buf := utl_encode.text_decode(l_buf, encoding => utl_encode.base64);
      l_pos := l_pos + l_amount;
      dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
    end loop;

    return l_clob;
  end decodeclobfrombase64;

  -----------------------------------------------------------------------------------------
  --  encodeclobtobase64
  --
  --    encode clob to base64
  --
  function encodeclobtobase64(p_clob clob) return clob is
    l_clob   clob;
    l_len    number;
    l_pos    number := 1;
    l_buf    varchar2(32767);
    l_amount number := 32767;
  begin
    l_len := dbms_lob.getlength(p_clob);
    dbms_lob.createtemporary(l_clob, true);

    while l_pos <= l_len
    loop
      dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
      l_buf := utl_encode.text_encode(l_buf, encoding => utl_encode.base64);
      l_pos := l_pos + l_amount;
      dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
    end loop;

    return l_clob;
  end encodeclobtobase64;

  -----------------------------------------------------------------------------------------
  -- перекодування clob із utf8 в базове кодування
  --
  function utf8todeflang(p_clob in clob) return clob is
    l_blob blob;
    l_clob clob;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
    l_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX;
    l_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
  BEGIN
    DBMS_LOB.CREATETEMPORARY(l_blob, FALSE);
    DBMS_LOB.CONVERTTOBLOB
    (
     dest_lob    =>l_blob,
     src_clob    =>p_clob,
     amount      =>DBMS_LOB.LOBMAXSIZE,
     dest_offset =>l_dest_offset,
     src_offset  =>l_source_offset,
     blob_csid   =>0,
     lang_context=>l_lang_context,
     warning     =>l_warning
    );
    l_dest_offset   := 1;
    l_source_offset := 1;
    l_lang_context  := DBMS_LOB.DEFAULT_LANG_CTX;
    DBMS_LOB.CREATETEMPORARY(l_clob, FALSE);
    DBMS_LOB.CONVERTTOCLOB
    (
     dest_lob    =>l_clob,
     src_blob    =>l_blob,
     amount      =>DBMS_LOB.LOBMAXSIZE,
     dest_offset =>l_dest_offset,
     src_offset  =>l_source_offset,
     blob_csid   =>NLS_CHARSET_ID ('UTF8'),
     lang_context=>l_lang_context,
     warning     =>l_warning
    );
    return l_clob;
  end;

  -----------------------------------------------------------------------------------------
  --  read_request
  --
  --    Функція повертає запис таблиці msp_requests
  --
  function read_request(p_request_id in msp_requests.id%type) return msp_requests%rowtype
  is
    l_request msp_requests%rowtype;
  begin
    select * into l_request from msp_requests where id = p_request_id;
    return l_request;
  end read_request;

  -----------------------------------------------------------------------------------------
  --  read_request_xml
  --
  --    Функція повертає xml таблиці msp_requests
  --
  function read_request_xml(p_request_id in msp_requests.id%type) return msp_requests.req_xml%type
  is
    l_req_xml msp_requests.req_xml%type;
  begin
    select req_xml into l_req_xml from msp_requests where id = p_request_id;
    return l_req_xml;
  end read_request_xml;

  -----------------------------------------------------------------------------------------
  --  read_request_xml
  --
  --    Функція читає xml-файл і повертає екземпляр головного тега
  --
  function read_request_xml(p_request_data in clob) return dbms_xmldom.domnode
  is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_root_node varchar2(30) := 'request';
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_request_data);
    l_doc    := dbms_xmlparser.getdocument(l_parser);
    l_rows   := dbms_xmldom.getelementsbytagname(l_doc, l_root_node);
    return dbms_xmldom.item(l_rows, 0);
  end read_request_xml;

  -----------------------------------------------------------------------------------------
  --  get_request_data
  --
  --    Функція повертає вміст тега "data" xml запиту
  --
  --      p_request_id - msp_requests.id
  --
  function get_request_data(p_request_id in msp_requests.id%type) return clob
  is
    l_req_xml clob;
    l_data    clob;
    l_parser  dbms_xmlparser.parser;
    l_doc     dbms_xmldom.domdocument;
    l_rows    dbms_xmldom.domnodelist;
    l_row     dbms_xmldom.domnode;
  begin
    l_req_xml := read_request_xml(p_request_id);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_req_xml);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'request');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row  := dbms_xmldom.item(l_rows, i);
      l_data := dbms_xslprocessor.valueof(l_row, 'data/text()');
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
    end loop;

    return l_data;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      raise;
  end get_request_data;

  -----------------------------------------------------------------------------------------
  --  get_request_data
  --
  --    Функція повертає вміст тега "data" xml запиту
  --
  --      p_request_xml - msp_requests.req_xml
  --
  function get_request_data(p_request_xml in clob) return clob
  is
    l_data    clob;
    l_parser  dbms_xmlparser.parser;
    l_doc     dbms_xmldom.domdocument;
    l_rows    dbms_xmldom.domnodelist;
    l_row     dbms_xmldom.domnode;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_request_xml);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'request');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row  := dbms_xmldom.item(l_rows, i);
      l_data := dbms_xslprocessor.valueof(l_row, 'data/text()');
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
    end loop;

    return l_data;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      raise;
  end get_request_data;

  -----------------------------------------------------------------------------------------
  --  decode_data
  --
  --    Метод приймає на вхід та повертає розшифрований вміст файла запиту конверта
  --
  --      p_data - вміст файла запиту конверта
  --
  procedure decode_data(p_data in out nocopy clob)
  is
  begin
    -- fix ІОЦ bug (чомусь ІОЦ шле не правильну base64)
    p_data := replace(p_data, ' ', '+');
    -- decode from base64
    p_data := decodeclobfrombase64(p_data);
    -- utf8 to def lang
    p_data := utf8todeflang(p_data);
  end decode_data;

  -----------------------------------------------------------------------------------------
  --  encode_data
  --
  --    Метод приймає на вхід та повертає шифрований вміст файла запиту конверта
  --
  --      p_data - вміст файла запиту конверта
  --
  procedure encode_data(p_data in out nocopy clob)
  is
  begin
    -- encode to base64
    p_data := encodeclobtobase64(p_data);
  end encode_data;


  -----------------------------------------------------------------------------------------
  --  read_request_data
  --
  --    Функція читає xml-файл запиту і повертає екземпляр головного тега
  --
  function read_request_data(p_request_data in clob,
                             p_act_type in msp_requests.act_type%type) return dbms_xmldom.domnode
  is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_root_node varchar2(30) := case p_act_type when msp_const.req_PAYMENT_DATA     then 'request'
                                                when msp_const.req_DATA_STATE       then 'data_state_ask'
                                                when msp_const.req_VALIDATION_STATE then 'validation_state_ask'
                                                                                    else 'root'
                                end;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_request_data);
    l_doc    := dbms_xmlparser.getdocument(l_parser);
    l_rows   := dbms_xmldom.getelementsbytagname(l_doc, l_root_node);
    return dbms_xmldom.item(l_rows, 0);
  end read_request_data;

  -----------------------------------------------------------------------------------------
  --  get_rq_st
  --
  --    Процедура формує атрибути відповіді на запит
  --
  --      p_idenv        - id конверта ІОЦ
  --      p_rq_st        - Код стану запиту (R, S, D)
  --      p_rq_st_detail - Деталі обробки запиту
  --      p_rq_ecp_error - Опис помилки
  --      p_id_msp       - можливо цей параметр вже не потрібний, треба перевірити і замінити на p_idenv
  --
  procedure get_rq_st(p_idenv        in msp_envelopes.id_msp_env%type,
                      p_rq_st        in out nocopy varchar2, -- varchar2(1)
                      p_rq_st_detail in out nocopy number,   -- number(1)
                      p_rq_ecp_error in out nocopy varchar2,
                      p_id_msp       in out nocopy msp_envelope_files_info.id_msp%type)
  is
    l_env_state  msp_envelopes.state%type;
    l_req_state  msp_requests.state%type;
    l_req_id     msp_requests.id%type;
    l_file_state msp_files.state_id%type;
    l_env_comm   msp_envelopes.comm%type;
    l_req_comm   msp_requests.comm%type;
    l_file_comm  msp_files.comm%type;
    --
    ex_error_xml_envelope     exception; -- 3 -- Помилка в структурі xml
    ex_error_ecp_envelope     exception; -- 1 -- Помилка ЕЦП для файлу
    ex_error_ecp_request      exception; -- 6 – помилка ЕЦП для конверту
    ex_error_unique_envelope  exception; -- 7 – помилка унікальності конверту
    ex_error_decrypt_envelope exception; -- 2 -- Помилка розшифрування даних конверту
    ex_error_unpack_envelope  exception; -- 4 -- Помилка при розархівуванні файлу
    ex_parse_error            exception; -- 5 –- помилка при розборі файлу
    ex_r                      exception;
    ex_s                      exception;
    ex_d                      exception;
    --
    procedure retval(rq_st_        in varchar2,
                     rq_st_detail_ in number default null,
                     rq_ecp_error_ in varchar2 default null)
    is
    begin
      p_rq_st        := rq_st_;
      p_rq_st_detail := rq_st_detail_;
      p_rq_ecp_error := rq_ecp_error_;
      return;
    end retval;
    --
  begin
    -- read msp_envelopes state
    begin
      select e.state, substrb(e.comm, 1000), e.id into l_env_state, l_env_comm, l_req_id from msp_envelopes e where e.id_msp_env = p_idenv;
    exception
      when no_data_found then
        -- вважаємо що якщо не знайдений запис по idenv то хибний запит, так як Помилка в структурі xml перевіряється і одразу дається відповідь
        raise ex_d;
      when others then
        raise;
    end;

    -- read msp_requests state
    begin
      select r.state, substrb(r.comm,1000) into l_req_state, l_req_comm from msp_requests r where r.id = l_req_id;
    exception
      when others then
        raise;
    end;

    if l_req_state = msp_const.st_req_ERROR_UNIQUE_ENVELOPE then -- 5
        -- 5 –- помилка унікальності конверту
        raise ex_error_unique_envelope;
    end if;

    -- check if state parsed
    if l_req_state = msp_const.st_req_PARSED and l_env_state not in (-2,-1,1,2,3,4) then
      -- read msp_files state
      begin
        select state, comm, id_msp
        into l_file_state, l_file_comm, p_id_msp
        from (
          select f.state, substrb(f.comm,1000) comm, f.id_msp,
                 -- оприділяю сами поганий статус файлу для формування відповіді
                 row_number() over (order by case when f.state in (2) then 1 when f.state in (-1,1,3,4) then 2 when f.state in (0) then 3 else 4 end) rn
          from msp_envelope_files_info f
          where f.id = l_req_id
          ) t where rn = 1;
      exception
        when no_data_found then
          -- R –- відповідь не готова
          raise ex_r;
        when others then
          raise;
      end;
      -- check file state
      if l_file_state = 0 then
        -- 0 –- запит оброблено успішно
        raise ex_s;
      elsif l_file_state = 2 then
        -- 2 -- PARSE_ERROR Помилка парсингу
        raise ex_parse_error;
      elsif l_file_state in (-1,1,3,4) then
        -- R –- відповідь не готова
        raise ex_r;
      end if;
    -- check bad state
    elsif l_req_state = msp_const.st_req_ERROR_ECP_REQUEST then -- 1
      -- 6 – помилка ЕЦП для конверту
      raise ex_error_ecp_request;
    elsif l_req_state = msp_const.st_req_ERROR_DECRYPT_ENVELOPE then -- 2
      -- 2 -- Помилка розшифрування даних конверту
      raise ex_error_decrypt_envelope;
    elsif l_req_state = msp_const.st_req_ERROR_UNPACK_ENVELOPE then -- 4
      -- 4 -- Помилка при розархівуванні файлу
      raise ex_error_unpack_envelope;
    elsif l_env_state = msp_const.st_env_ERROR_ECP_ENVELOPE then -- 1
      -- 1 -- Помилка ЕЦП для файлу
      raise ex_error_ecp_envelope;
    else
      -- R –- відповідь не готова
      raise ex_r;
    end if;

  exception
    when ex_d then
      retval(rq_st_ => 'D');
    when ex_r then
      retval(rq_st_ => 'R');
    when ex_s then
      retval(rq_st_ => 'S', rq_st_detail_ => 0);
    when ex_error_ecp_request then
      retval(rq_st_ => 'S', rq_st_detail_ => 6, rq_ecp_error_ => l_req_comm);
    when ex_error_decrypt_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 2/*, rq_ecp_error_ => l_req_comm*/);
    when ex_error_unpack_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 4/*, rq_ecp_error_ => l_req_comm*/);
    when ex_error_ecp_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 1, rq_ecp_error_ => l_env_comm);
    when ex_parse_error then
      retval(rq_st_ => 'S', rq_st_detail_ => 5/*, rq_ecp_error_ => l_file_comm*/);
    when ex_error_unique_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 7/*, rq_ecp_error_ => l_file_comm*/);
    when others then
      raise_application_error(-20000, 'Помилка в процедурі підготовки data_state_answer. '|| chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end get_rq_st;

  -----------------------------------------------------------------------------------------
  --  payment_data_answer
  --
  --    Функція готує xml-файл відповіді request_transport_answer на запит payment_data
  --
  --      p_idenv      - id ІОЦ конверту
  --      p_is_bad_xml - ознака xml битий
  --
  function get_payment_data_xml(p_idenv        in msp_envelopes.id_msp_env%type,
                                p_is_bad_xml   in simple_integer default 0) return clob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    l_buff         clob;
    l_rq_st        varchar2(1) := 'S';
    l_rq_st_detail number(1);
  begin
    dbms_lob.createtemporary(l_buff, true, 12);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    -- якщо xml битий то вертаю 3
    if p_is_bad_xml in (0) then
      l_rq_st_detail := 0;
    else
      l_rq_st_detail := 3;
    end if;

    l_head_node    := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'request_transport_answer')));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'id_env');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_idenv);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, l_rq_st);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st_detail');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, l_rq_st_detail);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    return '<?xml version="1.0" encoding="utf-8"?>'||l_buff;
  end get_payment_data_xml;

  -----------------------------------------------------------------------------------------
  --  data_state_answer
  --
  --    Функція готує xml-файл відповіді data_state_answer на запит data_state
  --
  --      p_rq_st        - Код стану запиту (R, S, D)
  --      p_rq_st_detail - Деталі обробки запиту
  --      p_rq_ecp_error - Опис помилки
  --
  function get_data_state_xml(p_id_msp       in msp_envelope_files_info.id_msp%type,
                              p_rq_st        in varchar2,
                              p_rq_st_detail in number,
                              p_rq_ecp_error in varchar2) return clob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    l_buff         clob;
  begin
    dbms_lob.createtemporary(l_buff, true, 12);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    l_head_node    := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'data_state_answer')));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'id_msp');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_id_msp);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_rq_st);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st_detail');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_rq_st_detail);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_ecp_error');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_rq_ecp_error);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    return '<?xml version="1.0" encoding="utf-8"?>'||l_buff;
  end get_data_state_xml;

  -----------------------------------------------------------------------------------------
  --  make_request_data
  --
  --    Функція готує файл відповіді на запит
  --
  --      p_request_data - xml запит
  --      p_act_type     - тип запиту
  --      p_id_env       - id конверта ІОЦ (in out)
  --      p_is_bad_xml   - ознака чи битий xml
  --      p_env_rq_st    - Код стану запиту (R – відповідь не готова, необхідно здійснити повторний запит через короткий проміжок часу, S – запит оброблено успішно, D – запит не може бути оброблено) (out)
  --      p_envelope_id  - id конверта (bars) (out)
  --
  function make_request_data(p_request_data in clob,
                             p_act_type     in msp_requests.act_type%type,
                             p_id_env       in out nocopy msp_envelopes.id_msp_env%type,
                             p_is_bad_xml   in simple_integer default 0,
                             p_env_rq_st    out varchar2,
                             p_envelope_id  out msp_envelopes.id%type) return clob
  is
    l_buff         clob;
    l_row          dbms_xmldom.domnode;
    l_rq_st        varchar2(1);
    l_rq_st_detail number(1);
    l_rq_ecp_error varchar2(1000);
    l_id_msp       msp_envelope_files_info.id_msp%type;
    l_isencode64   boolean := true;
    l_env_state    msp_envelopes.state%type;
    -- перевірка чи зформована квитанція 2, якщо так то повертає статус конверту 'D', інакше 'R'
    function get_match_rq_st(p_id in msp_envelopes.id%type) return varchar2
    is
      l_cnt number;
    begin
      select count(1)
      into l_cnt
      from msp_env_content c
      where id = p_id and type_id = 2;

      if l_cnt > 0 then
        return 'D';
      else
        return 'R';
      end if;
    end get_match_rq_st;
    --
  begin
    begin
      -- читаю параметри запиту
      l_row := read_request_data(p_request_data, p_act_type);
      -- читаю id конверта ІОЦ із xml
      p_id_env := coalesce(to_number(dbms_xslprocessor.valueof(l_row, 'idenv/text()')), p_id_env);

      --dbms_output.put_line('p_id_env='||p_id_env);
      --dbms_output.put_line('p_request_data='||p_request_data);

      if p_act_type = msp_const.req_PAYMENT_DATA /*1*/ then
        -- підготовка xml відповіді
        l_buff := get_payment_data_xml(p_idenv        => p_id_env,
                                       p_is_bad_xml   => p_is_bad_xml);
      elsif p_act_type = msp_const.req_DATA_STATE /*3*/ then
        begin
          -- отримаємо параметри відповіді
          get_rq_st(p_idenv        => p_id_env,
                    p_rq_st        => l_rq_st,
                    p_rq_st_detail => l_rq_st_detail,
                    p_rq_ecp_error => l_rq_ecp_error,
                    p_id_msp       => l_id_msp);
          -- підготовка xml відповіді
          l_buff := get_data_state_xml(p_id_msp       => l_id_msp,
                                       p_rq_st        => l_rq_st,
                                       p_rq_st_detail => l_rq_st_detail,
                                       p_rq_ecp_error => l_rq_ecp_error);
        exception
          when others then
            if sqlcode = -31011 then -- помилка структури вкладеного xml файлу
              l_buff := get_data_state_xml(p_id_msp       => null,
                                           p_rq_st        => 'S',
                                           p_rq_st_detail => 3,
                                           p_rq_ecp_error => null);
            else
              raise;
            end if;
        end;
      elsif p_act_type = msp_const.req_VALIDATION_STATE /*4*/ then
        begin
          select id, state into p_envelope_id, l_env_state from msp_envelopes e where e.id_msp_env = p_id_env;
          -- підготовка xml відповіді
          begin
            -- якщо квитанція 1 зформована або відправлена то відправляю квитанцію 1 і код стану запиту S – запит оброблено успішно
            if l_env_state in (msp_const.st_env_MATCH1_CREATED, msp_const.st_env_MATCH1_SEND) then
              select cvalue
              into l_buff
              from msp_env_content c
              where id = p_envelope_id and type_id = 1;
              p_env_rq_st  := 'S';
            -- якщо квитанція 2 зформована або відправлена то відправляю D – запит не може бути оброблено
            elsif l_env_state in (msp_const.st_env_MATCH2_CREATED, msp_const.st_env_MATCH2_SEND) then
              p_env_rq_st  := 'D';
            -- інакше R – відповідь не готова, необхідно здійснити повторний запит через короткий проміжок часу
            else
              p_env_rq_st  := 'R';
            end if;
          exception
            when no_data_found then
              -- перевірка чи зформована квитанція 2, якщо так то повертає статус конверту 'D', інакше 'R'
              p_env_rq_st := get_match_rq_st(p_id => p_envelope_id);
          end;
          l_isencode64 := false;
        exception
          when no_data_found then
            p_env_rq_st := 'R';
        end;
      elsif p_act_type = msp_const.req_PAYMENT_STATE /*5*/ then
        begin
          select id, state into p_envelope_id, l_env_state from msp_envelopes e where e.id_msp_env = p_id_env;
          -- підготовка xml відповіді
          -- якщо квитанція 2 зформована або відправлена то відправляю квитанцію 2 і код стану запиту S – запит оброблено успішно
          if l_env_state in (msp_const.st_env_MATCH2_CREATED, msp_const.st_env_MATCH2_SEND) then
            select cvalue
            into l_buff
            from msp_env_content c
            where id = p_envelope_id and type_id = 2;
            p_env_rq_st  := 'S';
          -- інакше R – відповідь не готова, необхідно здійснити повторний запит через короткий проміжок часу
          else
            p_env_rq_st  := 'R';
          end if;
          -- квитанція 2 вже зашифрована в base64
          l_isencode64 := false;
        exception
          when no_data_found then
            -- якщо не знайдено квитанцію то R – відповідь не готова, необхідно здійснити повторний запит через короткий проміжок часу
            p_env_rq_st := 'R';
        end;
      end if;
    exception
      when others then
        raise;
    end;
    -- перетворення в base64
    if l_buff is not null and l_isencode64 then
      encode_data(l_buff);
    end if;

    return l_buff;
  end make_request_data;

  -----------------------------------------------------------------------------------------
  --  make_envelope
  --
  --    Функція готує xml відповідь на запит
  --
  --      p_action_name - назва типу відповіді
  --      p_idenv       - id конверта ІОЦ
  --      p_data        - файл відповіді
  --      p_env_rq_st   - Код стану запиту (R – відповідь не готова, необхідно здійснити повторний запит через короткий проміжок часу, S – запит оброблено успішно, D – запит не може бути оброблено) (out)
  --
  function make_envelope(p_action_name in varchar2,
                         p_idenv       in number,
                         p_data        in clob default null,
                         p_env_rq_st   in varchar2 default null) return clob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    --
    l_buff         clob;
    --
    l_code         varchar2(30);
    l_from         varchar2(30);
    l_to           varchar2(30);
    l_partnumber   number(2);
    l_parttotal    number(2);
  begin
    dbms_lob.createtemporary(l_buff, true, 12);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'request')));

    l_from       := 'Bars';
    l_to         := 'IOC';
    l_partnumber := 1;
    l_parttotal  := 1;

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'code',
                     p_node_text => p_action_name);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'idenv',
                     p_node_text => to_char(p_idenv));

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'from',
                     p_node_text => l_from);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'to',
                     p_node_text => l_to);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'partnumber',
                     p_node_text => to_char(l_partnumber));

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'parttotal',
                     p_node_text => to_char(l_parttotal));

    add_clb_node_utl(p_document       => l_domdoc,
                     p_host_node      => l_head_node,
                     p_node_name      => 'data',
                     p_node_text_clob => p_data);

    if p_env_rq_st is not null then
      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'rq_st',
                       p_node_text => p_env_rq_st);
    end if;

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    return '<?xml version="1.0" encoding="utf-8"?>'||l_buff;
  end make_envelope;

  -----------------------------------------------------------------------------------------
  --  check_is_bad_xml
  --
  --    Перевірка коректності xml, return: 0 - xml коректний / 1 - xml битий
  --
  --    p_xml - xml, який потрібно перевірити на коректність
  --
  function check_is_bad_xml(p_xml in clob) return simple_integer
  is
    l_data    clob;
    l_parser  dbms_xmlparser.parser;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_xml);

    return 0;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      return 1;
  end check_is_bad_xml;

  -----------------------------------------------------------------------------------------
  --  payment_data_ans
  --
  --    Підготовка відповіді на запит payment_data
  --
  --    p_request    - запис запиту msp_requests
  --    p_id_env     - id конверта ІОЦ
  --    p_is_bad_xml - ознака чи битий xml
  --
  function payment_data_ans(p_request    in msp_requests%rowtype,
                            p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                            p_is_bad_xml in simple_integer) return clob
  is
    l_buff        clob;
    l_env_rq_st   varchar2(1);
    l_envelope_id msp_envelopes.id%type;
  begin
    l_buff := make_request_data(p_request.req_xml, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st, l_envelope_id);
    l_buff := make_envelope(p_action_name => 'payment_data_ans',
                            p_idenv       => p_id_env,
                            p_data        => l_buff);
    return l_buff;
  end payment_data_ans;

  -----------------------------------------------------------------------------------------
  --  data_state_ans
  --
  --    Підготовка відповіді на запит data_state
  --
  --    p_request    - запис запиту msp_requests
  --    p_id_env     - id конверта ІОЦ
  --    p_is_bad_xml - ознака чи битий xml
  --
  function data_state_ans(p_request    in msp_requests%rowtype,
                          p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                          p_is_bad_xml in simple_integer) return clob
  is
    l_buff        clob;
    l_env_rq_st   varchar2(1);
    l_envelope_id msp_envelopes.id%type;
  begin
    -- отримую параметри xml запиту data_state
    l_buff := get_request_data(p_request.req_xml);
    -- перетворення із base64
    decode_data(l_buff);
    -- підготовка файлу відповіді
    l_buff := make_request_data(l_buff, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st, l_envelope_id);
    -- підготовка конверту
    l_buff := make_envelope(p_action_name => 'data_state_ans',
                            p_idenv       => p_id_env,
                            p_data        => l_buff);
    -- якщо все ок то міняю стан запиту state = 0 - Ok - PARSED
    msp_utl.set_state_request(p_request.id, 0);
    return l_buff;
  end data_state_ans;

  -----------------------------------------------------------------------------------------
  --  validation_state_ans
  --
  --    Підготовка відповіді на запит validation_state
  --
  --    p_request    - запис запиту msp_requests
  --    p_id_env     - id конверта ІОЦ
  --    p_is_bad_xml - ознака чи битий xml
  --
  function validation_state_ans(p_request    in msp_requests%rowtype,
                                p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                                p_is_bad_xml in simple_integer) return clob
  is
    l_buff        clob;
    l_env_rq_st   varchar2(1);
    l_envelope_id msp_envelopes.id%type;
  begin
    -- отримую параметри xml запиту validation_state
    l_buff := get_request_data(p_request.req_xml);
    -- перетворення із base64
    decode_data(l_buff);
    -- підготовка файлу відповіді
    l_buff := make_request_data(l_buff, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st, l_envelope_id);
    -- підготовка конверту
    l_buff := make_envelope(p_action_name => 'validation_state_answer',
                            p_idenv       => p_id_env,
                            p_data        => l_buff,
                            p_env_rq_st   => l_env_rq_st);
    -- якщо все ок то проставляю статус квит1 відправлена
    if l_env_rq_st = 'S' then
      set_state_envelope(p_id    => l_envelope_id,
                         p_state => msp_const.st_env_MATCH1_SEND);
    end if;
    -- якщо все ок то міняю стан запиту state = 0 - Ok - PARSED
    msp_utl.set_state_request(p_request.id, 0);
    return l_buff;
  end validation_state_ans;

  -----------------------------------------------------------------------------------------
  --  payment_state_ans
  --
  --    Підготовка відповіді на запит payment_state
  --
  --    p_request    - запис запиту msp_requests
  --    p_id_env     - id конверта ІОЦ
  --    p_is_bad_xml - ознака чи битий xml
  --
  function payment_state_ans(p_request    in msp_requests%rowtype,
                             p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                             p_is_bad_xml in simple_integer) return clob
  is
    l_buff        clob;
    l_env_rq_st   varchar2(1);
    l_envelope_id msp_envelopes.id%type;
  begin
    -- отримую параметри xml запиту payment_state
    l_buff := get_request_data(p_request.req_xml);
    -- перетворення із base64
    decode_data(l_buff);
    -- підготовка файлу відповіді
    l_buff := make_request_data(l_buff, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st, l_envelope_id);
    -- підготовка конверту
    l_buff := make_envelope(p_action_name => 'payment_state_answer',
                            p_idenv       => p_id_env,
                            p_data        => l_buff,
                            p_env_rq_st   => l_env_rq_st);
    -- якщо все ок то проставляю статус квит2 відправлена
    if l_env_rq_st = 'S' then
      set_state_envelope(p_id    => l_envelope_id,
                         p_state => msp_const.st_env_MATCH2_SEND);
    end if;
    -- якщо все ок то міняю стан запиту state = 0 - Ok - PARSED
    msp_utl.set_state_request(p_request.id, 0);
    return l_buff;
  end payment_state_ans;

  -----------------------------------------------------------------------------------------
  --  prepare_request_xml
  --
  --    Функція готує xml відповідь на запит
  --
  --    p_request_id - id запиту
  --
  function prepare_request_xml(p_request_id in msp_requests.id%type) return clob
  is
    l_buff       clob;
    l_request    msp_requests%rowtype;
    l_id_env     msp_envelopes.id_msp_env%type;
    l_row        dbms_xmldom.domnode;
    l_is_bad_xml simple_integer := 0;
  begin
    -- читання запиту
    l_request := read_request(p_request_id);

    -- перевірка xml
    l_is_bad_xml := check_is_bad_xml(l_request.req_xml);

    -- зчитую спочатку idenv конверта, на випадок якщо xml-data битий
    if l_is_bad_xml = 0 then
      l_row := read_request_xml(l_request.req_xml);
      l_id_env := to_number(dbms_xslprocessor.valueof(l_row, 'idenv/text()'));
    end if;

    if l_request.act_type = msp_const.req_PAYMENT_DATA then -- 1
      -- підготовка файлу відповіді payment_data_ans
      l_buff := payment_data_ans(p_request    => l_request,
                                 p_id_env     => l_id_env,
                                 p_is_bad_xml => l_is_bad_xml);
    elsif l_request.act_type = msp_const.req_DATA_STATE then -- 3
      -- підготовка файлу відповіді data_state_ans
      l_buff := data_state_ans(p_request    => l_request,
                               p_id_env     => l_id_env,
                               p_is_bad_xml => l_is_bad_xml);
    elsif l_request.act_type = msp_const.req_VALIDATION_STATE then -- 4
      -- підготовка файлу відповіді validation_state_ans
      l_buff := validation_state_ans(p_request    => l_request,
                                     p_id_env     => l_id_env,
                                     p_is_bad_xml => l_is_bad_xml);
    elsif l_request.act_type = msp_const.req_PAYMENT_STATE then -- 5
      -- підготовка файлу відповіді payment_state_ans
      l_buff := payment_state_ans(p_request    => l_request,
                                  p_id_env     => l_id_env,
                                  p_is_bad_xml => l_is_bad_xml);
    end if;

    return l_buff;
  end prepare_request_xml;

  -----------------------------------------------------------------------------------------
  --  track_request
  --
  --    Лог відповіді на запит
  --
  --      p_request_id  - id запиту
  --      p_response    - текст запиту
  --      p_stack_trace - опис помилки
  --
  procedure track_request(p_request_id  in msp_request_tracking.id%type,
                          p_response    in msp_request_tracking.response%type,
                          p_stack_trace in msp_request_tracking.stack_trace%type default null)
  is
  begin
    insert into msp_request_tracking (id, response, stack_trace, state)
    values (p_request_id, p_response, p_stack_trace, case when p_stack_trace is null then null else 1 end);
  exception
    when others then
      raise_application_error(-20000, 'Помилка в процедурі msp_utl.track_request. '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end track_request;

  -----------------------------------------------------------------------------------------
  --  create_request
  --
  --    Процедура записує запит в базу даних і формує відповідь
  --    TOSS розшифровує запит і визиває метод і отримує відповідь p_xml
  --
  --      p_req_xml  - xml запит
  --      p_act_type - тип запиту
  --      p_xml      - відповідь на запит
  --
  procedure create_request(p_req_xml  in clob,
                           p_act_type in number,
                           p_xml      out clob)
  is
    l_id     msp_requests.id%type;
    l_errmsg clob;
  begin
    begin
      l_id := msp_request_seq.nextval;

      insert into msp_requests(id, req_xml, state, act_type)
      values (l_id, p_req_xml, -1, p_act_type);

      -- підготовка відповіді на запит
      p_xml := prepare_request_xml(l_id);
    exception
      when others then
        l_errmsg := dbms_utility.format_error_backtrace || chr(10) || sqlerrm;
    end;

    -- пишу відповідь в таблицю msp_request_tracking для історії
    track_request(p_request_id  => l_id,
                  p_response    => p_xml,
                  p_stack_trace => l_errmsg);
    commit;

    if l_errmsg is not null then
      raise_application_error(-20001, l_errmsg);
    end if;
  exception
    when others then
      raise_application_error(-20000, 'Помилка в процедурі create_request. ' || chr(10) || dbms_utility.format_error_backtrace || chr(10) || sqlerrm);
  end create_request;

  -----------------------------------------------------------------------------------------
  --  prepare_check_state
  --
  --    підготовка запиту для РУ-шок на перевірку станів оплати референсів по ЕБП
  --
  procedure prepare_check_state
   is
    l_file_lines        bars.number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_count             integer;
    l_date              date;
    l_idr               number;
  begin
    -- Блокуємо рядки перед обробкою
--    bars.bc.go('300465');
    for rec_mfo in (select p.kf mfo from pfu.pfu_syncru_params p) loop
      select count(*)
        into l_count
        from v_msp_file_records t
       where t.state_id = 20
         and t.mfo = rec_mfo.mfo;
      if (l_count > 0) then
        l_doc       := dbms_xmldom.newDomDocument;
        l_root_node := dbms_xmldom.makeNode(l_doc);
        l_root_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'root')));

        l_header_node := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'header')));
        l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'body')));

        select t.ref
          bulk collect
          into l_file_lines
          from v_msp_file_records t
         where t.state_id = 20
           and t.mfo = rec_mfo.mfo;

        if (l_file_lines is not empty) then
          for i in (select column_value ref from table(l_file_lines)) loop

            select O.PDAT
              into l_date
              from bars.oper o
             where o.ref = i.ref;

            select f.id
              into l_idr
              from v_msp_file_records f
             where f.ref = i.ref;

              l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                   'row')));
              add_txt_node_utl(l_doc,
                                l_row_node,
                                'ref',
                                MOD(i.ref, 1000000000));
              add_txt_node_utl(l_doc, l_row_node, 'pdat', to_char(l_date,'dd.mm.yyyy'));
              add_txt_node_utl(l_doc, l_row_node, 'idr', l_idr);


          end loop;
          --TRANS_TYPE_CHECKSTATE проставляємо тип  4    CHECKPAYMSTATE  Опитування статусу платежу
          l_transport_unit_id := pfu.transport_utl.create_transport_unit(pfu.transport_utl.TRANS_TYPE_CHECKSTATE_MSP,
                                                                     rec_mfo.mfo,
                                                                     pfu.transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end if;
      end if;
    end loop;
    commit;
  end prepare_check_state;

  -----------------------------------------------------------------------------------------
  --  prepare_get_rest_request
  --
  --    підготовка запиту на перевірку станів оплати референсів по ЕБП
  --
  --      p_acc    - рахунок 2909
  --      p_fileid - id реєстра
  --      p_kf     - відділення
  --
  procedure prepare_get_rest_request(
                               p_acc    in msp_acc_trans_2909.acc_num%type,
                               p_fileid in msp_files.id%type,
                               p_kf     in msp_acc_trans_2909.kf%type)
     is
      l_doc               dbms_xmldom.DOMDocument;
      l_root_node         dbms_xmldom.DOMNode;
      l_header_node       dbms_xmldom.DOMNode;
      l_body_node         dbms_xmldom.DOMNode;
      l_transport_unit_id integer;
    begin
      -- Блокуємо рядки перед обробкою
      l_doc       := dbms_xmldom.newDomDocument;
      l_root_node := dbms_xmldom.makeNode(l_doc);
      l_root_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'root')));

      l_header_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'header')));
      l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'body')));

      add_txt_node_utl(l_doc, l_body_node, 'acc', p_acc);
      add_txt_node_utl(l_doc, l_body_node, 'fileid', p_fileid);

      merge into msp_acc_rest ar
      using dual
      ON (ar.fileid = p_fileid)
      when matched then
        update set ar.rest = null, ar.restdate = sysdate, ar.acc = p_acc
      when not matched then
        insert values (p_acc, null, sysdate, p_fileid);
      begin
        l_transport_unit_id := pfu.transport_utl.create_transport_unit(pfu.transport_utl.TRANS_TYPE_MSP_GET_ACC_RST,
                                                                   p_kf,
                                                                   pfu.transport_utl.get_receiver_url(ltrim(p_kf,
                                                                                                        '0')),
                                                                   dbms_xmldom.getXmlType(l_doc)
                                                                   .getClobVal());
      end;
  end prepare_get_rest_request;

  -----------------------------------------------------------------------------------------
  --  create_envelope
  --
  --    Процедура записує розібрані дані конверта в базу даних
  --    TOSS іде по списку нових запитів в бд (стан запиту = -1), розшифровує запит, парсить і зберігає відповідні дані
  --
  --      p_id          - id запиту
  --      p_idenv       - id конверта ІОЦ
  --      p_code        - Код запиту від ІОЦ
  --      p_sender      - Відправник пакету
  --      p_recipient   - Отримувач пакету
  --      p_part_number - Порядковий номер частини конверту
  --      p_part_total  - Загальна к-ть частин конверту
  --      p_ecp         - ЕЦП, який був накладений в ІОЦ
  --      p_data        - Зашифрований конверт
  --      p_data_decode - Розшифрований конверт (base64)
  --
  procedure create_envelope(
    p_id          in msp_requests.id%type,
    p_idenv       in msp_envelopes.id_msp_env%type default null,
    p_code        in msp_envelopes.code%type       default null,
    p_sender      in msp_envelopes.sender%type     default null,
    p_recipient   in msp_envelopes.recipient%type  default null,
    p_part_number in msp_envelopes.partnumber%type default null,
    p_part_total  in msp_envelopes.parttotal%type  default null,
    p_ecp         in clob default null,
    p_data        in clob default null,
    p_data_decode in clob default null)
  is
    l_clob              clob;
    l_domdoc            dbms_xmldom.domdocument;
    l_root_node         dbms_xmldom.domnode;
    l_supp_element      dbms_xmldom.domelement;
    l_supp_node         dbms_xmldom.domnode;
    l_supp_text         dbms_xmldom.domtext;
    l_sup_node          dbms_xmldom.domnode;
    l_supp_tnode        dbms_xmldom.domnode;
  begin
    --bars.bars_audit.info('msp_utl.create_envelope_file start');
    dbms_lob.createtemporary(l_clob, true, 12);

    merge into msp_envelopes e
    using dual on (e.id = p_id)
    when matched then
      update set e.id_msp_env  = coalesce(p_idenv, e.id_msp_env),
                 e.code        = coalesce(p_code, e.code),
                 e.sender      = coalesce(p_sender, e.sender),
                 e.recipient   = coalesce(p_recipient, e.recipient),
                 e.partnumber  = coalesce(p_part_number, e.partnumber),
                 e.parttotal   = coalesce(p_part_total, e.parttotal),
                 e.ecp         = coalesce(p_ecp, e.ecp),
                 e.data        = coalesce(p_data, e.data),
                 e.data_decode = coalesce(p_data_decode, e.data_decode),
                 e.state       = -1,
                 e.filename    = null
    when not matched then
      insert values (p_id, p_idenv, p_code, p_sender, p_recipient, p_part_number, p_part_total, p_ecp, p_data, p_data_decode, -2, null, sysdate, null);

    -- запит розібраний успішно
    msp_utl.set_state_request(p_id, 0);
    commit;
    --bars.bars_audit.info('msp_utl.create_envelope_file start finish');
  exception
    when others then
      if sqlcode in (-1) then -- ORA-00001: unique constraint -- Помилка унікальності конверту
        msp_utl.set_state_request(p_id, 5, sqlerrm);
        commit;
      else
        raise_application_error(-20000, 'Помилка реєстрації конверту. '|| chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
      end if;
  end create_envelope;

  -----------------------------------------------------------------------------------------
  --  create_envelope_file
  --
  --    Процедура записує розібрані дані реєстрів конверта в базу даних
  --    TOSS іде по списку нових конвертів в бд (стан конверта = -1), парсить конверти і записує параметри реєстрів конверта
  --
  --      p_id       - id запиту / конверта
  --      p_id_msp   - id конверта ІОЦ
  --      p_filedata - текстовий файл реєстра
  --      p_filename - назва файлу реєстра
  --      p_filedate - дата файлу реєстра (ІОЦ)
  --      p_filepath - назва файлу в архіві
  --
  procedure create_envelope_file(
    p_id       in msp_envelopes.id%type,
    p_id_msp   in msp_envelope_files_info.id_msp%type,
    p_filedata in msp_envelope_files.filedata%type,
    p_filename in msp_envelope_files_info.filename%type,
    p_filedate in varchar2, -- в TOSS прописано string
    p_filepath in msp_envelope_files_info.filepath%type)
  is
    l_state number;
  begin
    /*
    bars.bars_audit.info('msp_utl.create_envelope_file start p_id='||to_char(p_id)||', '||
                                                             'p_id_msp='||to_char(p_id_msp)||', '||
                                                             'p_filename='||p_filename||', '||
                                                             'p_filedate='||p_filedate||', '||
                                                             'p_filepath='||p_filepath
                                                             );
    */
    
    select state into l_state from msp_envelopes where id = p_id;

    -- якщо стан конверта новий значить ще не оброблявся, добавляю інфу по реєстрам
    if l_state in (-1) then
      -- Інформаційний запис до файлів конвертів
      insert into msp_envelope_files_info(id, id_msp, filename, filedate, state, comm, filepath,id_file)
      values (p_id, p_id_msp, p_filename, to_date(p_filedate,'ddmmyyyyhh24miss'), -1, null, p_filepath, msp_file_seq.nextval);
      -- сам текстовий файл
      insert into msp_envelope_files(id, filedata)
      values (p_id, p_filedata);
      -- оновлюю назву файла конверта
      update msp_envelopes set filename = p_filename where id = p_id;
      -- якщо все ок
      msp_utl.set_state_envelope(p_id, 0);
      commit;
    --bars.bars_audit.info('msp_utl.create_envelope_file finish');
    end if;
  exception
    when others then
      bars.bars_audit.info('msp_utl.create_envelope_file error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
      raise_application_error(-20000, 'msp_utl.create_envelope_file error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end create_envelope_file;



  -----------------------------------------------------------------------------------------
  --  set_file_rest
  --
  --    оновлення залишку
  --
  procedure set_file_rest(p_file_data in clob,
                                      p_file_id   in number) is
    l_parser   dbms_xmlparser.parser;
    l_doc      dbms_xmldom.domdocument;
    l_rows     dbms_xmldom.domnodelist;
    l_row      dbms_xmldom.domnode;
    l_acc      varchar2(20);
    l_rest     number;
    l_fileid   number;
  begin

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

    l_row := dbms_xmldom.item(l_rows, 0);

    l_rest   := to_number(dbms_xslprocessor.valueof(l_row, 'ostc/text()'));
    l_acc    := to_number(dbms_xslprocessor.valueof(l_row, 'acc/text()'));
    l_fileid := to_number(dbms_xslprocessor.valueof(l_row, 'fileid/text()'));

    merge into msp_acc_rest ar
    using  dual ON (ar.fileid = l_fileid)
    when matched then
      update set ar.rest = l_rest,
                 ar.restdate = sysdate,
                 ar.acc = l_acc
    when not matched then
      insert values(l_acc,
                    l_rest,
                    sysdate,
                    l_fileid);

    pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                      p_state_id         => pfu.transport_utl.trans_state_done,
                                      p_tracking_comment => 'Файл оброблено',
                                      p_stack_trace      => null);
    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);
    commit;
    exception
      when others then
          pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                      p_state_id         => pfu.transport_utl.TRANS_STATE_FAILED,
                                      p_tracking_comment => 'Ошибка обработки',
                                      p_stack_trace      => dbms_utility.format_error_backtrace());

  end;

  -----------------------------------------------------------------------------------------
  --  check_state
  --
  --    оновлення стану оплати референсів по ЕБП
  --
  procedure check_state          (p_file_data in clob,
                                 p_file_id   in number) is
    l_parser   dbms_xmlparser.parser;
    l_doc      dbms_xmldom.domdocument;
    l_rows     dbms_xmldom.domnodelist;
    l_row      dbms_xmldom.domnode;
    l_ref      number;
    l_state    number;
    l_cnt      number;
    l_cnt2     number;
    l_fileid   msp_file_records.file_id%type;
    l_idr      msp_file_records.id%type;
    l_mfo      pfu.pfu_syncru_params.kf%type;
    l_arr_fileid   bars.number_list := bars.number_list();
    l_i            number;
  begin

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    select t.kf
      into l_mfo
      from pfu.transport_unit t
     where t.id = p_file_id;

    select count(*) into l_cnt2
      from bars.mv_kf s
     where s.kf = l_mfo;

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop

      l_row     := dbms_xmldom.item(l_rows, i);
      l_ref     := to_number(dbms_xslprocessor.valueof(l_row, 'ref/text()'));
      l_state   := to_number(dbms_xslprocessor.valueof(l_row, 'state_id/text()'));
      l_idr     := to_number(dbms_xslprocessor.valueof(l_row, 'idr/text()'));

      update msp_file_records mfr
         set mfr.state_id = case when l_state != 0
                              then 99
                              when l_state = 0  -- платеж закрыт
                              then 10
                              else mfr.state_id
                              end,
             mfr.fact_pay_date = sysdate
       where mfr.id = l_idr
       returning mfr.file_id into l_fileid;

       if l_fileid not member of l_arr_fileid then
         l_arr_fileid.extend;
         l_arr_fileid(l_arr_fileid.last) := l_fileid;
       end if;
    end loop;

       -- если все проставляем для файла статус оплачен

    update msp_files mf
       set mf.state_id = 9 --'PAYED'
     where mf.id in (select column_value
                       from table(l_arr_fileid))
       and not exists (select 1
                         from msp_file_records mfr
                        where mfr.file_id = mf.id
                          and mfr.state_id in (17,19,20,99));

    pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                          p_state_id         => pfu.transport_utl.trans_state_done,
                                          p_tracking_comment => 'Файл оброблено',
                                          p_stack_trace      => null);
    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);
    exception
      when others then
          pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                                p_state_id         => pfu.transport_utl.TRANS_STATE_FAILED,
                                                p_tracking_comment => 'Ошибка обработки',
                                                p_stack_trace      => dbms_utility.format_error_backtrace());

  end;


  -----------------------------------------------------------------------------------------
  --  process_receipt
  --
  --    Оновлення залишку та оновлення стану оплати референсів по ЕБП
  --
  procedure process_receipt is

    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

  begin
    for c0 in (select t.*, tt.transport_type_code
                 from pfu.transport_unit t
                 join pfu.transport_unit_type tt
                   on t.unit_type_id = tt.id
                  and tt.transport_type_code in
                      (pfu.transport_utl.TRANS_TYPE_MSP_GET_ACC_RST,
                       pfu.transport_utl.TRANS_TYPE_CHECKSTATE_MSP)
                  and t.state_id = pfu.transport_utl.TRANS_STATE_RESPONDED) loop
      declare
        l_clob         clob;
        l_tmpb         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;

      begin
        dbms_lob.createtemporary(l_clob, false);
        savepoint before_transaction;

        l_tmpb := utl_compress.lz_uncompress(c0.response_data);

        dbms_lob.converttoclob(dest_lob     => l_clob,
                               src_blob     => l_tmpb,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);


        if c0.transport_type_code = pfu.transport_utl.TRANS_TYPE_MSP_GET_ACC_RST then
          -- оновлення залишку
          set_file_rest(l_clob, c0.id);
        elsif c0.transport_type_code = pfu.transport_utl.TRANS_TYPE_CHECKSTATE_MSP then
          -- оновлення стану оплати референсів по ЕБП
          check_state(l_clob,c0.id);
        end if;
        dbms_lob.freetemporary(l_clob);
      exception
        when others then
          dbms_lob.freetemporary(l_clob);
          rollback to before_transaction;
      end;
    end loop;
  end;

begin
  -- Initialization
  null;
end msp_utl;
/

show err;
 
PROMPT *** Create  grants  msp_utl ***
grant execute on msp.msp_utl to bars_access_defrole;
  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/package/msp_utl.sql =========*** End *** 
PROMPT =====================================================================================
