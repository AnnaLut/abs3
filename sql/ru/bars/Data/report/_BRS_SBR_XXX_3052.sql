prompt ===================================== 
prompt == Виписки про рух коштів на рахунок Казначейства
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
   l_zpr.name := 'Виписки про рух коштів на рахунок Казначейства';
   l_zpr.pkey := '\BRS\SBR\***\3052';

   l_message  := 'Ключ запроса: '||l_zpr.pkey||'  '||nlchr;

   begin                                                   
      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        
      from zapros where pkey=l_zpr.pkey;                   
   exception when no_data_found then                       
      l_isnew:=1;                                          
      select s_zapros.nextval into l_zpr.kodz from dual;   
      if (6844>0) then                  
         select s_zapros.nextval into l_zpr.kodr from dual;
         l_zprr.kodz:=l_zpr.kodr;           
      end if;                               
   end;                                     
                                            
    ------------------------    
    --  constraint query  --    
    ------------------------    
                                
    l_zprr.id           := 1;
    l_zprr.name         := 'Виписки про рух коштів на рахунок Казначейства';
    l_zprr.namef        := '';
    l_zprr.bindvars     := ':sFdat1='''',:sFdat2='''',:NLS='''',:KV=''''';
    l_zprr.create_stmt  := 'MFO     CHAR(6),'||nlchr||
                           'FN      CHAR(20),'||nlchr||
                           'VDAT    DATE,'||nlchr||
                           'KV      NUMBER(3),'||nlchr||
                           'NLS     CHAR(15),'||nlchr||
                           'OST_VX  NUMBER(19),'||nlchr||
                           'OST_IS  NUMBER(19),'||nlchr||
                           'SDE     NUMBER(19),'||nlchr||
                           'SKR     NUMBER(19),'||nlchr||
                           'SDEQ    NUMBER(19),'||nlchr||
                           'SKRQ    NUMBER(19),'||nlchr||
                           'ID      NUMBER(19),'||nlchr||
                           'NLSK    CHAR(15),'||nlchr||
                           'NAMK    CHAR(38),'||nlchr||
                           'ND      CHAR(10),'||nlchr||
                           'SD      NUMBER(17,2),'||nlchr||
                           'SK      NUMBER(17,2),'||nlchr||
                           'SDQ     NUMBER(17,2),'||nlchr||
                           'SKQ     NUMBER(17,2),'||nlchr||
                           'NAZN    CHAR(160)';
    l_zprr.rpt_template := '';
    l_zprr.form_proc    := '';
    l_zprr.default_vars := ':SRT=''даті''';
    l_zprr.bind_sql     := ':SRT=''V_REPCHOOSE_SORT|ID|DESCRIPT|ORDER BY SRT''';
    l_zprr.xml_encoding := 'CL8MSWIN1251';
    l_zprr.pkey         := l_zpr.pkey||'\1';
    l_zprr.txt          := 'SELECT  to_char(f_ourmfo)                                     as MFO'||nlchr||
                           '       ,''lic_''||nls||lpad(kv,3,''0'')||''.DBF''                   as FN'||nlchr||
                           '       ,datd                                                  as VDAT'||nlchr||
                           '       , kv                                                   as KV'||nlchr||
                           '       ,nls                                                   as NLS'||nlchr||
                           '       ,(ostf*100)                                            as OST_VX'||nlchr||
                           '       ,((ostf- sum(doss*-1) over (partition by nls,kv,fdat order by nls,kv,fdat) + sum(koss) over (partition by nls,kv,fdat order by nls,kv,fdat))*100) as OST_IS'||nlchr||
                           '       ,sum(doss*-1) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                              as SDE'||nlchr||
                           '       ,sum(koss) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                              as SKR'||nlchr||
                           '       ,sum(dossq*-1) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                             as SDEQ'||nlchr||
                           '       ,sum(kossq) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                             as SKRQ'||nlchr||
                           '       ,1                                                     as ID'||nlchr||
                           '       ,CASE WHEN dk = 0 THEN  nls ELSE nls2 END              as NLSK'||nlchr||
                           '       ,substr(CASE WHEN dk = 0 THEN  nmk ELSE nmk2 END,1,50) as NAMK'||nlchr||
                           '       ,nd                                                  as ND'||nlchr||
                           '       ,(case when dk = 0 then -s else 0 end)*100              as SD'||nlchr||
                           '       ,(case when dk = 1 then s else 0 end)*100              as SK'||nlchr||
                           '       ,(case when dk = 0 then -sq else 0 end)*100             as SDQ'||nlchr||
                           '       ,(case when dk = 1 then sq else 0 end)*100             as SKQ'||nlchr||
                           '       ,substr(nazn,1,250)                                    as NAZN '||nlchr||
                           '       FROM    v_rptlic2'||nlchr||
                           'WHERE   NVL(ref, 0) = DECODE(''0'',''0'',ref,NVL(ref, 0))'||nlchr||
                           '        AND bis = 0 '||nlchr||
                           '        AND srt < 3'||nlchr||
                           '        and nls = :NLS and kv = :KV';
    l_zprr.xsl_data     := '';
    l_zprr.xsd_data     := '';

    if l_isnew = 1 then            
       insert into zapros values l_zprr;  
    else                           
       update zapros set name         = l_zprr.name,        
                         namef        = l_zprr.namef,       
                         bindvars     = l_zprr.bindvars,    
                         create_stmt  = l_zprr.create_stmt, 
                         rpt_template = l_zprr.rpt_template,
                         form_proc    = l_zprr.form_proc,   
                         default_vars = l_zprr.default_vars,
                         bind_sql     = l_zprr.bind_sql,    
                         xml_encoding = l_zprr.xml_encoding,
                         txt          = l_zprr.txt,         
                         xsl_data     = l_zprr.xsl_data,    
                         xsd_data     = l_zprr.xsd_data     
       where pkey=l_zprr.pkey;                              
                                                            
    end if;                                                 

    ------------------------    
    --  main query        --    
    ------------------------    
                                
    l_zpr.id           := 1;
    l_zpr.name         := 'Виписки про рух коштів на рахунок Казначейства';
    l_zpr.namef        := '=''lic_''||:NLS||''_''||:KV||''.''||''DBF''';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'rptlic_nls_3052(to_date(:sFdat1), to_date(:sFdat2))';
    l_zpr.default_vars := ':SRT=''даті''';
    l_zpr.bind_sql     := ':SRT=''V_REPCHOOSE_SORT|ID|DESCRIPT|ORDER BY SRT''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT  nls    , kv                          '||nlchr||
                           '       FROM    v_rptlic2'||nlchr||
                           'WHERE   NVL(ref, 0) = DECODE(''0'',''0'',ref,NVL(ref, 0))'||nlchr||
                           '        AND bis = 0 '||nlchr||
                           '        AND srt < 3';
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
    l_rep.description :='Виписки про рух коштів на рахунок Казначейства';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',11,sFdat,sFdat2,"",FALSE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='lic_*_*.*DBF';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3052;


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

begin
  insert into app_rep (codeapp, coderep, approve)
  values ('DRU1', 3052, 1);
exception when dup_val_on_index then null;
end;
/    

begin
  insert into app_rep (codeapp, coderep, approve)
  values ('OPER', 3052, 1);
exception when dup_val_on_index then null;
end;
/    
                
commit;                
/