prompt ===================================== 
prompt == Залишки коштів ФО(депозити) в вал. та екв. на дату
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
   l_zpr.name := 'Залишки коштів ФО(депозити) в вал. та екв. на дату';
   l_zpr.pkey := '\BRS\SBR\DPT\160';

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
    l_zpr.name         := 'Залишки коштів ФО(депозити) в вал. та екв. на дату';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate=''Звітна дата(DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select * from (
select b.branch      
       ,q1.ost_dep_980,q1.count_dep_980
       ,q2.ost_dep_840,round(f_ret_kurs(840,to_date(:zDate,''dd.mm.yyyy''))*q2.ost_dep_840,2) ost_dep_840_ekv,q2.count_dep_840
       ,q3.ost_dep_978,round(f_ret_kurs(978,to_date(:zDate,''dd.mm.yyyy''))*q3.ost_dep_978,2) ost_dep_978_ekv,q3.count_dep_978
       ,q4.ost_dep_643,round(f_ret_kurs(643,to_date(:zDate,''dd.mm.yyyy''))*q4.ost_dep_643,2) ost_dep_638_ekv,q4.count_dep_643
from branch b left join 
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_980,count(branch) count_dep_980,branch 
     from accounts a
     where (a.nbs in (2630, 2635) )
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=980
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q1 on b.branch=q1.branch
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_840,count(branch) count_dep_840,branch
     from accounts a
     where (a.nbs in (2630, 2635) )
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=840
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q2 on b.branch=q2.branch
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_978,count(branch) count_dep_978,branch
     from accounts a
     where (a.nbs in (2630, 2635) )
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=978
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q3 on b.branch=q3.branch     
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_643,count(branch) count_dep_643,branch
     from accounts a
     where (a.nbs in (2630, 2635) )
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=643
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q4 on b.branch=q4.branch                      
where b.DATE_CLOSED is null and length(b.branch)=22
union all
select SUBSTR(b.branch,1,15)
       ,sum(q1.ost_dep_980),sum(q1.count_dep_980)
       ,sum(q2.ost_dep_840),sum(round(f_ret_kurs(840,to_date(:zDate,''dd.mm.yyyy''))*q2.ost_dep_840,2)) ,sum(q2.count_dep_840)
       ,sum(q3.ost_dep_978),sum(round(f_ret_kurs(978,to_date(:zDate,''dd.mm.yyyy''))*q3.ost_dep_978,2)) ,sum(q3.count_dep_978)
       ,sum(q4.ost_dep_643),sum(round(f_ret_kurs(643,to_date(:zDate,''dd.mm.yyyy''))*q4.ost_dep_643,2)) ,sum(q4.count_dep_643)
from branch b left join 
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_980,count(branch) count_dep_980,branch
     from accounts a
     where (a.nbs in (2630, 2635) )
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=980
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q1 on b.branch=q1.branch
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_840,count(branch) count_dep_840,branch
     from accounts a
     where (a.nbs in (2630, 2635))
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=840
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q2 on b.branch=q2.branch
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_978,count(branch) count_dep_978,branch
     from accounts a
     where (a.nbs in (2630, 2635) )
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=978
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q3 on b.branch=q3.branch     
     left join
    (Select sum(fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))/100) ost_dep_643,count(branch) count_dep_643,branch
     from accounts a
     where (a.nbs in (2630, 2635))
       and (a.dazs is null or a.dazs>to_date(:zDate,''dd.mm.yyyy''))
       and a.kv=643
       and fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<>0
     group by a.branch) q4 on b.branch=q4.branch                      
where b.DATE_CLOSED is null and length(b.branch)=22 
group by SUBSTR(b.branch,1,15))
where branch like sys_context(''bars_context'',''user_mfo_mask'')
order by SUBSTR(branch,12,3),SUBSTR(branch,17,1) DESC,SUBSTR(branch,19,3)';
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
