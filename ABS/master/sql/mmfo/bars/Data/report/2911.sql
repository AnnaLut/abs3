prompt ===================================== 
prompt == Перевірка формування проводок по резерву (%)
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
   l_zpr.name := 'Перевірка формування проводок по резерву (%)';
   l_zpr.pkey := '\BRS\SBM\REZ\21';

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
    l_zpr.name         := 'Перевірка формування проводок по резерву (%)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':dat_=''Дата розрахунку'',:p_user=''Виконавець''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := ':p_user=''STAFF|ID|FIO| ORDER BY FIO''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ss.branch "Відділення", 
       sum(ss.szq) "Резерв_розрах",
       sum(sss.rest) "Резерв_факт", sum(ss.szq-sss.rest) "Відхилення",sum(sss.pr) "Проводка",
       sum(ss.szq_3570) "Резерв_розрах_інші",
       sum(sss.rest_3570) "Резерв_факт_інші", sum(ss.szq_3570-sss.rest_3570) "Відхил_інші",sum(sss.pr_3570) "Проводка_інші",
       sum(ss.szq_all) "ВСЬОГО_Резерв_розр",
       sum(sss.rest_3570+sss.rest) "ВСЬОГО_Резерв_факт", sum(ss.szq_all-sss.rest-sss.rest_3570) "ВСЬОГО_Відхилення"
,sum(sss.pr+sss.pr_3570) "ВСЬОГО_проводка"
from
(
 select branch, sum(decode(pr,0,szq,0)) szq, sum(decode(pr,1,szq,0)) szq_3570, sum(szq) szq_all
 from
    ( select b.branch, b.name br_name,sum(szq)/100 szq,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) pr 
      from tmp_rez_risk r, branch b
      where r.s080 = 9 and r.dat = to_date(:dat_ ,''dd.mm.yyyy'') and r.id = nvl(:p_user, user_id)
          and rtrim(substr(replace(r.tobo||''/'',''//'',''/000000/''),1,instr(replace(r.tobo||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
      group by b.branch, b.name,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) 
    )
 group by branch                
) ss,
(
   select b.branch, sum(decode(a.nbs,''2400'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest,
                 sum(decode(a.nbs,''3599'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest_3570
                 ,sum(decode(a.nbs,''2400'', decode(m.dk,0,(-1)*m.s2/100,1, m.s2/100, (-1)*m.s2/100),0)) pr,
                 sum(decode(a.nbs,''3599'',  decode(m.dk,0,(-1)*m.s2/100,1, m.s2/100, (-1)*m.s2/100),0)) pr_3570                 
    from accounts a, specparam_int s, branch b, rez_doc_maket m
    where a.nbs in (''2400'',''3599'') and a.acc = s.acc and
          ((a.nbs = ''2400'' and s.ob22 not in (''04'',''07'',''03'',''06'',''09'',''10'',''05'',''08'',''21'',''22'')) or
           (a.nbs = ''3599'' )
          ) 
          and nvl(a.dazs, to_date(''01014999'',''ddmmyyyy'')) >= to_date(:dat_ ,''dd.mm.yyyy'')
          and rtrim(substr(replace(a.branch||''/'',''//'',''/000000/''),1,instr(replace(a.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
          and a.nls = m.nlsa(+)
          and a.kv = m.kv(+) and m.dk(+) <> -1
         and m.USERID(+) = nvl(:p_user, user_id)
    group by b.branch
) sss
where ss.branch = sss.branch(+)
group by grouping sets
((ss.branch),
()
)
order by ss.branch';
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
