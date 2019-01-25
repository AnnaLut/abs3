prompt ===================================== 
prompt == Косолідований звіт по нерухомим вкладам
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
   l_zpr.name := 'Косолідований звіт по нерухомим вкладам';
   l_zpr.pkey := '\BRS\SBR\***\CRNV100';

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
    l_zpr.name         := 'Косолідований звіт по нерухомим вкладам';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На дату''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'CRNV100.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          :=  'select g.bsd, g.kv, g.ost, g.kilk, g.mfo, '||nlchr||
                           '         T.LCV,'||nlchr||
                           '         B.NAME,'||nlchr||
                           '         :sFdat1  date1,'||nlchr||
                           '         b.ru,'||nlchr||
                           '         t.lcv||''(''||g.kv||'')'' as kvlcv,'||nlchr||
                           '         '' Усього по балансовому рахунку''  text1'||nlchr||
                           ' from ('||nlchr||
                           'select  bsd,kv, sum(ost) ost,sum (kilk) kilk, mfo, sysdate from ('||nlchr||
                           'SELECT '||nlchr||
                           '         CASE WHEN a.bsd = ''2635'' THEN ''2630'' ELSE a.bsd END BSD,'||nlchr||
                           '         a.kv kv,'||nlchr||
                           '       COUNT (a.key) kilk,'||nlchr||
                           '      sum( CASE'||nlchr||
                           '            WHEN a.fl in (10,11,12)'||nlchr||
                           '            THEN'||nlchr||
                           '            (  a.ost'||nlchr||
                           '                     - f_part_sum_rep ('||nlchr||
                           '                          a.key,'||nlchr||
                           '                          :sFdat1))/100'||nlchr||
                           '          else'||nlchr||
                           '          a.ost/100 end'||nlchr||
                           '          ) '||nlchr||
                           '          as ost,'||nlchr||
                           '    SUBSTR (a.branch, 2, 6) mfo'||nlchr||
                           '    FROM bars.asvo_immobile a'||nlchr||
                           '   WHERE '||nlchr||
                           '          a.dzagr < to_date (:sFdat1 || '' 23:59:59'',''dd.mm.yyyy HH24:mi:ss'')'||nlchr||
                           '          AND A.FL IN (-6,-5,-4,-3 ,-1, 5 ,6,7 ,8 ,9,10,11,12,14)'||nlchr||
                           '         and key not in (select aa.key'||nlchr||
                           '    FROM bars.asvo_immobile aa,'||nlchr||
                           '         (select op.value, sum(s) s  from  operw  op , oper o where'||nlchr||
                           '               op.tag = ''REF92'''||nlchr||
                           '              and o.ref = op.ref'||nlchr||
                           '              and o.vdat <= trunc(sysdate) and o.sos =5'||nlchr||
                           '               and o.dk =1'||nlchr||
                           '              group by op.value'||nlchr||
                           '              ) p'||nlchr||
                           '   WHERE '||nlchr||
                           '         aa.key = to_number(p.value)'||nlchr||
                           '         AND  aa.dzagr < to_date (:sFdat1 || '' 23:59:59'',''dd.mm.yyyy HH24:mi:ss'')'||nlchr||
                           '         AND aa.FL IN (-6,-5,-4,-3 ,-1, 5 ,6,7 ,8 ,9 ,10,11,12,14)'||nlchr||
                           '         and aa.ost = p.s'||nlchr||
                           '         )'||nlchr||
                           '         GROUP BY bsd,'||nlchr||
                           '         kv,'||nlchr||
                           '         SUBSTR (a.branch, 2, 6)'||nlchr||
                           '         ) GROUP BY bsd,'||nlchr||
                           '         kv,'||nlchr||
                           '         mfo order by mfo,bsd) g, bars.banks_ru b, tabval t '||nlchr||
                           'where    g.mfo = b.mfo'||nlchr||
                           '         and t.kv=g.KV';
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
    l_rep.description :='Косолідований звіт по нерухомим вкладам';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3051;


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

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values   
               ('WIME', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Нерухомі - БЕК-офіс (WEB)';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Нерухомі - БЕК-офіс (WEB)';
    end;	
    bars_report.print_message(l_message);   

end;                                        
/                                           
                                            
commit;                                     
