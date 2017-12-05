prompt ===================================== 
prompt == БПК. зарплатний кредитний портфель
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
   l_zpr.name := 'БПК. зарплатний кредитний портфель';
   l_zpr.pkey := '\BRS\SBM\***\730';

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
    l_zpr.name         := 'БПК. зарплатний кредитний портфель';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select portf.branch,
       portf.kv,
       portf.kvo,
       portf.s_zagr,
       portf.s_ust,
       to_number(decode(to_char(to_date(:sFdat1, ''dd/mm/yyyy'') - 1, ''mm''),
                        ''01'',
                        plan.k2,
                        ''02'',
                        plan.k3,
                        ''03'',
                        plan.k4,
                        ''04'',
                        plan.k5,
                        ''05'',
                        plan.k6,
                        ''06'',
                        plan.k7,
                        ''07'',
                        plan.k8,
                        ''08'',
                        plan.k9,
                        ''09'',
                        plan.k10,
                        ''10'',
                        plan.k11,
                        ''11'',
                        plan.k12,
                        ''12'',
                        plan.k1,
                        plan.k1)) "plan",
       acc2625.kvo2625,
       acc2625.ost2625
  from (select t.branch,
               t.kv,
               sum(flag) kvo,
               sum(decode(t.bals, ''2203'', t.ost, 0)) s_zagr,
               sum(decode(t.bals, ''2203'', t.ost, 0)) +
               sum(decode(t.bals, ''9129'', t.ost, 0)) s_ust
          from (select ttt.branch,
                       ttt.kv,
                       ttt.bals,
                       abs(fost(a1.acc, to_date(:sFdat1, ''dd.mm.yyyy'') - 1) / 100) ost,
                       decode(ttt.bals, ''9129'', 1, 0) flag
                  from (select substr(a.branch, 1, 15) branch,
                               a.kv,
                               w.acc_pk,
                               ''9129'' bals,
                               w.acc_9129 acc
                          from accounts a, w4_acc w
                         where a.nbs = 9129
                           and a.ob22 in (''28'', ''29'', ''22'', ''25'', ''23'')
                           and (a.dazs is null or a.dazs >= :sFdat1)
                           and a.daos < :sFdat1
                           and a.acc = w.acc_9129
                        union all
                        select substr(a.branch, 1, 15) branch,
                               a.kv,
                               w.acc_pk,
                               ''2203'' bals,
                               nvl(w.acc_2203, a.acc) acc
                          from accounts a, w4_acc w
                         where a.nbs = 2203
                           and ob22 in (''36'', ''39'', ''43'', ''40'', ''37'', ''70'')
                           and (a.dazs is null or a.dazs >= :sFdat1)
                           and a.daos < :sFdat1
                           and a.acc = w.acc_2203(+)
                        union all
                        select substr(a.branch, 1, 15) branch,
                               a.kv,
                               w.acc_pk,
                               ''9129'' bals,
                               w.acc_9129 acc
                          from accounts a, bpk_acc w, specparam_int s
                         where (a.nbs = 9129 and a.ob22 in (''05'', ''07'', ''25''))
                           and (a.dazs is null or a.dazs >= :sFdat1)
                           and a.daos < :sFdat1
                           and a.acc = w.acc_9129
                           and W.ACC_PK = s.acc
                           and (s.demand_kk in (''C'', ''B'', ''G'') or
                               s.demand_kk is null)
                        union all
                        select substr(a.branch, 1, 15) branch,
                               a.kv,
                               w.acc_pk,
                               ''9129'' bals,
                               w.acc_9129 acc
                          from accounts a, w4_acc w, specparam_int s
                         where (a.nbs = 9129 and
                               a.ob22 in (''05'', ''07'', ''25'', ''23''))
                           and (a.dazs is null or a.dazs >= :sFdat1)
                           and a';
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
