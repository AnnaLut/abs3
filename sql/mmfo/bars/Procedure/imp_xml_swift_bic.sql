

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IMP_XML_SWIFT_BIC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IMP_XML_SWIFT_BIC ***


CREATE OR REPLACE 
PROCEDURE imp_xml_swift_bic (p_filename VARCHAR2, p_par INT DEFAULT 0)
IS
    l_parser               DBMS_XMLPARSER.parser;
    l_doc                  DBMS_XMLDOM.domdocument;
    l_analyticlist         DBMS_XMLDOM.domnodelist;
    l_analytic             DBMS_XMLDOM.domnode;
    i                      INT;
    j                      INT;
    l_filename             imp_file.file_name%TYPE;
    l_clob                 CLOB;
    l_mod_flag             CHAR (1);
    l_bic_code             VARCHAR2 (254);
    l_branch_code          VARCHAR2 (254);
    l_institution_name     VARCHAR2 (254);
    l_city_heading         VARCHAR2 (254);
    l_physical_address_1   VARCHAR2 (254);
    l_physical_address_2   VARCHAR2 (254);
    l_physical_address_3   VARCHAR2 (254);
    l_physical_address_4   VARCHAR2 (254);
    l_location             VARCHAR2 (254);
    l_country_name         VARCHAR2 (254);
    l_count_a              NUMBER DEFAULT 0;
    l_count_m              NUMBER DEFAULT 0;
    l_count_d              NUMBER DEFAULT 0;
    l_count_u              NUMBER DEFAULT 0;
    l_count_zz             NUMBER DEFAULT 0;
    l_count_total number;
BEGIN
    bars_audit.info (
           'GET_XML_SWIFT: start load file '
        || l_filename
        || ' timestamp = '
        || TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss'));

    BEGIN
        SELECT file_clob, file_name
        INTO   l_clob, l_filename
        FROM   imp_file
        WHERE  file_name = p_filename;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            raise_application_error (
                -20001,
                'Файл XML не был загружен в CLOB для обработки...',
                FALSE);
            RETURN;
    END;

    bars_audit.info (
           'GET_XML_SWIFT: load clob '
        || TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss'));

    l_parser := DBMS_XMLPARSER.newparser;

    DBMS_XMLPARSER.parseclob (l_parser, l_clob);

    l_doc := DBMS_XMLPARSER.getdocument (l_parser);

    l_analyticlist :=
        DBMS_XMLDOM.getelementsbytagname (l_doc, 'bicdir2018_v1');

    j := 0;
    l_count_total := DBMS_XMLDOM.getlength (l_analyticlist) - 1;

    FOR i IN 0 .. l_count_total
    LOOP
        l_analytic := DBMS_XMLDOM.item (l_analyticlist, i);

        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'modification_flag/text()',
                                   l_mod_flag);
        DBMS_XSLPROCESSOR.valueof (l_analytic, 'bic_code/text()', l_bic_code);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'branch_code/text()',
                                   l_branch_code);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'institution_name/text()',
                                   l_institution_name);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'city_heading/text()',
                                   l_city_heading);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'physical_address_1/text()',
                                   l_physical_address_1);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'physical_address_2/text()',
                                   l_physical_address_2);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'physical_address_3/text()',
                                   l_physical_address_3);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'physical_address_4/text()',
                                   l_physical_address_4);
        DBMS_XSLPROCESSOR.valueof (l_analytic, 'location/text()', l_location);
        DBMS_XSLPROCESSOR.valueof (l_analytic,
                                   'country_name/text()',
                                   l_country_name);


        CONTINUE WHEN l_bic_code IS NULL OR l_branch_code IS NULL;

        CASE l_mod_flag
            WHEN 'A'
            THEN                                                   -- addition
                BEGIN
                    INSERT INTO sw_banks (bic,
                                          name,
                                          office,
                                          city,
                                          country,
                                          transback)
                    VALUES      (
                                    l_bic_code || l_branch_code,
                                    l_institution_name,
                                    REPLACE (
                                        TRIM (
                                               l_physical_address_1
                                            || ' '
                                            || l_physical_address_2
                                            || ' '
                                            || l_physical_address_3
                                            || ' '
                                            || l_physical_address_4
                                            || ' '
                                            || l_location),
                                        '  ',
                                        ' '),
                                    TRIM (SUBSTR (l_city_heading, 1, 35)),
                                    l_country_name,
                                    0);

                    l_count_a := l_count_a + SQL%ROWCOUNT;
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX
                    THEN
                        bars_audit.info (
                               'GET_XML_SWIFT:  DUP_VAL_ON_INDEX on '
                            || l_bic_code
                            || l_branch_code);
                END;
            WHEN 'M'
            THEN                                              --- modification
                UPDATE sw_banks
                SET    name = l_institution_name,
                       office =
                           REPLACE (
                               TRIM (
                                      l_physical_address_1
                                   || ' '
                                   || l_physical_address_2
                                   || ' '
                                   || l_physical_address_3
                                   || ' '
                                   || l_physical_address_4
                                   || ' '
                                   || l_location),
                               '  ',
                               ' '),
                       city = TRIM (SUBSTR (l_city_heading, 1, 35)),
                       country = l_country_name
                WHERE  bic = l_bic_code || l_branch_code;

                l_count_m := l_count_m + SQL%ROWCOUNT;
            WHEN 'D'
            THEN    -- deletion
                -- существуют foreign key. но заявки от банка не реализуем
                ----DELETE FROM sw_banks  WHERE       bic = l_bic_code || l_branch_code;

                --- l_count_d := l_count_d + SQL%ROWCOUNT;
                null;
            WHEN 'U'
            THEN                                                 --- unchanged
                NULL;
                l_count_u := l_count_u + 1;
            ELSE
                bars_audit.info (
                       'GET_XML_SWIFT: неописанный modification_flag'
                    || l_mod_flag);
                l_count_zz := l_count_zz + 1;
        END CASE;

        --- total count
        j := j + 1;
        DBMS_APPLICATION_INFO.set_client_info (
            TO_CHAR (j + 1) || ' records were already loaded...');
    END LOOP;


    DBMS_APPLICATION_INFO.set_client_info (
        'In all ' || TO_CHAR (j + 1) || ' records loaded.');
    bars_audit.info (
           'GET_XML_SWIFT: end '
        || TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss')
        || ' A = '
        || l_count_a
        || ' M = '
        || l_count_m
        || ' D = '
        || l_count_d
        || ' U = '
        || l_count_u
        || ' others = '
        || l_count_zz
        || ' Total = '
        || l_count_total);
    RETURN;
END imp_xml_swift_bic;

/
show err;

PROMPT *** Create  grants  IMP_XML_SWIFT_BIC ***
grant EXECUTE                                                                on IMP_XML_SWIFT_BIC to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IMP_XML_SWIFT_BIC to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IMP_XML_SWIFT_BIC.sql =========***
PROMPT ===================================================================================== 
