prompt ===================================== 
prompt == Виписка за рахунком клієнта
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
   l_zpr.name := 'Виписка за рахунком клієнта';
   l_zpr.pkey := '\BRS\SBM\REP\LICNLS';

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
    l_zpr.name         := 'Виписка за рахунком клієнта';
    l_zpr.namef        := '= ''VP''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''_''||''RUHA''||''_''||user_id||''.''||''csv''';
    l_zpr.bindvars     := ':sFdat1='',:sFdat2='',:Param0=''Маска рахунку (%-всi)'',:KV=''Валюта (0-всi)'',:BRANCH=''Вiддiлення'',:DEP=''Вкл. пiдлеглих (1-вкл.)'',:ISP=''Виконавець рах.(0-всi)'',:NODOCS=''Вкл. без оборотів.(1-вкл.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep1009.frx';
    l_zpr.form_proc    := 'bars.rptlic_nls(to_date(:sFdat1), to_date(:sFdat2), :Param0, :KV, 1,  bars_report.get_branch(:BRANCH,:DEP), :ISP)';
    l_zpr.default_vars := ':Param0=''%'',:KV=''0'',:BRANCH=''Поточне'',:DEP=''1'',:INFORM=''0'',:ISP=''0'',:NODOCS=''1''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT
                  ref as num00,
                  to_char(datd,''DD.MM.YYYY'') as char00,
                  ostf*100 as num01,
                  (ostf- sum(doss*-1) over (partition by nls,kv, fdat order by nls,kv, fdat) +
                             sum(koss) over (partition by nls,kv, fdat order by nls,kv, fdat))*100 as num02,
                  GL.P_ICURVAL(kv,ostf*100,datd) as num03,
                  GL.P_ICURVAL(kv,(ostf-sum(doss*-1) over (partition by nls,kv, fdat order by nls,kv, fdat)+
                               sum(koss) over (partition by nls,kv, fdat order by nls,kv, fdat))*100,datd) as num04,
                  s*100 as num05,
                  sq*100 as num06,
                  kv as num07,
                  CASE WHEN dk = 0 THEN  nls ELSE nls2 END as char01,
                  substr(CASE WHEN dk = 0 THEN  mfo ELSE mfo2 END,1,6) as char02,
                  trim(substr(f_fm_replace_symbols(CASE WHEN dk = 0 THEN  nb  ELSE nb2  END),1,100)) as char03,
                  substr(f_fm_replace_symbols(CASE WHEN dk = 0 THEN  nmk ELSE nmk2 END),1,100) as char04,
                  CASE WHEN dk = 0 THEN okpo ELSE okpo2 END  as char05,
                  CASE WHEN dk = 1 THEN  nls ELSE nls2 END as char06,
                  substr(CASE WHEN dk = 1 THEN  mfo ELSE mfo2 END,1,6) as char07,
                  trim(substr(f_fm_replace_symbols(CASE WHEN dk = 1 THEN  nb  ELSE nb2  END),1,100)) as char08,
                  trim(substr(f_fm_replace_symbols(CASE WHEN dk = 1 THEN  nmk ELSE nmk2 END),1,100)) as char09,
                  CASE WHEN dk = 1 THEN okpo ELSE okpo2 END as char10,
                  substr(f_fm_replace_symbols(nazn),1,250) as char11,
                  nls as char12,
                  to_char(paydate, ''dd.mm.yyyy'') as char13,
                  to_char(paydate,  ''HH24:MI:SS'') as char14
          FROM    v_rptlic2
          WHERE   NVL(ref, 0) = DECODE(''0'',''0'',ref,NVL(ref, 0))
                  AND bis = 0
                  AND srt < 3
          ORDER BY nls, kv, fdat, srt, dksrt, vobsrt, paydate, ref, bis';
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
    l_rep.description :='Виписка за рахунком клієнта';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='*.*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 1009;


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
