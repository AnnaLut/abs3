

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SQL2XML.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SQL2XML ***

  CREATE OR REPLACE PROCEDURE BARS.SQL2XML (
  nodes_uri  varchar2,
  xsl_uri    varchar2,
  xml_uri    varchar2
  ) is
  ern         CONSTANT POSITIVE := 101;  -- error code
  err         EXCEPTION;
  erm         VARCHAR2(80);

  nodes_uri_ varchar2(255);
  sql_uri_   varchar2(255);
  xsl_uri_   varchar2(255);
  xml_uri_   varchar2(255);
  sql_block_ CLOB;
	sql_clob_  CLOB;
  xsl_clob_  CLOB;
  xml_clob_  CLOB;
  full_clob_ CLOB;
  tmp_clob_  CLOB;
  cur_       NUMBER;
  nCode      number;
  plsql_str  varchar2(32767);
  tmp_str    varchar2(32767);
  i   number;
  ctx 		 dbms_xmlquery.ctxHandle;

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
  nodes_uri_ := nodes_uri;
  xsl_uri_   := xsl_uri;
  xml_uri_   := xml_uri;
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

  dbms_output.put_line('Process nodes_uri='||nodes_uri_);
  tmp_clob_ := '<?xml version = ''1.0'' encoding = ''windows-1251''?> <ROOT>';
  dbms_lob.append(full_clob_, tmp_clob_);
  -- main loop
  for c in (select uri,num,uri_link
            from nodes_composer
            where uri=nodes_uri_ order by num)
  loop
    sql_uri_ := c.uri_link;
    dbms_output.put_line('- process sql_uri='||sql_uri_);
    begin
    	select sql_data into sql_block_ from sql_storage
      where uri=sql_uri_;
    exception when no_data_found then
      erm := '0001 - PL/SQL BLOCK not found, uri = '||sql_uri_;
      raise err;
    end;
    -- execute PL/SQL block
    if sql_block_ is not NULL then
      dbms_output.put_line('-- PL/SQL BLOCK was fetched');
      /*
      -- execute
      cur_ := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(cur_,
	  		sql_block_,
        DBMS_SQL.NATIVE);

      nCode := DBMS_SQL.EXECUTE(cur_);
      dbms_output.put_line('-- DBMS_SQL.EXECUTE() return code: '||nCode);
      DBMS_SQL.CLOSE_CURSOR(cur_);
      */
      plsql_str := sql_block_;

      EXECUTE IMMEDIATE plsql_str;

    else
      dbms_output.put_line('-- PL/SQL BLOCK is empty');
    end if;
    -- fetch SQL cursor
    begin
      select sql_statement into sql_clob_ from sql_storage
      where uri=sql_uri_;
    exception when no_data_found then
      erm := '0002 - SQL CLOB not found, uri = '||sql_uri_;
      raise err;
    end;
    dbms_output.put_line('-- SQL CLOB was fetched');
    if sql_clob_ is null then
      erm := '0003 - SQL CLOB cannot be empty, uri = '||sql_uri_;
      raise err;
    end if;

    -- convertion source SQL to simple XML
    ctx := dbms_xmlquery.newContext(sql_clob_);
    dbms_output.put_line('newContext() ... ok');

    dbms_xmlquery.setEncodingTag(ctx, 'windows-1251');
    dbms_xmlquery.setDateFormat(ctx,'dd.MM.yyyy HH:mm:ss');

    dbms_lob.trim(xml_clob_,0);
    dbms_xmlquery.getXML(ctx,xml_clob_);
    dbms_output.put_line('getXML() ... ok');

    dbms_xmlquery.closeContext(ctx);
    dbms_output.put_line('closeContext() ... ok');

    --
    dbms_output.put_line('Parsing XML document ');
    /*
    if xml_clob_ is not null then
      dbms_output.put_line('----1----');
      tmp_str := xml_clob_;
      dbms_output.put_line('----2----');
      i:=0;
      loop
        dbms_output.put_line(substr(tmp_str,1+255*i,255));
        i:=i+1;
        if substr(tmp_str,1+255*i,255) is null then exit; end if;
      end loop;
    end if;
    */
    xmlparser.parseClob(p, xml_clob_);

    -- get document
    tmp_clob_ := '<SELECT uri="'||c.uri_link||'">';
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
     select xsl_data into xsl_clob_ from xsl_storage
     where uri=xsl_uri_;
   exception when no_data_found then
     erm := '0003 - XSL CLOB not found, uri = '||xsl_uri_;
     raise err;
   end;
   if xsl_clob_ is null then
     dbms_output.put_line('XSL CLOB is empty');
   else
     dbms_output.put_line('XSL CLOB was fetched');

     xmlparser.parseClob(p, full_clob_);
  	 full_xmldoc := xmlparser.getDocument(p);

		 nCode := dbms_lob.getLength(full_clob_);
  	 dbms_lob.erase(full_clob_,nCode);

		 -- parse xsl file
	   dbms_output.put_line('Parsing XSL document ');
  	 xmlparser.parseClob(p, xsl_clob_);

		 -- get document
	   xsldoc := xmlparser.getDocument(p);

		 -- make stylesheet
	   ss := xslprocessor.newStylesheet(xsldoc, NULL);

		 -- process xsl
   	 proc := xslprocessor.newProcessor;

   	 dbms_output.put_line('Processing XSL stylesheet');
   	 xslprocessor.processXSL(proc, ss, full_xmldoc, full_clob_);

		 -- Free XML Documents
   	 xmldom.freeDocument(xsldoc);

		 -- Free XSL Stylesheet and Processor
	   xslprocessor.freeProcessor(proc);
  	 xslprocessor.freeStylesheet(ss);
     xmldom.freeDocument(full_xmldoc);
		 -------------------------------------------------
   end if;

   begin
    update xml_storage set xml_data=full_clob_
    where uri=xml_uri_;
		if SQL%ROWCOUNT=0 then
      insert into xml_storage(uri,xml_data)
      values(xml_uri_,full_clob_);
    end if;
   end;
   dbms_output.put_line('XML CLOB posted into storage');

   -- Free the xmlparser
   xmlparser.freeParser(p);

--  dbms_lob.freetemporary(sql_block_);
--  dbms_lob.freetemporary(sql_clob_);
--  dbms_lob.freetemporary(xsl_clob_);
--  dbms_lob.freetemporary(xml_clob_);
--  dbms_lob.freetemporary(full_clob_);


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

end sql2xml;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SQL2XML.sql =========*** End *** =
PROMPT ===================================================================================== 
