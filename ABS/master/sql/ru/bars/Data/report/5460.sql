prompt ===================================== 
prompt == Звіт про кільк. рах. ЮО та держ. органів
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
   l_zpr.name := 'Звіт про кільк. рах. ЮО та держ. органів';
   l_zpr.pkey := '\BRS\SBER\***\207';

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
    l_zpr.name         := 'Звіт про кільк. рах. ЮО та держ. органів';
    l_zpr.namef        := '=(select ''ZvitAccounts''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,gl.bd), ''DMY''),1,3)||''.TXT''  from rcukru where mfo=gl.kf)';
    l_zpr.bindvars     := ':sFdat1=''Звітна дата (dd/mm/yyyy):''';
    l_zpr.create_stmt  := 'DATE_REP [10,'' '',L]; Name_RU [50,'' '',L] ; MFO_DEP  [6,'' '',R]; BRANCH [30,'' '',L]; count_05 [12,'' '',R]; count_06 [12,'' '',R] ; count_07 [12,'' '',R]; count_08 [12,'' '',R]; count_08_1 [12,'' '',R]; count_08_2 [12,'' '',R]; count_09 [12,'' '',R]; count_09_1 [12,'' '',R]; count_09_2 [12,'' '',R]; count_10 [12,'' '',R]; count_11 [12,'' '',R]; count_12 [12,'' '',R]; count_13 [12,'' '',R]; count_14 [12,'' '',R]; count_14_1 [12,'' '',R]; count_14_2 [12,'' '',R]; count_15 [12,'' '',R]; count_15_1 [12,'' '',R]; count_15_2 [12,'' '',R]; count_16 [12,'' '',R]; count_17 [12,'' '',R]; count_18 [12,'' '',R]; count_19 [12,'' '',R]; count_20 [12,'' '',R]; count_21 [12,'' '',R]; count_22 [12,'' '',R]; count_23 [12,'' '',R]; count_24 [12,'' '',R]; count_25 [12,'' '',R]; Delim=''њ''';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_char(last_day(nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))+1,''dd/mm/yyyy'') DATE_REP, 
substr(GetGlobalOption(''NAME''),1,50) Name_RU,
to_number(GL.KF,999999)  MFO_DEP   ,  
b.branch BRANCH,
nvl(
(select count(*)  from accounts where (nbs in (''2601'',''2602'',''2603'',''2604'',''2640'',''2641'',''2642'',''2643'') or ( nbs in (''2600'',''2605'') /* and fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0 */ ))
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_05,
nvl(
(select count(*)  from accounts where (nbs in (''2601'',''2602'',''2603'',''2604'',''2640'',''2641'',''2642'',''2643'') or ( nbs in (''2600'',''2605'') /*and fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0 */))
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_06,
nvl(
(select count(*)  from accounts where (nbs in (''2601'',''2602'',''2603'',''2604'',''2640'',''2641'',''2642'',''2643'') or ( nbs in (''2600'',''2605'') /*and fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0 */))
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_07,
nvl(
(select count(*)  from accounts where nbs in (''2610'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_08,
nvl(
(select count(*)  from accounts where nbs in (''2610'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_08_1,
nvl(
(select count(*)  from accounts where nbs in (''2610'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_09,
nvl(
(select count(*)  from accounts where nbs in (''2610'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_10,
nvl(
(select count(*)  from accounts where nbs in (''2650'',''2655'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_11,
nvl(
(select count(*)  from accounts where nbs in (''2650'',''2655'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_12,
nvl(
(select count(*)  from accounts where nbs in (''2650'',''2655'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_13,
nvl(
(select count(*)  from accounts where nbs in (''2651'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_14,
nvl(
(select count(*)  from accounts where nbs in (''2651'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_15,
nvl(
(select count(*)  from accounts where nbs in (''2651'')
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_16,
nvl(
(select count(*)  from accounts where nbs like  ''25%'' and nbs not in (''2546'',''2518'' ,''2528'',''2538'',''2548'',''2558'',''2568'') and not (nbs=''2525'' and  fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0) 
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_17,
nvl(
(select count(*)  from accounts where nbs like  ''25%'' and nbs not in (''2546'',''2518'' ,''2528'',''2538'',''2548'',''2558'',''2568'') and not (nbs=''2525'' and  fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0)
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_18,
nvl(
(select count(*)  from accounts where nbs like  ''25%'' and nbs not in (''2546'',''2518'' ,''2528'',''2538'',''2548'',''2558'',''2568'') and not (nbs=''2525'' and  fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0)
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_19,
nvl(
(select count(*)  from accounts where (nbs=''2546''  or  (nbs=''2525'' and  fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0)) 
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_20,
nvl(
(select count(*)  from accounts where (nbs=''2546''  or  (nbs=''2525'' and  fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0))
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_21,
nvl(
(select count(*)  from accounts where (nbs=''2546''  or  (nbs=''2525'' and  fost(acc,nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))>=0))
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_22,
nvl(
(select count(*)  from accounts where nbs=''2606'' 
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv=980
and branch=b.branch
),0) count_23,
nvl(
(select count(*)  from accounts where nbs=''2606'' 
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and kv!=980
and branch=b.branch
),0) count_24,
nvl(
(select count(*)  from accounts where nbs=''2606''
and daos<= nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd)
and (dazs is null or dazs>nvl(to_date(:sFdat1,''dd/mm/yyyy''), gl.bd))
and (blkd!=0 or blkk!=0)
and branch=b.branch
),0) count_25
from branch b
order by b.branch';
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
