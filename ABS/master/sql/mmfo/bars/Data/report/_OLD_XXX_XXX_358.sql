prompt ===================================== 
prompt == Акция МПС MasterCard, 2625
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
   l_zpr.name := 'Акция МПС MasterCard, 2625';
   l_zpr.pkey := '\OLD\***\***\358';

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
    l_zpr.name         := 'Акция МПС MasterCard, 2625';
    l_zpr.namef        := 'mps_master_card';
    l_zpr.bindvars     := ':date_from=''С даты'',:date_to=''По дату''';
    l_zpr.create_stmt  := 'nls varchar2(15),nms varchar2(70),'||nlchr||
                           'rnk varchar2(38),daos date,dazs date,'||nlchr||
                           'kf varchar2(6),nb varchar2(70),branch varchar2(30),'||nlchr||
                           'fio varchar2(120)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select
   a.nls, a.nms, a.rnk, a.daos, a.dazs, a.kf , b.nb,a.branch,s.fio
  from  banks$base b, staff$base s ,accounts a
 where a.nbs = ''2625''
   and a.daos between
       to_date(:date_from, ''DD.MM.YYYY'') and
       to_date(:date_to, ''DD.MM.YYYY'')
   and a.kf = b.mfo
   and a.isp = s.id
   -- в названии счета дожна быть фраза из списка ниже
   and exists(select null from (select ''STND_EUR_2_MELITPP_0'' as parameter from dual union all
                                select ''STND_EUR_2_MELITPP_1/2'' as parameter from dual union all
                                select ''STND_EUR_2_MELITPP_5000'' as parameter from dual union all
                                select ''STND_EUR_2_MPLATPP_0'' as parameter from dual union all
                                select ''STND_EUR_2_MPLATPP_1/2'' as parameter from dual union all
                                select ''STND_EUR_2_MPLATPP_1500'' as parameter from dual union all
                                select ''STND_EUR_VIP_MELITPP'' as parameter from dual union all
                                select ''STND_EUR_VIP_MELITPP_1/2'' as parameter from dual union all
                                select ''STND_EUR_VIP_MPlatPP'' as parameter from dual union all
                                select ''STND_EUR_VIP_MPlatPP_1/2'' as parameter from dual union all
                                select ''STND_UAH_8_MELITPP_0'' as parameter from dual union all
                                select ''STND_UAH_8_MELITPP_1/2'' as parameter from dual union all
                                select ''STND_UAH_8_MELITPP_5000'' as parameter from dual union all
                                select ''STND_UAH_8_MPLATPP_0'' as parameter from dual union all
                                select ''STND_UAH_8_MPLATPP_1/2'' as parameter from dual union all
                                select ''STND_UAH_8_MPLATPP_1500'' as parameter from dual union all
                                select ''STND_UAH_VIP_MELITPP'' as parameter from dual union all
                                select ''STND_UAH_VIP_MELITPP_1/2'' as parameter from dual union all
                                select ''STND_UAH_VIP_MPlatPP'' as parameter from dual union all
                                select ''STND_UAH_VIP_MPlatPP_1/2'' as parameter from dual union all
                                select ''STND_USD_2_MELITPP_0'' as parameter from dual union all
                                select ''STND_USD_2_MELITPP_1/2'' as parameter from dual union all
                                select ''STND_USD_2_MELITPP_5000'' as parameter from dual union all
                                select ''STND_USD_2_MPLATPP_0'' as parameter from dual union all
                                select ''STND_USD_2_MPLATPP_1/2'' as parameter from dual union all
                                select ''STND_USD_2_MPLATPP_1500'' as parameter from dual union all
                                select ''STND_USD_VIP_MELITPP'' as parameter from dual union all
                                select ''STND_USD_VIP_MELITPP_1/2'' as parameter from dual union all
                                select ''STND_USD_VIP_MPlatPP'' as parameter from dual union all
                                select ''STND_USD_VIP_MPlatPP_1/2'' as parameter from dual) p
                           where regexp_like(a.nms,p.parameter))
   ';
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
