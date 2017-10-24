

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_5099.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt ==  Реестр операцій з забороненой кореспонденцією з 3800/03 
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
   l_zpr.name := ' Реестр операцій з забороненой кореспонденцією з 3800/03 ';
   l_zpr.pkey := '\BRS\SBR\REP\5099';

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
    l_zpr.name         := ' Реестр операцій з забороненой кореспонденцією з 3800/03 ';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep5099.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := '     Select /*+ parallel(10)*/'||nlchr||
                           '               o1.ref, '||nlchr||
                           '               o1.fdat,'||nlchr||
                           '               o1.tt,'||nlchr||
                           '               case o1.dk when 0 then a1.nls else a2.nls end dk_nls,'||nlchr||
                           '               case o1.dk when 0 then a1.ob22 else a2.ob22 end dk_ob22,'||nlchr||
                           '               case o1.dk when 0 then a1.kv else a2.kv end dk_kv,'||nlchr||
                           '               case o1.dk when 1 then a1.nls else a2.nls end kt_nls,'||nlchr||
                           '               case o1.dk when 1 then a1.ob22 else a2.ob22 end kt_ob22,'||nlchr||
                           '               case o1.dk when 1 then a1.kv else a2.kv end kt_kv,'||nlchr||
                           '               o1.s/100 summ,'||nlchr||
                           '               o.nazn  '||nlchr||
                           '          from opldok o1, accounts a1,'||nlchr||
                           '               opldok o2, accounts a2,'||nlchr||
                           '               oper o       '||nlchr||
                           '          where a1.acc = o1.acc  and o1.dk = 0 and '||nlchr||
                           '                a2.acc = o2.acc  and o2.dk = 1  '||nlchr||
                           '           and o1.fdat between  to_date(:sFdat1) and  to_date(:sFdat2) and (a1.nbs  in (''2600'',''2650'',''2541'',''2542'',''2544'',''2545'',''2560'',''2520'',''2530'',''2620'',''2625'',''2605'') or a1.nls like ''255%'')'||nlchr||
                           '           and substr(a1.nbs,1,1) !=substr(a2.nbs,1,1) '||nlchr||
                           '           and o2.fdat between  to_date(:sFdat1) and  to_date(:sFdat2) and a2.nbs in (''3800'') and a2.ob22 = ''03'''||nlchr||
                           '           and o1.dk = 1-o2.dk '||nlchr||
                           '           and o1.fdat = o2.fdat'||nlchr||
                           '           and o1.ref = o2.ref'||nlchr||
                           '           and o1.stmt = o2.stmt and O.REF = o1.ref';
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
    l_rep.description :=' Реестр операцій з забороненой кореспонденцією з 3800/03 ';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",FALSE,FALSE';
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
    l_rep.id          := 5099;


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

begin 
  execute immediate 
    ' insert into app_Rep  (codeapp, coderep, approve) values (''$RM_DRU1'', 5099,1)';
exception when dup_val_on_index then 
  null;
end;
/									
                                           
begin 
  execute immediate 
    ' insert into app_Rep  (codeapp, coderep, approve) values (''$RM_WCIM'', 5099,1)';
exception when dup_val_on_index then 
  null;
end;
/	                                            
											
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_5099.sql =========*** End 
PROMPT ===================================================================================== 
