prompt ===================================== 
prompt == Звіт проблемні БПК
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
   l_zpr.name := 'Звіт проблемні БПК';
   l_zpr.pkey := '\BRS\SBR\DPT\310';

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
    l_zpr.name         := 'Звіт проблемні БПК';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з (DD.MM.YYYY) :'',:zDate2=''Дата по (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x.tt,
       to_date(:zDate1, ''dd.mm.yyyy'') as d1,
       to_date(:zDate2, ''dd.mm.yyyy'') as d2,
       x.nls,
       x.kv,
       x.branch,
       c.okpo,
       c.rnk,
       c.nmk,
       x.nd,
       x.dat_begin,
       x.dat_end,
       x.lim,
       abs(fost(x.acc_ovr, to_date(:zDate1, ''dd.mm.yyyy'') - 1) / 100) as ost_ovr_d1,
       abs(fost(x.acc_2207, to_date(:zDate1, ''dd.mm.yyyy'') - 1) / 100) as ost_2207_d1,
       abs(fost(x.acc_2208, to_date(:zDate1, ''dd.mm.yyyy'') - 1) / 100) as ost_2208_d1,
       abs(fost(x.acc_2209, to_date(:zDate1, ''dd.mm.yyyy'') - 1) / 100) as ost_2209_d1,
       abs(fost(x.acc_3570, to_date(:zDate1, ''dd.mm.yyyy'') - 1) / 100) as ost_3570_d1,
       abs(fost(x.acc_3579, to_date(:zDate1, ''dd.mm.yyyy'') - 1) / 100) as ost_3579_d1,
       abs(fost(x.acc_ovr, to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as ost_ovr_d2,
       abs(fost(x.acc_2207, to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as ost_2207_d2,
       abs(fost(x.acc_2208, to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as ost_2208_d2,
       abs(fost(x.acc_2209, to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as ost_2209_d2,
       abs(fost(x.acc_3570, to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as ost_3570_d2,
       abs(fost(x.acc_3579, to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as ost_3579_d2,
       (select max(n.kat)
          from nbu23_rez n
         where n.rnk = x.rnk
           and n.fdat in (select max(fdat)
                            from nbu23_rez
                           where rnk = n.rnk
                             and fdat <= add_months(TO_DATE(''01.'' ||
                                                            to_char(EXTRACT(MONTH FROM
                                                                            to_date(:zDate2,
                                                                                    ''dd.mm.yyyy''))) || ''.'' ||
                                                            to_char(EXTRACT(YEAR FROM
                                                                            to_date(:zDate2,
                                                                                    ''dd.mm.yyyy''))),
                                                            ''dd.mm.yyyy''),
                                                    1))) as kat,
       case
         when abs(fost(x.acc_2207, to_date(:zDate2, ''dd.mm.yyyy''))) <> 0 then
          nvl((select max(ca.caldt_date) as Day_pr
                from ACCM_CALENDAR ca, accounts aa
               where aa.acc = x.acc_2207
                 and ca.caldt_date between aa.daos and
                     to_date(:zDate2, ''dd.mm.yyyy'')
                 and abs(fost(aa.acc, to_date(:zDate2, ''dd.mm.yyyy''))) / 100 -
                     fdos(aa.acc,
                          ca.caldt_date,
                          to_date(:zDate2, ''dd.mm.yyyy'')) / 100 <= 0),
              a7.daos)
         else
          NULL
       end as Dat_PR_2207,
       case
         when abs(fost(x.acc_2209, to_date(:zDate2, ''dd.mm.yyyy''))) <> 0 then
          nvl((select max(ca.caldt_date) as Day_pr
                from ACCM_CALENDAR ca, accounts aa
               where aa.acc = x.acc_2209
                 and ca.caldt_date between aa.daos and
                     to_date(:zDate2, ''dd.mm.yyyy'')
                 and abs(fost(aa.acc, to_date(:zDate2, ''dd.mm.yyyy''))) / 100 -
                     fdos(aa.acc,
                          ca.caldt_date,
                          to_date(:zDate2, ''dd.mm.yyyy'')) / 100 <= 0),
              a9.daos)
         else
          NULL
       end as Dat_PR_2209,
       abs(fkos(x.acc_ovr,
                to_date(:zDate1, ''dd.mm.yyyy''),
                to_date(:zDate2, ''dd.mm.yyyy'')) / 100) +
       abs(fkos(x.acc_2207,
                to_date(:zDate1, ''dd.mm.yyyy''),
                to_date(:zDate2, ''dd.mm.yyyy'')) / 100) as KOS_KRD,
       nvl(k3.pog_krd, 0) as pog_krd,
       a7.nls as nls_2207,
       abs(fkos(x.acc_2208,
                to_date(:zDate1, ''dd.mm.yyyy''),
                to_date(:zDate2, ';
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
