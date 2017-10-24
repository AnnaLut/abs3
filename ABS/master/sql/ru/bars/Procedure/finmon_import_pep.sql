create or replace procedure finmon_import_pep (
  p_mode     IN number,
  p_filename IN varchar2 )
is
    l_clob         clob;  
    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_filetrailer  dbms_xmldom.DOMNodeList;
    l_trailer      dbms_xmldom.DOMNode;
    l_analyticlist dbms_xmldom.DOMNodeList;
    l_analytic     dbms_xmldom.DOMNode;
    type t_finmon is table of FINMON_PEP_RELS%rowtype;
    finmon_row     t_finmon := t_finmon();
    l_tmp          varchar2(265);
    l_bigtmp       clob;
    
  procedure bulk_insert(finmon_row in t_finmon) is
  begin
    forall j in finmon_row.first .. finmon_row.last
      insert into FINMON_PEP_RELS values finmon_row(j);
  end;
begin
  execute immediate 'truncate table FINMON_PEP_RELS';

  begin
     select file_clob 
       into l_clob 
       from imp_file 
      where file_name = p_filename;
  exception when no_data_found then
     raise_application_error(-20000, 'Дані файлу ' || p_filename || ' не знайдено');
  end;
 
  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, l_clob);
  l_doc := dbms_xmlparser.getdocument(l_parser);
  l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'personlist');
  l_trailer := dbms_xmldom.item(l_filetrailer, 0);
  l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'person');

  
  for i in 0 .. dbms_xmldom.getlength(l_analyticlist)-1
  loop
     l_analytic := dbms_xmldom.item(l_analyticlist, i);
     finmon_row.extend;
        /*
        id          унікальний код    N(6)
        idcode      ІНН    N(10)
        name        прізвище, ім’я та по батькові ФО або назва ЮО    C(300)
        pep         Пов’язана з ЮО публічна особа    C(300)
        bdate       дата народження    
        doct        тип документу    N(2)
        docs        серія документу    С(10)
        docn        номер документу    N(10)
        category    категорія ПЕП    C(300)
        edate       дата втрати ознаки ПЕП    D(10)
        branch      код філії банка (МФО)    N(6)
        permit      Дозвіл на встановлення ділових відносин    N(1)
        remdoc      зауваження до пакета документів    N(1)
        comment     Примітки    C(300)
        ptype       тип особи    N(1)
        pres        резидентність    N(1)
        mdate       Дата останніх змін в даних    D(10)
        */

     dbms_xslprocessor.valueof(l_analytic, 'id/text()', l_tmp);
     finmon_row(i+1).id := to_number(trim(l_tmp));
     
     dbms_xslprocessor.valueof(l_analytic, 'idcode/text()', l_tmp);
     finmon_row(i+1).idcode := trim(l_tmp);

     dbms_xslprocessor.valueof(l_analytic, 'name/text()', l_tmp);
     finmon_row(i+1).name := trim(l_tmp);     
     
     dbms_xslprocessor.valueof(l_analytic, 'pep/text()', l_tmp);
     finmon_row(i+1).pep := trim(l_tmp); 
     
     dbms_xslprocessor.valueof(l_analytic, 'bdate/text()', l_tmp);
     finmon_row(i+1).bdate := to_date(trim(l_tmp),'dd.mm.yyyy');
     
     dbms_xslprocessor.valueof(l_analytic, 'doct/text()', l_tmp);
     finmon_row(i+1).doct := trim(l_tmp); 
     dbms_xslprocessor.valueof(l_analytic, 'docs/text()', l_tmp);
     finmon_row(i+1).docs := trim(l_tmp); 
     dbms_xslprocessor.valueof(l_analytic, 'docn/text()', l_tmp);
     finmon_row(i+1).docn := trim(l_tmp);           
     
     dbms_xslprocessor.valueof(l_analytic, 'category/text()', l_tmp);
     finmon_row(i+1).category := trim(l_tmp);        

     dbms_xslprocessor.valueof(l_analytic, 'edate/text()', l_tmp);
     finmon_row(i+1).edate := to_date(trim(l_tmp),'dd.mm.yyyy');

     dbms_xslprocessor.valueof(l_analytic, 'branch/text()', l_tmp);
     finmon_row(i+1).branch := trim(l_tmp);           

     dbms_xslprocessor.valueof(l_analytic, 'permit/text()', l_tmp);
     finmon_row(i+1).permit := trim(l_tmp);         
        
     dbms_xslprocessor.valueof(l_analytic, 'remdoc/text()', l_tmp);
     finmon_row(i+1).remdoc := trim(l_tmp);  

     dbms_xslprocessor.valueof(l_analytic, 'comment/text()', l_tmp);
     finmon_row(i+1).comments := trim(l_tmp);               

     dbms_xslprocessor.valueof(l_analytic, 'ptype/text()', l_tmp);
     finmon_row(i+1).ptype := trim(l_tmp);          
       
     dbms_xslprocessor.valueof(l_analytic, 'pres/text()', l_tmp);
     finmon_row(i+1).pres := trim(l_tmp);         

     dbms_xslprocessor.valueof(l_analytic, 'mdate/text()', l_tmp);
     finmon_row(i+1).mdate := to_date(trim(l_tmp),'dd.mm.yyyy');          
    
     finmon_row(i+1).DOCALL :=  finmon_row(i+1).docs||finmon_row(i+1).docn; 
     
  end loop;
  bulk_insert(finmon_row);
  finmon_row.delete; 
  finmon_row.delete();
  finmon_row := null;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);
end finmon_import_pep;
/
grant execute on finmon_import_pep to bars_access_defrole;
/