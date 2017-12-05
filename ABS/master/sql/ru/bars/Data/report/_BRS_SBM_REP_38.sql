

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_38.sql =========*** Run **
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Виписки ГРН, вiддiл., маска рахунку  (сорт.по датi)
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
   l_zpr.name := 'Виписки ГРН, вiддiл., маска рахунку  (сорт.по датi)';
   l_zpr.pkey := '\BRS\SBM\REP\38';

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
    l_zpr.name         := 'Виписки ГРН, вiддiл., маска рахунку  (сорт.по датi)';
    l_zpr.namef        := '= ''VPGRN''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Маска рахунку (%-всi)'',:OB22=''OБ22(%-всі)'',:BRANCH=''Вiддiлення'',:DEP=''Вкл. пiдлеглих (1-вкл.)'',:INFORM=''Вкл. iнф.повiдомл.(1-вкл.)'',:ISP=''Виконавці (%-всi)'',:NODOCS=''Вкл. без оборотiв (1-вкл.)'',:SRT=''Сортувати по''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'sbm_l2pg.qrp';
    l_zpr.form_proc    := 'bars_rptlic.lic_grnb_ob(to_date(:sFdat1), to_date(:sFdat2) , :Param0,  :ISP,  bars_report.get_branch(:BRANCH,:DEP),:INFORM,:OB22 )';
    l_zpr.default_vars := ':Param0=''%'',:BRANCH=''Поточне'',:DEP=''1'',:INFORM=''0'',:ISP=''%'',:NODOCS=''0'',:SRT=''датi'',:OB22=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME'',:ISP=''V_REPCHOOSE_ISP|ID|DESCRIPT|ORDER BY SRT'',:SRT=''V_REPCHOOSE_SORT|ID|DESCRIPT''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select   '''' fio, 
       v.srt,  
       v.dksrt,
       v.vobsrt,
       v.nmk ,
       v.okpo,    
       v.acc,            
       v.nls,            
       v.kv,           
       ''UAH'' lcv,            
       v.fdat,           
       v.dapp,           
       v.ostf,           
       v.nms,
       v.nlsalt,            
       v.s,      
       v.sq,     
       v.doss,   
       v.koss,   
       v.nd,     
       v.mfo2,    
       v.nb2  ,     
       v.nls2   ,   
       v.nmk2 ,  
       v.okpo2,   
       v.nazn,   
       v.bis,
       null branch
from v_rptlic v
where   nvl(v.ref, 0)  =  decode(:NODOCS, ''0'',  v.ref,   nvl(v.ref, 0) ) 
order by 
         decode(:SRT, ''рахунку'', substr(nls,1,4)||substr(nls,6), okpo ),
         nls, kv, srt, dksrt, vobsrt, sign(s),
         decode(:SRT, ''датi'',    to_char(fdat, ''yyymmdd''), 
                                   ''сумi'',    to_char(abs(s), ''000000000000000.00''),
                                                 to_char(fdat, ''yyymmdd'')
                        ),
         ref, bis,  fdat';
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
    l_rep.description :='Виписки ГРН, вiддiл., маска рахунку  (сорт.по датi)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='VPGRN*.*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 263;


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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_38.sql =========*** End **
PROMPT ===================================================================================== 
