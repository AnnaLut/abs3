prompt ===================================== 
prompt == Звіт про стан депозитних рахунків клієнта Кредитної фабрики
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
   l_zpr.name := 'Звіт про стан депозитних рахунків клієнта Кредитної фабрики';
   l_zpr.pkey := '\BRS\SBR\DPT\3053';

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
    l_zpr.name         := 'Звіт про стан депозитних рахунків клієнта Кредитної фабрики';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''Рахунок'',:Param1=''ІНН клієнта'',:Param2=''Валюта вкладу'',:Param3=''РНК клієнта''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_3053.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''%'',:Param1=''%'',:Param2=''%'',:Param3=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT c.nmk,'||nlchr||
                           '       P.NUMDOC,'||nlchr||
                           '       case when p.passp=1 then P.SER when p.passp=7 then p.EDDR_ID end ser,'||nlchr||
                           '       s.name,'||nlchr||
                           '       D.ND,'||nlchr||
                           '       a.nls,'||nlchr||
                           '       t.type_name,'||nlchr||
                           '       decode (d.kv,980,'''', bars.gl.p_icurval ( d.kv,a.ostc,bankdate)/100 ||'' ''||''UAH'') ostq,'||nlchr||
                           '       a.ostc/100 ||'' ''||b.lcv ostc,'||nlchr||
                           '       d.kv,'||nlchr||
                           '       to_char(d.datz,''dd.mm.yyyy'') DATZ,'||nlchr||
                           '       sysdate date1,'||nlchr||
                           '       to_char(d.dat_end,''dd.mm.yyyy'') DAT_END,'||nlchr||
                           '       c.okpo,'||nlchr||
                           '       bars.dpt_web.get_dptrate(a.acc,a.kv,d.limit,bars.bankdate) rate,'||nlchr||
                           '       case when v.disable_add = 1 then ''НІ'' else ''ТАК'' end popovn,'||nlchr||
                           '       case when v.comproc = 0 then ''НІ'' else ''TAK'' end kapitaliz'||nlchr||
                           '  FROM dpt_deposit d,'||nlchr||
                           '       accounts a,'||nlchr||
                           '       dpt_vidd v,'||nlchr||
                           '       customer c,'||nlchr||
                           '       person p,'||nlchr||
                           '       dpt_types t,'||nlchr||
                           '       tabval b,'||nlchr||
                           '       passp s'||nlchr||
                           ' WHERE     d.acc = a.acc'||nlchr||
                           '       AND d.rnk = C.RNK'||nlchr||
                           '       AND a.rnk = c.rnk'||nlchr||
                           '       AND d.vidd = v.vidd'||nlchr||
                           '       AND p.rnk = c.rnk'||nlchr||
                           '       AND t.type_code= v.type_cod'||nlchr||
                           '       and p.passp=s.passp'||nlchr||
                           '       and D.KV=b.kv'||nlchr||
						   '       and a.nbs!=''2620'''||nlchr||
                           '       and a.nls = decode(:Param0,''%'',a.nls,:Param0)'||nlchr||
                           '       and c.okpo = decode(:Param1,''%'',c.okpo,:Param1)'||nlchr||
                           '       and a.kv = decode(:Param2,''%'',a.kv,:Param2)'||nlchr||
                           '       and c.rnk = decode(:Param3,''%'',c.rnk,:Param3)';
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
    l_rep.description :='Звіт про стан депозитних рахунків клієнта Кредитної фабрики';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3053;


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
               ('WEBP', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Робота з клієнтом';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Робота з клієнтом';
    end;
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
