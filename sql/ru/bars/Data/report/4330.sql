prompt ===================================== 
prompt == CCK: Кредитні рахунки не прив'язані ні до КД ні до БПК
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
   l_zpr.name := 'CCK: Кредитні рахунки не прив''язані ні до КД ні до БПК';
   l_zpr.pkey := '\BRS\SBR\CCK\6';

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
    l_zpr.name         := 'CCK: Кредитні рахунки не прив''язані ні до КД ні до БПК';
    l_zpr.namef        := '';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select s.nkd   "Ном_контр_скарб",
       a.tobo  "Бранч",
       a.nls   "Особовий_рах",
       si.ob22 "Анал_рахунок" ,
       abs(ostc/100)    "Залишок",
       a.nms   "Найменув_рах",
       a.tip   "Тип_рах",
(select max(''Так'') from cc_deal d where  d.rnk=a.rnk and d.sos<15 ) "Є_кредит"
from accounts a,specparam s,specparam_int si where a.acc=s.acc(+) and
    a.nbs||si.ob22 not in (''357801'',''357805'',''357809'',''357810'',''357812'',''357814'',''357815'',''357816'',''357817'',
                           ''357818'',''357823'',''357824'',''357825'',''357037'',''357839'',''357840'',''357841'',''357031'',''357844'',
                           ''357040'',''357845'',''357848'') and
                            a.acc=si.acc and
a.acc in 
(
    select a.acc from accounts a where  a.dazs is null  and
            ( regexp_like (a.nls,''^[2][2,0].[2,3,7,8,9]'') or  nbs in  (''3578'',''3570'',''9129'')    )    
          and not exists (select 1 from nd_acc n where n.acc=a.acc )
         -- and not exists (select 1 from nd_acc n where n.acc=a.acc ) 
          and not exists (select 1 from acc_over n where n.acc_9129=a.acc ) 
          and not exists (select 1 from acc_over n where n.acc_2067=a.acc ) 
          and not exists (select 1 from acc_over n where n.acc_2069=a.acc ) 
          and not exists ( select 1 from acc_over o, int_accn i where i.id=0 and  o.acc_2067=i.acc and i.acra is not null  and nvl(i.acra,0)=a.acc)
          and not exists (select 1 from bpk_acc n where n.acc_ovr=a.acc )      
          and not exists (select 1 from bpk_acc n where n.acc_9129=a.acc )
          and not exists (select 1 from bpk_acc n where n.acc_2208=a.acc ) 
          and not exists (select 1 from bpk_acc n where n.acc_2207=a.acc )
          and not exists (select 1 from bpk_acc n where n.acc_2209=a.acc ) 
          and not exists (select 1 from w4_acc n where n.acc_ovr=a.acc ) 
          and not exists (select 1 from w4_acc n where n.acc_2203=a.acc )     
          and not exists (select 1 from w4_acc n where n.acc_2208=a.acc )
          and not exists (select 1 from w4_acc n where n.acc_2207=a.acc )
          and not exists (select 1 from w4_acc n where n.acc_2209=a.acc )
          and not exists (select 1 from w4_acc n where n.acc_3570=a.acc )
          and not exists (select 1 from w4_acc n where n.acc_3579=a.acc )
          and not exists (select 1 from w4_acc n where n.acc_9129=a.acc )
) ';
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
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
