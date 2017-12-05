prompt ===================================== 
prompt == Залишки коштів ФО(депозити) в вал. на дату(ТВБВ н.т.)
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
   l_zpr.name := 'Залишки коштів ФО(депозити) в вал. на дату(ТВБВ н.т.)';
   l_zpr.pkey := '\BRS\SBR\DPT\135';

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
    l_zpr.name         := 'Залишки коштів ФО(депозити) в вал. на дату(ТВБВ н.т.)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate=''Звітна дата(DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''10026/''||SUBSTR(bp.branch,18,4) as nom_otd,q1.ost_dep_980,q2.ost_dep_840,q3.ost_dep_978,ost_dep_643
from branch_parameters bp left join 
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_980,branch
     from accounts a
     where a.nbs in (2630,2637,2636) 
       and a.branch in (select branch from branch_parameters where tag=''DEPARTS6'' and val=''Y'')
       and a.dazs is null
       and a.kv=980
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q1 on bp.branch=q1.branch
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_840,branch
     from accounts a
     where a.nbs in (2630,2637,2636) 
       and a.branch in (select branch from branch_parameters where tag=''DEPARTS6'' and val=''Y'')
       and a.dazs is null
       and a.kv=840
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q2 on bp.branch=q2.branch
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_978,branch
     from accounts a
     where a.nbs in (2630,2637,2636) 
       and a.branch in (select branch from branch_parameters where tag=''DEPARTS6'' and val=''Y'')
       and a.dazs is null
       and a.kv=978
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q3 on bp.branch=q3.branch     
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_643,branch
     from accounts a
     where a.nbs in (2630,2637,2636) 
       and a.branch in (select branch from branch_parameters where tag=''DEPARTS6'' and val=''Y'')
       and a.dazs is null
       and a.kv=643
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q3 on bp.branch=q3.branch                   
where bp.tag=''DEPARTS6'' and bp.Val=''Y''     
order by ''10026/''||SUBSTR(bp.branch,18,4)';
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
