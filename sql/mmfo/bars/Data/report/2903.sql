prompt ===================================== 
prompt == Звіт про формування резерву за доходами
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
   l_zpr.name := 'Звіт про формування резерву за доходами';
   l_zpr.pkey := '\BRS\SBM\REZ\16';

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
    l_zpr.name         := 'Звіт про формування резерву за доходами';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':dat_=''Дата розрахунку'',:p_user=''Виконавець''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'rez.p_unload_data; p_fb8(to_date(:dat_ ,''dd.mm.yyyy''));commit';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := ':p_user=''STAFF|ID|FIO| ORDER BY FIO''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select s.branch "Відділення", 
       s.br_name "Назва",   
       sum(s.sm) "Усього", sum(s.sm_before30) "Проср_до_Зl", sum(s.sm_after30) "Проср_понад_Зl", 
       sum(s.sm_before60) "Сумнівні", sum(s.sm_after180) "Осн_борг_проср", 
       sum(s.sm_30_60_180) "Разом", sum(ss.szq) "Резерв_розрах",
       sum(sss.rest) "Резерв_факт", sum(ss.szq-sss.rest) "Відхилення",
       
       sum(s.sm_3570) "Усього", sum(s.sm_before30_3570) "Проср_до_Зl", sum(s.sm_after30_3570) "Проср_понад_Зl", 
       sum(s.sm_before60_3570) "Сумнівні", sum(s.sm_after180_3570) "Осн_борг_проср", 
       sum(s.sm_30_60_180_3570) "Разом", sum(ss.szq_3570) "Резерв_розрах",
       sum(sss.rest_3570) "Резерв_факт", sum(ss.szq_3570-sss.rest_3570) "Відхилення",
       
       sum(s.sm_all) "Усього", sum(s.sm_before30_all) "Проср_до_Зl", sum(s.sm_after30_all) "Проср_понад_Зl", 
       sum(s.sm_before60_all) "Сумнівні", sum(s.sm_after180_all) "Осн_борг_проср", 
       sum(s.sm_30_60_180_all) "Разом", sum(ss.szq_all) "Резерв_розрах",
       sum(sss.rest_3570+sss.rest) "Резерв_факт", sum(ss.szq_all-sss.rest-sss.rest_3570) "Відхилення"
       ,sum(ss.sm_jur) "Резерв_розрах_ЮР",sum(ss_o.sm_jur_old) "Попер_Рез_розр_ЮР"
       ,sum(ss.sm_jur)-sum(ss_o.sm_jur_old) "РІЗНИЦЯ_ЮР"
       ,sum(ss.sm_phys) "Резерв_розрах_ФІЗ",sum(ss_o.sm_phys_old) "Попер_Рез_розр_ФІЗ" 
       ,sum(ss.sm_phys) - sum(ss_o.sm_phys_old)  "РІЗНИЦЯ_ФІЗ"    
from
(
select branch, 
       replace('' ''||substr(trim(replace(replace(replace(substr(br_name,4),''смт'',''''),''м.'',''''),''.'','''')), 1,
                    instr(trim(replace(replace(replace(substr(br_name,4),''смт'',''''),''м.'',''''),''.'','''')),'' '')-1),
                    '' Рівне'', ''Рівне'') br_name,   
       sum(decode(pr,40, sm, 0)) sm_before30,
       sum(decode(pr,50, sm, 0)) sm_after30,
       sum(decode(pr,60, sm, 0)) sm_before60,
       sum(decode(pr,70, sm, 0)) sm_after180,
       sum(decode(pr,50, sm, 60, sm, 70, sm, 0)) sm_30_60_180,
       sum(decode(pr,40, sm,50, sm, 60, sm, 70, sm, 0)) sm,

       sum(decode(pr,41, sm, 0)) sm_before30_3570,
       sum(decode(pr,51, sm, 0)) sm_after30_3570,
       sum(decode(pr,61, sm, 0)) sm_before60_3570,
       sum(decode(pr,71, sm, 0)) sm_after180_3570,
       sum(decode(pr,51, sm, 61, sm, 71, sm, 0)) sm_30_60_180_3570,  
       sum(decode(pr,41, sm,51, sm, 61, sm, 71, sm, 0)) sm_3570,

       sum(decode(pr,40, sm, 41, sm, 0)) sm_before30_all,
       sum(decode(pr,50, sm, 51, sm,0)) sm_after30_all,
       sum(decode(pr,60, sm, 61, sm, 0)) sm_before60_all,
       sum(decode(pr,70, sm, 71, sm, 0)) sm_after180_all,
       sum(decode(pr,40, 0, 41, 0,  sm)) sm_30_60_180_all,                    
       sum(sm) sm_all
       
from
( 
    select b.branch, b.name br_name, substr(r.nls,4,1) nls4, replace(substr(kodp,6,1),''4'',''3'') r013, 
            substr(kodp,7,2) s270 ,sum(r.znap)/100 sm
            ,decode(substr(kodp,7,2) , ''08'', decode(substr(r.nls,4,1), ''8'', 
                                       7, 
                                       decode(replace(substr(kodp,6,1),''4'',''3''), ''3'', 6, 7)
                                       ),
                                decode(replace(substr(kodp,6,1),''4'',''3''), ''3'', 6, decode(replace(substr(kodp,6,1),''4'',''3''),''2'', 5, 4))                
             )*10 + decode(a.nbs,''3570'',1,''3578'',1,0) pr 
             ,sum(sum(r.znap)) over() sm_30_60_180_all    
     from rnbu_trace r, 
          accounts a,
          branch b
     where r.nls = a.nls and r.kv = a.kv and r.kodp like ''1%''and 
           ( (substr(r.nls,4,1) = ''8'' and substr(r.kodp,7,2) = ''08'')
             or 
             (substr(r.nls,4,1) = ''9'')-- and not(replace(substr(kodp,6,1),''4'',''3'') in (''1'',''0'') and substr(r.kodp,7,2) <> ''08''))
           )
           and
           rtrim(substr(replace(a.branch||''/'',''//'',''/000000/''),1,instr(replace(a.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch 
     group by b.branch, b.name, substr(r.nls,4,1) , substr(kodp,6,1) , substr(kodp,7,2),
              decode(substr(kodp,7,2) , ''08'', decode(substr(r.nls,4,1), ''8'', 7, decode(replace(substr(kodp,6,1),''4'',''3''), ''3'', 6, 7)),decode(replace(substr(kodp,6,1),''4'',''3''), ''3'', 6, decode(replace(substr(kodp,6,1),''4'',''3''),''2'', 5, 4)))  
              ,decode(a.nbs,''3570'',1,''3578'',1,0)
)
group by branch, br_name
) s,
(
 select branch, sum(decode(pr,0,szq,0)) szq, sum(decode(pr,1,szq,0)) szq_3570, sum(szq) szq_all, 
        sum(decode(pr,0,sm_jur,0)) sm_jur, sum(decode(pr,0,sm_phys,0)) sm_phys 
 from
    ( select b.branch, b.name br_name,sum(szq)/100 szq,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) pr 
             ,sum(decode(r.custtype,2,szq/100,0)) sm_jur 
             ,sum(decode(r.custtype,3,szq/100,0)) sm_phys
      from tmp_rez_risk r, branch b
      where r.s080 = 9 and r.dat = to_date(:dat_ ,''dd.mm.yyyy'') and r.id = nvl(:p_user, user_id)
          and rtrim(substr(replace(r.tobo||''/'',''//'',''/000000/''),1,instr(replace(r.tobo||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
      group by b.branch, b.name,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) 
    )
 group by branch                
) ss,
(
 select branch, 
        sum(decode(pr,0,sm_jur_old,0)) sm_jur_old, sum(decode(pr,0,sm_phys_old,0)) sm_phys_old 
 from
    ( select b.branch, b.name br_name,sum(szq)/100 szq,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) pr 
             ,sum(decode(r.custtype,2,gl.p_icurval(r.kv, sz, to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) sm_jur_old 
             ,sum(decode(r.custtype,3,gl.p_icurval(r.kv, sz, to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) sm_phys_old 
      from tmp_rez_risk r, branch b
      where r.s080 = 9 and 
            (r.id, r.dat) =(select userid, dat
                            from rez_protocol
                            where ''01.''||to_char(dat,''mm.yyyy'') = ''01.''||to_char(add_months(to_date(:dat_ ,''dd.mm.yyyy''),-1),''mm.yyyy'')
                            ) 
          and rtrim(substr(replace(r.tobo||''/'',''//'',''/000000/''),1,instr(replace(r.tobo||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
      group by b.branch, b.name,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) 
    )
 group by branch                
) ss_o,
(
   select  b.branch, sum(decode(a.nbs,''2400'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest,
                 sum(decode(a.nbs,''3599'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest_3570
    from accounts a, specparam_int s, branch b
    where a.nbs in (''2400'',''3599'') and a.acc = s.acc and
          ((a.nbs = ''2400'' and s.ob22 not in (''04'',''05'',''34'',''03'',''09'',''07'',''06'',''10'',''08'',''35'')) or
           (a.nbs = ''3599'' )
          ) 
          and nvl(a.dazs, to_date(''01014999'',''ddmmyyyy'')) >= to_date(:dat_ ,''dd.mm.yyyy'')
          and rtrim(substr(replace(a.branch||''/'',''//'',''/000000/''),1,instr(replace(a.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
    group by b.branch
) sss
where s.branch = ss.branch and s.branch = sss.branch(+) and s.branch = ss_o.branch(+)
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
