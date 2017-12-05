prompt ===================================== 
prompt == Звіт про кіл-ть рах. та залишків на них по вкладам на дату 
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
   l_zpr.name := 'Звіт про кіл-ть рах. та залишків на них по вкладам на дату ';
   l_zpr.pkey := '\BRS\SBM\DPT\103';

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
    l_zpr.name         := 'Звіт про кіл-ть рах. та залишків на них по вкладам на дату ';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:BRANCH=''Відділення'',:DEP=''Вкл. підлеглі(1-Так/0-Ні)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_103.QRP';
    l_zpr.form_proc    := 'bars_accm_sync.sync_snap(''BALANCE'',to_date(:sFdat1))';
    l_zpr.default_vars := ':DEP=''1''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME|ORDER BY BRANCH''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 0 PR,
       coalesce(ps.name, ob.txt) OB22_NAME,
       s.ob22 OB22,
       a.nbs NBS,        
       nvl(decode(a.kv, 980 ,''нац.валюта'' ,''ін.валюта''),a.nbs)KV,
       count(*) CNT, sum(b.ostq) OST, 
       f_dat_lit(to_date(:sFdat1,''dd/mm/yyyy''),''U'') DAT 
  from accm_snap_balances b, accm_calendar c, 
       v_gl a, specparam_int s, sb_ob22 ob, ps 
 where b.caldt_id = c.caldt_id 
   and c.caldt_date = to_date(:sFdat1,''dd/mm/yyyy'')
   and b.acc = a.acc
   and ps.nbs =a.nbs
   and a.nbs in (2620,2625,2630)
   and a.nls like a.nbs ||''%''
   and b.acc = s.acc
   and ob.r020=a.nbs
   and ob.ob22=s.ob22
 and a.branch like decode(:BRANCH, null, sys_context(''bars_context'', ''user_branch''), :BRANCH)||decode(:DEP,''1'',''%'','''')
group by grouping sets (
(ob.txt, a.nbs, s.ob22,decode(a.kv, 980 ,''нац.валюта'' ,''ін.валюта'')),
(ps.name,a.nbs),
(ob.txt, a.nbs, s.ob22),
(ps.name,a.nbs,decode(a.kv, 980 ,''нац.валюта'' ,''ін.валюта'')))
order by a.nbs, coalesce(s.ob22,'' ''), nvl(kv,'' '')';
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
