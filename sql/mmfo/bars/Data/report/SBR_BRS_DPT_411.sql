

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_SBR_BRS_DPT_411.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Середнi залишки по рахункам за перiод 
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
   l_zpr.name := 'Середнi залишки по рахункам за перiод ';
   l_zpr.pkey := '\SBR\BRS\DPT\411';

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
    l_zpr.name         := 'Середнi залишки по рахункам за перiод ';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:KV=''Вал (0=всi)'',:NLS=''Рах.схож на'',:BRANCH=''Бранч схож на''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_411.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':KV=''0'',:NLS=''%'',:BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_USERADM_BRANCHES|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT * 
  FROM(SELECT acc.kv,
              acc.nbs,
              acc.nls,
              acc.branch,
              acc.daos,
              acc.dazs,
              acc.nms,
              dat RD,
              FOSTV_AVG(acc.acc,to_date(:sFdat1, ''dd.mm.yyyy''),to_date(:sFdat2, ''dd.mm.yyyy'')) SN,
              FOSTQ_AVG(acc.acc,to_date(:sFdat1, ''dd.mm.yyyy''),to_date(:sFdat2, ''dd.mm.yyyy'')) SQ,
              dat KD
        FROM (SELECT (to_date(:sFdat2, ''dd.mm.yyyy'') - to_date(:sFdat1, ''dd.mm.yyyy'') + 1) DAT FROM dual),
               ACCOUNTS ACC        
       WHERE ACC.BRANCH LIKE :BRANCH
         AND ACC.NLS LIKE :NLS
         AND (acc.dazs IS NULL OR acc.dazs>TO_DATE(:sFdat1, ''dd/mm/yyyy''))
         AND acc.daos<TO_DATE(:sFdat2, ''dd/mm/yyyy'')
         and acc.kv = decode(:KV, ''0'', acc.kv, to_number(:KV))
       )
 WHERE sn<>0
 ORDER BY nls,kv';
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
    l_rep.description :='Середнi залишки по рахункам за перiод ';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 115; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 411;


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

exec umu.add_report2arm(411,'$RM_ANI1');
exec umu.add_report2arm(411,'$RM_DRU1');
exec umu.add_report2arm(411,'$RM_MAIN');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_SBR_BRS_DPT_411.sql =========*** End *
PROMPT ===================================================================================== 
