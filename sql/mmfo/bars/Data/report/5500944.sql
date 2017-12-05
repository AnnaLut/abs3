prompt ===================================== 
prompt == Звітність по закритих строкових депозитах
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
   l_zpr.name := 'Звітність по закритих строкових депозитах';
   l_zpr.pkey := '\BRS\SBR\DPT\205';

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
    l_zpr.name         := 'Звітність по закритих строкових депозитах';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':sFdat1=''Дата з (DD.MM.YYYY) :'',:sFdat2=''Дата по (DD.MM.YYYY) :'',:BRANCH=''Відділення :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''/322669/''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select dd.branch,dd.rnk,dd.NMK,dd.NLS,dd.KV,dd.DOS/100 sum_dep,dd.REAL_EXPIRE as dat_close ,dd.TELD,dd.TELM
from v_my_dpt dd
where action_id in (1,2)
   and nbs in(2630)
   and dat_app is not null
   and real_expire between :sFdat1 and :sFdat2
   and branch like :BRANCH||''%''
   and NOT  EXISTS (select c.okpo
                      from dpt_deposit d inner join accounts a on d.acc=a.acc
                                         inner join customer c on a.rnk=c.rnk
                      where a.nbs in (2630)
                            and a.DAZS is null
                            and a.DAPP is not null
                            and c.okpo =dd.okpo)
order  by dd.branch,dd.rnk';
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
