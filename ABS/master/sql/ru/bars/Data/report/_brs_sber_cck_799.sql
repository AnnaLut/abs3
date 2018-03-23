prompt ===================================== 
prompt == Фактичний реєстр клієнтів із залученням компенсаційних програм
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
   l_zpr.name := 'Фактичний реєстр клієнтів із залученням компенсаційних програм';

   l_zpr.pkey := '\BRS\SBER\CCK\799';

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
    l_zpr.name         := 'Фактичний реєстр клієнтів із залученням компенсаційних програм';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На:''';
    l_zpr.create_stmt  := '';    l_zpr.rpt_template := 'CCK795.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select rownum as rn,
       c.nmk,
       c.okpo,
       (select txt from sb_ob22 where r020||ob22 = substr(D.PROD,1,6)) as ob22,
       (select ''Номер ''||d.cc_id from dual) as num,
       (select ''Дата ''||to_date(d.DSDATE, ''dd/MM/yyyy'') from dual) as dat,
       d.dwdate as moun,
       to_number(d.sdog) as sum,
       d.pr,
       case  when cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then  cck_app.Get_ND_TXT(d.nd,''SQBA4'')  
             when cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then  cck_app.Get_ND_TXT(d.nd,''SQCA4'') 
             when cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then  cck_app.Get_ND_TXT(d.nd,''SQDA4'') end countcom,
       case  when cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then       
                                          ( select fost ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SS''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/-100 from dual)
             when cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then
                                          ( select fost ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SS''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/-100 from dual)
             when cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then
                                          ( select fost ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SS''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/-100 from dual)  end sumost,
       case  when cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then       
                                          ( select fdos ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SN''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),TRUNC(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''MM''), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/100 from dual) * to_number(cck_app.Get_ND_TXT(d.nd,''SQBA4''))/to_number(d.pr)
             when cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then
                                          ( select fdos ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SN''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),TRUNC(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''MM''), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/100 from dual) * to_number(cck_app.Get_ND_TXT(d.nd,''SQCA4''))/to_number(d.pr) 
             when cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then
                                          ( select fdos ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SN''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),TRUNC(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''MM''), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/100 from dual) * to_number(cck_app.Get_ND_TXT(d.nd,''SQCA4''))/to_number(d.pr) end sumproc,
       case  when cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then  (select fdos ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SN''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),TRUNC(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''MM''), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/100 from dual) 
             when cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then (select fdos ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SN''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),TRUNC(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''MM''), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/100 from dual)
             when cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then  (select fdos ((select na.acc 
                                         from nd_acc na, accounts a 
                                           where 
                                            a.tip = ''SN''
                                           and na.nd = d.nd 
                                           and na.acc = a.acc),TRUNC(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''MM''), trunc(LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))))/100 from dual) end sumprocmou,
         case when d.DSDATE  BETWEEN trunc(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1), ''mon'') and LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))
                then LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1)) - d.DSDATE
                else
                extract(DAY from LAST_DAY(add_months(to_date(:sFdat1,''dd/MM/yyyy''),-1))) end days,       
       (select a.nls 
                    from nd_acc na, accounts a
                    where a.nbs in (''2620'',''2625'')
                    and a.dazs is null
                    and na.nd = d.nd
                    and na.acc = a.acc
                    and rownum = 1) as pnls,
       (select NAME from branch where branch = d.branch) as ru,
       nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQBA3'') and cck_app.Get_ND_TXT(d.nd,''SQBA3'')=1 and  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
       nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQCA3'')and cck_app.Get_ND_TXT(d.nd,''SQCA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
       (select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQDA3'')and cck_app.Get_ND_TXT(d.nd,''SQDA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'') typecom,
       case when  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQBA1'')
            when  cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQCA1'')
            when  cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQDA1'')
            end zalcom,
       case when  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQBA2'')
            when  cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQCA2'')
            when  cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQDA2'')
            end LOCALITY
 from cc_v d, customer c 
 where 
        substr(d.prod,1,6) in (''220256'',''220257'',''220258'',''220346'',''220347'',''220348'')
        and d.sos in (10,11,13,15)
        and d.rnk = c.rnk
        and (cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' or
             cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' or
             cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'') 
        and (cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 or
             cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 or
             cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 )
        and cck_app.Get_ND_TXT(d.nd,''SQAPR'') = 1
        and (select nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQBA3'') and cck_app.Get_ND_TXT(d.nd,''SQBA3'')=1 and  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
             nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQCA3'')and cck_app.Get_ND_TXT(d.nd,''SQCA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
            (select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQDA3'')and cck_app.Get_ND_TXT(d.nd,''SQDA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'') from dual)  is not null';
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
