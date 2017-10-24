-- to_do
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
   l_zpr.name := 'Надходження коштів на рахунки НАК Нафтогаз';
   l_zpr.pkey := '\BRS\SBM\***\5060';

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
    l_zpr.name         := 'Надходження коштів на рахунки НАК Нафтогаз';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '5060.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  '||nlchr||
'l, '||nlchr||
'sq, '||nlchr||
'round(sq/eur,2) sq_eur,  '||nlchr||
'eur,  '||nlchr||
'usd_eur, '||nlchr||
'to_char(:sFdat1) dt1, '||nlchr||
'to_char(:sFdat2) dt2 '||nlchr||
'from  '||nlchr||
'(select   l, '||nlchr||
'        eur, '||nlchr||
'        usd, '||nlchr||
'        round(usd/eur,4) usd_eur, '||nlchr||
'   case when :sFdat1=to_date(''01/04/2016'',''dd/mm/yyyy'') and :sFdat2=to_date(''31/03/2017'',''dd/mm/yyyy'') and l=''Кошти 1 рівня пріоритетності: '' then sum(sq)/100+8005463016.86+4702017757.73+13128920403.45+1588708217.19 '||nlchr||
'        when :sFdat1=to_date(''01/04/2016'',''dd/mm/yyyy'') and :sFdat2=to_date(''31/03/2017'',''dd/mm/yyyy'') and l=''Кошти 2 рівня пріоритетності: '' then sum(sq)/100+1344815611.96+ 780117118.43+ 7907877489.75+1677843432.62 '||nlchr||
'        when :sFdat1=to_date(''01/07/2016'',''dd/mm/yyyy'') and :sFdat2=to_date(''30/06/2017'',''dd/mm/yyyy'') and l=''Кошти 1 рівня пріоритетності: '' then sum(sq)/100+4702017757.73+13128920403.45+1588708217.19 '||nlchr||
'        when :sFdat1=to_date(''01/07/2016'',''dd/mm/yyyy'') and :sFdat2=to_date(''30/06/2017'',''dd/mm/yyyy'') and l=''Кошти 2 рівня пріоритетності: '' then sum(sq)/100+ 780117118.43+ 7907877489.75+1677843432.62 '||nlchr||
'        when :sFdat1=to_date(''01/10/2016'',''dd/mm/yyyy'') and :sFdat2=to_date(''30/09/2017'',''dd/mm/yyyy'') and l=''Кошти 1 рівня пріоритетності: '' then sum(sq)/100+13128920403.45+1588708217.19 '||nlchr||
'        when :sFdat1=to_date(''01/10/2016'',''dd/mm/yyyy'') and :sFdat2=to_date(''30/09/2017'',''dd/mm/yyyy'') and l=''Кошти 2 рівня пріоритетності: '' then sum(sq)/100+ 7907877489.75+1677843432.62 '||nlchr||
'        when :sFdat1=to_date(''01/01/2017'',''dd/mm/yyyy'') and :sFdat2=to_date(''31/12/2017'',''dd/mm/yyyy'') and l=''Кошти 1 рівня пріоритетності: '' then sum(sq)/100+1588708217.19 '||nlchr||
'        when :sFdat1=to_date(''01/01/2017'',''dd/mm/yyyy'') and :sFdat2=to_date(''31/12/2017'',''dd/mm/yyyy'') and l=''Кошти 2 рівня пріоритетності: '' then sum(sq)/100+1677843432.62   '||nlchr||
'        else sum(sq)/100 end sq '||nlchr||
'from ( '||nlchr||
'select case '||nlchr||
'          when     o.nlsa in (''26000303921'', '||nlchr||
'                              ''26031305921'', '||nlchr||
'                              ''26034302921'', '||nlchr||
'                              ''26039307921'') '||nlchr||
'               and mfoa = ''300465'' '||nlchr||
'               and mfob = ''300465'' '||nlchr||
'               and o.kv = 980 '||nlchr||
'          then '||nlchr||
'             ''Кошти 1 рівня пріоритетності: '' '||nlchr||
'          when     o.nlsa in (''26006866'', '||nlchr||
'                              ''2603136166'', '||nlchr||
'                              ''26033324066'', '||nlchr||
'                              ''26030324166'', '||nlchr||
'                              ''26037324266'', '||nlchr||
'                              ''26034324366'', '||nlchr||
'                              ''26031324466'', '||nlchr||
'                              ''26038324566'', '||nlchr||
'                              ''26035324666'', '||nlchr||
'                              ''26032324766'', '||nlchr||
'                              ''26039324866'', '||nlchr||
'                              ''26036324966'', '||nlchr||
'                              ''26039325166'', '||nlchr||
'                              ''26036325266'', '||nlchr||
'                              ''26033325366'', '||nlchr||
'                              ''26030325466'', '||nlchr||
'                              ''26037325566'', '||nlchr||
'                              ''26034325666'', '||nlchr||
'                              ''26032325066'', '||nlchr||
'                              ''2603834266'') '||nlchr||
'               and mfoa = ''320478'' '||nlchr||
'               and mfob = ''300465'' '||nlchr||
'               and o.kv = 980 '||nlchr||
'          then '||nlchr||
'             ''Кошти 1 рівня пріоритетності: '' '||nlchr||
'          when     o.nlsa in (''26008305921'') '||nlchr||
'               and mfoa = ''300465'' '||nlchr||
'               and mfob = ''300465'' '||nlchr||
'               and o.kv = 980 '||nlchr||
'          then '||nlchr||
'             ''Кошти 2 рівня пріоритетності: '' '||nlchr||
'          else '||nlchr||
'             ''Кошти 3 рівня пріоритетності: '' '||nlchr||
'       end '||nlchr||
'          l, '||nlchr||
'       case '||nlchr||
'          when o.kv = 980 then op.s '||nlchr||
'          else gl.p_icurval (o.kv, op.s, op.fdat) '||nlchr||
'       end '||nlchr||
'          sq, '||nlchr||
' eur,usd '||nlchr||
'  from opldok op, '||nlchr||
'       oper o, '||nlchr||
'       accounts a, '||nlchr||
'       (select round (sum (rate_o / bsum) / count (*), 4) eur '||nlchr||
'          from cur_rates$base '||nlchr||
'         where     kv = 978 '||nlchr||
'               and branch = ''/300465/'' '||nlchr||
'               and vdate between :sFdat1 and :sFdat2) e, '||nlchr||
'       (select round (sum (rate_o / bsum) / count (*), 4) usd '||nlchr||
'          from cur_rates$base '||nlchr||
'         where     kv = 840 '||nlchr||
'               and branch = ''/300465/'' '||nlchr||
'               and vdate between :sFdat1 and :sFdat2) u '||nlchr||
' where     op.acc = a.acc '||nlchr||
'       and op.ref = o.ref '||nlchr||
'       and a.nls = ''26006307921'' '||nlchr||
'       and op.dk = 1 '||nlchr||
'       and op.fdat between :sFdat1 and :sFdat2) '||nlchr||
'group by l,eur,usd,usd/eur '||nlchr||
')order by l ';
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
    l_rep.description :='Надходження коштів на рахунки НАК Нафтогаз';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 210; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5060;


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
begin
  insert into app_rep (codeapp, coderep, approve)
  values ('$RM_KONS', 5060, 1);
exception when dup_val_on_index then null;
end;
/                     
commit;                
/


