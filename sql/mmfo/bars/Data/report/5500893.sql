prompt ===================================== 
prompt == Звіт про кількість нових депозитів
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
   l_zpr.name := 'Звіт про кількість нових депозитів';
   l_zpr.pkey := '\BRS\SBR\DPT\114';

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
    l_zpr.name         := 'Звіт про кількість нових депозитів';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':Param1=''Дата з: '',:Param0=''Дата по:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select b_all,s_all,c_all,s_new,c_new,s_renew,c_renew,s_new_dep,c_new_dep,s_all20k,c_all20k
    from ( select sum(s) s_all,b b_all ,sum(col) c_all
            from(select round(a.ostc*f_ret_rate(d.kv,d.dat_begin)/100,2) s,d.kv,substr(d.branch,1,15) b,d.DAT_BEGIN,count(*) col
                from dpt_deposit d inner join accounts a on d.acc=a.acc and a.nbs in (2630)
                                   inner join customer c on a.rnk=c.rnk                  
                where d.dat_begin between :Param1  and :Param0 and a.ostc<>0
                group by substr(d.branch,1,15),d.kv,dat_begin,a.acc,a.ostc,c.rnk,c.okpo,d.deposit_id
                order by substr(d.branch,1,15),d.kv,a.acc,a.ostc)
            group by b
            order by b) s1 
        left join 
        (select sum(s) s_new,b b_new,sum(col) c_new
            from(select round(a.ostc*f_ret_rate(d.kv,d.dat_begin)/100,2) s,d.kv,substr(d.branch,1,15) b,d.DAT_BEGIN,count(*) col
                from dpt_deposit d inner join accounts a on d.acc=a.acc and a.nbs in (2630)
                                   inner join customer c on a.rnk=c.rnk                  
                where d.dat_begin between :Param1  and :Param0 and a.ostc<>0
                        and d.rnk in (select rnk from customer where date_on between :Param1  and :Param0 )  
                        and c.okpo not in (select okpo  from customer where date_on < :Param1 and (k050 in (''000'') and custtype=3) and okpo=c.okpo )                      
                group by substr(d.branch,1,15),d.kv,dat_begin,a.acc,a.ostc,c.rnk,c.okpo,d.deposit_id
                order by substr(d.branch,1,15),d.kv,a.acc,a.ostc)
        group by b
        order by b)s2 ON b_all=b_new
        left join 
        (select sum(s) s_renew,b b_renew,sum(col) c_renew
            from(select c.rnk,c.okpo,round(a.ostc*f_ret_rate(d.kv,d.dat_begin)/100,2) s,d.kv,substr(d.branch,1,15) b,d.DAT_BEGIN,count(*) col,d.deposit_id
                from dpt_deposit d inner join accounts a on d.acc=a.acc and a.nbs in (2630)
                                   inner join customer c on a.rnk=c.rnk                 
                where d.dat_begin between :Param1  and :Param0 and a.ostc<>0
                        and c.okpo in (select okpo  from customer where date_on < :Param1 and (k050 in (''000'') and custtype=3) and okpo=c.okpo )                         
                group by substr(d.branch,1,15),d.kv,dat_begin,a.acc,a.ostc,c.rnk,c.okpo,d.deposit_id
                order by c.date_on,c.rnk,c.okpo,substr(d.branch,1,15),d.kv,a.acc,a.ostc)
        group by b
        order by b)s2 ON b_all=b_renew
        left join 
        (select sum(s) s_new_dep,b b_new_dep,sum(col) c_new_dep
            from(select round(a.ostc*f_ret_rate(d.kv,d.dat_begin)/100,2) s,d.kv,substr(d.branch,1,15) b,d.DAT_BEGIN,count(*) col
                 from dpt_deposit d inner join accounts a on d.acc=a.acc and a.nbs in (2630)
                 where d.dat_begin between :Param1  and :Param0 and a.ostc<>0
                         and d.rnk not in (select rnk from dpt_deposit where dat_begin <= :Param1 and acc in (select acc from accounts where nbs<>2620 group by acc)
                                           union all
                                           select rnk from dpt_deposit_clos where dat_end <= add_months(:Param1,-12) and acc in (select acc from accounts where nbs<>2620 group by acc)  ) 
                group by substr(d.branch,1,15),d.kv,dat_begin,a.acc,a.ostc
                order by substr(d.branch,1,15),d.kv,a.acc,a.ostc)
        group by b
        order by b)s2 ON b_all=b_new_dep                   
        left join 
        (select sum(s) s_all20k,b b_all20k,sum(col) c_all20k
        from(select round(a.ostc*f_ret_rate(d.kv,d.dat_begin)/100,2) s,d.kv,substr(d.branch,1,15) b,d.DAT_BEGIN,count(*) col
            from dpt_deposit d inner join accounts a on d.acc=a.acc and a.nbs in (2630)
                               inner join customer c on a.rnk=c.rnk              
            where d.dat_begin between :Param1  and :Param0 and a.ostc<>0
            group by substr(d.branch,1,15),d.kv,dat_begin,a.acc,a.ostc,c.rnk,c.okpo,d.deposit_id
            having round(a.ostc*f_ret_rate(d.kv,d.dat_begin)/100,2)>=20000
            order by substr(d.branch,1,15),d.kv,a.acc,a.ostc)
        group by b
        order by b)s3 ON b_all=b_all20k';
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
