prompt ===================================== 
prompt == Звіт про дату зміни ліміту кредиту по БПК
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
   l_zpr.name := 'Звіт про дату зміни ліміту кредиту по БПК';
   l_zpr.pkey := '\BRS\SBR\REP\5714';

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
    l_zpr.name         := 'Звіт про дату зміни ліміту кредиту по БПК';
    l_zpr.namef        := '';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5714.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a.branch,c.NMK,c.okpo,c.rnk,w.CARD_CODE,wc.product_code,wp.grp_code, to_char(a.lim/100) lim_grn,to_char(u.chg_lim,''dd/mm/yyyy'') as chg_lim,to_char(b.DAOS,''dd/mm/yyyy'') as DAOS'||nlchr||
                           'from (select * from accounts where nbs =2625 and dazs is null and lim > 0) a '||nlchr||
                           '   inner join w4_acc w on a.acc=w.acc_pk'||nlchr||
                           '   inner join w4_card wc on w.card_code=wc.code'||nlchr||
                           '   inner join w4_product wp on wc.PRODUCT_CODE=wp.CODE'||nlchr||
                           '   inner join customer c on a.rnk=c.rnk '||nlchr||
                           '   inner join (select acc,daos from accounts where nbs =9129 and dazs is null) b on b.acc=w.acc_9129'||nlchr||
                           '   inner join '||nlchr||
                           '(SELECT a.acc,  max(a.chgdate) chg_lim'||nlchr||
                           '  FROM accounts_update a, accounts_update b'||nlchr||
                           ' WHERE  a.acc = b.acc'||nlchr||
                           '   AND (   a.LIM <> b.LIM'||nlchr||
                           '        OR a.LIM IS NULL AND b.LIM IS NOT NULL'||nlchr||
                           '        OR a.LIM IS NOT NULL AND b.LIM IS NULL'||nlchr||
                           '       )'||nlchr||
                           '   AND a.idupd ='||nlchr||
                           '          (SELECT MIN (idupd)'||nlchr||
                           '             FROM accounts_update'||nlchr||
                           '            WHERE acc = b.acc'||nlchr||
                           '              AND idupd > b.idupd'||nlchr||
                           '              AND (   LIM <> b.LIM'||nlchr||
                           '                   OR LIM IS NULL AND b.LIM IS NOT NULL'||nlchr||
                           '                   OR LIM IS NOT NULL AND b.LIM IS NULL'||nlchr||
                           '                  ))'||nlchr||
                           '   AND b.idupd ='||nlchr||
                           '          (SELECT MAX (idupd)'||nlchr||
                           '             FROM accounts_update'||nlchr||
                           '            WHERE acc = a.acc'||nlchr||
                           '              AND idupd < a.idupd'||nlchr||
                           '              AND (   LIM <> a.LIM'||nlchr||
                           '                   OR LIM IS NULL AND a.LIM IS NOT NULL'||nlchr||
                           '                   OR LIM IS NOT NULL AND a.LIM IS NULL'||nlchr||
                           '                  ))'||nlchr||
                           ' GROUP BY a.acc ) u on a.acc=u.acc'||nlchr||
                           'ORDER BY a.BRANCH,c.RNK';
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
    l_rep.description :='Звіт про дату зміни ліміту кредиту по БПК';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",FALSE,FALSE';
    l_rep.ndat        :=null;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 75; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5714;


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
