prompt ===================================== 
prompt == СДЗ та кіль-ть відкр./закр. рах. 2610,2615,2651,2652,2546
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
   l_zpr.name := 'СДЗ та кіль-ть відкр./закр. рах. 2610,2615,2651,2652,2546';
   l_zpr.pkey := '\BRS\SBR\DPT\125';

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
    l_zpr.name         := 'СДЗ та кіль-ть відкр./закр. рах. 2610,2615,2651,2652,2546';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY) :'',:zDate31=''Дата по(DD.MM.YYYY) :'',:nbs=''Бал.рахунки (пусто - всі, ВВВВ,ВВВВ...- окремі):'',:kv=''Валюта (0 або пусто - всі, 1 - всі крім UAH, ККК - код вал.)
 :'',:indcode=''Код ЗКПО :'',:BUSSL=''Сегм.кл.: (пусто, 0 -всі;1-ДКБ;2-ММСБ;3-б.о.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':nbs=''2610,2615,2651,2652''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 
     case when (substr(x1.branch,9,6)=''000000'' or substr(x1.branch,9,6) is NULL) then ''ГУ по м. Києву та обл.''
          when  substr(x1.branch,9,6)=''000001'' then ''Голосіївське''
          when  substr(x1.branch,9,6)=''000020'' then ''Днiпровське''
          when  substr(x1.branch,9,6)=''000045'' then ''Дарницьке''
          when  substr(x1.branch,9,6)=''000066'' then ''Деснянське''
          when  substr(x1.branch,9,6)=''000084'' then ''Солом"янське''
          when  substr(x1.branch,9,6)=''000104'' then ''Подiльське''
          when  substr(x1.branch,9,6)=''000124'' then ''Святошинське''
          when  substr(x1.branch,9,6)=''000143'' then ''Оболонське''
          when  substr(x1.branch,9,6)=''000159'' then ''Шевченкiвське''
          when  substr(x1.branch,9,6)=''000187'' then ''Печерське''
          when  substr(x1.branch,9,6)=''000538'' then ''Обухiвське''
          when  substr(x1.branch,9,6)=''000559'' then ''Іванкiвське''
          when  substr(x1.branch,9,6)=''000583'' then ''Рокитнянське''
          when  substr(x1.branch,9,6)=''000594'' then ''Яготинське''
          when  substr(x1.branch,9,6)=''000614'' then ''Кагарлицьке''
          when  substr(x1.branch,9,6)=''000638'' then ''Богуславське''
          when  substr(x1.branch,9,6)=''000657'' then (case when substr(x1.branch,16,6)=''000668'' then ''Фастiвське (Сквира)'' else ''Фастiвське'' end) 
          when  substr(x1.branch,9,6)=''000671'' then (case when substr(x1.branch,16,6)=''000638'' then ''Миронiвське (Богуслав)'' else ''Миронiвське'' end)
          when  substr(x1.branch,9,6)=''000688'' then ''Василькiвське''
          when  substr(x1.branch,9,6)=''000712'' then ''Ірпiнське''
          when  substr(x1.branch,9,6)=''000726'' then (case when substr(x1.branch,16,6)=''000559'' then ''Вишгородське (Іванків)'' else ''Вишгородське'' end)
          when  substr(x1.branch,9,6)=''000741'' then ''Броварське''
          when  substr(x1.branch,9,6)=''000773'' then ''Макарiвське''
          when  substr(x1.branch,9,6)=''000790'' then ''Бородянське''
          when  substr(x1.branch,9,6)=''000805'' then ''Тетiївське''
          when  substr(x1.branch,9,6)=''000830'' then ''К-Святошинське''
          when  substr(x1.branch,9,6)=''000849'' then ''П-Хмельницьке''
          when  substr(x1.branch,9,6)=''000877'' then (case when substr(x1.branch,16,6)=''000583'' then ''Білоцеркiвське (Рокитне)'' 
                                                          when substr(x1.branch,16,6)=''000898'' then ''Білоцеркiвське (Володарка)'' else ''Білоцеркiвське'' end)
          when  substr(x1.branch,9,6)=''000901'' then (case when substr(x1.branch,16,6)=''000916'' then ''Бориспiльське (Баришівка)'' else ''Бориспiльське'' end)
          else ''''
     end as Name_TVBV    
     , x1.branch as KOD_TVBV, x1.TIP, x1.obl
     , nvl(sum(x2.sd_ost),0) as sd_ost
     , count(x2.nbs) as COUNT_NLS
     , sum(case when x2.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate31,''dd.mm.yyyy'') then 1 else 0 end) as Open_NLS
     , sum(case when x2.dazs between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate31,''dd.mm.yyyy'') then 1 else 0 end) as Close_NLS

from (       
select b.branch, b.description as TIP, b.obl
from branch b
where b.date_closed is NULL and b.branch<>''/'' and nvl(b.description,''0'')<>''4''
group by b.branch,  b.description, b.obl
order by b.branch ) x1 left join 

(
select a.branch, a.nbs, a.daos, a.dazs, a.nls
    , nvl(round((select sum(case when fost(a2.acc,c.caldt_date)<0 then 0 else fost(a2.acc,c.caldt_date)
                                                                   *nvl((select rate_o/bsum as kf 
                                                                         from cur_rates$base 
                                                                         where kv=a2.kv and branch=a2.branch
                                                                           and vdate=c.caldt_date
                                                                         ),1)
                                                                   /100 
                 end)
      /(to_date(:zDate31,''dd.mm';
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
