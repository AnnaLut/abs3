prompt ===================================== 
prompt == Звіту щодо закритих вкладних (депозитних) рахунків клієнтів-фізи
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
   l_zpr.name := 'Звіту щодо закритих вкладних (депозитних) рахунків клієнтів-фізи';
   l_zpr.pkey := '\BRS\SBM\DPT\371';

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
    l_zpr.name         := 'Звіту щодо закритих вкладних (депозитних) рахунків клієнтів-фізи';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Код відділення(0-всі)'',:Param1=''Код виду вкладу(0-всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_371.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0'',:Param1=''0''';
    l_zpr.bind_sql     := ':Param0=''V_REPCHOOSE_BRANCH|BRANCH|BRANCH,NAME'',:Param1=''DPT_VIDD|VIDD|VIDD,TYPE_NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_date(:sFdat1,''dd.mm.yyyy'') DAT1, to_date(:sFdat2,''dd.mm.yyyy'') DAT2,'||nlchr||
                           '            ad.dazs DAZS,      '||nlchr||
                           '             b.branch||'' - ''||b.name BR_,'||nlchr||
                           '             ad.nbs NBS,  d.kv KV,'||nlchr||
                           '             s.ob22 OB22,  v.type_name VIDD,'||nlchr||
                           '             c.nmk NMK,  ad.nls NLSD, an.nls NLSN,'||nlchr||
                           '             decode (nvl(ad.nlsalt,0),0,to_char(d.deposit_id), ad.nlsalt) NLSALT,'||nlchr||
                           '             sd.ostf+sd.kos OSTD, eqv_obs(ad.kv, sd.ostf+sd.kos,d.bdate) OSTDQ, '||nlchr||
                           '             sn.ostf+sn.kos OSTN, eqv_obs(an.kv, sn.ostf+sn.kos,d.bdate) OSTNQ,'||nlchr||
                           '             t.dig DIG'||nlchr||
                           '  from dpt_deposit_clos d, dpt_vidd v,'||nlchr||
                           '            accounts ad, accounts an,'||nlchr||
                           '            int_accn i, customer c,branch b, '||nlchr||
                           '            specparam_int s, tabval t,saldoa sd,saldoa sn'||nlchr||
                           ' where d.action_id in (1,2)'||nlchr||
                           '    and d.bdate   >= to_date(:sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '    and d.bdate   <= to_date(:sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '    and d.acc          = i.acc and  i.id = 1 '||nlchr||
                           '    and i.acra          = an.acc'||nlchr||
                           '    and d.acc          = ad.acc'||nlchr||
                           '    and d.rnk           = c.rnk'||nlchr||
                           '    and d.vidd         = v.vidd'||nlchr||
                           '    and d.acc          = s.acc'||nlchr||
                           '    and t.kv              = d.kv'||nlchr||
                           '    and ad.branch  = b.branch'||nlchr||
                           '    and (ad.branch = :Param0 or :Param0 = ''0'')'||nlchr||
                           '    and (d.vidd         = :Param1 or :Param1 = ''0'')'||nlchr||
                           '    and ad.acc         = sd.acc '||nlchr||
                           '   and sd.fdat          = (select max(fdat) from saldoa where acc = ad.acc)'||nlchr||
                           '   and an.acc          = sn.acc '||nlchr||
                           '   and sn.fdat         = (select max(fdat) from saldoa where acc = an.acc)'||nlchr||
                           ' order by d.bdate desc,b.branch, ad.nbs,d.vidd,deposit_id';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
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
    l_rep.description :='Звіту щодо закритих вкладних (депозитних) рахунків клієнтів-фізи';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 371;


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
    for r in (select 'WDOC' app from dual union all
              select 'WDRU' app from dual union all
              select 'WOP'  app from dual union all
              select 'DRU1' app from dual)
    loop 
        
        begin
             insert into app_rep (codeapp, coderep, approve, grantor)
                          values (r.app,   l_rep.id,     1 ,      1);
             commit;
                          
          exception when dup_val_on_index then null;                 
        end;
    end loop;           
   end;

    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
