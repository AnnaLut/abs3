create or replace procedure p_nbur_ovdp_6ex_ins(p_clob          in clob,
                                              p_message         out varchar2)
is
      i                integer;
      j                integer;
      type l_type is record
      ( DATE_FV       varchar(70),
        ISIN          varchar(70),
        KV            varchar(70),
        FV_CP         varchar(70),
        YIELD         varchar(70),
        KURS          varchar(70),
        KOEF          varchar(70),
        DATE_MATURITY	varchar(70)

        );
      type l_ovdp       is table of l_type;
      l_tab_ovdp        l_ovdp := l_ovdp ();
      title            varchar2(100) := 'p_nbur_ovdp_6ex_ins';

      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_rowlist         dbms_xmldom.domnodelist;
      l_row             dbms_xmldom.domnode;
      l_str             varchar2(2000);
      l_err_loc         NUMBER(10);
      l_date_list       date_list:=date_list();
      l_date            date;
      l_datet           date;
begin
   l_parser := dbms_xmlparser.newparser;
   dbms_xmlparser.parseclob(l_parser, p_clob);
   l_doc := dbms_xmlparser.getdocument(l_parser);

   --формируем список строк
   l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'Row');
   BEGIN
     EXECUTE IMMEDIATE ' delete from  ERR$_NBUR_OVDP_6EX';
   END;

     for i in 0 .. dbms_xmldom.getlength(l_rowlist) - 1
     loop
        l_row := dbms_xmldom.item(l_rowlist, i);
        
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="DATE_FV"]/Value/text()', l_str);
         l_datet := to_date(trim(l_str),'dd.mm.yyyy');
         if l_datet is not null then
         l_tab_ovdp .extend;
         l_tab_ovdp (l_tab_ovdp .last).DATE_FV := l_datet;
         --наполняем список дат
         if l_date <> l_datet or l_date is null then
            l_date_list .extend;
            l_date_list (l_date_list .last) := l_datet;
         l_date:=l_datet;           
         end if;
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="ISIN"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).ISIN := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="KV"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).KV := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="FV_CP"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).FV_CP := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="YIELD"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).YIELD := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="KURS"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).KURS := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="KOEF"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).KOEF := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="DATE_MATURITY"]/Value/text()', l_str);
         l_tab_ovdp (l_tab_ovdp .last).DATE_MATURITY := to_date(trim(l_str),'dd.mm.yyyy');
         end if;
      end loop;
     
     --очищаем таблицу по тем датам, что грузим
     forall j in indices of l_date_list 
     delete from  NBUR_OVDP_6EX t where t.date_fv = l_date_list(j);
      
     forall i in indices of l_tab_ovdp
     insert into NBUR_OVDP_6EX (  DATE_FV,
                                  ISIN,
                                  KV,
                                  FV_CP,
                                  YIELD,
                                  KURS,
                                  KOEF,
                                  DATE_MATURITY)
           values (l_tab_ovdp(i).DATE_FV,
                   l_tab_ovdp(i).ISIN,
                   l_tab_ovdp(i).KV,
                   l_tab_ovdp(i).FV_CP,
                   l_tab_ovdp(i).YIELD,
                   l_tab_ovdp(i).KURS,
                   l_tab_ovdp(i).KOEF,
                   l_tab_ovdp(i).DATE_MATURITY
                   )
             log errors INTO ERR$_NBUR_OVDP_6EX
              ('INSERT') reject LIMIT unlimited;
             l_tab_ovdp.DELETE;
             l_date_list.delete;
     BEGIN
       SELECT count(*) into l_err_loc  from  ERR$_NBUR_OVDP_6EX;
       if l_err_loc> 0 then
         p_message:= 'Завантаження пройшло з помилками! Кількість помилок = '||l_err_loc||'.  Дані о помилках в таблиці - ERR$_NBUR_OVDP_6EX';
       else
         p_message:= 'Завантаження пройшло успішно!';
       end if;
     END;
exception when others then
   p_message:= substr(title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,4000);
end;
/

grant EXECUTE                                                                on p_nbur_ovdp_6ex_ins to ABS_ADMIN;
grant EXECUTE                                                                on p_nbur_ovdp_6ex_ins to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on p_nbur_ovdp_6ex_ins to WR_ALL_RIGHTS;
