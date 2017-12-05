prompt ===================================== 
prompt == Звіт за запитом – ефективна ставка
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
   l_zpr.name := 'Звіт за запитом – ефективна ставка';
   l_zpr.pkey := '\BRS\SBER\CCK\1';

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
    l_zpr.name         := 'Звіт за запитом – ефективна ставка';
    l_zpr.namef        := '=(select ''ZE''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,gl.bd), ''DMY''),1,3)||''.TXT''  from rcukru where mfo=gl.kf)';
    l_zpr.bindvars     := ':sFdat1=''Звітна дата (dd/mm/yyyy):''';
    l_zpr.create_stmt  := 'DATE_REP [10,'' '',L]; MFO_DEP  [6,'' '',R]; ZKPO_CLI [10,'' '',L]; NAME_CLI [50,'' '',L]; BAL_ACC [4,'' '',L]; NAME_ACC [50,'' '',L]; KV  [3,'' '',R]; DK  [1,'' '',L]; AMOUNT [19,'' '',L]; REF_DOG [14,'' '',R];  N_DOG  [50,'' '',L]; VID_DOG [70,'' '',L]; Stavka [12,'' '',L]; EfStavka   [12,'' '',L]; Delim=''њ''   ';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 
 nvl(:sFdat1, to_char(gl.bd,''dd/mm/yyyy'')) DATE_REP ,    
  to_number(GL.KF,999999)  MFO_DEP   ,  
  c.okpo  ZKPO_CLI  , 
  c.nmk  NAME_CLI  ,  
  to_number(a.nbs,9999)  BAL_ACC  ,   
  substr(a.nms ,1,50)  NAME_ACC ,  
  a.kv  KV      ,     
  ( case when  (select ost/100  from sal where acc=a.acc  and fdat=( select max(fdat) from sal where acc=a.acc and fdat<=nvl(to_date(:sFdat1,''dd/mm/yyyy''),gl.bd) )) <=0 then 1 else 2 end)   DK     ,         
  to_char(round( 
 (select abs(ost/100)  from sal where acc=a.acc  and fdat=( select max(fdat) from sal where acc=a.acc and fdat<=nvl(to_date(:sFdat1,''dd/mm/yyyy''),gl.bd)))  
 ,2) , ''999999999999999.99''  )   AMOUNT  ,    
  d.nd  REF_DOG  ,  
  substr(d.cc_id,1,50) N_DOG   , 
  decode( d.vidd,1,''ЮО Стандартний'',2,''ЮО Кр.лінія'',3,''ЮО МультВал Кр.лінія''  ) VID_DOG ,   
   translate( to_char( 
  (select ir  from int_ratn where acc=a.acc and id=0 and bdat=(select max(bdat) from int_ratn where id=0 and acc=a.acc and bdat<=nvl(to_date(:sFdat1,''dd/mm/yyyy''),gl.bd)  )) 
   )  , '','',''.'' )  Stavka ,    
  translate( to_char( 
 (select ir  from int_ratn where acc=(select ae.acc from accounts ae, nd_acc nae where ae.acc=nae.acc and NAE.ND=d.nd and ae.tip=''LIM'' ) and id=-2 
  and bdat=(select max(bdat) from int_ratn where id=-2 and acc=(select ae.acc from accounts ae, nd_acc nae where ae.acc=nae.acc and NAE.ND=d.nd and ae.tip=''LIM'' ) and bdat<=nvl(to_date(:sFdat1,''dd/mm/yyyy'') ,gl.bd) )
  ))  , '','',''.'')  
  EfStavka   
  from accounts a, customer c, cc_deal d, nd_acc na where 
  d.nd=na.nd and a.acc=na.acc and na.acc=a.acc and d.rnk=c.rnk 
  and d.vidd in (1,2,3) and (a.dazs is null or dazs >nvl(to_date(:sFdat1,''dd/mm/yyyy'' ),gl.bd) )
  and a.nbs in (2010, 2020, 2030, 2040, 2045, 2046, 2047, 2050, 2055, 2057, 2061, 2063, 2067, 2070, 2071, 2072, 2073, 2074, 2083, 2100, 2103, 2110, 2113, 2123, 2133)
  order by d.rnk, d.nd, a.nbs, a.kv  ';
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
