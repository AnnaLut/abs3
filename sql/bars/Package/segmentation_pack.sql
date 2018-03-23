CREATE OR REPLACE PACKAGE BARS.SEGMENTATION_PACK
IS
  --
  -- пакет процедур для обробки інформації по сегментації клієнтів від DWH. Ощадбанк
  --
  g_header_version  CONSTANT  VARCHAR2(64)  := 'version 1.4  01.10.2017';

  FUNCTION header_version RETURN varchar2;

  FUNCTION body_version RETURN varchar2;

  PROCEDURE InsertNewPackage(p_package_id     in dwh_log.package_id%type,
                             p_package_data   in dwh_log.package_data%type,
                             p_package_type   in dwh_log.package_type%type,
                             p_bank_date      in dwh_log.bank_date%type,
                             p_kf             in dwh_log.kf%type);

  procedure parse(p_package_id in number);

  procedure parse_last_pack;

END SEGMENTATION_PACK;
/
show errors

CREATE OR REPLACE PACKAGE BODY BARS.segmentation_pack IS
  g_body_version CONSTANT VARCHAR2(64) := 'version 1.4  01.10.2017';

  TYPE parse_result IS RECORD(
     status      VARCHAR2(20)
    ,description VARCHAR2(2000));

  g_parse_result parse_result;
  --
  -- повертає версію заголовка пакета
  --
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header SEGMENTATION_PACK ' || g_header_version || '.';
  END header_version;

  --
  -- повертає версію тіла пакета
  --
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body SEGMENTATION_PACK ' || g_body_version || '.';
  END body_version;

  PROCEDURE InsertNewPackage(p_package_id     in dwh_log.package_id%type,
                             p_package_data   in dwh_log.package_data%type,
                             p_package_type   in dwh_log.package_type%type,
                             p_bank_date      in dwh_log.bank_date%type,
                             p_kf             in dwh_log.kf%type) is
  BEGIN
    insert into dwh_log
      (package_id, package_data, recieved_date, package_status, package_type, bank_date, kf)
    values
      (p_package_id, p_package_data, sysdate, 'DELIVERED', p_package_type, p_bank_date, p_kf);
    commit work;
  END InsertNewPackage;

  PROCEDURE set_package_status(p_package_id IN dwh_log.package_id%TYPE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE dwh_log
       SET package_status = g_parse_result.status
          ,package_error  = g_parse_result.description
     WHERE package_id = p_package_id;
    COMMIT WORK;
  END set_package_status;

  function udf_to_number(ps_numero string) return number is
  begin
    -- Хуйегознает какой разделитель DWH пошлет для чисел, терь будем парсить все, уже раз нарвались
    return to_number(ps_numero, '999999999999999D99999', 'NLS_NUMERIC_CHARACTERS = ''' || regexp_substr(ps_numero, '\D') || 'G ' || '');
  end udf_to_number;

  PROCEDURE parse_capacity(p_package_id IN NUMBER) IS

    l_dwhlog_row dwh_log%rowtype;
--    l_clob   CLOB;
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    x             xmltype;
    l_dwh_rnk     string(38);
    l_gr          string(38);
    l_nm          string(38);
    l_pt          string(38);
    l_rnk         customer.rnk%TYPE;
    l_error_count pls_integer := 0;
    l_tmp_cnt     pls_integer := 0;
--    l_bankdate    DATE;
    l_date_off    DATE;
  BEGIN
    bars.bars_audit.info('segmentation_pack.parse_capacity - start. package №' || to_char(p_package_id));

    execute immediate q'#alter session set nls_date_format = 'DD.MM.YYYY'#';

--    SELECT package_data, to_date(bank_date, 'DD.MM.YYYY') INTO l_clob, l_bankdate
    SELECT * INTO l_dwhlog_row
      FROM dwh_log
     WHERE package_id = p_package_id;

    bars.bars_audit.info('segmentation_pack.parse_capacity - CLOB selected');

    /*
    x := xmltype.createxml (clob_in);

    BARS.BARS_AUDIT.INFO (
       'SEGMENTATION_PACK: parse_capacity - XML created');


    FOR R
       IN (SELECT EXTRACTVALUE (VALUE (P), '/rw/rnk/text()') AS rnk,
                  EXTRACTVALUE (VALUE (P), '/rw/gr/text()') AS gr,
                  EXTRACTVALUE (VALUE (P), '/rw/nm/text()') AS nm,
                  EXTRACTVALUE (VALUE (P), '/rw/pt/text()') AS pt
             FROM TABLE (XMLSEQUENCE (EXTRACT (X, '//packagedata/rw'))) P) */
    l_parser := dbms_xmlparser.newparser;
--    dbms_xmlparser.parseclob(l_parser, l_clob);
    dbms_xmlparser.parseclob(l_parser, l_dwhlog_row.package_data);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'rw');

    FOR i IN 0 .. dbms_xmldom.getlength(l_rows) - 1

    LOOP
      SAVEPOINT before_customer;

      l_row := dbms_xmldom.item(l_rows, i);

      dbms_xslprocessor.valueof(l_row, 'rnk/text()', l_dwh_rnk);
      l_dwh_rnk := bars_sqnc.rukey(l_dwh_rnk, l_dwhlog_row.kf);

      dbms_xslprocessor.valueof(l_row, 'gr/text()', l_gr);  -- номер прод.группы
--      dbms_xslprocessor.valueof(l_row, 'nm/text()', l_nm);  -- количество продуктов
      dbms_xslprocessor.valueof(l_row, 'pt/text()', l_pt);  -- баллы

      l_date_off := NULL;
      l_rnk      := NULL;

      IF (MOD(l_tmp_cnt, 1000) = 0) THEN
        bars.bars_audit.info('segmentation_pack.parse_capacity - in LOOP. row ' || to_char(l_tmp_cnt));
      END IF;

      BEGIN
        SELECT t1.rnk, t1.date_off
          INTO l_rnk, l_date_off
          FROM customer t1
         WHERE rnk = to_number(l_dwh_rnk)
           AND custtype = 3 --AND T1.SED <> '91'--and date_off is null
        ;

        IF (l_date_off IS NOT NULL) THEN
          continue;
          --дані по закритим клієнтам не зберігаємо.
        END IF;

        /* insert into test_customer_segments(package_id, rnk,  s1,  s2,  s3,  s4,  s5,  s6,   s1d1,  s2d1 , s2d2,      s3d1,    s4d1  )
                                           values (p_package_id, R.rnk,R.s1,R.s2,R.s3,R.s4,R.s5,R.s6,l_bankdate, to_date(R.s2d1, 'DD.MM.YYYY'), to_date(R.s2d2, 'DD.MM.YYYY'), l_bankdate, l_bankdate );

        */ --TODO:розібратись куди писати pt

        CASE l_gr
          WHEN '0' THEN
            -- сегмент проднавантаження
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_SEGMENT_PRODUCTS_AMNT',
                                         udf_to_number(l_pt),
--                                       l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '1' THEN
            -- Депозити
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_DPT',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '2' THEN
            -- Кредити (під заставу)
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_CREDITS',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '3' THEN
            -- Кредити с БПК
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_CRDCARDS',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '4' THEN
            -- Кредити під поруку
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_CRD_GARANT',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '5' THEN
            -- Кредити Енергоефективність
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_CRDENERGY',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '6' THEN
            -- БПК
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_CARDS',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '7' THEN
            -- Поточні рахунки
            bars.attribute_utl.set_value(l_rnk,
                                         'CUSTOMER_PRDCT_AMNT_ACC',
                                         udf_to_number(l_pt),
                                         -- l_bankdate,
                                         to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'),
                                         cast(null as date));
          WHEN '8' THEN
            -- Індивідуальні сейфи
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES', udf_to_number(l_pt));
          WHEN '9' THEN
            -- Кеш-кредити
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_CASHLOANS', udf_to_number(l_pt));
          WHEN '10' THEN
            -- Встановлені кредитні лінії на БПК
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE', udf_to_number(l_pt));
          WHEN '11' THEN
            -- Страхування «Автоцивілка»
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA', udf_to_number(l_pt));
          WHEN '12' THEN
            -- Страхування «Автоцивілка+»
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+', udf_to_number(l_pt));
          WHEN '13' THEN
            -- Страхування «Оберіг»
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG', udf_to_number(l_pt));
          WHEN '14' THEN
            -- Страхування життя (Кеш)
            bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_PRDCT_AMNT_INSURANCE_CASH', udf_to_number(l_pt));
        END CASE;

      EXCEPTION
        WHEN no_data_found THEN
          l_error_count := l_error_count + 1;

          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || l_dwh_rnk || ' not found.';
          END IF;
        WHEN OTHERS THEN
          l_error_count := l_error_count + 1;
          bars.bars_audit.error('segmentation_pack.parse_capacity, rnk=' || l_dwh_rnk || chr(13) || chr(10) || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace);

          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || l_dwh_rnk || '. SQLCode=' || sqlcode || chr(13) || chr(10);
          END IF;
      END;

      l_tmp_cnt := l_tmp_cnt + 1;
    END LOOP;

    bars.bars_audit.info('segmentation_pack.parse_capacity - LOOP ended. ');

    g_parse_result.status      := 'PARSED';
    set_package_status(p_package_id);

  END parse_capacity;
  /*
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);

      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'rw');

      dbms_output.put_line(dbms_xmldom.getlength(l_analyticlist));
      for i in 0 .. least(dbms_xmldom.getlength(l_analyticlist) - 1, 100) loop

         l_analytic := dbms_xmldom.item(l_analyticlist, i);

         dbms_xslprocessor.valueof(l_analytic, 's1/text()', l_str);
         dbms_output.put_line(l_str);
  */
  PROCEDURE parse_segments(p_package_id IN NUMBER) IS
    l_dwhlog_row dwh_log%rowtype;
    --    l_clob CLOB;

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    l_rnk         customer.rnk%TYPE;
    l_error_count pls_integer := 0;
    l_tmp_cnt     pls_integer := 0;
    --    l_bank_date   DATE;
    l_date_off DATE;

    l_dwh_rnk                      string(38);
    l_ACTIVITY                     string(38);
    l_FINANCIAL                    string(38);
    l_FINANCIAL_VALID_FROM         string(10);
    l_FINANCIAL_VALID_UNTIL        string(10);
    l_BEHAVIOR                     string(38);
    l_TRANSACTIONS                 string(38);
    l_ATM                          string(38);
    l_BPK_CREDITLINE               string(38);
    l_CASHCREDIT_GIVEN             string(38);
    l_CASHCREDIT_GIVEN_VALID_FROM  string(10);
    l_CASHCREDIT_GIVEN_VALID_UNTIL string(10);
  BEGIN
    bars.bars_audit.info('segmentation_pack.parse_segments: p_package_id : ' || to_char(p_package_id));

    execute immediate q'#alter session set nls_date_format = 'DD.MM.YYYY'#';

--    SELECT package_data, to_date(bank_date, 'dd.mm.yyyy') INTO l_clob, l_bank_date
    select * into l_dwhlog_row from dwh_log where package_id = p_package_id;

    l_parser := dbms_xmlparser.newparser;
--    dbms_xmlparser.parseclob(l_parser, l_clob);
    dbms_xmlparser.parseclob(l_parser, l_dwhlog_row.package_data);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'rw');

    FOR i IN 0 .. dbms_xmldom.getlength(l_rows) - 1
    LOOP
      SAVEPOINT before_customer;
      -- raise_application_error(-20007,'fdgdfs');
      l_row := dbms_xmldom.item(l_rows, i);

      dbms_xslprocessor.valueof(l_row, 'rnk/text()', l_dwh_rnk);
      l_dwh_rnk := bars_sqnc.rukey(l_dwh_rnk, l_dwhlog_row.kf);

      dbms_xslprocessor.valueof(l_row, 's1/text()', l_ACTIVITY);
      dbms_xslprocessor.valueof(l_row, 's2/text()', l_FINANCIAL);
      dbms_xslprocessor.valueof(l_row, 's2d1/text()', l_FINANCIAL_VALID_FROM);
      dbms_xslprocessor.valueof(l_row, 's2d2/text()', l_FINANCIAL_VALID_UNTIL);
      dbms_xslprocessor.valueof(l_row, 's3/text()', l_BEHAVIOR);
      dbms_xslprocessor.valueof(l_row, 's4/text()', l_TRANSACTIONS);
      dbms_xslprocessor.valueof(l_row, 's5/text()', l_ATM);
      dbms_xslprocessor.valueof(l_row, 's6/text()', l_BPK_CREDITLINE);
      dbms_xslprocessor.valueof(l_row, 's7/text()', l_CASHCREDIT_GIVEN);
      dbms_xslprocessor.valueof(l_row, 's7d1/text()', l_CASHCREDIT_GIVEN_VALID_FROM);
      dbms_xslprocessor.valueof(l_row, 's7d2/text()', l_CASHCREDIT_GIVEN_VALID_UNTIL);

      l_date_off := NULL;
      l_rnk      := NULL;

      BEGIN

        SELECT t1.rnk, t1.date_off
          INTO l_rnk, l_date_off
          FROM customer t1
         WHERE rnk = to_number(l_dwh_rnk)
           AND custtype = 3
        ;
        --and T1.SED<>'91'
        --and date_off is null

        /*IF (l_date_off is not null) THEN
          CONTINUE;
          --дані по закритим клієнтам не зберігаємо.
        END IF;
        bars.bars_audit.info('SEGMENTATION_PACK: parse_segments - s1 l_dwh_rnk -' ||
                             to_char(l_dwh_rnk) || ' s1 - ' ||
                             to_char(l_s1) || ' s2 - ' || to_char(l_s2) ||
                             ' s3 - ' || to_char(l_s3) || ' s4 - ' ||
                             to_char(l_s4) || ' s5 - ' || to_char(l_s5) ||
                             ' s6 - ' || to_char(l_s6) || ' l_rnk - ' ||
                             to_char(l_rnk));*/
        -- сегмент активності
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_ACTIVITY'
                                    ,udf_to_number(l_ACTIVITY)
--                                    ,l_bank_date
                                    ,to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY')
                                    ,cast(null as date));
        -- BARS.BARS_AUDIT.INFO('SEGMENTATION_PACK: parse_segments - in LOOP. s1 ' || to_char(l_rnk) || ' '  || to_char(l_s1));
        -- сегмент фінансовий
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_FINANCIAL'
                                    ,udf_to_number(l_FINANCIAL)
                                    ,to_date(l_FINANCIAL_VALID_FROM, 'DD.MM.YYYY')
                                    ,to_date(l_FINANCIAL_VALID_UNTIL, 'DD.MM.YYYY'));
        -- сегмент поведінковий
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_BEHAVIOR'
                                    ,udf_to_number(l_BEHAVIOR)
--                                    ,l_bank_date
                                    ,to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY')
                                    ,cast(null as date));
        -- BARS.BARS_AUDIT.INFO('SEGMENTATION_PACK: parse_segments - in LOOP. s3 ' || to_char(l_rnk) || ' '  || to_char(l_s3));
        -- сегмент транзактори  (кол-во операций в ТСП)
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_TRANSACTIONS'
                                    ,udf_to_number(l_TRANSACTIONS)
--                                    ,l_bank_date
                                    ,to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY')
                                    ,cast(null as date));
        -- BARS.BARS_AUDIT.INFO('SEGMENTATION_PACK: parse_segments - in LOOP. s4 ' || to_char(l_rnk) || ' '  || to_char(l_s4));
        -- Кількість операцій зняття готівки в АТМ
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_ATM'
                                    ,udf_to_number(l_ATM)
--                                    ,l_bank_date
                                    ,to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY')
                                    ,cast(null as date));
        -- Сума встановленої кредитної лінії на БПК
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_BPK_CREDITLINE'
                                    ,udf_to_number(l_BPK_CREDITLINE)
--                                    ,l_bank_date
                                    ,to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY')
                                    ,cast(null as date));
        -- Сума наданого кеш-кредиту
        bars.attribute_utl.set_value(l_rnk
                                    ,'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN'
                                    ,udf_to_number(l_CASHCREDIT_GIVEN)
                                    ,to_date(l_CASHCREDIT_GIVEN_VALID_FROM, 'DD.MM.YYYY')
                                    ,to_date(l_CASHCREDIT_GIVEN_VALID_UNTIL, 'DD.MM.YYYY'));

      EXCEPTION

        WHEN no_data_found THEN
          ROLLBACK TO before_customer;
          l_error_count := l_error_count + 1;
          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || l_dwh_rnk || ' not found.';
          END IF;
        WHEN OTHERS THEN
          bars.bars_audit.error('segmentation_pack.parse_segments, rnk=' || l_dwh_rnk || chr(13) || chr(10) || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace);
          ROLLBACK TO before_customer;
          l_error_count := l_error_count + 1;
          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || l_dwh_rnk || '. SQLCode=' || sqlcode || chr(13) || chr(10);
          END IF;
      END;
      /* if (l_error_count)>100
      then
         rollback;
       BARS.BARS_AUDIT.INFO('SEGMENTATION_PACK: 100 Errors. EXIT.');
       EXIT;
      end if;*/
      l_tmp_cnt := l_tmp_cnt + 1;

    END LOOP;

    bars.bars_audit.info('segmentation_pack.parse_segments - LOOP ended. ERRORS count: ' || to_char(l_error_count));

    g_parse_result.status      := 'PARSED';
    set_package_status(p_package_id);

  END parse_segments;

 PROCEDURE parse_bussegment(p_package_id IN NUMBER) IS

    l_dwhlog_row dwh_log%rowtype;
--    l_clob CLOB;

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    l_customerrow         customer%ROWTYPE;
    l_error_count pls_integer := 0;
    l_tmp_cnt     pls_integer := 0;

    l_dwh_rnk VARCHAR2(32767 BYTE);
    l_s1      VARCHAR2(32767 BYTE);
    l_s2      VARCHAR2(32767 BYTE);

  BEGIN
    bars.bars_audit.info('segmentation_pack.parse_bussegment: p_package_id : ' ||
                         to_char(p_package_id));

--    SELECT package_data INTO l_clob
    SELECT * INTO l_dwhlog_row
      FROM dwh_log t
     WHERE t.package_id = p_package_id;

    l_parser := dbms_xmlparser.newparser;
--    dbms_xmlparser.parseclob(l_parser, l_clob);
    dbms_xmlparser.parseclob(l_parser, l_dwhlog_row.package_data);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'rw');

    FOR i IN 0 .. dbms_xmldom.getlength(l_rows) - 1

    LOOP

      SAVEPOINT before_customer;

      l_row := dbms_xmldom.item(l_rows, i);

      dbms_xslprocessor.valueof(l_row, 'rnk/text()', l_dwh_rnk);
      l_dwh_rnk := bars_sqnc.rukey(l_dwh_rnk, l_dwhlog_row.kf);

      dbms_xslprocessor.valueof(l_row, 's1/text()', l_s1);
      dbms_xslprocessor.valueof(l_row, 's2/text()', l_s2);




       BEGIN
        SELECT * INTO l_customerrow
          FROM customer
         WHERE rnk = to_number(l_dwh_rnk);

        if l_customerrow.date_off is not null then
          l_error_count := l_error_count + 1;
          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || to_char(l_dwh_rnk) || ' closed.';
          end if;
          continue;
        end if; 

        bars.kl.setCustomerElement(l_customerrow.rnk,'BUSSL', l_s1, 0);
        bars.kl.setCustomerElement(l_customerrow.rnk,'BUSSS', l_s2, 0);

      EXCEPTION

        WHEN no_data_found THEN
          ROLLBACK TO before_customer;
          l_error_count := l_error_count + 1;
          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || to_char(l_dwh_rnk) || ' not found.';
          END IF;
        WHEN OTHERS THEN
          bars_audit.error('segmentation_pack.parse_bussegment : ' || l_error_count || ' : ' || lpad(l_customerrow.rnk, 8) || SQLERRM);
          ROLLBACK TO before_customer;
          l_error_count := l_error_count + 1;
          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || to_char(l_dwh_rnk) || ' others ERROR.';
          END IF;
      END;

      l_tmp_cnt := l_tmp_cnt + 1;

    END LOOP;

    bars.bars_audit.info('SEGMENTATION_PACK: parse_bussegment - LOOP ended. ERRORS count: ' || to_char(l_error_count));

    g_parse_result.status      := 'PARSED';
    set_package_status(p_package_id);

 END parse_bussegment;
 /* Процедура на всякий случай вдруг когдато будет парсится Json из базы
  PROCEDURE parse_bussegment(p_package_id IN NUMBER) IS

    l_clob   CLOB;
    l_list JSON_LIST;

    l_dwh_rnk     VARCHAR2(32767 BYTE);
    l_BUSSL          VARCHAR2(32767 BYTE);
    l_BUSSS          VARCHAR2(32767 BYTE);
    l_rnk         customer.rnk%TYPE;
    l_error_count NUMBER := 0;
    l_tmp_cnt     NUMBER := 0;

  BEGIN
    bars.bars_audit.info('SEGMENTATION_PACK: parse_bussegment - start. package №' ||
                         to_char(p_package_id));

    SELECT package_data
      INTO l_clob
      FROM dwh_log
     WHERE package_id = p_package_id;

    bars.bars_audit.info('SEGMENTATION_PACK: parse_bussegment - CLOB selected');


      l_list := json_list(l_clob);
      FOR i IN 1..l_list.count
      LOOP

      SAVEPOINT before_customer;

        l_dwh_rnk  := json_ext.get_string(json(l_list.get(i)),'rnk');
        l_BUSSL := json_ext.get_string(json(l_list.get(i)),'s1');
        l_BUSSS := json_ext.get_string(json(l_list.get(i)),'s2');


      BEGIN
        SELECT t1.rnk
          INTO l_rnk
          FROM customer t1
         WHERE rnk = to_number(l_dwh_rnk)
           AND custtype in (2,3) AND T1.k050 <> '000' and date_off is null   --Проверка на всякий случай что клиент является ЮО или СПД
        ;


        if l_BUSSL in ('1','2') then --Проверка на допустимое значение
          bars.kl.setCustomerElement(l_rnk,'BUSSL', l_BUSSL, 0);
        end if;

        if l_BUSSL in ('11','12','21','22','23') then --Проверка на допустимое значение
          bars.kl.setCustomerElement(l_rnk,'BUSSS', l_BUSSS, 0);
        end if;

      EXCEPTION
        WHEN no_data_found THEN
          l_error_count := l_error_count + 1;

          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description ||
                                          'RNK:' || to_char(l_dwh_rnk) ||
                                          ' not found.';
          END IF;
        WHEN OTHERS THEN
          l_error_count := l_error_count + 1;

          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description ||
                                          'RNK:' || to_char(l_dwh_rnk) ||
                                          ' others ERROR.';
          END IF;
      END;


    END LOOP;

    bars.bars_audit.info('SEGMENTATION_PACK: parse_bussegment - LOOP ended. ');

    IF (l_error_count > 0) THEN
      g_parse_result.status := 'PARSED';
      set_package_status(p_package_id);
      --  ROLLBACK;
    ELSE
      g_parse_result.status      := 'PARSED';
      g_parse_result.description := 'NO ERRORS';
      set_package_status(p_package_id);
    END IF;

  END parse_bussegment;
*/


  PROCEDURE parse_CustomerInfo(p_package_id IN NUMBER) IS

    l_dwhlog_row dwh_log%rowtype;
    l_parser     dbms_xmlparser.parser;
    l_doc        dbms_xmldom.domdocument;
    l_row        dbms_xmldom.domnode;
    l_row_child  dbms_xmldom.domnode;

    x             xmltype;
    l_dwh_rnk     string(32767);
    l_branch      string(32767);
    l_rnk         customer.rnk%TYPE;
    l_error_count pls_integer := 0;
    l_tmp_cnt     pls_integer := 0;
    --    l_bankdate    DATE;
    l_date_off DATE;
  BEGIN
    bars.bars_audit.info('segmentation_pack.parse_CustomerInfo - package №' || to_char(p_package_id));

    --    execute immediate q'#alter session set nls_date_format = 'DD.MM.YYYY'#';

    SELECT * INTO l_dwhlog_row FROM dwh_log WHERE package_id = p_package_id;

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_dwhlog_row.package_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);
    dbms_xmlparser.freeParser(l_parser);

    l_row := dbms_xmldom.makeNode(l_doc); -- #document
    l_row := dbms_xmldom.getFirstChild(l_row); -- /packagedata
    l_row := dbms_xmldom.getFirstChild(l_row); -- /rw

    while not dbms_xmldom.isNull(l_row) loop

      l_row_child := dbms_xmldom.getFirstChild(l_row); -- /rnk
      l_dwh_rnk   := dbms_xmldom.getNodeValue(dbms_xmldom.getFirstChild(l_row_child));
      l_dwh_rnk   := bars_sqnc.rukey(l_dwh_rnk, l_dwhlog_row.kf);

      l_row_child := dbms_xmldom.getNextSibling(l_row_child); -- /branch
      l_branch    := dbms_xmldom.getNodeValue(dbms_xmldom.getFirstChild(l_row_child));

      BEGIN
        SELECT rnk, date_off
          INTO l_rnk, l_date_off
          FROM customer
         WHERE rnk = to_number(l_dwh_rnk)
           AND custtype = 3;

        --дані по закритим клієнтам не зберігаємо.
        if l_date_off is not null then
          l_row := dbms_xmldom.getNextSibling(l_row);
          continue;
        end if;

        bars.attribute_utl.set_value(l_rnk, 'CUSTOMER_SEGMENT_TVBV', l_branch, to_date(l_dwhlog_row.bank_date, 'DD.MM.YYYY'), cast(null as date));

      EXCEPTION
        WHEN no_data_found THEN
          l_error_count := l_error_count + 1;

          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || to_char(l_dwh_rnk) || ' not found.';
          END IF;
        WHEN OTHERS THEN
          l_error_count := l_error_count + 1;

          IF (length(nvl(g_parse_result.description, 0)) < 1950) THEN
            g_parse_result.description := g_parse_result.description || 'RNK:' || to_char(l_dwh_rnk) || ':' || sqlerrm;
          END IF;
      END;

      l_row := dbms_xmldom.getNextSibling(l_row);
    end loop;

    bars.bars_audit.info('segmentation_pack.parse_CustomerInfo - ERRORS count: ' || to_char(l_error_count));

    g_parse_result.status      := 'PARSED';
    set_package_status(p_package_id);

    dbms_xmldom.freeDocument(l_doc);
  END parse_CustomerInfo;

  PROCEDURE parse(p_package_id IN NUMBER) IS
    clob_in CLOB;
    x       xmltype;
    p_type  NUMBER;
  BEGIN

    SELECT package_type
      INTO p_type
      FROM dwh_log
     WHERE package_id = p_package_id;

    dbms_output.put_line('parse start' || to_char(p_type));
    g_parse_result.status      := 'PROCESSING';
    g_parse_result.description := null;
    set_package_status(p_package_id);

    CASE p_type
      WHEN 1 THEN
        parse_segments(p_package_id);
      WHEN 2 THEN
        parse_capacity(p_package_id);
      WHEN 3 THEN
        parse_CustomerInfo(p_package_id);
      WHEN 51 THEN
        parse_bussegment(p_package_id);
      ELSE
        raise_application_error(-20101, 'package_type is out of range(1,2,3,51)');
    END CASE;

  END parse;

  PROCEDURE parse_last_pack IS
    l_package_id     dwh_log.package_id%TYPE;
    l_package_status dwh_log.package_status%TYPE;
  BEGIN

    bars.bars_audit.info('segmentation_pack.parse_last_packs - start');
/*
    SELECT package_id, package_status
      INTO l_package_id, l_package_status
      FROM dwh_log
     WHERE package_id = (SELECT MAX(package_id) FROM dwh_log);

    IF (l_package_status = 'DELIVERED') THEN
      parse(l_package_id);
      bars.bars_audit.info('SEGMENTATION_PACK: parse_last_pack - stop');
    END IF;
*/

    for i in (SELECT package_id FROM dwh_log where package_status = 'DELIVERED' order by package_id) loop
      bars.bars_audit.info('segmentation_pack.parsing package_id ' || i.package_id || ' - start');
      parse(i.package_id);
      bars.bars_audit.info('segmentation_pack.parsing package_id ' || i.package_id || ' - stop');
    end loop;

    bars.bars_audit.info('segmentation_pack.parse_last_packs - stop');
  EXCEPTION
    WHEN no_data_found THEN
      bars.bars_audit.info('segmentation_pack.parse_last_packs - no_data_found');
      NULL;

  END parse_last_pack;

  PROCEDURE parse_clob_with_buffer(p_package_id IN NUMBER) IS
    v_clob    CLOB;
    v_varchar VARCHAR2(32767);
    v_start   PLS_INTEGER := 1;
    v_buffer  PLS_INTEGER := 32767;
    blob_in   CLOB;
    x         xmltype;
  BEGIN
    dbms_lob.createtemporary(v_clob, TRUE);

    SELECT package_data INTO blob_in FROM dwh_log WHERE package_id = 10;

    FOR i IN 1 .. ceil(dbms_lob.getlength(blob_in) / v_buffer)
    LOOP

      v_varchar := dbms_lob.substr(blob_in, v_buffer, v_start);
      --DBMS_OUTPUT.PUT_LINE(v_varchar);
      dbms_lob.writeappend(v_clob, length(v_varchar), v_varchar);

      v_start := v_start + v_buffer;
    END LOOP;

  END parse_clob_with_buffer;

END segmentation_pack;
/
show errors

grant execute on segmentation_pack to bars_access_defrole;
