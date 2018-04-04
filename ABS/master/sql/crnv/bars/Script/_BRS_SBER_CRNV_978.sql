prompt ===================================== 
prompt == Звіт з розшифровки залишків ЦРНВ на дату
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
   l_zpr.name := 'Звіт з розшифровки залишків ЦРНВ на дату';
   l_zpr.pkey := '\BRS\SBER\CRNV\978';

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
    l_zpr.name         := 'Звіт з розшифровки залишків ЦРНВ на дату';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На:'',:Param1=''Відділення'',:Param2=''Валюта''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'CRNV978.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param1=''%'',:Param2=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := '  SELECT ROWNUM as RN,'||nlchr||
                           '         b.mfo ,'||nlchr||
                           '         b.name,'||nlchr||
                           '         a.branch ,'||nlchr||
                           '         CASE WHEN a.bsd = ''2635'' THEN ''2630'' ELSE a.bsd END  BSD,'||nlchr||
                           '         a.kv ,'||nlchr||
                           '         a.FIO ,'||nlchr||
                           '         a.idcode ,'||nlchr||
                           '         a.pasp_s ,'||nlchr||
                           '         a.pasp_n ,'||nlchr||
                           '         a.nls ,'||nlchr||
                           '         a.nd ,'||nlchr||
                           '         A.DPTID,'||nlchr||
                           '         (a.ost - f_part_sum_immobile_hist (a.key, TO_DATE ( :sFdat1)))'||nlchr||
                           '                / 100'||nlchr||
                           '            AS OST,'||nlchr||
                           '         a.ob22de ,'||nlchr||
                           '         A.SOURCE '||nlchr||
                           '    FROM bars.asvo_immobile a, bars.banks_ru b,  (select o.ref, o.pdat,  os.fdat, o.sos from  oper o, opldok os where o.ref = os.ref and os.dk = 0) op'||nlchr||
                           '    WHERE    '||nlchr||
                           'SUBSTR (a.branch, 2, 6) = b.mfo'||nlchr||
                           '        and a.branch like :Param1'||nlchr||
                           '        and a.kv like :Param2'||nlchr||
                           '        and  A.REFPAY = op.ref(+)'||nlchr||
                           '         AND a.dzagr < TO_DATE ( :sFdat1)'||nlchr||
                           '         AND (a.refpay IS NULL OR op.pdat > TO_DATE ( :sFdat1) or (op.fdat > TO_DATE ( :sFdat1)  and op.pdat <= TO_DATE ( :sFdat1)))'||nlchr||
                           '         AND A.FL IN (-6,'||nlchr||
                           '                      -5,'||nlchr||
                           '                      -4,'||nlchr||
                           '                      -3,'||nlchr||
                           '                      -2,'||nlchr||
                           '                      -1,'||nlchr||
                           '                      5,'||nlchr||
                           '                      6,'||nlchr||
                           '                      7,'||nlchr||
                           '                      8,'||nlchr||
                           '                      9,'||nlchr||
                           '                      10,'||nlchr||
                           '                      11,'||nlchr||
                           '                      12,'||nlchr||
                           '                      14)'||nlchr||
                           'ORDER BY b.mfo,'||nlchr||
                           '         a.branch,'||nlchr||
                           '         bsd,'||nlchr||
                           '         a.kv';
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
    l_rep.description :='Звіт з розшифровки залишків ЦРНВ на дату';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 978;


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
