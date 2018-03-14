create or replace PROCEDURE p_nbur_xml_sk_parse(p_ReportDate in date,  
                                                p_KF         in varchar2,
                                                p_err        out NUMBER,
                                                p_message    out varchar2
) IS
    title           VARCHAR2(100) := 'P_NBUR_XML_SK_PARSE.';
    
    l_doc           dbms_xmldom.domdocument;
    v_RootNode      dbms_xmldom.DomNode;
    l_parser        dbms_xmlparser.parser;
    l_tablelist     dbms_xmldom.domnodelist;
    l_rowlist       dbms_xmldom.domnodelist;
    l_columnlist    dbms_xmldom.domnodelist;
    l_row           dbms_xmldom.domnode;
    l_table_name    VARCHAR2(100);
    l_str           VARCHAR2(2000);
    l_clob          clob;
    l_blob          blob;
    l_tmpb          blob;
    l_file_data     clob;
    l_warning       integer;
    l_dest_offset   integer := 1;
    l_src_offset    integer := 1;
    l_blob_csid     number := dbms_lob.default_csid;
    l_lang_context  number := dbms_lob.default_lang_ctx;
    l_xml           xmltype;
    
    TYPE t_XML_SK   IS TABLE OF NBUR_TMP_E9_SK%ROWTYPE;
    l_XML_ROW       t_XML_SK :=t_XML_SK();

    v_Attr_Node     Dbms_Xmldom.Domnode;
    v_Attr_Nodes    Dbms_Xmldom.Domnamednodemap;
    
    p_err_loc       NUMBER(10);
    
    p_edrpou        varchar2(100);
    
    function decode_base64(
        p_clob_in in clob)
    return blob
    is
        v_blob blob;
        v_result blob;
        v_offset integer;
        v_buffer_size binary_integer := 48;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_clob_in is null then
            return null;
        end if;

        dbms_lob.createtemporary(v_blob, true);
        v_offset := 1;

        for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size) loop
            dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);
            v_buffer_raw := utl_raw.cast_to_raw(v_buffer_varchar);
            v_buffer_raw := utl_encode.base64_decode(v_buffer_raw);
            dbms_lob.writeappend(v_blob, utl_raw.length(v_buffer_raw), v_buffer_raw);
            v_offset := v_offset + v_buffer_size;
        end loop;

        v_result := v_blob;
        dbms_lob.freetemporary(v_blob);

        return v_result;
    end;    
BEGIN
    logger.info(title||'BEGIN parse XML for KF = '||p_kf);
    
    BEGIN
        SELECT t.xml_file
          INTO l_clob
          FROM NBUR_TMP_E9_CLOB t
         WHERE t.REPORT_DATE = p_ReportDate and
               t.kf = p_KF;
    EXCEPTION
        WHEN no_data_found THEN
           bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
    END;
      
    l_parser := dbms_xmlparser.newparser;
    
    dbms_xmlparser.parseclob(l_parser, l_clob);
    
    bars_audit.trace(title || 'clob loaded');
    
    l_doc := dbms_xmlparser.getdocument(l_parser);
    
    bars_audit.trace(title || 'getdocument done');
    
    v_RootNode := XmlDom.MakeNode(XmlDom.GetDocumentElement(l_doc));
    
    p_edrpou := XmlDom.GetNodeValue(XslProcessor.SelectSingleNode(v_RootNode, 
           '/TransactionShortReportResponse/TransactionShortReportResult/HEAD/EDRPOU/text()'));
    ------------------------------------------
    --формируем список строк
    l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'DATA');
    
    FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
    LOOP
        l_row := dbms_xmldom.item(l_rowlist, i);
        l_XML_ROW.extend;

        l_XML_ROW (l_XML_ROW.last).CTEDRPOU  := trim(p_edrpou);

        dbms_xslprocessor.valueof(l_row, 'EKP/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_EKP   := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'D060_1/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_D060_1    := nvl(ltrim(trim(l_str), '-'), '42');

        dbms_xslprocessor.valueof(l_row, 'K020/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_K020    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'K021/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_K021    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'F001/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_F001    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'R030/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_R030    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'K040_1/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_K040_1    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'KU_1/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_KU_1    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'K040_2/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_K040_2    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'KU_2/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_KU_2    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'T071/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_T071    := to_number(nvl(trim(l_str), '0')) * 100;

        dbms_xslprocessor.valueof(l_row, 'T080/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_T080    := to_number(nvl(trim(l_str), '0'));

        dbms_xslprocessor.valueof(l_row, 'D060_2/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_D060_2    := trim(l_str);

        dbms_xslprocessor.valueof(l_row, 'Q001/text()', l_str);
        l_XML_ROW (l_XML_ROW.last).CTKOD_Q001    := trim(l_str);
    END LOOP;

    BEGIN
        EXECUTE IMMEDIATE ' delete from NBUR_TMP_E9_SK where report_date = :p_dat and kf=:p_kf'
        using p_reportdate, p_kf;
    END;

    BEGIN
        EXECUTE IMMEDIATE ' delete from ERR$_NBUR_TMP_E9_SK where report_date = :p_dat and kf=:p_kf'
        using p_reportdate, p_kf;
    END;
    
    if l_XML_ROW IS NOT EMPTY then
        --обновление данных
        BEGIN
            FOR j IN l_XML_ROW.first .. l_XML_ROW.last
            loop
                INSERT INTO NBUR_TMP_E9_SK(REPORT_DATE, KF, CTEDRPOU, CTKOD_EKP, CTKOD_D060_1, 
                     CTKOD_K020, CTKOD_K021, CTKOD_F001, CTKOD_R030, CTKOD_K040_1, CTKOD_KU_1, 
                     CTKOD_K040_2, CTKOD_KU_2, CTKOD_T071, CTKOD_T080, CTKOD_D060_2, CTKOD_Q001)
                VALUES (p_ReportDate, p_KF, l_XML_ROW(j).CTEDRPOU, l_XML_ROW(j).CTKOD_EKP, 
                     l_XML_ROW(j).CTKOD_D060_1, l_XML_ROW(j).CTKOD_K020, l_XML_ROW(j).CTKOD_K021, 
                     l_XML_ROW(j).CTKOD_F001, l_XML_ROW(j).CTKOD_R030, 
                     l_XML_ROW(j).CTKOD_K040_1, l_XML_ROW(j).CTKOD_KU_1, 
                     l_XML_ROW(j).CTKOD_K040_2, l_XML_ROW(j).CTKOD_KU_2, 
                     l_XML_ROW(j).CTKOD_T071, l_XML_ROW(j).CTKOD_T080, 
                     l_XML_ROW(j).CTKOD_D060_2, l_XML_ROW(j).CTKOD_Q001)
                log errors INTO ERR$_NBUR_TMP_E9_SK
                ('INSERT') reject LIMIT unlimited;
            end loop;
        END;
    end if;

    BEGIN
        SELECT count(*) 
        into p_err_loc  
        from  ERR$_NBUR_TMP_E9_SK 
        where report_date = p_reportdate and
              kf=p_kf;
        
        p_err:=p_err_loc;
        
        if p_err_loc> 0 then
           p_message:='ERR$_NBUR_TMP_E9_SK HAS ERRORS';
        end if;
    END;

     --очистка,якщо виникли помилки
    l_XML_ROW.delete();
    l_XML_ROW := NULL;

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);

    logger.info(title||'END parse XML for KF = '||p_kf);
exception
    when others then
        logger.error(title||'Errors during parse XML for KF = '||p_kf||' '||sqlerrm);
END;
/