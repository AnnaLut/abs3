create or replace procedure p_nbu_credit_ins(p_file_name       in NBU_CREDIT_INSURANCE_FILES.NAME%type,
                                             p_ddate           in varchar2,  --месяц.год в формате 07.18
                                             p_clob            in clob,
                                             p_message         out varchar2)
is
      i                integer;
      j                integer;
      type l_req_oper is record
      ( kf       varchar(70),
        numb     varchar(70),
        branch   varchar(70),
        nmk      varchar(70),
        okpo     varchar(70),
        typezp   varchar(70),
        zallast  varchar(70),
        zabday   varchar(70),
        rate     varchar(70),
        sum      varchar(70),
        tar      varchar(70),
        strsum   varchar(70),
        range    varchar(70),
        nls      varchar(70),
        kv       varchar(70),
        rnk      varchar(70),
        nd       varchar(70)
        );
      type l_nsi       is table of l_req_oper;
      l_tab_nsi        l_nsi := l_nsi ();
      l_nsif           NBU_CREDIT_INSURANCE_FILES%ROWTYPE;
      title            varchar2(100) := 'p_nbu_credit_ins';

      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_rowlist         dbms_xmldom.domnodelist;
      l_collist         dbms_xmldom.domnodelist;
      l_row             dbms_xmldom.domnode;
      l_col             dbms_xmldom.domnode;
      l_str             varchar2(2000);
      l_str1            varchar2(2000);
      l_attr_node       dbms_xmldom.domnode;
      l_attr_nodes      dbms_xmldom.domnamednodemap;
      l_pref            varchar2(2);
      l_err_loc         NUMBER(10);
      l_kf              varchar2(6):= sys_context('bars_context','user_mfo');
begin
   l_parser := dbms_xmlparser.newparser;
   dbms_xmlparser.parseclob(l_parser, p_clob);
   l_doc := dbms_xmlparser.getdocument(l_parser);

    l_nsif.DDATE := last_day(to_date('01.' || p_ddate, 'dd.mm.yyyy'));
    insert into NBU_CREDIT_INSURANCE_FILES  (ID,
                                             NAME,
                                             DDATE,
                                             IDUPD,
                                             CHGDATE)
         values (s_NBU_CREDIT_INSURANCE_FILES.Nextval,
                 p_file_name,
                 l_nsif.DDATE,
                 gl.aUID,
                 sysdate
                )
     return id into l_nsif.id;


   --формируем список строк
   l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'Row');
  
    --почищу ошибки старых файлов
   delete from  ERR$_NBU_CREDIT_INSURANCE where pid<l_nsif.id-20;


     for i in 0 .. dbms_xmldom.getlength(l_rowlist) - 1
     loop
        l_row := dbms_xmldom.item(l_rowlist, i);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="KF"]/Value/text()', l_str);
         
         if trim(l_str) = l_kf or (l_kf is null and trim(l_str) is not null ) then  --загружаем только свое, даже если в файле разные РУ
         l_tab_nsi .extend;
         l_tab_nsi (l_tab_nsi .last).KF := trim(l_str);
         l_pref:=bars_sqnc.ru(p_kf => l_tab_nsi (l_tab_nsi .last).KF);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="NUMB"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).NUMB := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="BRANCH"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).BRANCH := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="NMK"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).NMK := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="OKPO"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).OKPO := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="TYPEZP"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).TYPEZP := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="ZALLAST"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).ZALLAST := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="ZABDAY"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).ZABDAY := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="RATE"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).RATE := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="SUM"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).SUM := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="TAR"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).TAR := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="STRSUM"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).STRSUM := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="RANGE"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).RANGE := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="NLS"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).NLS := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="KV"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).KV := trim(l_str);
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="RNK"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).RNK := trim(l_str)||l_pref;
         dbms_xslprocessor.valueof(l_row, 'Column[Tag="ND"]/Value/text()', l_str);
         l_tab_nsi (l_tab_nsi .last).ND := trim(l_str)||l_pref;
         end if;
      end loop;
     forall i in indices of l_tab_nsi
     insert into NBU_CREDIT_INSURANCE (KF,
                                       NUMB,
                                       BRANCH,
                                       NMK,
                                       OKPO,
                                       TYPEZP,
                                       ZALLAST,
                                       ZABDAY,
                                       RATE,
                                       SUM,
                                       TAR,
                                       STRSUM,
                                       RANGE,
                                       NLS,
                                       KV,
                                       RNK,
                                       ND,
                                       PID)
           values (l_tab_nsi(i).KF,
                  l_tab_nsi(i).NUMB,
                  l_tab_nsi(i).BRANCH,
                  l_tab_nsi(i).NMK,
                  l_tab_nsi(i).OKPO,
                  l_tab_nsi(i).TYPEZP,
                  l_tab_nsi(i).ZALLAST,
                  l_tab_nsi(i).ZABDAY,
                  l_tab_nsi(i).RATE,
                  l_tab_nsi(i).SUM,
                  l_tab_nsi(i).TAR,
                  l_tab_nsi(i).STRSUM,
                  l_tab_nsi(i).RANGE,
                  l_tab_nsi(i).NLS,
                  l_tab_nsi(i).KV,
                  l_tab_nsi(i).RNK,
                  l_tab_nsi(i).ND,
                  l_nsif.id)
             log errors INTO ERR$_NBU_CREDIT_INSURANCE
              ('INSERT') reject LIMIT unlimited;
             l_tab_nsi.DELETE;
     BEGIN
       SELECT count(*) into l_err_loc  from  ERR$_NBU_CREDIT_INSURANCE where pid = l_nsif.id;
       if l_err_loc> 0 then
         p_message:= 'Завантаження пройшло з помилками! Зформовано файл № '||l_nsif.id||'. Кількість помилок = '||l_err_loc||'.  Дані о помилках в таблиці - ERR$_NBU_CREDIT_INSURANCE';
         update  NBU_CREDIT_INSURANCE_FILES
            set  state =2
         where   id =  l_nsif.id;
       else
         p_message:= 'Завантаження пройшло успішно! Зформовано файл № '||l_nsif.id;
       end if;
     END;
exception when others then
   p_message:= substr(title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,4000);
end;
/

grant EXECUTE     on p_nbu_credit_ins to BARS_ACCESS_DEFROLE;