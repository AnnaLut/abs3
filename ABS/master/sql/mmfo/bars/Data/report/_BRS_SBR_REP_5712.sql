prompt ===================================== 
prompt == РЕЄСТР до платіжної вимоги (EWA)
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
   l_zpr.name := 'РЕЄСТР до платіжної вимоги (EWA)';
   l_zpr.pkey := '\BRS\SBR\REP\5712';

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
    l_zpr.name         := 'РЕЄСТР до платіжної вимоги (EWA)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:ID_B=''ЄДРПОУ отримувача''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5712.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':ID_B=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT'||nlchr||
                           '       O.BRANCH,'||nlchr||
                           '       o.pdat,'||nlchr||
                           '       o.vdat,'||nlchr||
                           '       o.s / 100 AS s,'||nlchr||
                           '       nvl(ow.VALUE,0) AS VALUE,'||nlchr||
                           '       o.pdat,'||nlchr||
                           '       o.nd,'||nlchr||
                           '       O.ID_B,'||nlchr||
                           '       o.nam_b'||nlchr||
                           '  FROM oper o, operw ow'||nlchr||
                           'WHERE     O.REF = OW.REF'||nlchr||
                           '       AND ow.tag = ''EWCOM'''||nlchr||
                           '       AND o.pdat BETWEEN TO_DATE ( :sFdat1, ''dd/mm/yyyy'')'||nlchr||
                           '                      AND TO_DATE ( :sFdat2, ''dd/mm/yyyy'')'||nlchr||
                           '       AND o.TT = ''EW1'''||nlchr||
                           '       AND o.ID_B like nvl(:ID_B, o.ID_B)'||nlchr||
                           '       and not exists (SELECT 1'||nlchr||
                           '                              FROM opldok op'||nlchr||
                           '                                 WHERE     op.REF = o.ref'||nlchr||
                           '                                       AND op.acc IN (SELECT acc'||nlchr||
                           '                                                        FROM accounts a'||nlchr||
                           '                                                       WHERE op.acc = a.acc AND a.nbs LIKE ''6%'')    '||nlchr||
                           '                                                     )'||nlchr||
                           ''||nlchr||
                           '                                       '||nlchr||
                           'and o.sos=5'||nlchr||
                           'order by o.ID_B, O.PDAT'||nlchr||
                           '';
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
    l_rep.description :='РЕЄСТР до платіжної вимоги (EWA)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 50; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5712;


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
