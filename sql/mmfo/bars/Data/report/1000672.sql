prompt ===================================== 
prompt == Звіт про формування резерву за доходами (в розрізіі RNK)
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
   l_zpr.name := 'Звіт про формування резерву за доходами (в розрізіі RNK)';
   l_zpr.pkey := '\OLD\SBM\OTC\4009';

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
    l_zpr.name         := 'Звіт про формування резерву за доходами (в розрізіі RNK)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':dat_=''Дата розрахунку'',:p_user=''Виконавець''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'rez.p_unload_data; p_fb8(to_date(:dat_ ,''dd.mm.yyyy''));commit';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := ':p_user=''STAFF|ID|FIO| ORDER BY FIO''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select s.rnk "Код_контрагента", 
       s.nmk "Назва",   
       sum(s.sm) "Усього", sum(s.sm_before30) "Проср_до_Зl", sum(s.sm_after30) "Проср_понад_Зl", 
       sum(s.sm_before60) "Сумн_вн_", sum(s.sm_after180) "Осн_борг_проср", 
       sum(s.sm_30_60_180) "Разом", sum(ss.szq) "Резерв_розрах",
       sum(sss.rest) "Резерв_факт", sum(ss.szq-sss.rest) "В_дхилення",       
       sum(s.sm_3579) "Усього", sum(s.sm_before30_3579) "Проср_до_Зl", sum(s.sm_after30_3579) "Проср_понад_Зl", 
       sum(s.sm_before60_3579) "Сумн_вн_", sum(s.sm_after180_3579) "Осн_борг_проср", 
       sum(s.sm_30_60_180_3579) "Разом", sum(ss.szq_3579) "Резерв_розрах",
       sum(sss.rest_3579) "Резерв_факт", sum(ss.szq_3579-sss.rest_3579) "В_дхилення",       
       sum(s.sm_all) "Усього", sum(s.sm_before30_all) "Проср_до_Зl", sum(s.sm_after30_all) "Проср_понад_Зl", 
       sum(s.sm_before60_all) "Сумн_вн_", sum(s.sm_after180_all) "Осн_борг_проср", 
       sum(s.sm_30_60_180_all) "Разом", sum(ss.szq_all) "Резерв_розрах",
       sum(sss.rest_3579+sss.rest) "Резерв_факт", sum(ss.szq_all-sss.rest-sss.rest_3579) "В_дхилення"
       ,sum(ss.sm_jur) "Резерв_розрах_ЮР",sum(ss_o.sm_jur_old) "Попер_Рез_розр_ЮР"
       ,sum(ss.sm_jur)-sum(ss_o.sm_jur_old) "Р_ЗНИЦЯ_ЮР"
       ,sum(ss.sm_phys) "Резерв_розрах_Ф_З",sum(ss_o.sm_phys_old) "Попер_Рез_розр_Ф_З" 
       ,sum(ss.sm_phys) - sum(ss_o.sm_phys_old)  "Р_ЗНИЦЯ_Ф_З"    
from
(select RNK, 
       nmk,    
       sum(decode(pr,40, sm, 0)) sm_before30,
       sum(decode(pr,50, sm, 0)) sm_after30,
       sum(decode(pr,60, sm, 0)) sm_before60,
       sum(decode(pr,70, sm, 0)) sm_after180,
       sum(decode(pr,50, sm, 60, sm, 70, sm, 0)) sm_30_60_180,
       sum(decode(pr,40, sm,50, sm, 60, sm, 70, sm, 0)) sm,
       sum(decode(pr,41, sm, 0)) sm_before30_3579,
       sum(decode(pr,51, sm, 0)) sm_after30_3579,
       sum(decode(pr,61, sm, 0)) sm_before60_3579,
       sum(decode(pr,71, sm, 0)) sm_after180_3579,
       sum(decode(pr,51, sm, 61, sm, 71, sm, 0)) sm_30_60_180_3579,  
       sum(decode(pr,41, sm,51, sm, 61, sm, 71, sm, 0)) sm_3579,
       sum(decode(pr,40, sm, 41, sm, 0)) sm_before30_all,
       sum(decode(pr,50, sm, 51, sm,0)) sm_after30_all,
       sum(decode(pr,60, sm, 61, sm, 0)) sm_before60_all,
       sum(decode(pr,70, sm, 71, sm, 0)) sm_after180_all,
       sum(decode(pr,40, 0, 41, 0,  sm)) sm_30_60_180_all,                    
       sum(sm) sm_all       
from
(select b.rnk, 
       b.nmk nmk, 
       substr(r.nls,4,1) nls4, 
       replace(substr(kodp,6,1),''4'',''3'') r013, 
       substr(kodp,7,2) s270, sum(r.znap)/100 sm,
            (case when substr(kodp,7,2) = ''08'' then
                      (case when substr(r.nls,4,1)=''8'' or substr(r.nls,1,4) in (''2607'', ''2627'', ''3570'') 
                                  then 7 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''3''
                                                    then 6 else 7
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
                                                          then 7 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''2''
                                                                            then 5 else 4
                                                                       end)
                                                     end)
                                   end)
                       end)    
               end)*10 + decode(a.nbs,''3570'',1,''3578'',1,0) pr 
             ,sum(sum(r.znap)) over() sm_30_60_180_all    
     from rnbu_trace r, accounts a, customer b
     where r.nls = a.nls and r.kv = a.kv and r.kodp like ''1%''and 
           ( ((substr(r.nls,4,1) = ''8'' or 
               substr(r.nls,1,4) in (''3570'',''2607'',''2627'')) and (substr(r.kodp,7,2) = ''08'' or 
                                                                 substr(r.kodp,9,1)=''J'') )
             or 
             (substr(r.nls,4,1) = ''9'')
           )
           and
           a.rnk = b.rnk 
 group by b.rnk, b.nmk, substr(r.nls,4,1), replace(substr(kodp,6,1),''4'',''3''), 
            substr(kodp,7,2), 
            (case when substr(kodp,7,2) = ''08'' then
                      (case when substr(r.nls,4,1)=''8'' or substr(r.nls,1,4) in (''2607'', ''2627'', ''3570'') 
                                  then 7 
                            else (case when replace(substr(kodp,6,1),''4'',''3'') = ''3''
                                       then 6 else 7
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
                                                          then 7 else (case when replace(substr(kodp,6,1),''4'',''3'') = ''2''
                                                                            then 5 else 4
                                                                       end)
                                                     end)
                                   end)
                       end)    
               end), decode(a.nbs,''3570'',1,''3578'',1,0) )
group by rnk, nmk
) s,
(select rnk, sum(decode(pr,0,szq,0)) szq, sum(decode(pr,1,szq,0)) szq_3579, sum(szq) szq_all, 
        sum(decode(pr,0,sm_jur,0)) sm_jur, sum(decode(pr,0,sm_phys,0)) sm_phys 
 from
    ( select b.rnk, b.nmk nmk,sum(szq)/100 szq,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) pr 
             ,sum(decode(r.custtype,2,szq/100,0)) sm_jur 
             ,sum(decode(r.custtype,3,szq/100,0)) sm_phys
      from tmp_rez_risk r, customer b
      where r.s080 = 9 and r.dat = to_date(:dat_ ,''dd.mm.yyyy'') and r.id = nvl(:p_user, user_id)
          and r.rnk = b.rnk
      group by b.rnk, b.nmk,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) 
    )
 group by rnk                
) ss,
(select rnk, 
        sum(decode(pr,0,sm_jur_old,0)) sm_jur_old, sum(decode(pr,0,sm_phys_old,0)) sm_phys_old 
 from
    ( select b.rnk, b.nmk nmk,sum(szq)/100 szq,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) pr 
             ,sum(decode(r.custtype,2,gl.p_icurval(r.kv, sz, to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) sm_jur_old 
             ,sum(decode(r.custtype,3,gl.p_icurval(r.kv, sz, to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) sm_phys_old 
      from tmp_rez_risk r, customer b
      where r.s080 = 9 and 
            (r.id, r.dat) =(select userid, dat
                            from rez_protocol
                            where ''01.''||to_char(dat,''mm.yyyy'') = ''01.''||to_char(add_months(to_date(:dat_ ,''dd.mm.yyyy''),-1),''mm.yyyy'')
                            ) 
          and r.rnk = b.rnk
      group by b.rnk, b.nmk,decode(substr(r.nls,1,4),''3570'',1,''3578'',1,0) 
    )
 group by rnk                
) ss_o,
(select  b.rnk, sum(decode(a.nbs,''2400'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest,
                 sum(decode(a.nbs,''3599'', gl.p_icurval (a.kv, (rez.ostc96 (a.acc, to_date(:dat_ ,''dd.mm.yyyy''))), to_date(:dat_ ,''dd.mm.yyyy''))/100,0)) rest_3579
    from accounts a, specparam_int s, customer b
    where a.nbs in (''2400'',''3599'') and a.acc = s.acc and
          ((a.nbs = ''2400'' and s.ob22 not in (''04'',''05'',''34'',''03'',''09'',''07'',''06'',''10'',''08'',''35'')) or
           (a.nbs = ''3599'' )
          ) 
          and nvl(a.dazs, to_date(''01014999'',''ddmmyyyy'')) >= to_date(:dat_ ,''dd.mm.yyyy'')
          and a.rnk = b.rnk
    group by b.rnk
) sss
where s.rnk = ss.rnk(+) and s.rnk = sss.rnk(+) and s.rnk = ss_o.rnk(+)
group by grouping sets
((s.rnk, s.nmk),
()
)
order by 1 nulls last';
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
