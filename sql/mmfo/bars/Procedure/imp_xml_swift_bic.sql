

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IMP_XML_SWIFT_BIC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IMP_XML_SWIFT_BIC ***

  CREATE OR REPLACE PROCEDURE BARS.IMP_XML_SWIFT_BIC 
  (p_filename   varchar2,
   p_par        int  default 0
  )

IS

  l_parser                dbms_xmlparser.parser;
  l_doc                   dbms_xmldom.domdocument;
  l_analyticlist          dbms_xmldom.DOMNodeList;
  l_analytic              dbms_xmldom.DOMNode;
  i                       int          ;
  j                       int          ;
  l_clob                  clob         ;
  l_bic_code              varchar2(254);
  l_branch_code           varchar2(254);
  l_institution_name      varchar2(254);
  l_city_heading          varchar2(254);
  l_physical_address_1    varchar2(254);
  l_physical_address_2    varchar2(254);
  l_physical_address_3    varchar2(254);
  l_physical_address_4    varchar2(254);
  l_location              varchar2(254);
  l_country_name          varchar2(254);

begin

  bars_audit.info('GET_XML_SWIFT: start '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));

  begin
    select file_clob into l_clob from imp_file where file_name = p_filename;
  exception when no_data_found then
    raise_application_error(-20001,
                            'Файл XML не был загружен в CLOB для обработки...',
                            false);
    return;
  end;

  bars_audit.info('GET_XML_SWIFT: load clob '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));

  l_parser := dbms_xmlparser.newparser;

  dbms_xmlparser.parseclob(l_parser,l_clob);

  l_doc := dbms_xmlparser.getdocument(l_parser);

  l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc,'fi');

  j := 0;
  begin
    savepoint sp_before;
    for i in 0 .. dbms_xmldom.getlength(l_analyticlist)-1
    loop

      l_analytic := dbms_xmldom.item(l_analyticlist,i);

      dbms_xslprocessor.valueof(l_analytic,'bic_code/text()'          ,l_bic_code          );
      dbms_xslprocessor.valueof(l_analytic,'branch_code/text()'       ,l_branch_code       );
      dbms_xslprocessor.valueof(l_analytic,'institution_name/text()'  ,l_institution_name  );
      dbms_xslprocessor.valueof(l_analytic,'city_heading/text()'      ,l_city_heading      );
      dbms_xslprocessor.valueof(l_analytic,'physical_address_1/text()',l_physical_address_1);
      dbms_xslprocessor.valueof(l_analytic,'physical_address_2/text()',l_physical_address_2);
      dbms_xslprocessor.valueof(l_analytic,'physical_address_3/text()',l_physical_address_3);
      dbms_xslprocessor.valueof(l_analytic,'physical_address_4/text()',l_physical_address_4);
      dbms_xslprocessor.valueof(l_analytic,'location/text()'          ,l_location          );
      dbms_xslprocessor.valueof(l_analytic,'country_name/text()'      ,l_country_name      );

      if l_bic_code is not null and l_branch_code is not null then
        if p_par=0 then

          begin
            update SW_BANKS
            set    NAME=l_institution_name                  ,
                   OFFICE=replace(trim(l_physical_address_1||' '||
                                       l_physical_address_2||' '||
                                       l_physical_address_3||' '||
                                       l_physical_address_4||' '||
                                       l_location),'  ',' '),
                   CITY=trim(substr(l_city_heading,1,35))   ,
                   COUNTRY=l_country_name
            where  bic=l_bic_code||l_branch_code;
            if sql%rowcount=0 then
              insert
              into   SW_BANKS (BIC    ,
                               NAME   ,
                               OFFICE ,
                               CITY   ,
                               COUNTRY,
                               TRANSBACK)
                       values (l_bic_code||l_branch_code         ,
                               l_institution_name                ,
                               replace(trim(l_physical_address_1||' '||
                                            l_physical_address_2||' '||
                                            l_physical_address_3||' '||
                                            l_physical_address_4||' '||
                                            l_location),'  ',' '),
                               trim(substr(l_city_heading,1,35)) ,
                               l_country_name                    ,
                               0);
            end if;
          end;

        else

          begin
            insert
            into   SW_BANKS (BIC    ,
                             NAME   ,
                             OFFICE ,
                             CITY   ,
                             COUNTRY,
                             TRANSBACK)
                     values (l_bic_code||l_branch_code         ,
                             l_institution_name                ,
                             replace(trim(l_physical_address_1||' '||
                                          l_physical_address_2||' '||
                                          l_physical_address_3||' '||
                                          l_physical_address_4||' '||
                                          l_location),'  ',' '),
                             trim(substr(l_city_heading,1,35)) ,
                             l_country_name                    ,
                             0);
          exception when dup_val_on_index then
            update SW_BANKS
            set    NAME=l_institution_name                  ,
                   OFFICE=replace(trim(l_physical_address_1||' '||
                                       l_physical_address_2||' '||
                                       l_physical_address_3||' '||
                                       l_physical_address_4||' '||
                                       l_location),'  ',' '),
                   CITY=trim(substr(l_city_heading,1,35))   ,
                   COUNTRY=l_country_name
            where  bic=l_bic_code||l_branch_code;
          end;

        end if;
--      счетчик записей
        j := j + 1;
        dbms_application_info.set_client_info(to_char(j+1)||' records were already loaded...');
      end if;

    end loop;
 -- exception when others then
   -- rollback to sp_before;
    --dbms_application_info.set_client_info(' ');
   -- bars_audit.info('GET_XML_SWIFT: end (error) '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));
  --  RETURN;
  end;

  dbms_application_info.set_client_info('In all '||to_char(j+1)||' records loaded.');
  bars_audit.info('GET_XML_SWIFT: end '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));
  RETURN;
end IMP_XML_SWIFT_BIC;
/
show err;

PROMPT *** Create  grants  IMP_XML_SWIFT_BIC ***
grant EXECUTE                                                                on IMP_XML_SWIFT_BIC to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IMP_XML_SWIFT_BIC to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IMP_XML_SWIFT_BIC.sql =========***
PROMPT ===================================================================================== 
