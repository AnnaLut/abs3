prompt ===================================== 
prompt == Актуалізація (у розрізі РУ) за період (створені)
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
   l_zpr.name := 'Актуалізація (у розрізі РУ) за період (створені)';
   l_zpr.pkey := '\BRS\SBER\CRCA\3113';

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
    l_zpr.name         := 'Актуалізація (у розрізі РУ) за період (створені)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:p_mfo=''МФО (%-всі)'',:p_type=''Код операції''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'brs_3113.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_mfo=''%'',:p_type=''5''';
    l_zpr.bind_sql     := ':p_mfo=''BANKS_RU|MFO|NAME|ORDER BY RU'',:p_status=''COMPEN_OPER_STATES|STATE_ID|STATE_NAME|ORDER BY STATE_ID'',:p_type=''COMPEN_OPER_TYPES|TYPE_ID|TEXT|ORDER BY TYPE_ID''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := ' select  b.ru,
        b.name,
        to_char(regdate,''dd/mm/yyyy'') regdate,
        count(1) s1,
        sum(case when O.STATE = 0 then 1 else 0 end) st_0,
        sum(case when O.STATE = 10 then 1 else 0 end) st_10,
        sum(case when O.STATE = 20 then 1 else 0 end) st_20,
        sum(case when O.STATE = 30 then 1 else 0 end) st_30,
        sum(case when O.STATE = 40 then 1 else 0 end) st_40,
        sum(amount/100) s2,
        sum(oper_ost/100) s3,
        count(distinct o.rnk) s4,
        count(distinct o.branch) s5
  from COMPEN_OPER o, banks_ru b
 where regdate between to_date(:sFdat1) and to_date(:sFdat2)+0.999
   and O.OPER_TYPE = :p_type 
   and O.mfo = b.mfo
   and b.mfo like :p_mfo
 group by grouping sets (
                        (),
                        (b.ru, b.name, to_char(regdate,''dd/mm/yyyy''))
                        )
 Order by regdate desc';
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

 ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='Актуалізація (у розрізі РУ) за період (створені)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 0; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3113;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' изменен.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;                                  
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;        
   