prompt ===================================== 
prompt == Звіт про зміни в статистичній звітності по  BRANCHу
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
   l_zpr.name := 'Звіт про зміни в статистичній звітності по  BRANCHу';
   l_zpr.pkey := '\BRS\SBM\DPT\202';

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
    l_zpr.name         := 'Звіт про зміни в статистичній звітності по  BRANCHу';
    l_zpr.namef        := '16_rahun';
    l_zpr.bindvars     := ':Param0=''Дата'',:BRANCH=''Відділення''';
    l_zpr.create_stmt  := 'KU NUMBER(2), REGION CHAR(15),'||nlchr||
                           'Fizpot_NV NUMBER(8),'||nlchr||
                           'Fizpot_N NUMBER(8),'||nlchr||
                           'Pens_20V NUMBER(8),'||nlchr||
                           'Pens_2LI NUMBER(8),'||nlchr||
                           'Fizpot_IN NUMBER(8),'||nlchr||
                           'Kart_NV NUMBER(8),'||nlchr||
                           'Kart_IN NUMBER(8),'||nlchr||
                           'Fizstr_NV NUMBER(8),'||nlchr||
                           'Fizstr_N NUMBER(8),'||nlchr||
                           'Fizstr_IN NUMBER(8)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''Поточне''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT 16 KU,''Рiвненська фiл.'' REGION ,
            max(UAH_2620)Fizpot_NV, max(NER_2620)Fizpot_N,   
            max(PV_2620) Pens_20V,  max(PEN_2620)Pens_2LI,
            max(VAL_2620)Fizpot_IN, max(VAL_2625)Kart_NV,
            max(UAH_2625)Kart_IN,   max(UAH_263) Fizstr_NV,
            max(NER_263) Fizstr_N,  max(VAL_263) Fizstr_IN
from (select DAT,decode (kod,1,kol,0) UAH_2620, decode (kod,2,kol,0) NER_2620,   
                 decode (kod,3,kol,0) PV_2620,  decode (kod,4,kol,0) PEN_2620,
                 decode (kod,5,kol,0) VAL_2620, decode (kod,6,kol,0) VAL_2625,
                 decode (kod,7,kol,0) UAH_2625, decode (kod,8,kol,0) UAH_263,     
                 decode (kod,9,kol,0) NER_263,  decode (kod,10,kol,0) VAL_263
      FROM ( SELECT  KOD , SUM(KOL)KOL, DAT 
              FROM (select nbs NBS, decode(nbs,''2620'', decode(kv, 980, 1, 5), 
                                               ''2625'', decode(kv, 980, 6, 7),
                                               ''2630'', decode(kv, 980, 8, 10)
                                           )KOD, count(*) KOL,:Param0 DAT
                      from accounts   
                     where branch like ''%'' || :BRANCH ||''%''  
                       and nbs in (''2620'', ''2625'', ''2630'') 
                       and (dazs is null or dazs > to_date(:Param0,''dd.mm.yyyy'')) 
                     group by nbs, decode(kv, 980, 1, 0),decode(nbs,''2620'', decode(kv, 980, 1, 5), 
                                                               ''2625'', decode(kv, 980, 6, 7),
                                                               ''2630'', decode(kv, 980, 8, 10))  
                    union all
                   select nbs , decode(i.ob22, ''08'', 2, ''09'', 2, ''11'', 2, ''12'',2,''20'',3,''21'',4) ,
                          count(*) ,:Param0 DAT
                     from accounts a, specparam_int i
                    where a.branch like ''%'' || :BRANCH ||''%''  
                      and a.nbs  = ''2620''
                      and a.acc  = i.acc
                      and (a.dazs is null or a.dazs > to_date(:Param0,''dd.mm.yyyy''))
                      and i.ob22 in (''08'', ''09'', ''11'', ''12'', ''20'', ''21'') 
                    group by nbs, decode(i.ob22, ''08'', 2, ''09'', 2, ''11'', 2, ''12'',2,''20'',3,''21'',4) 
                    union all 
                   select nbs , 9 , count(*) ,:Param0 DAT
                     from accounts a, specparam_int i
                    where a.branch like ''%'' || :BRANCH ||''%''
                      and a.nbs  = ''2630'' and i.ob22 in (''11'', ''12'', ''13'', ''14'',''B6'',''B7'',''B8'',''B9'') 
                      and a.acc  = i.acc
                      and (a.dazs is null or a.dazs > to_date(:Param0,''dd.mm.yyyy''))
                    group by nbs
                ) group by  KOD, DAT
                  order by 1))
group by DAT';
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
