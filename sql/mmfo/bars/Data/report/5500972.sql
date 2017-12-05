prompt ===================================== 
prompt == Звітність по перевкладеним депозитам
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_zpr       zapros%rowtype;    
   l_zprr      zapros%rowtype;    
   l_rep       reports%rowtype;   
   l_repfolder number;            
   l_isnew     smallint:=0;       
   l_isnewr    smallint:=0;       
   l_message   varchar2(1000);    

begin     
   l_zpr.name := 'Звітність по перевкладеним депозитам';
   l_zpr.pkey := '\BRS\SBR\DPT\208';

   l_message  := 'Ключ запроса: '||l_zpr.pkey||'  '||nlchr;

   begin                                                   
      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        
      from zapros where pkey=l_zpr.pkey;                   
   exception when no_data_found then                       
      l_isnew:=1;                                          
      select s_zapros.nextval into l_zpr.kodz from dual;   
      if (0>0) then                  
         select s_zapros.nextval into l_zpr.kodr from dual;
         l_zprr.kodz:=l_zpr.kodr;           
      end if;                               
   end;                                     
                                            

    ------------------------    
    --  main query        --    
    ------------------------    
                                
    l_zpr.id           := 1;
    l_zpr.name         := 'Звітність по перевкладеним депозитам';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':sFdat1=''Дата з (DD.MM.YYYY) :'',:sFdat2=''Дата по (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select   b.branch,
         (CASE WHEN count_980_dep_close IS NULL THEN 0 ELSE count_980_dep_close END)+(CASE WHEN count_840_dep_close IS NULL THEN 0 ELSE count_840_dep_close END)+(CASE WHEN count_978_dep_close IS NULL THEN 0 ELSE count_978_dep_close END) AS all_count_close,
         (CASE WHEN count_980_dep_close IS NULL THEN 0 ELSE count_980_dep_close END) count_980_dep_close, sum_980_dep_close,
         (CASE WHEN count_840_dep_close IS NULL THEN 0 ELSE count_840_dep_close END) count_840_dep_close, sum_840_dep_close,
         (CASE WHEN count_978_dep_close IS NULL THEN 0 ELSE count_978_dep_close END)  count_978_dep_close, sum_978_dep_close,
         (CASE WHEN count_980_dep_cl_op IS NULL THEN 0 ELSE count_980_dep_cl_op END)+(CASE WHEN count_840_dep_cl_op IS NULL THEN 0 ELSE count_840_dep_cl_op END)+(CASE WHEN count_978_dep_cl_op IS NULL THEN 0 ELSE count_978_dep_cl_op END) AS all_count_reopen,
         (CASE WHEN count_980_dep_cl_op IS NULL THEN 0 ELSE count_980_dep_cl_op END) count_980_dep_cl_op, sum_980_dep_cl_op,
         (CASE WHEN count_840_dep_cl_op IS NULL THEN 0 ELSE count_840_dep_cl_op END) count_840_dep_cl_op, sum_840_dep_cl_op,
         (CASE WHEN count_978_dep_cl_op IS NULL THEN 0 ELSE count_978_dep_cl_op END) count_978_dep_cl_op, sum_978_dep_cl_op
    FROM (SELECT branch
            FROM branch
           WHERE LENGTH (branch) = 22 AND date_closed IS NULL) b
         LEFT JOIN
         (SELECT   dd.branch, dd.kv,(CASE WHEN COUNT (dd.kv) IS NULL THEN 0 ELSE COUNT (dd.kv) END) count_980_dep_close,SUM (dd.dos / 100) sum_980_dep_close
              FROM v_my_dpt dd
             WHERE action_id IN (1, 2)
               AND nbs IN (2630)
               AND dat_app IS NOT NULL
               AND dat_app BETWEEN :sFdat1 AND :sFdat2
               AND dd.kv = 980
          GROUP BY dd.branch, dd.kv) d_980 ON b.branch = d_980.branch
         LEFT JOIN
         (SELECT   dd.branch, dd.kv,(CASE WHEN COUNT (dd.kv) IS NULL THEN 0 ELSE COUNT (dd.kv) END) count_840_dep_close,SUM (dd.dos / 100) sum_840_dep_close
              FROM v_my_dpt dd
             WHERE action_id IN (1, 2)
               AND nbs IN (2630)
               AND dat_app IS NOT NULL
               AND dat_app BETWEEN :sFdat1 AND :sFdat2
               AND dd.kv = 840
          GROUP BY dd.branch, dd.kv) d_840 ON b.branch = d_840.branch
         LEFT JOIN
         (SELECT   dd.branch, dd.kv,(CASE WHEN COUNT (dd.kv) IS NULL THEN 0 ELSE COUNT (dd.kv) END) count_978_dep_close,SUM (dd.dos / 100) sum_978_dep_close
              FROM v_my_dpt dd
             WHERE action_id IN (1, 2)
               AND nbs IN (2630 )
               AND dat_app IS NOT NULL
               AND dat_app BETWEEN :sFdat1 AND :sFdat2
               AND dd.kv = 978
          GROUP BY dd.branch, dd.kv) d_978 ON b.branch = d_978.branch
         LEFT JOIN
         (SELECT   dd0.branch, dd0.kv, COUNT (dd0.kv) count_980_dep_cl_op,
                   SUM (dd0.LIMIT / 100) sum_980_dep_cl_op
              FROM (SELECT d.branch, d.kv, d.LIMIT, d.dat_begin, c.okpo
                      FROM customer c INNER JOIN dpt_deposit d ON c.rnk =
                                                                         d.rnk
                           INNER JOIN accounts a ON d.acc = a.acc
                     WHERE a.nbs IN (2630 ) AND a.dapp IS NOT NULL) dd0
             WHERE EXISTS (
                      SELECT dd.okpo, dd.rnk
                        FROM v_my_dpt dd
                       WHERE dd.action_id IN (1, 2)
                         AND dd.nbs IN (2630)
                         AND dd.kv = dd0.kv
                         AND dd.dat_app IS NOT NULL
                         AND dd.dat_app BETWEEN :sFdat1 AND :sFdat2
                         AND dd0.okpo = dd.okpo
                         AND dd0.dat_begin BETWEEN dd.dat_app - 1
                                               AND ADD_MONTHS (dd.dat_app - 1,
                                                               1
                              ';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
                         namef        = l_zpr.namef,       
                         bindvars     = l_zpr.bindvars,    
                         create_stmt  = l_zpr.create_stmt, 
                         rpt_template = l_zpr.rpt_template,
                         form_proc    = l_zpr.form_proc,   
                         default_vars = l_zpr.default_vars,
                         bind_sql     = l_zpr.bind_sql,    
                         xml_encoding = l_zpr.xml_encoding,
                         txt          = l_zpr.txt,         
                         xsl_data     = l_zpr.xsl_data,    
                         xsd_data     = l_zpr.xsd_data     
       where pkey=l_zpr.pkey;                              
       l_message:=l_message||'Кат.запрос c таким ключем уже существует под №'||l_zpr.kodz||', его параметры изменены.'; 
                                                           
    end if;                                                
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
