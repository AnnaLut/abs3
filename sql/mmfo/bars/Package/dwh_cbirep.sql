
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dwh_cbirep.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DWH_CBIREP 
AS

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.1.1  21.11.2014';

l_cbirepq_id   number;


/*
 * -- Вертає назву файла
 */
function filenames (p_rep_id     in number,
                    p_xml_params in varchar2)
					return varchar2;
/*
 * -- Создает заявку на формирование отчета
 */
procedure create_report_query(p_rep_id     in number,
                              p_xml_params in varchar2);


/*
 *  -- Выполняем заявку на формирование отчета
 */                             
procedure exec_report_query (p_cbirep_queries_id  number);  

                           
									 
/*
 *  -- Привязка параметров
 */                                     
function bind_variables(p_sql_text in varchar2, 
                        p_xml_params in varchar2)
                                 return varchar2;                                     
                         
/*
 * -- формування DBF
 */                                    
procedure exec_report_dbf (p_cbirepq_id         number, 
                                p_sql             varchar2,
                                p_stmt            varchar2, 
                                p_encoding        varchar2,
                                p_file_name       varchar2    
                            );                                     

/*
 * -- Устанавливает статус заявке
 */
procedure set_status (p_cbirepq_id number, 
                      p_status     varchar2,
                      p_err        varchar2 default null
                     );
                     
/*
 *-- удаление отчета
 */                     
procedure clear_report_data(p_cbirepq_id number);     


    /*-- FRMT_DATE()
    --
    --   По строке даты типа 21.02.2008, отдать форматированн.дату
    --
    --   p_date   - строка даты
    --   p_format - шаблон  ('MMDD', 'DDMM', 'MD'(32-разр), 'DM'-(32-разр))
    --              шаблон строиться из символов
    --              MM/M -  месяц в 10-разр(32-разр)
    --              DD/D -  день в 10-разр(32-разр)
    --              YYYY/YY/Y - год полный/два последних знака/два последних знака (32-разр)
	*/
 function  frmt_date(
                  p_date    varchar2,
                  p_format  varchar2 default 'MD' )  return varchar2;

procedure export_to_script_reports( 
                             p_kodf          VARCHAR2
                              );

function parse_params (p_xml_params in varchar2)
                       return varchar2;							  
 /*
  * header_version - возвращает версию заголовка пакета DKU_REPORTS
  */ 
function header_version return varchar2;

/*
 * body_version - возвращает версию тела пакета DKU_REPORTS
 */
function body_version   return varchar2;




END dwh_cbirep;
/
CREATE OR REPLACE PACKAGE BODY BARS.DWH_CBIREP 
AS

G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.1.1  21.11.2014';


procedure set_status_reports (p_cbirepq_id number )
as
l_status DWH_CBIREP_QUERIES.status_id%type;
l_count    number;

begin

   select count(1)
     into l_count
     from bars.DWH_CBIREP_QUERIES_DATA
    where cbirep_queries_id = p_cbirepq_id;
  
    if  nvl(l_count,0) = 0 then  l_status := 'missing';
	else                         l_status := 'createdfile';
	end if;
  

    update bars.DWH_CBIREP_QUERIES
   set status_id   = l_status,
       status_date = sysdate
 where id = p_cbirepq_id;
 COMMIT;
end;

function filenames (p_rep_id     in number,
                    p_xml_params in varchar2)
					return varchar2
as
	l_cbirep_file_names       dwh_cbirep_queries.file_names%type;
begin
  select RESULT_FILE_NAME
        into l_cbirep_file_names	  
		from  DWH_REPORTS
		where id = p_rep_id;
		 
	  
      l_cbirep_file_names :=  'select '||bind_variables(l_cbirep_file_names,p_xml_params)||' from dual'; 
      --logger.info(l_cbirep_file_names); 
     EXECUTE IMMEDIATE   l_cbirep_file_names into l_cbirep_file_names;

return l_cbirep_file_names;
end;	

					

/*
 * -- Создает заявку на формирование отчета
 */
procedure create_report_query(p_rep_id     in number,
                             p_xml_params in varchar2)
as  
    l_cbirep_queries_id       dwh_cbirep_queries.id%type;
    l_cbirep_file_names       dwh_cbirep_queries.file_names%type;

  begin
    begin
      select bars.s_dwh_cbirep_queries.nextval
        into l_cbirep_queries_id
        from dual;

	  select RESULT_FILE_NAME
        into l_cbirep_file_names	  
		from  DWH_REPORTS
		where id = p_rep_id;
		 
	  
       l_cbirep_file_names := filenames(p_rep_id, p_xml_params);
		
		
        insert into bars.DWH_CBIREP_QUERIES (id, userid, rep_id, key_params, file_names, creation_time, status_id, status_date, job_id)
              values (l_cbirep_queries_id, user_id,  p_rep_id, p_xml_params, l_cbirep_file_names, sysdate, 'start', sysdate, null);
         EXCEPTION
              WHEN DUP_VAL_ON_INDEX
              THEN raise_application_error (-20000,'Формування даних з такимиж параметрами вже запущено або сфоррмовано');
           END;

    -- установка статуса
    set_status(l_cbirep_queries_id, 'start');

    -- стартуем job
    savepoint before_job_start;
    declare
      l_job_id   number;
      l_job_what varchar2(4000) := 'begin
                                    dwh_cbirep.exec_report_query(' || l_cbirep_queries_id ||');
                                    end;  ';
    begin

      dbms_job.submit(job       => l_job_id,
                      what      => l_job_what,
                      next_date => sysdate,
                      interval  => null,
                      no_parse  => true);

      update DWH_CBIREP_QUERIES cq
         set cq.job_id = l_job_id
       where cq.id = l_cbirep_queries_id;

    exception
      when others then
        rollback to savepoint before_job_start;
        -- произошли ошибки
        set_status(l_cbirep_queries_id,
                   'error'--, substr(sqlerrm || chr(10) ||dbms_utility.format_call_stack(),0,4000)
                   );
    end;

   -- return l_cbirep_queries_id;
  end create_report_query;




/*
 *  -- Привязка параметров
 */  
function bind_variables(p_sql_text in varchar2, p_xml_params in varchar2)
    return varchar2 is
    l_xmlParser  xmlparser.Parser;
    l_xmlDoc     xmldom.DOMDocument;
    l_xmlNodes   xmldom.DOMNodeList;
    l_xmlNode    xmldom.DOMNode;
    l_xmlElement xmldom.DOMElement;

    l_par_id    varchar2(100);
    l_par_value varchar2(1024);

    l_sql_text varchar2(32000);
  begin
    l_sql_text := p_sql_text;

    -- парсим документ
    l_xmlParser := xmlparser.newParser;
    begin
      xmlparser.parseBuffer(l_xmlParser, p_xml_params);
      l_xmlDoc := xmlparser.getDocument(l_xmlParser);

      -- перебор всех параметров
      l_xmlNodes := xmldom.getElementsByTagName(l_xmlDoc, 'Param');
      for node_index in 0 .. xmldom.getLength(l_xmlNodes) - 1 loop
        -- берем атрибуты каждого параметра
        l_xmlNode    := xmldom.item(l_xmlNodes, node_index);
        l_xmlElement := xmldom.makeElement(l_xmlNode);

        -- биндим переменную
        l_par_id    := xmldom.getAttribute(l_xmlElement, 'Id');
        l_par_value := xmldom.getAttribute(l_xmlElement, 'Value');
        l_sql_text  := replace(l_sql_text,
                               l_par_id,
                               '''' || replace(l_par_value, '''', '''''') || '''');

      end loop;

      xmlparser.freeParser(l_xmlParser);
      xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        xmlparser.freeParser(l_xmlParser);
        xmldom.freeDocument(l_xmlDoc);

        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    return l_sql_text;
end bind_variables;


/*
 *  -- вичитка параметра
 */
function get_variable(p_var_name in varchar2, p_xml_params in varchar2)
    return varchar2 is
    l_xmlParser  xmlparser.Parser;
    l_xmlDoc     xmldom.DOMDocument;
    l_xmlNodes   xmldom.DOMNodeList;
    l_xmlNode    xmldom.DOMNode;
    l_xmlElement xmldom.DOMElement;

    l_par_id    varchar2(100);
    l_par_value varchar2(1024);
  begin
    l_xmlParser := xmlparser.newParser;
    -- парсим документ
    begin
      xmlparser.parseBuffer(l_xmlParser, p_xml_params);
      l_xmlDoc := xmlparser.getDocument(l_xmlParser);

      -- перебор всех параметров
      l_xmlNodes := xmldom.getElementsByTagName(l_xmlDoc, 'Param');
      for node_index in 0 .. xmldom.getLength(l_xmlNodes) - 1 loop
        -- берем атрибуты каждого параметра
        l_xmlNode    := xmldom.item(l_xmlNodes, node_index);
        l_xmlElement := xmldom.makeElement(l_xmlNode);

        -- биндим переменную
        l_par_id    := xmldom.getAttribute(l_xmlElement, 'Id');
        l_par_value := xmldom.getAttribute(l_xmlElement, 'Value');

        if (l_par_id = p_var_name) then
          xmlparser.freeParser(l_xmlParser);
          return l_par_value;
        end if;
      end loop;

      xmlparser.freeParser(l_xmlParser);
      xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        xmlparser.freeParser(l_xmlParser);
        xmldom.freeDocument(l_xmlDoc);

        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    return null;
  end get_variable;




/*
 *  -- Выполняем заявку на формирование отчета
       #P_ID#    id  queries_id 
 */ 
procedure exec_report_query (p_cbirep_queries_id  number)
as
l_cbirep_q  DWH_CBIREP_QUERIES%rowtype;
l_reports   DWH_REPORTS%rowtype;
   
   p_msrprd_date   date;    
   p_region_id     number;   
   p_type          number;  
  l_ number;   
begin

 /*
		begin
			login.login_user('admin','jobs',sys_context('USERENV','HOST'), l_);
			login.set_user_session(0, 'jobs'); 
		end;
   */
  
  execute immediate('alter session set nls_date_format=''dd.MM.yyyy''');
    
select *
  into l_cbirep_q
  from DWH_CBIREP_QUERIES
 where id =  p_cbirep_queries_id;
 
  -- BARS_LOGIN.LOGIN_USER('xxx',l_cbirep_q.userid,null,null);
     -- представляемся пользователем
    bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                          p_userid    => l_cbirep_q.userid,
                          p_hostname  => null,
                          p_appname   => 'BARSWEB_JOBS dwh_reports');

    -- представляемся бранчем, если формирование было запущено с представлением
    if (l_cbirep_q.branch != sys_context('bars_context', 'user_branch')) then
      bc.subst_branch(l_cbirep_q.branch);
    end if;
	
select *
  into l_reports
  from DWH_REPORTS
 where id = l_cbirep_q.rep_id;
 
     set_status(p_cbirep_queries_id, 'startcreatedfile');
     commit;
	 
  
  if l_reports.form_proc is null 
      then
      
      l_reports.sqlprepare := bind_variables(l_reports.sqlprepare,l_cbirep_q.KEY_PARAMS);
      l_reports.file_name :=  'select '||bind_variables(l_reports.file_name,l_cbirep_q.KEY_PARAMS)||' from dual'; 
      EXECUTE IMMEDIATE   l_reports.file_name into l_reports.file_name;
      
           
      exec_report_dbf   ( p_cbirep_queries_id, 
                          l_reports.sqlprepare      ,
                          l_reports.stmt            , 
                          l_reports.encoding        ,
                          l_reports.file_name       ); 
                              
     set_status(p_cbirep_queries_id, 'createdfile');
  else

      l_reports.form_proc :=  replace('begin '||bind_variables(l_reports.form_proc,l_cbirep_q.KEY_PARAMS)||'  end;' , '#P_ID#', p_cbirep_queries_id);
      l_cbirepq_id := p_cbirep_queries_id;
      EXECUTE IMMEDIATE   l_reports.form_proc ;  
      
     set_status_reports(l_cbirepq_id);
  end if;      
   
  commit;
 exception   when others then
    set_status(p_cbirep_queries_id, 'error',substr(sqlerrm || chr(10) 
			                                      ||dbms_utility.format_error_backtrace||
                                                    dbms_utility.format_call_stack(), 0, 4000));
    LOGGER.ERROR('CBIREP_QUERIES_ID= '||p_cbirep_queries_id|| chr(10) 
	           ||' ORA-20000='||substr(sqlerrm || chr(10) 
			   ||dbms_utility.format_error_backtrace||
                 dbms_utility.format_call_stack(), 0, 4000));

end;



	

/*
 *  -- Формування DBF
 */ 
procedure exec_report_dbf   (   p_cbirepq_id         number, 
                                p_sql             varchar2,
                                p_stmt            varchar2, 
                                p_encoding        varchar2,
                                p_file_name       varchar2    
                            )
as 
 
 l_clob       blob;
 j            NUMBER;
 bl           BLOB;
 blb          BLOB;
begin                            



  l_clob:= null;
  
  
 dbms_lob.createtemporary(l_clob,  FALSE);
 DBMS_LOB.createtemporary(bl, FALSE);

   --logger.info('p_cbirepq_id='||p_cbirepq_id||' SQL = '||p_sql);
   --logger.info('p_cbirepq_id='||p_cbirepq_id||' stmt = '||p_stmt);
   --logger.info('p_cbirepq_id='||p_cbirepq_id||' encoding = '||p_encoding);
  
  
  bars_dbf.dbf_from_sql ( p_sql,   p_stmt,    p_encoding,   bl);
  
   
  j := 0;
  bars_dbf.GET_EXPORTED_ROWSCOUNT (j);



  -- якщо кількість строк  більша нуля пишем файл
   IF j > 0
      THEN
                  
	  dbms_application_info.set_client_info ('Формування DBF '||p_file_name);				  
	 -- logger.info('p_cbirepq_id='||p_cbirepq_id||' file = '||p_file_name);
         INSERT INTO bars.dwh_cbirep_queries_data (cbirep_queries_id,  result_file_name,  Length_file,   fil)
              VALUES (  p_cbirepq_id,   p_file_name,       DBMS_LOB.GETLENGTH (bl),     EMPTY_BLOB ()     )
           RETURNING fil
                INTO blb;

         DBMS_LOB.OPEN   (blb, DBMS_LOB.LOB_READWRITE);
         DBMS_LOB.APPEND (blb, bl);
         DBMS_LOB.CLOSE  (blb);
   
     set_status(p_cbirepq_id, 'process');
	 
    else
    null;
    
  end if;   


    



null;
commit;
end;



/*
* -- Устанавливает статус заявке
*/
procedure set_status (p_cbirepq_id number, 
                      p_status     varchar2,
                      p_err        varchar2 default null
                     )
as
l_status DWH_CBIREP_QUERIES.status_id%type;
begin

   select status_id
     into l_status
     from DWH_CBIREP_QUERIES
    where id = p_cbirepq_id; 
    
    
    if p_status = 'missing' and  (l_status = 'process' OR  l_status = 'createdfile')    then return; end if;
    if p_status = 'createdfile' and  l_status = 'missing'  then return; end if;

    update bars.DWH_CBIREP_QUERIES
   set status_id   = p_status,
       status_date = sysdate,
       comm        = p_err 
 where id = p_cbirepq_id;
 COMMIT;
end;


/*
 *-- удаление отчета
 */
procedure clear_report_data(p_cbirepq_id number)
as
l_cbirep_q DWH_CBIREP_QUERIES%rowtype;

   ID_         NUMBER;
   l_dj_row    dba_jobs%ROWTYPE;
   l_djr_row   dba_jobs_running%ROWTYPE;
   job_id      NUMBER;
begin

    begin
      select *
        into l_cbirep_q
        from DWH_CBIREP_QUERIES
       where id = p_cbirepq_id;

        job_id := l_cbirep_q.job_id;

    EXCEPTION  WHEN NO_DATA_FOUND
       THEN   return;
    end;      

	begin  
		--execute IMMEDIATE  'ALTER TABLE BARS.DWH_CBIREP_QUERIES_DATA  drop PARTITION for ('||to_char(p_cbirepq_id)||') UPDATE GLOBAL INDEXES ';
		execute IMMEDIATE  'ALTER TABLE BARS.DWH_CBIREP_QUERIES_DATA  drop PARTITION for ('||to_char(p_cbirepq_id)||')  ';
		exception when others then 
	  if sqlcode=-02149 then null; else raise; end if;
	end;
	
    --DELETE FROM DWH_CBIREP_QUERIES_DATA           WHERE CBIREP_QUERIES_ID = p_cbirepq_id;



    DELETE FROM DWH_CBIREP_QUERIES
          WHERE id = p_cbirepq_id; 

   

   -- смотрим есть ли джоб
   BEGIN
      SELECT dj.*
        INTO l_dj_row
        FROM dba_jobs dj
       WHERE dj.job = job_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN;
   END;



   -- смотрим работает ли джоб
   BEGIN
      SELECT djr.*
        INTO l_djr_row
        FROM dba_jobs_running djr
       WHERE djr.job = job_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         -- удалям джоб
         SYS.DBMS_iJOB.broken (job_id, TRUE);
         COMMIT;
         SYS.DBMS_iJOB.remove (job_id);
         COMMIT;
         RETURN;
   END;

   -- удаляем работающий джоб и сесссию
   SYS.DBMS_iJOB.broken (job_id, TRUE);
   COMMIT;

   DECLARE
      l_s_row   v$session%ROWTYPE;
   BEGIN
      SELECT s.*
        INTO l_s_row
        FROM v$session s
       WHERE s.sid = l_djr_row.sid;

      EXECUTE IMMEDIATE
            'alter system kill session '''
         || l_s_row.sid
         || ','
         || l_s_row.serial#
         || '''';
   EXCEPTION
      WHEN NO_DATA_FOUND  THEN    NULL;
      WHEN OTHERS THEN
        if  sqlcode = -1031 then null;
        else logger.info(substr(sqlerrm || chr(10) ||dbms_utility.format_call_stack(),0,4000));  raise;
        end if;
    null;
   END;
   SYS.DBMS_iJOB.remove (job_id);
   COMMIT;

EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;



end;
 
    /* ------------------------------------------------------------------
    -- CONVERT_DEC_TO_32
    --
    --  перевести 10-ти разрядноре число в 32-разр.
   */
    function convert_dec_to_32(
                  l_dec smallint) return char is

       x char(1);
    begin
       if l_dec >= 0 and l_dec <= 9 then
          X := chr(l_dec + 48);
       elsif l_dec >= 10 and l_dec <= 35 then
          X := chr(l_dec + 55);
       else
          X := '0';
       end if;
       return x;
    end;
 
    /*-- FRMT_DATE()
    --
    --   По строке даты типа 21.02.2008, отдать форматированн.дату
    --
    --   p_date   - строка даты
    --   p_format - шаблон  ('MMDD', 'DDMM', 'MD'(32-разр), 'DM'-(32-разр))
    --              шаблон строиться из символов
    --              MM/M -  месяц в 10-разр(32-разр)
    --              DD/D -  день в 10-разр(32-разр)
    --              YYYY/YY/Y - год полный/два последних знака/два последних знака (32-разр)
	*/
 function  frmt_date(
                  p_date    varchar2,
                  p_format  varchar2 default 'MD' )  return varchar2
    is
       l_day  smallint;
       l_mon  smallint;
       l_year number;
       l_rez  varchar2(100);
       l_fmt  varchar2(100);
    begin


       l_day  := to_number(substr(p_date,1,2));
       l_mon  := to_number(substr(p_date,4,2));
       l_year := to_number(substr(p_date,-4));

       l_fmt  := upper(p_format);

       l_rez :=  l_fmt;
       if instr(l_fmt,'M') > 0  then
          if instr(l_fmt,'MM') > 0  then
             l_rez := replace(l_rez,'MM', lpad(to_char(l_mon),2,'0'));
          else
             l_rez := replace(l_rez,'M', convert_dec_to_32(l_mon));
          end if;

       end if;

       if instr(l_fmt,'D') > 0  then
          if instr(l_fmt,'DD') > 0  then
             l_rez := replace(l_rez,'DD', lpad(to_char(l_day),2,'0'));
          else
             l_rez := replace(l_rez,'D', convert_dec_to_32(l_day));
          end if;

       end if;

       if instr(l_fmt,'Y') > 0  then
          if instr(l_fmt,'YYYY') > 0  then
             l_rez := replace(l_rez, 'YYYY', l_year);
          else
             if instr(l_fmt,'YY') > 0  then
                 l_rez := replace(l_rez, 'YY', substr(l_year,-2));
             else
                 l_rez := replace(l_rez, 'Y', convert_dec_to_32(substr(l_year,-2)) );
             end if;
          end if;

       end if;

       return l_rez;

	   end;

procedure export_to_script_reports( 
                             p_kodf          VARCHAR2
                              )
                    
    is
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);
       l_reports  DWH_REPORTS%rowtype;
       l_clob     blob;
       p_clob_scrpt blob;
       l_cbirep_queries_id       dwh_cbirep_queries.id%type;
       l_ number;
  

    begin
 /*       
      begin
            login.login_user('admin','jobs',sys_context('USERENV','HOST'), l_);
            login.set_user_session(0, 'jobs'); 
      
      end;
*/
        p_clob_scrpt:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);
       begin

          select * into l_reports
          from DWH_REPORTS
          where id=p_kodf ;

       exception when no_data_found then
        --  bars_error.raise_error('IES', to_char(p_kodz));
        NULL;
       end;

       l_txt:=       'prompt ===================================== '||nlchr ;
       l_txt:=l_txt||'prompt == '||(replace((l_reports.name), chr(39), chr(39)||chr(39)))                ||nlchr ;
       l_txt:=l_txt||'prompt ===================================== '||nlchr||nlchr;

       l_txt:=l_txt||'set serveroutput on'||nlchr ;
       l_txt:=l_txt||'set feed off       '||nlchr ;

       l_txt:=l_txt||'declare                               '||nlchr ;
       l_txt:=l_txt||nlchr ;

       l_txt:=l_txt||'   nlchr       char(2):=chr(13)||chr(10);'||nlchr ;
       l_txt:=l_txt||'   l_reports       DWH_REPORTS%rowtype;    '||nlchr ;
       l_txt:=l_txt||'   l_reportsr      DWH_REPORTS%rowtype;    '||nlchr ;
       l_txt:=l_txt||'   l_isnew     smallint:=0;       '||nlchr ;


       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'begin     '||nlchr ;
       l_txt:=l_txt||'   l_reports.name := '''||(replace((l_reports.name), chr(39), chr(39)||chr(39))) ||''';'||nlchr ;
       l_txt:=l_txt||'   l_reports.id := '''||p_kodf||''';'||nlchr ;

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'   begin                                                   '||nlchr ;
       l_txt:=l_txt||'      select id into l_reportsr.id                      '||nlchr ;
       l_txt:=l_txt||'      from DWH_REPORTS where id=l_reports.id;             '||nlchr ;
       l_txt:=l_txt||'   exception when no_data_found then                       '||nlchr ;
       l_txt:=l_txt||'      l_isnew:=1;                                          '||nlchr ;
       l_txt:=l_txt||'   end;                                     '||nlchr ;
       l_txt:=l_txt||'                                            '||nlchr ;    

       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';


   

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'    ---------------------------    '||nlchr ;
       l_txt:=l_txt||'    --  main dku_zvt zapros  --    '||nlchr ;
       l_txt:=l_txt||'    ---------------------------    '||nlchr ;
       l_txt:=l_txt||'                                  '||nlchr ;



       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';


       l_txt:=l_txt||'    l_reports.name                 := '''||replace((l_reports.name), chr(39), chr(39)||chr(39))         ||''';'||nlchr;
       l_txt:=l_txt||'    l_reports.TYPEID               := '''||l_reports.TYPEID                  ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';

       l_txt:=l_txt||'    l_reports.PARAMS               := '''||l_reports.PARAMS                 ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';        
       
       l_txt:=l_txt||'    l_reports.TEMPLATE_NAME        := '''||l_reports.TEMPLATE_NAME                 ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:=''; 

	   l_reports.RESULT_FILE_NAME := (replace((l_reports.RESULT_FILE_NAME), chr(39), chr(39)||chr(39)));
       l_txt:=l_txt||'    l_reports.RESULT_FILE_NAME     := '''||l_reports.RESULT_FILE_NAME                 ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';        

       l_reports.SQLPREPARE := (replace((l_reports.SQLPREPARE), chr(39), chr(39)||chr(39)));
       l_reports.SQLPREPARE := replace (l_reports.SQLPREPARE, nlchr, '''||nlchr||'||nlchr||'                           ''' );
       l_txt:=l_txt||'    l_reports.SQLPREPARE          := '''||l_reports.SQLPREPARE                  ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';
       
       l_txt:=l_txt||'    l_reports.DESCRIPTION         := '''||l_reports.DESCRIPTION                 ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';         
       
	   l_reports.FORM_PROC := (replace((l_reports.FORM_PROC), chr(39), chr(39)||chr(39)));
       l_txt:=l_txt||'    l_reports.FORM_PROC           := '''||l_reports.FORM_PROC                 ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';  
       
                     
       l_reports.stmt := (replace((l_reports.stmt), chr(39), chr(39)||chr(39)));
       l_reports.stmt :=  replace ( l_reports.stmt, chr(13)||chr(10), nlchr );
       l_reports.stmt :=  replace ( l_reports.stmt, nlchr, '''||nlchr||'||nlchr||'                           ''' );

       l_txt:=l_txt||'    l_reports.stmt                := '''||l_reports.stmt          ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';      
      
       l_reports.FILE_NAME := (replace((l_reports.FILE_NAME), chr(39), chr(39)||chr(39)));
       l_txt:=l_txt||'    l_reports.FILE_NAME           := '''||l_reports.FILE_NAME                 ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';
      
       

       l_txt:=l_txt||'    l_reports.encoding            := '''||l_reports.encoding                  ||''';'||nlchr;
       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';
       
       
      

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'    ----------------------------------    '||nlchr ;
       l_txt:=l_txt||'    --  main dku_zvt insert/update  --    '||nlchr ;
       l_txt:=l_txt||'    ----------------------------------    '||nlchr ;
       l_txt:=l_txt||'                                          '||nlchr ;


       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'    if l_isnew = 1 then           '||nlchr;
       l_txt:=l_txt||'       insert into DWH_REPORTS values l_reports;  '||nlchr;
       l_txt:=l_txt||'    else                           '||nlchr;
       l_txt:=l_txt||'      update DWH_REPORTS set name         = l_reports.name,        '||nlchr;
       l_txt:=l_txt||'                         TYPEID           = l_reports.TYPEID, '||nlchr;
       l_txt:=l_txt||'                         PARAMS           = l_reports.PARAMS,    '||nlchr;
       l_txt:=l_txt||'                         TEMPLATE_NAME    = l_reports.TEMPLATE_NAME,        '||nlchr;
       l_txt:=l_txt||'                         RESULT_FILE_NAME = l_reports.RESULT_FILE_NAME,   '||nlchr;
       l_txt:=l_txt||'                         SQLPREPARE       = l_reports.SQLPREPARE,     '||nlchr;
       l_txt:=l_txt||'                         DESCRIPTION      = l_reports.DESCRIPTION,      '||nlchr;
       l_txt:=l_txt||'                         FORM_PROC        = l_reports.FORM_PROC,     '||nlchr;
       l_txt:=l_txt||'                         STMT             = l_reports.STMT,          '||nlchr;
       l_txt:=l_txt||'                         FILE_NAME        = l_reports.FILE_NAME,          '||nlchr;
       l_txt:=l_txt||'                         ENCODING         = l_reports.ENCODING   '||nlchr;
       l_txt:=l_txt||'       where id=l_reports.id;                                '||nlchr;
       l_txt:=l_txt||'                                                           '||nlchr;
       l_txt:=l_txt||'    end if;                                                '||nlchr;



       
       l_txt:=l_txt||'end;                                        '||nlchr;
       l_txt:=l_txt||'/                                           '||nlchr;
       l_txt:=l_txt||'                                            '||nlchr;
       l_txt:=l_txt||'commit;                                     '||nlchr;

       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       p_clob_scrpt:=l_clob;
       
       
        begin
              select bars.s_dwh_cbirep_queries.nextval
                into l_cbirep_queries_id
                from dual;

        insert into bars.DWH_CBIREP_QUERIES (id, userid, rep_id, key_params, creation_time, status_id, status_date, job_id)
              values (l_cbirep_queries_id, user_id,  l_reports.id, '<ReportParams></ReportParams>', sysdate, 'createdfile', sysdate, null);
              
              
              
        INSERT INTO bars.dwh_cbirep_queries_data (cbirep_queries_id,  result_file_name,  Length_file,   fil)
             VALUES (  l_cbirep_queries_id,   'rep_'||to_char(l_reports.id)||'.sql',       DBMS_LOB.GETLENGTH (p_clob_scrpt),     p_clob_scrpt     );
       
         EXCEPTION
              WHEN DUP_VAL_ON_INDEX
              THEN null;
           END;
   
end;	   

function parse_params (p_xml_params in varchar2)
                       return varchar2 is
    l_xmlParser  xmlparser.Parser;
    l_xmlDoc     xmldom.DOMDocument;
    l_xmlNodes   xmldom.DOMNodeList;
    l_xmlNode    xmldom.DOMNode;
    l_xmlElement xmldom.DOMElement;

    l_par_id    varchar2(100);
    l_par_value varchar2(1024);
     
    l_text     varchar2(4000);       
 
  begin
    

    -- парсим документ
    l_xmlParser := xmlparser.newParser;
    begin
      xmlparser.parseBuffer(l_xmlParser, p_xml_params);
      l_xmlDoc := xmlparser.getDocument(l_xmlParser);

      -- перебор всех параметров
      l_xmlNodes := xmldom.getElementsByTagName(l_xmlDoc, 'Param');
      for node_index in 0 .. xmldom.getLength(l_xmlNodes) - 1 loop
        -- берем атрибуты каждого параметра
        l_xmlNode    := xmldom.item(l_xmlNodes, node_index);
        l_xmlElement := xmldom.makeElement(l_xmlNode);

        -- биндим переменную
        l_par_id    := xmldom.getAttribute(l_xmlElement, 'Id');
        l_par_value := xmldom.getAttribute(l_xmlElement, 'Value');
       
        l_text := l_text ||rpad(l_par_id,10,' ')||'=  '||l_par_value||chr(10);
         
      end loop;

      xmlparser.freeParser(l_xmlParser);
      xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        xmlparser.freeParser(l_xmlParser);
        xmldom.freeDocument(l_xmlDoc);

        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    return substr(l_text,1,length(l_text)-1);
end;
 
/**
 * header_version - возвращает версию заголовка пакета DKU_REPORTS
 */
function header_version return varchar2 is
begin
  return 'Package header DWH_CBIREP '||G_HEADER_VERSION;
end header_version;


/**
 * body_version - возвращает версию тела пакета DKU_REPORTS
 */
function body_version return varchar2 is
begin
  return 'Package body DWH_CBIREP '||G_BODY_VERSION;
end body_version;



END dwh_cbirep;
/
 show err;
 
PROMPT *** Create  grants  DWH_CBIREP ***
grant EXECUTE                                                                on DWH_CBIREP      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dwh_cbirep.sql =========*** End *** 
 PROMPT ===================================================================================== 
 