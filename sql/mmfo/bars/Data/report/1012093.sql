prompt ===================================== 
prompt == Інф про залишки на поточних та строкових рах фіз осіб-пов_яз стор
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
   l_zpr.name := 'Інф про залишки на поточних та строкових рах фіз осіб-пов_яз стор';
   l_zpr.pkey := '\BRS\SBER\***\545';

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
    l_zpr.name         := 'Інф про залишки на поточних та строкових рах фіз осіб-пов_яз стор';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'INF_545.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select b.nb, 
       a.kf,
       a.branch,
       c.nmk,
       c.okpo,
       a.nbs,
       a.nls,
       w.nd,
       w.datz, 
       w.dat_end, 
       a.kv,
       case when a.nbs in (''2620'',''2630'')
              then dpt.FPROC(a.acc, :sFdat2)
            when a.nbs = ''2625''
              then get_int_rate(a.acc, :sFdat2)
       end rate,
       fostq(a.acc, :sFdat2)/100 ssum1,
       (select nvl(sum(sq),0)/100 
          from opldok 
         where fdat = :sFdat2 
           and acc = w.acra 
           and tt in (''%%1'',''%15'', ''MIL'') 
           and dk = 1) ssum2,
       (select nvl(sum(sq),0)/100 
          from opldok 
         where (fdat, acc) in (select fdat, acc from saldoa where acc=w.acra and fdat between :sFdat1 and :sFdat2) 
           and acc = w.acra 
           and tt in (''%%1'',''%15'', ''MIL'') 
           and dk = 1) ssum3,
       (select nvl(sum(o1.sq),0)/100
          from opldok o1, opldok o2, accounts a1
         where (o1.fdat, o1.acc) in (select fdat, acc from saldoa where acc=a.acc and fdat between :sFdat1 and :sFdat2) 
           and o1.acc = a.acc 
           and o1.dk = 0
           and o1.ref = o2.ref 
           and o1.stmt = o2.stmt 
           and o2.dk = 1
           and o2.acc = a1.acc
           and a1.nls like ''6%'') ssum4,
       case when a.nbs in (''2620'',''2625'') then (select nvl(sum(o1.sq),0)/100
                                              from opldok o1, opldok o2, accounts a1
                                             where (o1.fdat, o1.acc) in (select fdat, acc from saldoa where acc=a.acc and fdat between :sFdat1 and :sFdat2) 
                                               and o1.acc = a.acc 
                                               and o1.dk = 1 
                                               and o1.ref = o2.ref 
                                               and o1.stmt = o2.stmt 
                                               and o2.dk = 0
                                               and o2.acc = a1.acc
                                               and a1.nls like ''7%'') 
            else 0 end ssum5,
       case when c.prinsider = 2 then ''Так'' else ''Ні'' end lead_pers
  from customer c, accounts a,
       (select acc_pk acc, to_char(nd) nd, acc_2628 acra, dat_begin datz, dat_end
          from w4_acc
         union all
        select b.acc_pk acc, to_char(b.nd) nd, i1.acra, null datz, null dat_end
          from bpk_acc b left join int_accn i1 on b.acc_pk = i1.acc and i1.id = 0
         union all
         select d.acc, d.nd, i1.acra, d.datz, d.dat_end
           from dpt_deposit d, int_accn i1
          where d.acc = i1.acc
            and i1.id = 1
        ) w,
        banks$base b        
 where c.prinsider in (1,2,3,4,5)
   and c.rnk = a.rnk
   and a.nbs in (2620,2625,2630) 
   and a.daos <= :sFdat2 
   and (a.dazs is null or a.dazs > :sFdat2)
   and a.acc = w.acc(+)
   and a.kf = b.mfo';
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
