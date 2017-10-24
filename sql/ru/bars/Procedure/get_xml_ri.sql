

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_XML_RI.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_XML_RI ***

  CREATE OR REPLACE PROCEDURE BARS.GET_XML_RI 
  (p_FILEXML  IN  varchar2,
   p_FILEKVT  IN  varchar2,
   p_KU       IN  varchar2,
   p_key      IN  number  ,
   p_RET      OUT int     ,
   p_err      OUT varchar2
  )
IS

  l_parser        xmlparser.parser := xmlparser.newparser;
  l_doc           xmldom.domdocument;
  l_HEAD          xmldom.domnodelist;
  l_RIROW         xmldom.domnodelist;
  l_HEADelement   xmldom.DOMNode    ;
  l_RIROWelement  xmldom.DOMNode    ;
  l_clob          clob           ;
  l_FNAME         varchar2(12)   ;
  l_FSIGN         varchar2(254)  ;
  l_FSIGO         varchar2(254)  ;
  l_ASCII         varchar2(254)  ;
  l_nASCI         number         ;
  l_FDATE         varchar2(12)   ;
  l_FTIME         varchar2(12)   ;
  l_FDATO         varchar2(12)   ;
  l_FTIMO         varchar2(12)   ;
  l_RNUM          varchar2(12)   ;
  l_tmp           varchar2(254)  ;

  l_idcode        varchar2(12)   ;
  l_doct          varchar2(2)    ;
  l_docs          varchar2(10)   ;
  l_docn          varchar2(10)   ;
  l_insform       varchar2(12)   ;
  l_k060          varchar2(12)   ;

  l_xml_schema    varchar2(12)   ;
  l_header        xmltype        ;
  l_xml_data      xmltype        ;
  l_clob_data     clob           ;
  l_DATERI        date           ;
  nono            int            ;
  l_iN            int            ;
begin

  p_RET := 0;
  p_err := null;
  l_iN  := 0;

  bars_audit.info('GET_XML_RI: '||p_FILEXML||' start');

  begin
--  select count(*)
--  into   i
--  from   tmp_ri_clob;
--  bars_audit.info('GET_XML_RI: i='||to_char(i));
    select replace(replace(replace(c,chr(38),chr(38)||'amp;'),chr(38)||chr(38)||'amp;',chr(38)||'amp;'),chr(38)||'amp;amp;',chr(38)||'amp;')
    into   l_clob
    from   tmp_ri_clob
    where  namef=to_char(p_key);
--  l_xml := xmltype(l_clob);
    bars_audit.info('GET_XML_RI: '||p_FILEXML||' loaded into CLOB');
  exception when no_data_found then
    p_RET := -7;
    p_err := 'Помилка при завантаженні файлу '||p_FILEXML||' в таблицю (CLOB) для обробки';
    return;
  end;

--очистка CUSTOMER_RI

  begin
--  GET_RI('','','','',-1,0,'',l_ret,l_err);
    delete
    from   customer_ri;
  exception when others then
    bars_audit.error('GET_XML_RI(-8): '||sqlerrm||' '||dbms_utility.format_error_backtrace);
    P_RET := -8;
    p_err := 'Помилка -10008: при виконанні очистки таблиці реєстра інсайдерів: '||sqlerrm;
--  return;
    goto errz;
  end;

  bars_audit.info('GET_XML_RI: '||p_FILEXML||' the table of CUSTOMER_RI is cleared');


--text_ := to_char(l_clob);
--text_ := dbms_lob.substr(l_clob,32767,1);
--bars_audit.info('GET_XML_RI: l_clob = '||text_);

  xmlparser.parseCLOB(l_parser,l_clob);
  l_doc   := xmlparser.getDocument(l_parser);

  l_HEAD  := xmldom.getElementsByTagName(l_doc,'HEAD');
--lh_     := xmldom.getlength(l_HEAD);
--l_HEAD  := xmldom.getElementsByTagName(l_doc,'DECLARATION');
--bars_audit.info('GET_XML_RI: xmldom.getlength(l_HEAD) = '||lh_);

  for m in 0..xmldom.getlength(l_HEAD)-1
  loop
--  bars_audit.info('GET_XML_RI: m = '||m);
    l_HEADelement := xmldom.item(l_HEAD,m);
    xslprocessor.valueof(l_HEADelement,'FNAME/text()',l_FNAME);
    xslprocessor.valueof(l_HEADelement,'FSIGN/text()',l_FSIGN);
    xslprocessor.valueof(l_HEADelement,'FDATE/text()',l_FDATE);
    xslprocessor.valueof(l_HEADelement,'FTIME/text()',l_FTIME);
    xslprocessor.valueof(l_HEADelement,'RNUM/text()' ,l_RNUM );
--  bars_audit.info('GET_XML_RI: FSIGN = '||l_FSIGN);
--  bars_audit.info('GET_XML_RI: FDATE = '||l_FDATE);
--  bars_audit.info('GET_XML_RI: FTIME = '||l_FTIME);
--  bars_audit.info('GET_XML_RI: RNUM  = '||l_RNUM );
  end loop;

  bars_audit.info('GET_XML_RI: '||p_FILEXML||' прочитан заголовок');

--обов’язковість заповнення тегів FNAME, FDATE, FTIME, FSIGN

  if l_FNAME is null then
    P_RET := -1;
    p_err := 'Помилка -10001: не заповнений тег FNAME';
    goto errz;
  end if;

  if upper(l_FNAME)<>upper(p_FILEXML) then
    P_RET := -5;
    p_err := 'Помилка -10005: значення тега FNAME не співпадає з іменем XML-файлу';
    goto errz;
  end if;

  if l_FDATE is null then
    P_RET := -2;
    p_err := 'Помилка -10002: не заповнений тег FDATE';
    goto errz;
  end if;

  if l_FTIME is null then
    P_RET := -3;
    p_err := 'Помилка -10003: не заповнений тег FTIME';
    goto errz;
  end if;

  if l_FSIGN is not null then
    l_nASCI := sumascii(l_FNAME)+sumascii(l_FDATE)+sumascii(l_FTIME)+sumascii(l_RNUM);
  else
    P_RET := -4;
    p_err := 'Помилка -10004: не заповнений тег FSIGN';
    goto errz;
  end if;

--l_ret := 0;

  l_RIROW := xmldom.getelementsbytagname(l_doc,'RIROW');
--bars_audit.info('GET_XML_RI: xmldom.getlength(l_RIROW) = '||xmldom.getlength(l_RIROW));

  for i in 0..xmldom.getlength(l_RIROW)-1
  loop
    l_RIROWelement := xmldom.item(l_RIROW,i);
    xslprocessor.valueof(l_RIROWelement,'IDCODE/text()' ,l_IDCODE );
    begin
      xslprocessor.valueof(l_RIROWelement,'DOCT/text()'   ,l_DOCT   );
    exception when others then
      l_DOCT := null;
    end;
    begin
      xslprocessor.valueof(l_RIROWelement,'DOCS/text()'   ,l_DOCS   );
    exception when others then
      l_DOCS := null;
    end;
    if ascii(l_DOCS)=10 then
      l_DOCS := null;
    end if;
    begin
      xslprocessor.valueof(l_RIROWelement,'DOCN/text()'   ,l_DOCN   );
    exception when others then
      l_DOCN := null;
    end;
    if ascii(l_DOCN)=10 then
      l_DOCN := null;
    end if;
    xslprocessor.valueof(l_RIROWelement,'INSFORM/text()',l_INSFORM);
    xslprocessor.valueof(l_RIROWelement,'K060/text()'   ,l_K060   );

--  bars_audit.info('GET_XML_RI: IDCODE  = '||l_IDCODE );
----bars_audit.info('GET_XML_RI: PASPSN  = '||l_PASPSN );
--  bars_audit.info('GET_XML_RI: DOCT    = '||l_DOCT   );
--  bars_audit.info('GET_XML_RI: DOCS    = '||l_DOCS   );
--  bars_audit.info('GET_XML_RI: DOCN    = '||l_DOCN   );
--  bars_audit.info('GET_XML_RI: INSFORM = '||l_INSFORM);
--  bars_audit.info('GET_XML_RI: K060    = '||l_K060   );

    if l_idcode is null then
      P_RET := -9;
      p_err := 'Помилка -10009: не заповнене IDCODE - ROW='||to_char(i+1);
      goto err;
    end if;
    if not isnumber(l_idcode) then
      P_RET := -10;
      p_err := 'Помилка -10010: IDCODE не числове - ROW='||to_char(i+1);
      goto err;
    end if;

    if l_insform is null then
      P_RET := -11;
      p_err := 'Помилка -10011: не заповнене INSFORM - ROW='||to_char(i+1);
      goto err;
    end if;
    if l_insform not in ('0','1') then
      P_RET := -12;
      p_err := 'Помилка -10012: неприпустиме значення INSFORM - ROW='||to_char(i+1);
      goto err;
    end if;

    if l_k060 is null then
      P_RET := -13;
      p_err := 'Помилка -10013: не заповнене K060 - ROW='||to_char(i+1);
      goto err;
    end if;

    if l_FSIGN is not null then
--    bars_audit.info('GET_XML_RI: idcode ='||l_idcode ||', sumascii(idcode )='||sumascii(l_idcode ));
--    bars_audit.info('GET_XML_RI: doct   ='||l_doct   ||', sumascii(doct   )='||sumascii(l_doct   ));
--    bars_audit.info('GET_XML_RI: docs   ='||l_docs   ||', sumascii(docs   )='||sumascii(l_docs   ));
--    bars_audit.info('GET_XML_RI: docn   ='||l_docn   ||', sumascii(docn   )='||sumascii(l_docn   ));
--    bars_audit.info('GET_XML_RI: insform='||l_insform||', sumascii(insform)='||sumascii(l_insform));
--    bars_audit.info('GET_XML_RI: k060   ='||l_k060   ||', sumascii(k060   )='||sumascii(l_k060   ));
--    l_nASCI := l_nASCI+sumascii(l_idcode)+sumascii(l_paspsn)+sumascii(l_insform)+sumascii(l_k060);
      l_nASCI := l_nASCI+sumascii(l_idcode)+sumascii(l_DOCT)+sumascii(l_DOCS)+sumascii(l_DOCN)+sumascii(l_insform)+sumascii(l_k060);
    end if;

    begin
      l_DATERI := to_date(substr(p_FILEXML,3,6),'DDMMYY');
    exception when others then
      l_DATERI := trunc(sysdate);
    end;
    begin
      insert
      into   customer_ri (idcode ,
--                        paspsn ,
                          doct   ,
                          docs   ,
                          docn   ,
                          insform,
                          k060   ,
                          fileri ,
                          dateri)
                  values (l_IDCODE            ,
--                        p_PASPSN            ,
                          to_number(l_DOCT)   ,
                          l_DOCS              ,
                          l_DOCN              ,
                          to_number(l_INSFORM),
                          to_number(l_k060)   ,
                          p_FILEXML           ,
                          l_DATERI);
    exception when others then
--    bars_audit.info('GET_XML_RI: sqlcode = '||sqlcode||' '||dbms_utility.format_error_backtrace);
      if sqlcode=-1 then -- дублирование ключа игнорируется
        null;
--      bars_audit.info('GET_XML_RI: l_IDCODE  = '||l_IDCODE );
--      bars_audit.info('GET_XML_RI: l_DOCT    = '||l_DOCT   );
--      bars_audit.info('GET_XML_RI: l_DOCS    = '||l_DOCS   );
--      bars_audit.info('GET_XML_RI: l_DOCN    = '||l_DOCN   );
--      bars_audit.info('GET_XML_RI: l_INSFORM = '||l_INSFORM);
--      bars_audit.info('GET_XML_RI: l_k060    = '||l_k060   );
--      bars_audit.info('GET_XML_RI: p_FILEXML = '||p_FILEXML);
--      bars_audit.info('GET_XML_RI: l_DATERI  = '||l_DATERI );
      else
        bars_audit.error('GET_XML_RI(-16): '||sqlerrm||' '||dbms_utility.format_error_backtrace);
        p_RET := -16;
        p_err := 'Помилка -10016: при вставці в таблицю реєстра інсайдерів: '||sqlerrm;
--      goto err;
      end if;
    end;

<<err>>
--  if l_ret<>0 or p_RET<>0 then
    if p_RET<>0 then
      exit;
    end if;

  end loop;

  bars_audit.info('GET_XML_RI: '||p_FILEXML||' прочитаны инф.строки');


--  основная обработка ВСЕХ клиентов AБС
 if p_RET=0 then

    begin
      GET_RI;
    exception when others then
      bars_audit.error('GET_XML_RI: '||sqlerrm||' '||dbms_utility.format_error_backtrace);
      p_RET := -17;
      p_err := 'Помилка '||to_char(p_RET)||
               ' при выполнении GET_RI (занесение данных по инсайдерам)';
      --goto err;
    end;

 end if;

  bars_audit.info('GET_XML_RI: '||p_FILEXML||' основная обработка +');

<<errz>>

--bars_audit.info('GET_XML_RI: '||l_FNAME||' sumASCII='||to_char(l_nASCI));

  if P_RET=0 and l_FSIGN!=to_char(l_nASCI) then
    P_RET := -15;
    p_err := 'Помилка -10015: невірна контрольна сума (не рівна значенню тега FSIGN)';
  end if;

  l_FDATO := to_char(sysdate,'dd.mm.yyyy');
  l_FTIMO := to_char(sysdate,'hh24:mi:ss');
  l_FSIGO := to_char(sumascii(p_FILEKVT)+sumascii(p_KU)+sumascii(l_FDATO)+sumascii(l_FTIMO));

--сформировать квитанцию xml в таблицу tmp_ri_clob !!!
  l_xml_schema := 'RI_P.XSD';

  select XmlElement("HEAD",XmlForest(p_FILEKVT "FNAME",
                                     l_FSIGO   "FSIGN",
                                     p_KU      "KU"   ,
                                     l_FDATO   "FDATE",
                                     l_FTIMO   "FTIME"))
  into   l_header
  from   dual;

  if p_RET<>0 then
    p_RET := 1;
  else
    p_err := 'OK';
  end if;
  select XmlElement("DECLARATION",
                    XmlAttributes(l_xml_schema as "xsi:noNamespaceSchemaLocation",
                                  'http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi"),
         XmlConcat(l_header,
                   XmlElement("PROCBODY",
                              XmlConcat(XmlElement("RIFNAME"     ,p_FILEXML)     ,
                                        XmlElement("PROC_ERR"    ,to_char(p_RET)),
                                        XmlElement("PROC_COMMENT",p_err)         ,
                                        XmlElement("PROC_INFO"                   ,
                                        XmlAgg(XmlElement("CUSTOMER",
                                               XmlElement("RNK"             ,RNK             ),
                                               XmlElement("BRANCH"          ,BRANCH          ),
                                               XmlElement("CUSTTYPE"        ,CUSTTYPE        ),
                                               XmlElement("OKPO"            ,OKPO            ),
                                               XmlElement("PASSP"           ,PASSP           ),
                                               XmlElement("SER"             ,SER             ),
                                               XmlElement("NUMDOC"          ,NUMDOC          ),
                                               XmlElement("PRINSIDER"       ,PRINSIDER       ),
                                               XmlElement("INSFO"           ,INSFO           ),
                                               XmlElement("PRINSIDER_BEFORE",PRINSIDER_BEFORE),
                                               XmlElement("INSFO_BEFORE"    ,INSFO_BEFORE    ))))))))
  into   l_xml_data
  from   (select distinct * from tmp_ri_cust);

  dbms_lob.createtemporary(l_clob_data,FALSE);
  dbms_lob.append(l_clob_data,'<?xml version="1.0" encoding="windows-1251"?>');
  dbms_lob.append(l_clob_data,l_xml_data.getClobVal());

  delete
  from   tmp_ri_cust;

  delete
  from   tmp_ri_clob;

  insert
  into   tmp_ri_clob (C,
                      NAMEF)
              values (l_clob_data,
                      2);

  bars_audit.info('GET_XML_RI: '||p_FILEXML||' finish');

  RETURN;
end GET_XML_RI;
/
show err;

PROMPT *** Create  grants  GET_XML_RI ***
grant EXECUTE                                                                on GET_XML_RI      to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_XML_RI.sql =========*** End **
PROMPT ===================================================================================== 
