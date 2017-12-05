prompt ===================================== 
prompt == Кількість прострочених кредитних угод
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
   l_zpr.name := 'Кількість прострочених кредитних угод';
   l_zpr.pkey := '\BRS\SBM\REP\236';

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
    l_zpr.name         := 'Кількість прострочених кредитних угод';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''На дату''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select unique
   (select count(*) from accounts a, specparam_int s where a.nbs=2203 and a.kv=980 and a.dazs is null and a.tip=''SP''
                           and a.acc=s.acc and s.ob22 in (''A2'',''A4'',''B0'',''87'',''B3'',''B5'',''B6'')) "2203/грн К",
   (select count(*) from accounts a, specparam_int s where a.nbs=2203 and a.kv<>980 and a.dazs is null and a.tip=''SP''
                           and a.acc=s.acc and s.ob22 in (''A2'',''A4'',''B0'',''87'',''B3'',''B5'',''B6'')) "2203/вал К",
  (select count(*) from accounts a, specparam_int s where a.nbs=2203 and a.kv=980 and a.dazs is null and a.tip=''SP''
                           and a.acc=s.acc and s.ob22 in (''A3'',''A5'',''A6'',''A7'',''A8'',''B1'',''B2'',''C1'')) "2203/грн Д",
  (select count(*) from accounts a, specparam_int s where a.nbs=2203 and a.kv<>980 and a.dazs is null and a.tip=''SP''
                           and a.acc=s.acc and s.ob22 in (''A3'',''A5'',''A6'',''A7'',''A8'',''B1'',''B2'',''C1'')) "2203/вал Д",
  (select count(*) from accounts a, specparam_int s where a.nbs=2233 and a.kv=980 and a.dazs is null and a.tip=''SP''
                           and a.acc=s.acc and s.ob22 in (''25'',''26'',''27'',''28'',''29'',''30'',''31'',''32'',''33'')) "2233/грн Д",
  (select count(*) from accounts a, specparam_int s where a.nbs=2233 and a.kv<>980 and a.dazs is null and a.tip=''SP''
                           and a.acc=s.acc and s.ob22 in (''25'',''26'',''27'',''28'',''29'',''30'',''31'',''32'',''33'')) "2233/вал Д"
from accounts where dazs is null and daos<:Param0';
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
