

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_20375.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Виписки в розрізі дат ВАЛ.(Звіт 20375)
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
   l_zpr.name := 'Виписки в розрізі дат ВАЛ.(Звіт 20375)';
   l_zpr.pkey := '\BRS\SBM\REP\20375';

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
    l_zpr.name         := 'Виписки в розрізі дат ВАЛ.(Звіт 20375)';
    l_zpr.namef        := '= ''VPVAL''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Маска рахунку (%-всi)'',:KV=''Валюта (0-всi)'',:BRANCH=''Вiддiлення'',:DEP=''Вкл. пiдлеглих (1-вкл.)'',:INFORM=''Вкл. iнф.повiдомл.(1-вкл.)'',:NODOCS=''Вкл. без оборотiв (1-вкл.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep20375.frx';
    l_zpr.form_proc    := 'bars_rptlic.lic_valb(to_date(:sFdat1), to_date(:sFdat2) , :Param0,  :KV, 0,  bars_report.get_branch(:BRANCH,:DEP) , :INFORM)';
    l_zpr.default_vars := ':Param0=''%'',:KV=''0'',:BRANCH=''Поточне'',:DEP=''1'',:INFORM=''0'',:NODOCS=''0''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select   '''' fio, 
       srt,  
       dksrt,
       vobsrt,
       nmk ,
       okpo,    
       acc,            
       nls,            
       v.kv,           
       lcv,            
       v.fdat,           
       dapp,           
       ostf,           
       ostfq,           
       nms,            
       s,      
       sq,     
       doss,   
       koss,   
       dossq,  
       kossq,  
       nd,     
       mfo2,    
       nb2  ,     
       nls2   ,   
       nmk2 ,  
       okpo2,   
       nazn,   
       bis,
       dosr,       
       kosr,       
       ostfr,          
       v.fdat,
       curs,
       bsum,
       paydate
from  v_rptlic2 v, 
          tabval t, 
         ( select  t.kv, t.fdat,  c1.bsum,    c1.rate_o curs
              from (select unique kv, fdat from tmp_licm)  t,    cur_rates c1
           where  c1.kv = t.kv  and c1.vdate  = t.fdat
      ) k          
where v.kv = t.kv and k.kv = v.kv
  and k.fdat = v.fdat 
  and nvl(v.ref, 0)  =  decode(:NODOCS, ''0'',  v.ref,   nvl(v.ref, 0) )
order by okpo, nls, v.kv, v.fdat,  srt desc, dksrt, sign(s),  vobsrt,  abs(s), ref, bis  ';
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
    l_rep.description :='Виписки в розрізі дат ВАЛ.(Звіт 20375)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='VPVAL*.*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 20375;


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

exec umu.add_report2arm(20375,'$RM_CRPC');
exec umu.add_report2arm(20375,'$RM_WSSR');
exec umu.add_report2arm(20375,'$RM_@UDT');
exec umu.add_report2arm(20375,'$RM_@ECH');
exec umu.add_report2arm(20375,'$RM_OPER');
exec umu.add_report2arm(20375,'$RM_UCCK');
exec umu.add_report2arm(20375,'$RM_VALB');
exec umu.add_report2arm(20375,'$RM_W_FM');
exec umu.add_report2arm(20375,'$RM_WDOC');
exec umu.add_report2arm(20375,'$RM_DRU1');
exec umu.add_report2arm(20375,'$RM_MAIN');
exec umu.add_report2arm(20375,'$RM_BVBB');
exec umu.add_report2arm(20375,'$RM_WCIM');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_20375.sql =========*** End
PROMPT ===================================================================================== 
