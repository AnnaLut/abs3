

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5009.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Звіт для фін монітор опер по платіжн карткам
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
   l_zpr.name := 'Звіт для фін монітор опер по платіжн карткам';
   l_zpr.pkey := '\BRS\SBM\REP\5009';

   l_message  := 'Ключ запроса: '||l_zpr.pkey||'  '||nlchr;

   begin                                                   
      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        
      from zapros where pkey=l_zpr.pkey;                   
   exception when no_data_found then                       
      l_isnew:=1;                                          
      select s_zapros.nextval into l_zpr.kodz from dual;   
      if (7021>0) then                  
         select s_zapros.nextval into l_zpr.kodr from dual;
         l_zprr.kodz:=l_zpr.kodr;           
      end if;                               
   end;                                     
                                            
    ------------------------    
    --  constraint query  --    
    ------------------------    
                                
    l_zprr.id           := 1;
    l_zprr.name         := 'Звіт для фін монітор опер по платіжн карткам';
    l_zprr.namef        := '=''fm_''||''test''||''.csv''';
    l_zprr.bindvars     := ':sFdat1='''',:sFdat2='''',:sMASK=''Маска рахунка'',:NLS='''',:KV=''''';
    l_zprr.create_stmt  := '';
    l_zprr.rpt_template := '';
    l_zprr.form_proc    := 'pul.put(''~nls'',:NLS);pul.put(''~kv'',:KV)';
    l_zprr.default_vars := '';
    l_zprr.bind_sql     := '';
    l_zprr.xml_encoding := 'CL8MSWIN1251';
    l_zprr.pkey         := l_zpr.pkey||'\1';
    l_zprr.txt          := 'select f_rep_5009(to_date(:sFdat1,''dd-mm-yyyy''), to_date(:sFdat2,''dd-mm-yyyy'') , nls, kv) '||nlchr||
                           'from v_gl a '||nlchr||
                           'where nls = pul.get(''~nls'') and kv = pul.get(''~kv'')';
    l_zprr.xsl_data     := '';
    l_zprr.xsd_data     := '';

    if l_isnew = 1 then            
       insert into zapros values l_zprr;  
    else                           
       update zapros set name         = l_zprr.name,        
                         namef        = l_zprr.namef,       
                         bindvars     = l_zprr.bindvars,    
                         create_stmt  = l_zprr.create_stmt, 
                         rpt_template = l_zprr.rpt_template,
                         form_proc    = l_zprr.form_proc,   
                         default_vars = l_zprr.default_vars,
                         bind_sql     = l_zprr.bind_sql,    
                         xml_encoding = l_zprr.xml_encoding,
                         txt          = l_zprr.txt,         
                         xsl_data     = l_zprr.xsl_data,    
                         xsd_data     = l_zprr.xsd_data     
       where pkey=l_zprr.pkey;                              
                                                            
    end if;                                                 

    ------------------------    
    --  main query        --    
    ------------------------    
                                
    l_zpr.id           := 1;
    l_zpr.name         := 'Звіт для фін монітор опер по платіжн карткам';
    l_zpr.namef        := '=''fm_''||:NLS||''_''||:KV||''.csv''';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:sMASK=''Маска рахунка''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select nls, kv'||nlchr||
                           'from v_gl a '||nlchr||
                           'where  nls like :sMASK '||nlchr||
                           '  and daos <= to_date(:sFdat2,''dd-mm-yyyy'') '||nlchr||
                           '  and nvl(dazs, to_date(:sFdat2,''dd-mm-yyyy'')) between to_date(:sFdat1,''dd-mm-yyyy'') and to_date(:sFdat2,''dd-mm-yyyy'')'||nlchr||
                           '  and exists (select 1 from saldoa where acc = a.acc and fdat between to_date(:sFdat1,''dd-mm-yyyy'') and to_date(:sFdat2,''dd-mm-yyyy'') and (dos+kos)!=0)'||nlchr||
                           ' ';
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
    l_rep.description :='Звіт для фін монітор опер по платіжн карткам';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',18,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='fm_*_*.csv';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5009;


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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5009.sql =========*** End 
PROMPT ===================================================================================== 
                                   

begin
  insert into app_rep (codeapp, coderep, approve)
  values ('DRU1', 5009, 1);
exception when dup_val_on_index then null;
end;
/              
       
commit;                
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5009.sql =========*** End 
PROMPT ===================================================================================== 
