prompt ===================================== 
prompt == Сума резерву по фіз. особам
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
   l_zpr.name := 'Сума резерву по фіз. особам';
   l_zpr.pkey := '\BRS\SBM\REZ\13';

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
    l_zpr.name         := 'Сума резерву по фіз. особам';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat=''Дата розрахунку'',:p_curr=''Валюта''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_curr=''980''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select branch "Відділення",
       br_name "Назва",
       sum(sm_1)/100 "Стандартні",
       sum(sm_2)/100  "Під_контролем",
       sum(sm_2i)/100  "Під_контролем_Іп",
       sum(sm_3)/100  "Субстандартні",
        sum(sm_3i)/100  "Субстандартні_Іп",
       sum(sm_4)/100  "Сумнівні",
       sum(sm_4i)/100  "Сумнівні_Іп",
       sum(sm_5)/100  "Безнадійні",
       sum(sm_5i)/100  "Безнадійні_Іп",
       sum(sm_2+sm_3+sm_4+sm_5+sm_2i+sm_3i+sm_4i+sm_5i)/100  "РАЗОМ_НЕСТАНДартні",
       sum(sm_1+sm_2+sm_3+sm_4+sm_5+sm_2i+sm_3i+sm_4i+sm_5i)/100  "ВСЬОГО"
from(           
    select b.branch,
           b.name br_name,
           sum(decode(t.s080||t.ipoteka,''10'',t.sm,0)) sm_1,
           sum(decode(t.s080||t.ipoteka,''20'',t.sm,0)) sm_2,
           sum(decode(t.s080||t.ipoteka,''30'',t.sm,0)) sm_3,
           sum(decode(t.s080||t.ipoteka,''40'',t.sm,0)) sm_4,
           sum(decode(t.s080||t.ipoteka,''50'',t.sm,0)) sm_5,
           sum(decode(t.s080||t.ipoteka,''11'',t.sm,0)) sm_1i,
           sum(decode(t.s080||t.ipoteka,''21'',t.sm,0)) sm_2i,
           sum(decode(t.s080||t.ipoteka,''31'',t.sm,0)) sm_3i,
           sum(decode(t.s080||t.ipoteka,''41'',t.sm,0)) sm_4i,
           sum(decode(t.s080||t.ipoteka,''51'',t.sm,0)) sm_5i
    from
    ( select r.tobo branch,  r.s080, r.kv,
               decode(decode(s080,1,1,2)||:p_curr,
                      ''2980'', decode(substr(r.nls,1,4),''2233'',1,0), 
                      0) ipoteka,
               NVL(SUM(NVL(r.sz1, r.sz)), 0) sm       
        from tmp_rez_risk r
        where dat = :sFdat and  id = user_id
              and r.s080 <> 9 and r.CUSTTYPE = 3
              and r.kv = :p_curr
              and r.nls not like ''9%''
        group by r.tobo , r.s080, r.kv,decode(decode(s080,1,1,2)||:p_curr,
                      ''2980'', decode(substr(r.nls,1,4),''2233'',1,0), 
                      0)
    ) t,
    branch b
    where rtrim(substr(replace(t.branch||''/'',''//'',''/000000/''),1,instr(replace(t.branch||''/'',''//'',''/000000/''),''/'',1,3)-1),''/'')||''/'' = b.branch
    group by 
           b.branch ,
           b.name 
) 
group by grouping sets
((branch ,br_name),
 ()
)      
order by branch';
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
