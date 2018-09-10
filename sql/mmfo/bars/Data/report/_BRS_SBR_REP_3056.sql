prompt ===================================== 
prompt == Звіт із розшифровки залишків за рахунками 2924 (AT7,AT8)
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
   l_message   varchar2(2000);    

begin     
   l_zpr.name := 'Звіт із розшифровки залишків за рахунками 2924 (AT7,AT8)';
   l_zpr.pkey := '\BRS\SBR\REP\3056';

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
    l_zpr.name         := 'Звіт із розшифровки залишків за рахунками 2924 (AT7,AT8)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param1=''OB22''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_3056.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param1=''07''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT branch,'||nlchr||
                           '         ob22  ,'||nlchr||
                           '         nls,'||nlchr||
                           '         acc,'||nlchr||
                           '         nms,'||nlchr||
                           '         ostc / 100  ostc1,'||nlchr||
                           '         ref1,'||nlchr||
                           '         vdat,'||nlchr||
                           '         nazn1,'||nlchr||
						   '         kv,'||nlchr||
                           '         s / 100 sv,'||nlchr||
                           '         s2 / 100 sp,'||nlchr||
                           '         sysdate date1,'||nlchr||
                           '         decode(:Param1,''%'',''Всі'',:Param1) par,'||nlchr||
                           '         (s - nvl(s2,0)) / 100 snep'||nlchr||
                           '    FROM (SELECT a.branch,'||nlchr||
                           '                 a.ob22,'||nlchr||
                           '                 a.nls,'||nlchr||
                           '                 a.acc,'||nlchr||
                           '                 a.nms,'||nlchr||
                           '                 a.ostc,'||nlchr||
                           '                 x1.ref1,'||nlchr||
						   '                 o.kv,'||nlchr||  
                           '                 o.s,'||nlchr||
                           '                 o.vdat,'||nlchr||
                           '                 o.tt || ''*'' || o.nazn nazn1,'||nlchr||
                           '                 (SELECT SUM (NVL (x2.s, o2.s))'||nlchr||
                           '                    FROM atm_ref2 x2, oper o2'||nlchr||
                           '                   WHERE x2.ref1 = x1.ref1 AND x2.ref2 = o2.REF AND o2.sos = 5)'||nlchr||
                           '                    s2'||nlchr||
                           '            FROM accounts a, atm_ref1 x1, oper o'||nlchr||
                           '           WHERE     a.acc = x1.acc'||nlchr||
                           '                 AND X1.REF1 = o.REF'||nlchr||
                           '                 AND o.sos = 5'||nlchr||
                           '                 AND a.ob22 = decode(:Param1,''%'',a.ob22,:Param1)'||nlchr||
                           '                 AND a.tip IN (''AT7'', ''AT8''))'||nlchr||
                           '   WHERE (s - nvl(s2,0)) <> 0'||nlchr||
                           'ORDER BY branch,'||nlchr||
                           '         ob22,'||nlchr||
                           '         nls,'||nlchr||
                           '         ref1';
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
    l_rep.description :='Звіт із розшифровки залишків за рахунками 2924 (AT7,AT8)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3056;


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
               ('$RM_OWAY', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в "АРМ Інтерфейс з OpenWay"';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в "АРМ Інтерфейс з OpenWay"';
    end;		
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
