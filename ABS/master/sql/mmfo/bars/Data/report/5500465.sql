prompt ===================================== 
prompt == Сума коригування для визначення обсягу прибутку
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
   l_zpr.name := 'Сума коригування для визначення обсягу прибутку';
   l_zpr.pkey := '\BRS\SBM\OTC\2738';

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
    l_zpr.name         := 'Сума коригування для визначення обсягу прибутку';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':dat_=''Звітна дата''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'p_fb8(to_date(:dat_ ,''dd.mm.yyyy''))';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select s.branch "Код_ТВБВ", 
       s.br_name "Назва", 
       to_char(sum(s.sm_p_all),''999999999990D00'') "Пр_нар_дох", 
       to_char(sum(ss.szq_all)+sum(sss.rest_3578)-sum(s.sm_after180_all),''999999999990D00'') "Резерв", 
       to_char(sum(sss1.rest_3118),''999999999990D00'') "Дох_за_ЦП", 
       to_char(sum(s.sm_p_all)-(sum(ss.szq_all)+sum(sss.rest_3578)-sum(s.sm_after180_all))+NVL(sum(sss1.rest_3118),0),''999999999990D00'') "Дох_без_р"
from
(select branch, 
       br_name, 
       sum(decode(pr,40, sm, 0)) sm_before30,
       sum(decode(pr,50, sm, 0)) sm_after30,
       sum(decode(pr,60, sm, 0)) sm_before60,
       sum(decode(pr,70, sm, 0)) sm_after180,
       sum(decode(pr,50, sm, 60, sm, 70, sm, 0)) sm_30_60_180,
       sum(decode(pr,40, sm,50, sm, 60, sm, 70, sm, 0)) sm,
       sum(decode(pr,41, sm, 0)) sm_before30_3578,
       sum(decode(pr,51, sm, 0)) sm_after30_3578,
       sum(decode(pr,61, sm, 0)) sm_before60_3578,
       sum(decode(pr,71, sm, 0)) sm_after180_3578,
       sum(decode(pr,51, sm, 61, sm, 71, sm, 0)) sm_30_60_180_3578,  
       sum(decode(pr,41, sm,51, sm, 61, sm, 71, sm, 0)) sm_3578,
       sum(decode(pr,40, sm, 41, sm, 0)) sm_before30_all,
       sum(decode(pr,50, sm, 51, sm,0)) sm_after30_all,
       sum(decode(pr,60, sm, 61, sm, 0)) sm_before60_all,
       sum(decode(pr,70, sm, 71, sm, 0)) sm_after180_all,
       sum(decode(pr,40, 0, 41, 0,  sm)) sm_30_60_180_all,                    
       sum(sm) sm_all,       
       sum(sm_p) sm_p_all        
from
(select b.branch, 
       b.name br_name, 
       substr(r.nls,4,1) nls4, 
       replace(substr(kodp,6,1),''4'',''3'') r013, 
       substr(kodp,7,2) s270, sum(r.znap)/100 sm,
       sum(decode(substr(kodp,5,1),''9'',r.znap,0))/100 sm_p,
            (case when substr(kodp,7,2) = ''08'' then
                      (case when substr(r.nls,4,1)=''8'' or substr(r.nls,1,4) in (''2607'', ''2627'', ''3570'') 
                                  then 7 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''3''
                                                    then 6 else 6
                                               end)
                       end)
                 else (case when substr(r.nls,4,1) = ''8'' or substr(r.nls,1,4) in (''2607'', ''2627'', ''3570'')  
                             then
                                (case when substr(kodp,9,1) = ''J'' 
                                      then 7 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''3'' 
                                                        then 6 else 7
                                                   end)
                                 end)
                             else
                                  (case when replace(substr(kodp,6,1),''4'',''3'') = ''3'' 
                                        then 6 else (case when substr(kodp,9,1) = ''J''
                                                          then 6 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''2''
                                                                            then 5 else 4
                                                                       end)
                                                     end)
                                   end)
                       end)    
               end)*10 + decode(a.nbs,''3570'',1,''3578'',1,''3578'',1,0) pr 
             ,sum(sum(r.znap)) over() sm_30_60_180_all    
     from rnbu_trace r, accounts a, branch b
     where r.nls = a.nls and r.kv = a.kv and r.kodp like ''1%''and 
           ( ((substr(r.nls,4,1) = ''8'' or 
               substr(r.nls,1,4) in (''3570'',''2607'',''2627'')) and (substr(r.kodp,7,2) = ''08'' or 
                                                                 substr(r.kodp,9,1)=''J'') ) or 
             (substr(r.nls,4,1) = ''9'')
           )
           and
           rtrim(substr(replace(a.branch||''/'',''//'',''/000000/''),1,instr(replace(a.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch 
 group by b.branch, b.name , substr(r.nls,4,1), replace(substr(kodp,6,1),''4'',''3''), 
            substr(kodp,7,2), 
            (case when substr(kodp,7,2) = ''08'' then
                      (case when substr(r.nls,4,1)=''8'' or substr(r.nls,1,4) in (''2607'', ''2627'', ''3570'') 
                                  then 7 
                            else (case when replace(substr(kodp,6,1),''4'',''3'') = ''3''
                                       then 6 else 6
                                  end)
                       end)
                 else (case when substr(r.nls,4,1) = ''8'' or substr(r.nls,1,4) in (''2607'', ''2627'', ''3570'')  
                             then
                                (case when substr(kodp,9,1) = ''J'' 
                                      then 7 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''3'' 
                                                        then 6 else 7
                                                   end)
                                 end)
                             else
                                  (case when replace(substr(kodp,6,1),''4'',''3'') = ''3'' 
                                        then 6 else (case when substr(kodp,9,1) = ''J''
                                                          then 6 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''2''
                                                                            then 5 else 4
                                                                       end)
                                                     end)
                                   end)
                       end)    
               end), decode(a.nbs,''3570'',1,''3578'',1,''3578'',1,0) )
group by branch, br_name
) s,
(select branch, sum(decode(pr,0,szq,0)) szq, sum(decode(pr,1,szq,0)) szq_3578, sum(szq) szq_all
 from
    ( select b.branch, b.name br_name,NVL(sum(r.znap)/100,0) szq,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,''3578'',1,0) pr 
      from rnbu_trace r, accounts a, branch b
      where substr(r.nls,1,4) in (''1590'',''1592'',''2400'') 
          and substr(r.kodp,6,1) = ''3'' and r.nls = a.nls and r.kv = a.kv  
          and rtrim(substr(replace(a.branch||''/'',''//'',''/000000/''),1,instr(replace(a.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
      group by b.branch, b.name,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,''3578'',1,0) 
    )
 group by branch                
) ss,
(select  b.branch, 
         sum(decode(a.nbs,''3599'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest_3578
    from accounts a, branch b
    where a.nbs in (''3599'')  
          and nvl(a.dazs, to_date(''01014999'',''ddmmyyyy'')) >= to_date(:dat_ ,''dd.mm.yyyy'')
          and rtrim(substr(replace(a.branch||''/'',''//'',''/000000/''),1,instr(replace(a.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
    group by b.branch
) sss,
(select  b.branch, 
         greatest(NVL(sum(gl.p_icurval (a.kv, rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy'')), to_date(:dat_ ,''dd.mm.yyyy'')))/100,0),0)  rest_3118
      from accounts a, branch b
    where a.nbs in (''3118'',''3219'',''3191'',''3291'')  
          and nvl(a.dazs, to_date(''01014999'',''ddmmyyyy'')) >= to_date(:dat_ ,''dd.mm.yyyy'')
          and a.branch(+) = b.branch
    group by b.branch
) sss1
where s.branch = ss.branch and s.branch = sss.branch(+) and s.branch = sss1.branch(+)
group by grouping sets
((s.branch, s.br_name),
()
)
order by 2 nulls last';
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
