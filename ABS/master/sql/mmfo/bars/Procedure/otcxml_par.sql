

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTCXML_PAR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTCXML_PAR ***

  CREATE OR REPLACE PROCEDURE BARS.OTCXML_PAR (p_kod in number,  p_params_str in varchar2,  p_validate_res out varchar2 ) is
  -- errs
  l_ern         CONSTANT POSITIVE := 101;  -- error code
  l_err         EXCEPTION;
  l_erm         VARCHAR2(80);
  -- clobs
  l_sql_block   CLOB;
  l_sql_clob    CLOB;
  l_xsl_clob    CLOB;
  l_xml_clob    CLOB;
  l_full_clob   CLOB;
  l_tmp_clob    CLOB;
  l_xsd_clob    CLOB;
  -- xmltypes
  l_params_xml XMLType;
  l_node_xml   XMLType;
  l_tmp_xml    XMLType;
  l_full_xml   XMLType;
  l_xsl_xml    XMLType;
  -- other vars
  l_cur        NUMBER;
  l_nCode      number;
  l_param_map  varchar2(32767);
  l_ctx        dbms_xmlquery.ctxHandle;
  l_p          xmlparser.Parser;
  l_xmldoc     xmldom.DOMDocument;
  l_xmldocnode xmldom.DOMNode;
  l_doc_elem   xmldom.DOMElement;
  l_base_url   varchar2(1000);
  i            number;
  -- consts
  G_MAX_XSLT_SIZE number := 5242880;
  G_XML_HEADER varchar2(100) := '<?xml version = ''1.0'' encoding = ''windows-1251''?>'||chr(10);

  -----------------------------------------------
  -- Функция безопаcно получает значение по XPath
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
  end;

begin
  l_params_xml := XMLType(p_params_str);

  dbms_lob.createtemporary(l_sql_block,FALSE);
  dbms_lob.createtemporary(l_sql_clob,FALSE);
  dbms_lob.createtemporary(l_xsl_clob,FALSE);
  dbms_lob.createtemporary(l_xml_clob,FALSE);
  dbms_lob.createtemporary(l_full_clob,FALSE);
  dbms_lob.createtemporary(l_tmp_clob,FALSE);
  dbms_lob.createtemporary(l_xsd_clob,FALSE);

  -- new parser
  l_p := xmlparser.newParser;

  -- set some characteristics
  xmlparser.setValidationMode(l_p, FALSE);
  xmlparser.setPreserveWhiteSpace(l_p, TRUE);

  -- получить данные запроса
  select
    trim(txt),
    trim(form_proc),
    trim(xsd_data)
  into
    l_tmp_clob,
    l_sql_block,
    l_xsd_clob
  from zapros
  where kodz=p_kod;

  -- обнулить нулевые клобы
  if dbms_lob.getlength(l_tmp_clob)=0 then l_tmp_clob:=null; end if;
  if dbms_lob.getlength(l_sql_block)=0 then l_sql_block:=null; end if;
  if dbms_lob.getlength(l_xsd_clob)=0 then l_xsd_clob:=null; end if;

  -- параметры
  l_params_xml := XMLType(p_params_str);

  -- если нет запроса, а указана только процедура - выполнить ее
  if l_tmp_clob is null and l_sql_block is not null then

    -- парсинг блока
    l_sql_block := 'BEGIN '||l_sql_block||'; END;';
    l_cur := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(l_cur, l_sql_block, DBMS_SQL.NATIVE);

    -- параметры блока
    l_node_xml := l_params_xml.extract('/PARAMS/PARAMSET[@kodz="'||to_char(p_kod)||'" and @type="xsl"]');
    if l_node_xml is not null then
      i:=1;
      loop
        l_tmp_xml := l_node_xml.extract('/PARAMSET/PARAM[@num="'||i||'"]');
        if l_tmp_xml is null then
          exit;
        end if;

        begin
          dbms_sql.bind_variable(l_cur,
                  extract(l_tmp_xml, '/PARAM/NAME/text()','undefined'),
                  extract(l_tmp_xml, '/PARAM/VALUE/text()','')
          );
        exception when others then
          --пропустить попытку binda несуществующей переменной
          if sqlcode=-01006 then null; else raise; end if;
        end;

        i := i + 1;
      end loop;
    end if;

    -- выполнить блок
    l_nCode := DBMS_SQL.EXECUTE(l_cur);

    dbms_output.put_line(to_char(p_kod)||'-- DBMS_SQL.EXECUTE() return code: '||l_nCode);

    DBMS_SQL.CLOSE_CURSOR(l_cur);

    -- результат должен быть во временной таблице
    select dd into l_tmp_clob from tmp_xml_data;
    dbms_lob.append(l_full_clob, l_tmp_clob);

  -- если запрос есть
  else

    l_tmp_clob := G_XML_HEADER || '<ROOT>';
    dbms_lob.append(l_full_clob, l_tmp_clob);
    -- main loop
    for c in (select kodz, txt, form_proc
              from zapros
              START WITH kodz=p_kod connect by prior kodr=kodz
              order by rownum desc)
    loop

      l_sql_block := c.form_proc;

      -- если указана процедура - сперва выполнить ее
      if l_sql_block is not NULL then
        dbms_output.put_line(to_char(c.kodz)||'-- PL/SQL BLOCK was fetched');
        l_sql_block := 'BEGIN '||l_sql_block||'; END;';
        l_cur := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(l_cur, l_sql_block , DBMS_SQL.NATIVE);
        -- задаем параметры
        l_node_xml := l_params_xml.extract('/PARAMS/PARAMSET[@kodz="'||to_char(c.kodz)||'" and @type="block"]');
        if l_node_xml is not null then
          i:=1;
          loop
            l_tmp_xml := l_node_xml.extract('/PARAMSET/PARAM[@num="'||i||'"]');
            if l_tmp_xml is null then
              exit;
            end if;
            DBMS_SQL.BIND_VARIABLE(l_cur,
                extract(l_tmp_xml, '/PARAM/NAME/text()',''),
                extract(l_tmp_xml, '/PARAM/VALUE/text()',''));
            i := i+1;
          end loop;
        end if;
        l_nCode := DBMS_SQL.EXECUTE(l_cur);
        dbms_output.put_line(to_char(c.kodz)||'-- DBMS_SQL.EXECUTE() return code: '||l_nCode);
        DBMS_SQL.CLOSE_CURSOR(l_cur);
      else
        dbms_output.put_line(to_char(c.kodz)||'-- PL/SQL BLOCK is empty');
      end if;

      -- выполнить SQL
      l_sql_clob := c.txt;
      if l_sql_clob is null then
        l_erm := '0003 - SQL CLOB cannot be empty, uri = ';
        raise l_err;
      end if;
      dbms_output.put_line(to_char(c.kodz)||'-- SELECT was fetched');

      -- указывает SQL для xml-запроса
      l_ctx := dbms_xmlquery.newContext(l_sql_clob);

      dbms_xmlquery.setEncodingTag(l_ctx, 'windows-1251');
      dbms_xmlquery.setDateFormat(l_ctx,'dd.MM.yyyy HH:mm:ss');

      -- задаем параметры запроса
      l_node_xml := l_params_xml.extract('/PARAMS/PARAMSET[@kodz="'||to_char(c.kodz)||'" and @type="select"]');
      if l_node_xml is not null then
        i:=1;
        loop
          l_tmp_xml := l_node_xml.extract('/PARAMSET/PARAM[@num="'||i||'"]');
          if l_tmp_xml is null then
            exit;
          end if;
          dbms_xmlquery.setBindValue(l_ctx,
                extract(l_tmp_xml, '/PARAM/NAME/text()',''),
                extract(l_tmp_xml, '/PARAM/VALUE/text()',''));
          i := i+1;
        end loop;
      end if;

      dbms_lob.trim(l_xml_clob,0);
      -- записывает результат выполнения SQL в CLOB в формате XML
      dbms_xmlquery.getXML(l_ctx, l_xml_clob);
      dbms_xmlquery.closeContext(l_ctx);
      xmlparser.parseClob(l_p, l_xml_clob);

      l_tmp_clob := '<SELECT kodz="'||to_char(c.kodz)||'">';
      dbms_lob.append(l_full_clob, l_tmp_clob);

      l_xmldoc := xmlparser.getDocument(l_p);
      l_doc_elem := xmldom.getDocumentElement(l_xmldoc);
      l_xmldocnode := xmldom.makeNode(l_doc_elem);

      dbms_lob.trim(l_tmp_clob,0);
      xmldom.writeToClob(l_xmldocnode, l_tmp_clob,'windows-1251');
      dbms_lob.append(l_full_clob, l_tmp_clob);

      l_tmp_clob := '</SELECT>';
      dbms_lob.append(l_full_clob, l_tmp_clob);

    end loop;
    l_tmp_clob := '</ROOT>';
    dbms_lob.append(l_full_clob, l_tmp_clob);
  end if;

  --------------------------------------
  -- XSLT преобразование полученного XML
  --

  begin
    select xsl_data into l_xsl_clob from zapros
    where kodz=p_kod;
  exception when no_data_found then
    l_erm := '0003 - XSL CLOB not found, uri = ';
    raise l_err;
  end;

  -- переменная для хранения параметров преобразования (в формате a=b c=d e=f)
  l_param_map := '';


  if l_xsl_clob is null then
    dbms_output.put_line('XSL CLOB is empty');
  else

    -- только если размер XML в пределах MAX_XSLT_SIZE
    if dbms_lob.getlength(l_full_clob) <= G_MAX_XSLT_SIZE then

      -- задаем параметры преобразования XSL (в формате a=b c=d e=f)
      l_node_xml := l_params_xml.extract('/PARAMS/PARAMSET[@kodz="'||to_char(p_kod)||'" and @type="xsl"]');
      if l_node_xml is not null then
        i:=1;
        loop
          l_tmp_xml := l_node_xml.extract('/PARAMSET/PARAM[@num="'||i||'"]');
          if l_tmp_xml is null then exit; end if;
          l_param_map := l_param_map || trim(extract(l_tmp_xml,'/PARAM/NAME/text()',''))||'='||trim(extract(l_tmp_xml,'/PARAM/VALUE/text()',''))||' ';
          i := i+1;
        end loop;
      end if;

      -- преобразвовываем CLOBы в XMLType
      l_full_xml := xmltype(l_full_clob);
      l_xsl_xml := xmltype(l_xsl_clob);

      -- здесь происходит XSL-преобразование
      l_full_xml := l_full_xml.transform(l_xsl_xml, trim(l_param_map));

      -- т.к. xmltype.transform почему-то обрезает заголовок XML, то
      --
      -- обнулим результирующий clob
      dbms_lob.trim(l_full_clob,0);
      -- добавим заголовок
      dbms_lob.append(l_full_clob, G_XML_HEADER);
      -- добавим преобразованый XML
      dbms_lob.append(l_full_clob, l_full_xml.getClobVal());

    end if;

  end if;

  ----------------------------------
  --  проверка XML согласно схемы
  --
  if l_xsd_clob is not null then
    begin
      select val into l_base_url from params where par='XSD_URL';
    exception when no_data_found then
      l_base_url := '';
    end;
    p_validate_res := xml_validate(l_full_clob, l_xsd_clob, l_base_url);
  end if;

  ----------------------------------
  -- сохранение результата в таблицу
  --
  begin
    update xml_storage set xml_data=trim(l_full_clob)
    where uri=to_char(p_kod);
    if SQL%ROWCOUNT=0 then
      insert into xml_storage(uri,xml_data)
      values(to_char(p_kod),trim(l_full_clob));
    end if;
  end;

  ----------------------------------
  -- освобождение ресурсов
  --
  xmlparser.freeParser(l_p);

  if dbms_lob.isTemporary(l_sql_block)=1 then  dbms_lob.freetemporary(l_sql_block); end if;
  if dbms_lob.isTemporary(l_sql_clob)=1 then  dbms_lob.freetemporary(l_sql_clob); end if;
  if dbms_lob.isTemporary(l_xsl_clob)=1 then  dbms_lob.freetemporary(l_xsl_clob); end if;
  if dbms_lob.isTemporary(l_xml_clob)=1 then  dbms_lob.freetemporary(l_xml_clob); end if;
  if dbms_lob.isTemporary(l_full_clob)=1 then  dbms_lob.freetemporary(l_full_clob); end if;
  if dbms_lob.isTemporary(l_tmp_clob)=1 then  dbms_lob.freetemporary(l_tmp_clob); end if;
  if dbms_lob.isTemporary(l_xsd_clob)=1 then  dbms_lob.freetemporary(l_xsd_clob); end if;

exception

when xmldom.INDEX_SIZE_ERR then
  raise_application_error(-20120, 'Index Size error');

when xmldom.DOMSTRING_SIZE_ERR then
  raise_application_error(-20120, 'String Size error');

when xmldom.HIERARCHY_REQUEST_ERR then
  raise_application_error(-20120, 'Hierarchy request error');

when xmldom.WRONG_DOCUMENT_ERR then
  raise_application_error(-20120, 'Wrong doc error');

when xmldom.INVALID_CHARACTER_ERR then
  raise_application_error(-20120, 'Invalid Char error');

when xmldom.NO_DATA_ALLOWED_ERR then
  raise_application_error(-20120, 'Nod data allowed error');

when xmldom.NO_MODIFICATION_ALLOWED_ERR then
  raise_application_error(-20120, 'No mod allowed error');

when xmldom.NOT_FOUND_ERR then
  raise_application_error(-20120, 'Not found error');

when xmldom.NOT_SUPPORTED_ERR then
  raise_application_error(-20120, 'Not supported error');

when xmldom.INUSE_ATTRIBUTE_ERR then
  raise_application_error(-20120, 'In use attr error');

when l_err then
  raise_application_error(-(20000+l_ern),'\'||l_erm,TRUE);

end otcxml_par;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTCXML_PAR.sql =========*** End **
PROMPT ===================================================================================== 
