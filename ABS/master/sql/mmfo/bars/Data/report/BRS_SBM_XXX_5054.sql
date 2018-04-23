prompt ===================================== 
prompt == Щомісячний звіт по корпоративним клієнтам
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
   l_zpr.name := 'Щомісячний звіт по корпоративним клієнтам';
   l_zpr.pkey := '\BRS\SBM\***\5054';

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
    l_zpr.name         := 'Щомісячний звіт по корпоративним клієнтам';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На дату(dd/mm/yyyy)'',:KF=''МФО''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep5054.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ',:KF=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select trunc(sysdate) DATGEN, '||nlchr||
                           '       trunc(add_months(:sFdat1,0),''MM'')-0 DAT1, '||nlchr||
                           '       trunc(add_months(:sFdat1,1),''MM'')-1 DAT2,'||nlchr||
                           '       substr(c.branch,2,6) MFO, c.branch BRANCH, c.rnk RNK,'||nlchr||
                           '       c.okpo OKPO, c.date_on DATE_ON, c.date_off DATE_OFF,'||nlchr||
                           '       decode(c.custtype, 3, c.nmk, p.nmku) NMKU,'||nlchr||
                           '       c.nmkk NMKK, c.adr ADR, c.country, c.prinsider, '||nlchr||
                           '       c.ise, c.fs, c.ved, c.k050,'||nlchr||
                           '       p.ruk, s.fio isp,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''IDDPD'',trunc(add_months(:sFdat1,1),''MM'')-1),1,10) IDDPD,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''IDDPL'',trunc(add_months(:sFdat1,1),''MM'')-1),1,10) IDDPL,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''FSKPR'',trunc(add_months(:sFdat1,1),''MM'')-1),1,6) FSKPR,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''FSPOR'',trunc(add_months(:sFdat1,1),''MM'')-1),1,6) FSPOR,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''FSZOP'',trunc(add_months(:sFdat1,1),''MM'')-1),1,6) FSZOP,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''FSOVR'',trunc(add_months(:sFdat1,1),''MM'')-1),1,6) FSOVR,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''FSRSK'',trunc(add_months(:sFdat1,1),''MM'')-1),1,6) FSRSK,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''SUTD'',trunc(add_months(:sFdat1,1),''MM'')-1),1,120)  SUTD,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''CCVED'',trunc(add_months(:sFdat1,1),''MM'')-1),1,120) CCVED,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''UUDV'',trunc(add_months(:sFdat1,1),''MM'')-1),1,10) UUDV,'||nlchr||
                           '       substr(f_get_typdist(c.rnk),1,1) typdist,'||nlchr||
                           '       decode(c.custtype, 3, decode(trim(c.sed),''91'',2,3),1) CUSTTYPE,'||nlchr||
                           '       substr(f_get_custw_h(c.rnk,''KVPKK'',trunc(add_months(:sFdat1,1),''MM'')-1),1,10) KVPKK'||nlchr||
                           'from customer c, corps p, staff s, rnkp_kod rk, '||nlchr||
                           '     (select a.rnk, substr(max(w.value),1,10) val'||nlchr||
                           '        from accounts a, accountsw w'||nlchr||
                           '       where a.acc = w.acc'||nlchr||
                           '         and w.tag = ''KODU'''||nlchr||
                           '         and substr(a.nbs,1,2) in (''20'',''21'',''25'',''26'')'||nlchr||
                           '        group by a.rnk) aw'||nlchr||
                           'where c.rnk = p.rnk(+)'||nlchr||
                           '  and (c.date_off is null or (c.date_off >= trunc(add_months(:sFdat1,0),''MM'')-0 and c.date_off <= trunc(add_months(:sFdat1,1),''MM'')-1 ) ) '||nlchr||
                           '  and case when trim(:KF) = ''%'' then substr(c.branch,2,6) else :KF end  = substr(c.branch,2,6)'||nlchr||
                           '  and (c.custtype = 2 or (c.custtype = 3 and trim(c.sed) =''91''))'||nlchr||
                           '  and c.isp = s.id(+)'||nlchr||
                           '  and c.rnk = rk.rnk'||nlchr||
                           '  and c.rnk = aw.rnk'||nlchr||
                           'order by 4,5,6,8';
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
    l_rep.description :='Щомісячний звіт по корпоративним клієнтам';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5054;


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
/