

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FINMON_IMPORT_FILES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FINMON_IMPORT_FILES ***

  CREATE OR REPLACE PROCEDURE BARS.FINMON_IMPORT_FILES (
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
    type t_finmon is table of finmon_public_rels%rowtype;
    finmon_row     t_finmon := t_finmon();
    l_tmp          varchar2(265);
    l_bigtmp       clob;

  procedure bulk_insert(finmon_row in t_finmon) is
  begin
    forall j in finmon_row.first .. finmon_row.last
      insert into finmon_public_rels values finmon_row(j);
  end;
begin
  execute immediate 'truncate table finmon_public_rels';

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
        <id>
        <name>
        <termin>
        <birth>
        <bio>
        */

     dbms_xslprocessor.valueof(l_analytic, 'id/text()', l_tmp);
     finmon_row(i+1).id := to_number(trim(l_tmp));

     dbms_xslprocessor.valueof(l_analytic, 'name/text()', l_tmp);
     finmon_row(i+1).name := trim(l_tmp);

     dbms_xslprocessor.valueof(l_analytic, 'termin/text()', l_tmp);
     finmon_row(i+1).termin := to_date(trim(l_tmp),'dd.mm.yyyy');

     dbms_xslprocessor.valueof(l_analytic, 'birth/text()', l_tmp);
     finmon_row(i+1).birth := to_date(trim(l_tmp),'dd.mm.yyyy');

     dbms_xslprocessor.valueof(l_analytic, 'bio/text()', l_bigtmp);
     finmon_row(i+1).bio := trim(l_bigtmp);

     finmon_row(i+1).PRIZV := substr(finmon_row(i+1).name, 1, instr(finmon_row(i+1).name,' ')-1);
     finmon_row(i+1).FNAME := trim(substr(finmon_row(i+1).name, length(finmon_row(i+1).PRIZV)+1, length(finmon_row(i+1).name)));
     finmon_row(i+1).TERMINMOD := trunc(sysdate);
     finmon_row(i+1).FULLNAME :=  upper(replace(replace(replace(replace(replace(replace(replace(replace(finmon_row(i+1).name,'/',''),'\',''),'*',''),'~',''),'!',''),'&',''),'?',''),' ',''));

  end loop;
  bulk_insert(finmon_row);
  finmon_row.delete;
  finmon_row.delete();
  finmon_row := null;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);
end finmon_import_files;
/
show err;

PROMPT *** Create  grants  FINMON_IMPORT_FILES ***
grant EXECUTE                                                                on FINMON_IMPORT_FILES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FINMON_IMPORT_FILES.sql =========*
PROMPT ===================================================================================== 
