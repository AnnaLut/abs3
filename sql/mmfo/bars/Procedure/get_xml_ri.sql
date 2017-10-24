create or replace procedure get_xml_ri(
    p_filexml  in  varchar2,
    p_filekvt  in  varchar2,
    p_ku       in  varchar2,
    p_key      in  number,
    p_ret      out integer,
    p_err      out varchar2)
is
    l_parser            xmlparser.parser := xmlparser.newparser;
    l_doc               xmldom.domdocument;
    l_head              xmldom.domnodelist;
    l_rirow             xmldom.domnodelist;
    l_headelement       xmldom.domnode;
    l_rirowelement      xmldom.domnode;
    l_clob              clob;
    l_fname             varchar2(12);
    l_file_check_sum    varchar2(254);
    l_local_check_sum   number;
    l_fdate             varchar2(12);
    l_ftime             varchar2(12);
    l_rnum              varchar2(12);

    l_idcode            varchar2(12);
    l_doct              varchar2(2);
    l_docs              varchar2(10);
    l_docn              varchar2(10);
    l_insform           varchar2(12);
    l_k060              varchar2(12);

    l_dateri            date;
    l_current_branch    varchar2(30 char) := bars_context.current_branch_code();

    procedure build_receipt
    is
        l_receipt_date           varchar2(12);
        l_receipt_time           varchar2(12);
        l_receipt_clob           clob;
        l_receipt_file_check_sum varchar2(254);
        l_header                 xmltype;
        l_xml_data               xmltype;
    begin
        l_receipt_date := to_char(sysdate,'dd.mm.yyyy');
        l_receipt_time := to_char(sysdate,'hh24:mi:ss');
        l_receipt_file_check_sum := to_char(sumascii(p_filekvt) + sumascii(p_ku) + sumascii(l_receipt_date) + sumascii(l_receipt_time));

        --сформировать квитанцию xml в таблицу tmp_ri_clob !!!
        select xmlelement("HEAD", xmlforest(p_filekvt                  "FNAME",
                                            l_receipt_file_check_sum   "FSIGN",
                                            p_ku                       "KU",
                                            l_receipt_date             "FDATE",
                                            l_receipt_time             "FTIME"))
        into   l_header
        from   dual;

        select xmlelement("DECLARATION",
                          xmlattributes('RI_P.XSD' as "xsi:noNamespaceSchemaLocation",
                                        'http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi"),
               xmlconcat(l_header,
                         xmlelement("PROCBODY",
                                    xmlconcat(xmlelement("RIFNAME"     , p_filexml),
                                              xmlelement("PROC_ERR"    , case when p_ret = 0 then 0 else 1 end),
                                              xmlelement("PROC_COMMENT", nvl(p_err, 'OK')),
                                              xmlelement("PROC_INFO",
                                              xmlagg(xmlelement("CUSTOMER",
                                                     xmlelement("RNK"             , rnk             ),
                                                     xmlelement("BRANCH"          , branch          ),
                                                     xmlelement("CUSTTYPE"        , custtype        ),
                                                     xmlelement("OKPO"            , okpo            ),
                                                     xmlelement("PASSP"           , passp           ),
                                                     xmlelement("SER"             , ser             ),
                                                     xmlelement("NUMDOC"          , numdoc          ),
                                                     xmlelement("PRINSIDER"       , prinsider       ),
                                                     xmlelement("INSFO"           , insfo           ),
                                                     xmlelement("PRINSIDER_BEFORE", prinsider_before),
                                                     xmlelement("INSFO_BEFORE"    , insfo_before    ))))))))
        into   l_xml_data
        from   (select distinct * from tmp_ri_cust);

        dbms_lob.createtemporary(l_receipt_clob,false);
        dbms_lob.append(l_receipt_clob,'<?xml version="1.0" encoding="windows-1251"?>');
        dbms_lob.append(l_receipt_clob, l_xml_data.getclobval());

        delete tmp_ri_cust;

        delete tmp_ri_clob;

        insert into tmp_ri_clob (c, namef)
        values (l_receipt_clob, 2);
    end;
begin

    p_ret := 0;
    p_err := null;

    bars_audit.info('GET_XML_RI: ' || p_filexml || ' start');

    begin
        select replace(replace(replace(c, chr(38), chr(38) || 'amp;'), chr(38) || chr(38) || 'amp;', chr(38) || 'amp;'), chr(38) || 'amp;amp;', chr(38) || 'amp;')
        into   l_clob
        from   tmp_ri_clob
        where  namef = to_char(p_key);

        bars_audit.info('GET_XML_RI: ' || p_filexml || ' loaded into clob');
    exception when no_data_found then
        bars_audit.error('GET_XML_RI(-7): ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
        p_ret := -7;
        p_err := 'Помилка при завантаженні файлу ' || p_filexml || ' в таблицю (clob) для обробки';
        return;
    end;

    --очистка CUSTOMER_RI
    begin
        delete customer_ri;
    exception when others then
        bars_audit.error('GET_XML_RI(-8): ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
        p_ret := -8;
        p_err := 'Помилка -10008: при виконанні очистки таблиці реєстра інсайдерів: ' || sqlerrm;
        build_receipt();
        return;
    end;

    bars_audit.info('GET_XML_RI: ' || p_filexml || ' the table of CUSTOMER_RI is cleared');

    xmlparser.parseclob(l_parser,l_clob);

    l_doc := xmlparser.getdocument(l_parser);

    l_head := xmldom.getelementsbytagname(l_doc, 'HEAD');

    for m in 0..xmldom.getlength(l_head) - 1 loop
        l_headelement := xmldom.item(l_head, m);

        xslprocessor.valueof(l_headelement, 'FNAME/text()', l_fname);
        xslprocessor.valueof(l_headelement, 'FSIGN/text()', l_file_check_sum);
        xslprocessor.valueof(l_headelement, 'FDATE/text()', l_fdate);
        xslprocessor.valueof(l_headelement, 'FTIME/text()', l_ftime);
        xslprocessor.valueof(l_headelement, 'RNUM/text()' , l_rnum);
    end loop;

    bars_audit.info('GET_XML_RI: ' || p_filexml || ' прочитан заголовок');

    if l_fname is null then
        p_ret := -1;
        p_err := 'Помилка -10001: не заповнений тег FNAME';
        build_receipt();
        return;
    end if;

    if upper(l_fname) <> upper(p_filexml) then
        p_ret := -5;
        p_err := 'Помилка -10005: значення тега FNAME не співпадає з іменем XML-файлу';
        build_receipt();
        return;
    end if;

    if l_fdate is null then
        p_ret := -2;
        p_err := 'Помилка -10002: не заповнений тег FDATE';
        build_receipt();
        return;
    end if;

    if l_ftime is null then
        p_ret := -3;
        p_err := 'Помилка -10003: не заповнений тег FTIME';
        build_receipt();
        return;
    end if;

    if l_file_check_sum is null then
        p_ret := -4;
        p_err := 'Помилка -10004: не заповнений тег FSIGN';
        build_receipt();
        return;
    end if;

    l_local_check_sum := sumascii(l_fname) + sumascii(l_fdate) + sumascii(l_ftime) + sumascii(l_rnum);

    l_rirow := xmldom.getelementsbytagname(l_doc, 'RIROW');

    for i in 0..xmldom.getlength(l_rirow)-1 loop

        l_rirowelement := xmldom.item(l_rirow, i);
        xslprocessor.valueof(l_rirowelement, 'IDCODE/text()', l_idcode);

        begin
            xslprocessor.valueof(l_rirowelement, 'DOCT/text()', l_doct);
        exception when others then
            l_doct := null;
        end;

        begin
            xslprocessor.valueof(l_rirowelement, 'DOCS/text()', l_docs);
        exception when others then
            l_docs := null;
        end;

        if ascii(l_docs)=10 then
            l_docs := null;
        end if;

        begin
            xslprocessor.valueof(l_rirowelement, 'DOCN/text()', l_docn);
        exception when others then
            l_docn := null;
        end;

        if ascii(l_docn) = 10 then
            l_docn := null;
        end if;

        xslprocessor.valueof(l_rirowelement, 'INSFORM/text()', l_insform);
        xslprocessor.valueof(l_rirowelement, 'K060/text()', l_k060);

        if l_idcode is null then
            p_ret := -9;
            p_err := 'Помилка -10009: не заповнене IDCODE - ROW = ' || to_char(i + 1);
            exit;
        end if;

        if not isnumber(l_idcode) then
            p_ret := -10;
            p_err := 'Помилка -10010: IDCODE не числове - ROW = ' || to_char(i + 1);
            exit;
        end if;

        if l_insform is null then
            p_ret := -11;
            p_err := 'Помилка -10011: не заповнене INSFORM - ROW = ' || to_char(i + 1);
            exit;
        end if;

        if l_insform not in ('0','1') then
            p_ret := -12;
            p_err := 'Помилка -10012: неприпустиме значення INSFORM - ROW = ' || to_char(i + 1);
            exit;
        end if;

        if l_k060 is null then
            p_ret := -13;
            p_err := 'Помилка -10013: не заповнене K060 - ROW = ' || to_char(i + 1);
            exit;
        end if;

        if l_file_check_sum is not null then
            l_local_check_sum := l_local_check_sum + sumascii(l_idcode) + sumascii(l_doct) + sumascii(l_docs) + sumascii(l_docn) + sumascii(l_insform) + sumascii(l_k060);
        end if;

        begin
            l_dateri := to_date(substr(p_filexml, 3, 6), 'DDMMYY');
        exception when others then
            l_dateri := trunc(sysdate);
        end;

        begin
            insert into customer_ri
             values (bars_sqnc.get_nextval('s_customer_ri'),        -- id        number 
                     l_idcode,                                      -- idcode    varchar2(10)   Код за ЄДРПОУ/ДРФО
                     l_doct,                                        -- doct      number(2)      Тип документа
                     l_docs,                                        -- docs      varchar2(10)   Серія документа
                     l_docn,                                        -- docn      varchar2(10)   Номер документа
                     l_insform,                                     -- insform   number(1)      Ознака наявності анкети інсайдера (0-ні,1-так)
                     l_k060,                                        -- k060      number(2)      Код ознаки інсайдера
                     p_filexml,                                     -- fileri    varchar2(12)   файл
                     l_dateri);                                     -- dateri    date           дата файлу
        exception when others then
            if sqlcode = -1 then -- дублирование ключа игнорируется
                null;
            else
                bars_audit.error('GET_XML_RI(-16): ' || sqlerrm || ' ' || dbms_utility.format_error_backtrace);
                p_ret := -16;
                p_err := 'Помилка -10016: при вставці в таблицю реєстра інсайдерів: ' || sqlerrm;
                exit;
            end if;
        end;
    end loop;

    if l_file_check_sum != to_char(l_local_check_sum) then
        p_ret := -15;
        p_err := 'Помилка -10015: невірна контрольна сума (не рівна значенню тега FSIGN)';
        build_receipt();
        return;
    end if;

    bars_audit.info('GET_XML_RI: '||p_filexml||' прочитаны инф.строки');

    if p_ret = 0 then
        --  основная обработка всех клиентов aбс
        begin
            for i in (select bars_context.extract_mfo(b.branch) kf
                      from   v_user_branches b
                      where  bars_context.is_mfo(b.branch) = 1) loop

                bars_context.go(i.kf);
                get_ri;

                bars_audit.info('GET_XML_RI: '||p_filexml||' основная обработка +');
            end loop;
        exception when others then
            bars_context.go(l_current_branch);
            bars_audit.error('GET_XML_RI: '||sqlerrm||' '||dbms_utility.format_error_backtrace);
            p_ret := -17;
            p_err := 'Помилка '||to_char(p_ret)||
                     ' при выполнении GET_RI (занесение данных по инсайдерам)';
        end;
    end if;

    bars_context.go(l_current_branch);

    build_receipt();

    bars_audit.info('GET_XML_RI: '||p_filexml||' finish');
end;
/
show err;
