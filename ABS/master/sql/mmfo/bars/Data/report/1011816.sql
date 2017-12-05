prompt ===================================== 
prompt == Звіт про операції з корпоративними клієнтами
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
   l_zpr.name := 'Звіт про операції з корпоративними клієнтами';
   l_zpr.pkey := '\BRS\SBER\***\543';

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
    l_zpr.name         := 'Звіт про операції з корпоративними клієнтами';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата с'',:sFdat2=''Дата по''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'REE_543.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''Перший день звітного періоду'' dat1,
       ''Останній день звітного періоду'' dat2,
       ''Код безбалансового відділення'' barnch,
       ''Тип платежу (вхідний/вихідний)'' type,
       ''Сума платежу, грн. екв.'' sq,
       ''Назва власника рахунку'' nmku,
       ''ЄДРПОУ власника рахунку'' okpo,
       ''РНК власника  рахунку'' rnk,
       ''Назва контрагента'' nam,
       ''ЄДРПОУ контрагента'' okpo_k,
       ''РНК контрагента'' rnk_k,
       ''Баланс. рахунок'' nbs,
       ''Особовий номер рахунку'' nls,
       ''Валюта'' kv,
       ''Назва рахунку'' nms,
       ''Код банківської операції'' tt,
       ''Назва операції'' tt_name,
       ''Призначення платежу'' nazn
  from dual 
 union all 
select :sFdat1 dat1,
       :sFdat2 dat2,
       a.branch,
       o.type,
       (SELECT to_char(p.sq/100,''9999999999990.99'')
          FROM opldok p
         WHERE p.REF = o.REF
           AND rownum = 1) sq,
       c.nmku,
       (select s.okpo from customer s where s.rnk = c.rnk) okpo,
       to_char(c.rnk) rnk,
       o.nam,
       o.okpo_k,
       (select to_char(a1.rnk) from accounts a1 where a1.nls = o.nlsa and a1.kv = o.kv) rnk_k,
       a.nbs,
       a.nls,
       to_char(a.kv) kv,
       a.nms,
       o.tt,
       (select t.name from tts t where t.tt = o.tt) tt_name,
       o.nazn
  from corps c, accounts a, (select o1.ref, ''Вхідний'' type, o1.s, o1.nlsa, o1.nlsb, o1.nam_a nam, o1.id_a okpo_k, o1.kv, o1.tt, o1.nazn
                                           from oper o1
                                         where o1.pdat between :sFdat1 and :sFdat2 and o1.tt <> ''МГР'' and o1.sos = 5
                                          union all
                                         select o2.ref, ''Вихідний'' type, o2.s, o2.nlsb nlsa, o2.nlsa nlsb, o2.nam_b nam, o2.id_b okpo_k, o2.kv, o2.tt, o2.nazn
                                           from oper o2
                                         where o2.pdat between :sFdat1 and :sFdat2 and o2.tt <> ''МГР'' and o2.sos = 5) o 
where c.rnk=a.rnk
    and a.nbs in (2020, 2028, 2030, 2038, 2062, 2063, 2068, 2071, 2078, 2083, 2088, 2103, 2108, 2512, 2513, 2520, 2523, 2525, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2546, 2552, 2553, 2554, 2555, 2560, 2561, 2562, 2565, 2570, 2571, 2572, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2610, 2640, 2641, 2642, 2643, 2644, 2650, 2651)
    and a.daos <= :sFdat2 and (a.dazs is null or a.dazs >=  :sFdat1)
    and o.nlsb = a.nls and o.kv = a.kv';
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
