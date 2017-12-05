prompt ===================================== 
prompt == Сал.ведомость по кредиторской задолжености (для Юры)
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
   l_zpr.name := 'Сал.ведомость по кредиторской задолжености (для Юры)';
   l_zpr.pkey := '\OLD\***\***\295';

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
    l_zpr.name         := 'Сал.ведомость по кредиторской задолжености (для Юры)';
    l_zpr.namef        := 'sal_pros';
    l_zpr.bindvars     := ':Param0=''За дату''';
    l_zpr.create_stmt  := 'NLS CHAR(14), NBS CHAR(4), NMS CHAR(38), NMK CHAR(38),
'||nlchr||
                           ''||nlchr||
                           'OST NUMBER(16,2), DAPP DATE';
    l_zpr.rpt_template := 'SAL_PROS.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 
  a.nls,a.nbs,a.nms,c.nmk,
  FOST(A.ACC,:Param0)/100*(-1) OST,
  a.kv,
  FOSTQ(A.ACC,:Param0)/100*(-1) OSTQ,
  a.dapp
from accounts a, customer c, cust_acc ca
where a.nbs in (1208,1218,1508,1518,1519,1528,
                1418,1428,1438,1448,
                2008,2018,2028,2048,2049,2058,2059,
                2068,2078,2101,2118,
                2208,2218,2219,3108,3118,3208,
                2218,3219,3570,3578,1780,2480,3589) 
  and FOSTQ(A.ACC,:Param0)<>0
  and c.rnk=ca.rnk and ca.acc=a.acc  
order by a.nbs';
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
