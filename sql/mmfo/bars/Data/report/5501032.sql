prompt ===================================== 
prompt == Зведений результат REZ_23_39 ЮО+ФО (в розрізі КАТ, ВАЛ)
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
   l_zpr.name := 'Зведений результат REZ_23_39 ЮО+ФО (в розрізі КАТ, ВАЛ)';
   l_zpr.pkey := '\BRS\SBR\DPT\318';

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
    l_zpr.name         := 'Зведений результат REZ_23_39 ЮО+ФО (в розрізі КАТ, ВАЛ)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Звітна дата (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select max(fdat) as ZV_DATE
     , KAT, kv
     , sum(bvq) as BALV
     , sum(case when nbs in (''2208'',''2238'',''2068'') then bvq else 0 end) as BALV_PRC
     , sum(rezq) as REZ
     , sum(rezq23) as REZ_23
     , sum(rezq39) as REZ_39
from nbu23_rez
where fdat=to_date(:zDate1,''dd.mm.yyyy'') 
      and DDD in (''122'',''123'',''124'',''125'')
      and DD in (''2'',''3'')
      and nbs||r013<>''91299''
group by KAT, kv     
order by kv, KAT';
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
