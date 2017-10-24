
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/naek.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NAEK is

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.00 17/02/2009';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- prepare_files - готовит файлы для отправки
  --
  procedure prepare_files;

  ----
  -- prepare_files - готовит файлы для отправки
  --
  procedure set_file_state(
    p_fileyear in naek_headers.file_year%type,
    p_filename in naek_headers.file_name%type,
    p_state    in naek_headers.state%type);

  ----
  -- get_file_clob - возвращает файл в виде CLOB'a
  --
  function get_file_clob(
    p_fileyear in naek_headers.file_year%type,
    p_filename in naek_headers.file_name%type
  ) return clob;

  ----
  -- get_current_year - получить текущий год(из банковской даты)
  --
  function get_current_year return integer;

  ----
  -- process_receipt - обработка квитанции
  --
  procedure process_receipt;

end naek;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.NAEK is

  G_BODY_DEFS constant varchar2(512) := '';

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.03 14/08/2009';

  -- маска формата для преобразования char <--> number
  g_summa_format      constant varchar2(128) := 'FM9999999999999999999990.00';
  g_currate_format    constant varchar2(128) := 'FM9999999999999999999990.0000';
  -- параметры преобразования char <--> number
  g_number_nlsparam   constant varchar2(30)  := 'NLS_NUMERIC_CHARACTERS = ''. ''';

  -- global variables
  g_corpvisa        integer;        -- Код групи візування "Корпоративний контроль"
  g_corpvisa_hex    varchar2(2);    -- Код групи візування "Корпоративний контроль" (hex)

  g_backatom_par    params.par%type := 'BACKATOM'; -- имя параметра для код причины отказа от визы Энергоатома

  g_backatom_id     bp_reason.id%type;  -- код причины отказа от визы Энергоатома

  g_backatom_txt     bp_reason.reason%type;  -- описание причины отказа от визы Энергоатома

  g_nba             banks.nb%type;  -- наименование своего банка

  g_backv_tag       constant op_field.tag%type := 'BACKV';  -- имя тэга 'BACKV'

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package NAEK header '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package NAEK body '||G_BODY_VERSION||'awk: '||G_BODY_DEFS;
  end body_version;

  ----
  -- prepare_files - готовит файлы для отправки
  --
  procedure prepare_files is
    l_rnk   customer.rnk%type;
    l_ecode naek_ecounters.ecode%type;
    type t_file_list is table of naek_headers%rowtype index by naek_ecounters.ecode%type;
    l_file_info     naek_headers%rowtype;
    l_file_list     t_file_list;
    l_md            varchar2(2);
    l_naek_ecounter naek_ecounters%rowtype;
    l_doc           naek_lines%rowtype;
    l_nbb           banks.nb%type;
    l_rat_o         number;
    l_rat_b         number;
    l_rat_s         number;
  begin
    --
    for d in (select o.* from oper o, ref_que q
              where o.ref=q.ref and o.nextVisaGrp=g_corpvisa_hex
              and q.ref not in (select ref from naek_lines
                                where case when processed='N' then ref else null end is not null))
    loop
        select rnk into l_rnk from accounts where nls=d.nlsa and kv=d.kv;
        begin
            select ecode into l_ecode from naek_customer_map where rnk=l_rnk;
        exception when no_data_found then
            raise_application_error(-20000, 'Клиент RNK='||l_rnk||' не зарегистрирован в таблице "NAEK_CUSTOMER_MAP"', true);
        end;
        -- ищем запись о текущем файле
        begin
            l_file_info := l_file_list(l_ecode);
        exception when no_data_found then
            select * into l_naek_ecounter from naek_ecounters where ecode=l_ecode;
            -- сегодня еще ничего не формировалось по данному клиенту ?
            if l_naek_ecounter.dat<>gl.bDATE then
                update naek_ecounters set dat=gl.bDATE, cnt=0 where ecode=l_ecode;
            end if;
            -- инкрементируем счетчик
            update naek_ecounters set cnt=cnt+1 where ecode=l_ecode returning cnt into l_naek_ecounter.cnt;
            -- начинаем формирование нового файла
            l_md := sep.h2_rrp(to_number(to_char(gl.bdate,'MM')))||sep.h2_rrp(to_number(to_char(gl.bdate,'DD')));
            l_file_info.file_year := extract(year from gl.bDATE);
            l_file_info.file_name := upper('^P'||l_ecode||l_md||'.'||lpad(l_naek_ecounter.cnt,3,'0'));
            l_file_info.make_time := sysdate;
            l_file_info.lines_count := 0;
            l_file_info.state     := 0;
            --
            insert into naek_headers values l_file_info;
            --
            l_file_list(l_ecode) := l_file_info;
        end;
        --
        l_file_info.lines_count := l_file_info.lines_count + 1;
        --
        if d.mfob<>gl.aMFO then
            select trim(nb) into l_nbb from banks where mfo=d.mfob;
        else
            l_nbb := g_nba;
        end if;
        -- получаем курс
        gl.x_rat(l_rat_o, l_rat_b, l_rat_s, d.kv, gl.baseVal);
        -- добавляем документ в файл
        l_doc.file_year         := l_file_info.file_year;
        l_doc.file_name         := l_file_info.file_name;
        l_doc.line_no           := l_file_info.lines_count;
        l_doc.visa_flag         := '0';
        l_doc.doc_num           := trim(d.nd);
        l_doc.doc_date          := d.datd;
        l_doc.doc_value_date    := d.vdat;
        l_doc.payer_name        := trim(d.nam_a);
        l_doc.payer_id          := trim(d.id_a);
        l_doc.payer_bank_name   := g_nba;
        l_doc.payer_bank_code   := trim(d.mfoa);
        l_doc.payer_account     := trim(d.nlsa);
        l_doc.payee_name        := trim(d.nam_b);
        l_doc.payee_id          := trim(d.id_b);
        l_doc.payee_bank_name   := l_nbb;
        l_doc.payee_bank_code   := trim(d.mfob);
        l_doc.payee_account     := trim(d.nlsb);
        l_doc.currency          := d.kv;
        l_doc.summa             := d.s/100;
        l_doc.currency_rate     := l_rat_o;
        l_doc.narrative         := trim(d.nazn);
        l_doc.dk                := d.dk;
        l_doc.ref               := d.ref;
        l_doc.ord               := 1;
        l_doc.processed         := 'N';
        insert into naek_lines values l_doc;
        -- увеличивем кол-во строк в заголовке
        update naek_headers set lines_count=l_file_info.lines_count
        where file_year=l_file_info.file_year and file_name=l_file_info.file_name;
        --
        l_file_list(l_ecode) := l_file_info;
    end loop;
  end prepare_files;

  ----
  -- prepare_files - готовит файлы для отправки
  --
  procedure set_file_state(
    p_fileyear in naek_headers.file_year%type,
    p_filename in naek_headers.file_name%type,
    p_state    in naek_headers.state%type) is
  begin
    update naek_headers set state=p_state
    where file_year=p_fileyear and file_name=p_filename;
    if sql%rowcount=0 then
        raise_application_error(-20000, 'Файл не найден: '||p_filename||', год '||p_fileyear, true);
    end if;
  end set_file_state;

  ----
  -- get_file_clob - возвращает файл в виде CLOB'a
  --
  function get_file_clob(
    p_fileyear in naek_headers.file_year%type,
    p_filename in naek_headers.file_name%type
  ) return clob is
    l_body clob;
    l_line varchar2(1024);
    l_pipe constant varchar2(1) := chr(124);
  begin
    dbms_lob.createTemporary(l_body, true, dbms_lob.call);
    for c in (select * from naek_lines where file_year=p_fileyear and file_name=p_filename
              order by line_no)
    loop
        l_line := l_pipe||c.visa_flag
                ||l_pipe||lpad(c.doc_num, 10)
                ||l_pipe||to_char(c.doc_date, 'DD.MM.YYYY')
                ||l_pipe||to_char(c.doc_value_date, 'DD.MM.YYYY')
                ||l_pipe||lpad(c.payer_name, 38)
                ||l_pipe||lpad(c.payer_id, 12)
                ||l_pipe||lpad(c.payer_bank_name, 38)
                ||l_pipe||lpad(c.payer_bank_code, 9)
                ||l_pipe||lpad(c.payer_account, 14)
                ||l_pipe||lpad(c.payee_name, 38)
                ||l_pipe||lpad(c.payee_id, 12)
                ||l_pipe||lpad(c.payee_bank_name, 38)
                ||l_pipe||lpad(c.payee_bank_code, 9)
                ||l_pipe||lpad(c.payee_account, 14)
                ||l_pipe||to_char(c.currency)
                ||l_pipe||lpad(to_char(c.summa, g_summa_format, g_number_nlsparam), 16)
                ||l_pipe||lpad(to_char(c.currency_rate, g_currate_format, g_number_nlsparam), 9)
                ||l_pipe||lpad(c.narrative, 160)
                ||l_pipe||to_char(c.dk)
                ||l_pipe||lpad(to_char(c.ref), 14)
                ||l_pipe||lpad(to_char(c.ord), 5)
                ||l_pipe||lpad(lower(c.file_name), 14)
                ||l_pipe||chr(13)||chr(10);
        dbms_lob.writeAppend(l_body, length(l_line), l_line);
        /*
        -- это для теста, потом убрать
        for i in 1..1000 loop
            dbms_lob.writeAppend(l_body, length(l_line), l_line);
        end loop;
        */
    end loop;
    if l_body is null then
        raise_application_error(-20000, 'Файл не найден: '||p_filename||', год '||p_fileyear, true);
    end if;
    return l_body;
  end get_file_clob;

  procedure init is
  begin
    -- сначала прочитаем имя своего банка
    select trim(nb) into g_nba from banks where mfo=gl.aMFO;
    --
    begin
        select to_number(val) into g_corpvisa from params where par='CORPVISA';
    exception when no_data_found then
        raise_application_error(-20000, 'Параметр CORPVISA не найден');
    end;
    g_corpvisa_hex := chk.to_hex(g_corpvisa);
    begin
        select to_number(val) into g_backatom_id from params where par=g_backatom_par;
    exception when no_data_found then
        raise_application_error(-20000, 'Параметр '||g_backatom_par||' не найден');
    end;
    select reason into g_backatom_txt from bp_reason where id=g_backatom_id;
  end init;

  ----
  -- get_current_year - получить текущий год(из банковской даты)
  --
  function get_current_year return integer is
  begin
    return extract(year from gl.bDATE);
  end get_current_year;

  ----
  -- process_receipt_row - обработка строки квитанции(платежа)
  --
  procedure process_receipt_row(p_row in naek_lines%rowtype) is
    l_row   naek_lines%rowtype;
    l_par2  number;
    l_par3  varchar2(16);
    l_tt    oper.tt%type;
    --
    procedure throw(p_field in varchar2) is
    begin
        raise_application_error(-20000, 'Несовпадение реквизита "'||p_field||'", строка '||l_row.line_no, true);
    end throw;
  begin
    begin
        select * into l_row from naek_lines where file_year=p_row.file_year and file_name=p_row.file_name and line_no=p_row.line_no;
    exception when no_data_found then
        raise_application_error(-20000, 'Документ не найден: file_year='||p_row.file_year||', file_name='||p_row.file_name||', line_no='||p_row.line_no, true);
    end;
    -- все реквизиты должны совпадать !!!
    if l_row.doc_num<>p_row.doc_num then
        throw('Номер документа');
    end if;
    if l_row.doc_date<>p_row.doc_date then
        throw('Дата документа');
    end if;
    if l_row.doc_value_date<>p_row.doc_value_date then
        throw('Дата валютирования документа');
    end if;
    if l_row.payer_name<>p_row.payer_name then
        throw('Имя плательщика');
    end if;
    if l_row.payer_id<>p_row.payer_id then
        throw('ID плательщика');
    end if;
    if l_row.payer_bank_name<>p_row.payer_bank_name then
        throw('Банк плательщика');
    end if;
    if l_row.payer_bank_code<>p_row.payer_bank_code then
        throw('Код банка плательщика');
    end if;
    if l_row.payer_account<>p_row.payer_account then
        throw('Счет плательщика');
    end if;
    if l_row.payee_name<>p_row.payee_name then
        throw('Имя получателя');
    end if;
    if l_row.payee_id<>p_row.payee_id then
        throw('ID получателя');
    end if;
    if l_row.payee_bank_name<>p_row.payee_bank_name then
        throw('Банк получателя');
    end if;
    if l_row.payee_bank_code<>p_row.payee_bank_code then
        throw('Код банка получателя');
    end if;
    if l_row.payee_account<>p_row.payee_account then
        throw('Счет получателя');
    end if;
    if l_row.currency<>p_row.currency then
        throw('Валюта');
    end if;
    if l_row.summa<>p_row.summa then
        throw('Сумма');
    end if;
    if l_row.currency_rate<>p_row.currency_rate then
        throw('Курс');
    end if;
    if l_row.narrative<>p_row.narrative then
        throw('Назначение платежа');
    end if;
    if l_row.dk<>p_row.dk then
        throw('Д/К');
    end if;
    if l_row.ref<>p_row.ref then
        throw('Референс документа');
    end if;
    if l_row.ord<>p_row.ord then
        throw('Номер проводки в док-те');
    end if;
    if (p_row.visa_flag='0') then
        -- отказ от визирования
        -- сейчас просят сразу сторнировать документ
        p_back_dok (
            Ref_        => l_row.ref,
            Lev_        => 3,
            ReasonId_   => g_backatom_id,
            Par2_       => l_par2,
            Par3_       => l_par3,
            FullBack_   => 1);
        /*
        -- возвращаем на предыдущую визу
        -- и указываем причину возврата
        chk.back_last_visa(p_ref => l_row.ref, p_reasonid => g_backatom_id);
        --
        delete from operw where ref=l_row.ref and tag=g_backv_tag;
        insert into operw(ref, tag, value) values(l_row.ref, g_backv_tag, g_backatom_txt);
        --
        */
    elsif(p_row.visa_flag='1') then
        select tt into l_tt from oper where ref=l_row.ref;
        chk.put_visa(
            ref_        => l_row.ref,
            tt_         => l_tt,
            grp_        => g_corpvisa,
            status_     => 1,
            keyid_      => null,
            sign1_      => null,
            sign2_      => null);
    else
        raise_application_error(-20000, 'Неизвестный флаг визы: "'||p_row.visa_flag||'"', true);
    end if;
    -- помечаем строку как обработанную
    update naek_lines set processed='Y', visa_flag=l_row.visa_flag
    where file_year=l_row.file_year and file_name=l_row.file_name and line_no=l_row.line_no;
  end process_receipt_row;

  ----
  -- process_receipt - обработка квитанции
  --
  procedure process_receipt is
    l_clob      clob;
    l_clob_size number;
    l_row_size  constant integer := 500; -- размер строки(вместе с CRLF)
    l_pos       number;
    l_row_str   varchar2(500);
    l_header    naek_headers%rowtype;
    l_row       naek_lines%rowtype;
    l_line_no   integer := 0;
  begin
    bars_audit.trace('process_receipt: start');
    select naek.get_current_year(), upper(file_name), c
    into l_row.file_year, l_row.file_name, l_clob
    from tmp_naek_clob;
    l_clob_size := length(l_clob);
    bars_audit.trace('process_receipt: clob size='||l_clob_size);
    if (mod(l_clob_size, l_row_size)<>0) then
        raise_application_error(-20000, 'Размер файла не кратен размеру строки', true);
    end if;
    -- проверка состояния визируемого файла
    begin
        select * into l_header from naek_headers where file_year=l_row.file_year and file_name=l_row.file_name;
    exception when no_data_found then
        raise_application_error(-20000, 'Файл не найден: год='||l_row.file_year||', имя='||l_row.file_name, true);
    end;
    if l_header.state<>3 then
        raise_application_error(-20000, 'Попытка квитовки файла с состоянием '||l_header.state||'(<>3)');
    end if;
    dbms_lob.open(l_clob, dbms_lob.lob_readonly);
    l_pos := 1;
    while(l_pos<=l_clob_size)
    loop
        l_row_str := dbms_lob.substr(l_clob, l_row_size, l_pos);
        l_line_no := l_line_no + 1;
        l_row.line_no           := l_line_no;
        l_row.visa_flag         := substr(l_row_str, 2, 1);
        l_row.doc_num           := trim(substr(l_row_str, 4, 10));
        l_row.doc_date          := to_date(substr(l_row_str, 15, 10), 'DD.MM.YYYY');
        l_row.doc_value_date    := to_date(substr(l_row_str, 26, 10), 'DD.MM.YYYY');
        l_row.payer_name        := trim(substr(l_row_str, 37, 38));
        l_row.payer_id          := trim(substr(l_row_str, 76, 12));
        l_row.payer_bank_name   := trim(substr(l_row_str, 89, 38));
        l_row.payer_bank_code   := trim(substr(l_row_str, 128, 9));
        l_row.payer_account     := trim(substr(l_row_str, 138, 14));
        l_row.payee_name        := trim(substr(l_row_str, 153, 38));
        l_row.payee_id          := trim(substr(l_row_str, 192, 12));
        l_row.payee_bank_name   := trim(substr(l_row_str, 205, 38));
        l_row.payee_bank_code   := trim(substr(l_row_str, 244, 9));
        l_row.payee_account     := trim(substr(l_row_str, 254, 14));
        l_row.currency          := to_number(substr(l_row_str, 269, 3));
        l_row.summa             := to_number(substr(l_row_str, 273, 16), g_summa_format, g_number_nlsparam);
        l_row.currency_rate     := to_number(substr(l_row_str, 290, 9), g_currate_format, g_number_nlsparam);
        l_row.narrative         := trim(substr(l_row_str, 300, 160));
        l_row.dk                := to_number(substr(l_row_str, 461, 1));
        l_row.ref               := to_number(substr(l_row_str, 463, 14));
        l_row.ord               := to_number(substr(l_row_str, 478, 5));
        --
        process_receipt_row(l_row);
        -- разбираем строку файла
        l_pos := l_pos + l_row_size;
    end loop;
    dbms_lob.close(l_clob);
    -- помечаем файл как сквитованный
    set_file_state(l_row.file_year, l_row.file_name, 5);
    --
    bars_audit.trace('process_receipt: finish');
  end process_receipt;

begin
  init;
end naek;
/
 show err;
 
PROMPT *** Create  grants  NAEK ***
grant EXECUTE                                                                on NAEK            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAEK            to TOSS;
grant EXECUTE                                                                on NAEK            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/naek.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 