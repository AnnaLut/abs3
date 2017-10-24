

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTCXML.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTCXML ***

  CREATE OR REPLACE PROCEDURE BARS.OTCXML (kod_ number
  ) is
  ern         CONSTANT POSITIVE := 101;  -- error code
  err         EXCEPTION;
  erm         VARCHAR2(80);

  sql_block_ CLOB;
  sql_clob_  CLOB;
  xsl_clob_  CLOB;
  xml_clob_  CLOB;
  full_clob_ CLOB;
  tmp_clob_  CLOB;
  cur_       NUMBER;
  nCode      number;
  plsql_str  varchar2(32767);
  ctx        dbms_xmlquery.ctxHandle;

    p xmlparser.Parser;
  full_xmldoc xmldom.DOMDocument;
  full_xmldocnode xmldom.DOMNode;
    full_docfrag xmldom.DOMDocumentFragment;
    xmldoc xmldom.DOMDocument;
    xmldocnode xmldom.DOMNode;
    tmp_node xmldom.DOMNode;
  doc_elem  xmldom.DOMElement;
    proc xslprocessor.Processor;
    ss xslprocessor.Stylesheet;
    xsldoc xmldom.DOMDocument;

begin
  dbms_lob.createtemporary(sql_block_,FALSE);
  dbms_lob.createtemporary(sql_clob_,FALSE);
  dbms_lob.createtemporary(xsl_clob_,FALSE);
  dbms_lob.createtemporary(xml_clob_,FALSE);
  dbms_lob.createtemporary(full_clob_,FALSE);
  dbms_lob.createtemporary(tmp_clob_,FALSE);

  -- new parser
  p := xmlparser.newParser;
  -- set some characteristics
  xmlparser.setValidationMode(p, FALSE);
  xmlparser.setPreserveWhiteSpace(p, TRUE);

  tmp_clob_ := '<?xml version = ''1.0'' encoding = ''windows-1251''?> <ROOT>';
  dbms_lob.append(full_clob_, tmp_clob_);
  -- main loop
  for c in (select kodz, txt, form_proc
            from zapros
            START WITH kodz=kod_ connect by prior kodr=kodz
            order by rownum desc)
  loop
    sql_block_ := c.form_proc;
    -- execute PL/SQL block
    if sql_block_ is not NULL then
      plsql_str := 'BEGIN '||sql_block_||'; END;';
      EXECUTE IMMEDIATE plsql_str;
    else
      dbms_output.put_line('-- PL/SQL BLOCK is empty');
    end if;
    -- fetch SQL cursor
    sql_clob_ := c.txt;
    if sql_clob_ is null then
      erm := '0003 - SQL CLOB cannot be empty';
      raise err;
    end if;

    -- convertion source SQL to simple XML
    ctx := dbms_xmlquery.newContext(sql_clob_);

    dbms_xmlquery.setEncodingTag(ctx, 'windows-1251');
    dbms_xmlquery.setDateFormat(ctx,'dd.MM.yyyy HH:mm:ss');

    dbms_lob.trim(xml_clob_,0);
    dbms_xmlquery.getXML(ctx,xml_clob_);

    dbms_xmlquery.closeContext(ctx);

    xmlparser.parseClob(p, xml_clob_);

    -- get document
    tmp_clob_ := '<SELECT kodz="'||to_char(c.kodz)||'">';
    dbms_lob.append(full_clob_, tmp_clob_);
    xmldoc := xmlparser.getDocument(p);
    doc_elem := xmldom.getDocumentElement(xmldoc);
    xmldocnode := xmldom.makeNode(doc_elem);
    xmldom.writeToClob(xmldocnode,tmp_clob_,'windows-1251');
    dbms_lob.append(full_clob_, tmp_clob_);
    tmp_clob_ := '</SELECT>';
    dbms_lob.append(full_clob_, tmp_clob_);
  end loop;
  tmp_clob_ := '</ROOT>';
  dbms_lob.append(full_clob_, tmp_clob_);

  begin
    select xsl_data into xsl_clob_ from zapros
    where kodz=kod_;
  exception when no_data_found then
    erm := '0003 - XSL CLOB not found';
    raise err;
  end;
  if xsl_clob_ is null then
    dbms_output.put_line('XSL CLOB is empty');
  else
    xmlparser.parseClob(p, full_clob_);
    full_xmldoc := xmlparser.getDocument(p);

    nCode := dbms_lob.getLength(full_clob_);
    dbms_lob.erase(full_clob_,nCode);

    -- parse xsl file
    xmlparser.parseClob(p, xsl_clob_);

    -- get document
    xsldoc := xmlparser.getDocument(p);

    -- make stylesheet
    ss := xslprocessor.newStylesheet(xsldoc, NULL);

    -- process xsl
    proc := xslprocessor.newProcessor;

    xslprocessor.processXSL(proc, ss, full_xmldoc, full_clob_);

    -- Free XML Documents
    xmldom.freeDocument(xsldoc);

    -- Free XSL Stylesheet and Processor
    xslprocessor.freeProcessor(proc);
    xslprocessor.freeStylesheet(ss);
    xmldom.freeDocument(full_xmldoc);
  end if;

  begin
    update xml_storage set xml_data=trim(full_clob_)
    where uri=to_char(kod_);
    if SQL%ROWCOUNT=0 then
      insert into xml_storage(uri,xml_data)
      values(to_char(kod_),trim(full_clob_));
    end if;
  end;

  -- Free the xmlparser
  xmlparser.freeParser(p);

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

when err then
  raise_application_error(-(20000+ern),'\'||erm,TRUE);

when OTHERS then
  raise_application_error(-(20000+ern),SQLERRM,TRUE);

end otcxml;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTCXML.sql =========*** End *** ==
PROMPT ===================================================================================== 
