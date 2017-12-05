prompt ===================================== 
prompt == БПК. Комиссионные доходы(на начало дня)
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
   l_zpr.name := 'БПК. Комиссионные доходы(на начало дня)';
   l_zpr.pkey := '\BRS\SBM\***\744\';

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
    l_zpr.name         := 'БПК. Комиссионные доходы(на начало дня)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a1.branch,a1.kv,a1.ost_beg/100 "п.1.2",
                                         a2.ost_beg/100 "п. 1.3",
                                         a3.ost_beg/100 "п. 3.1.1",
                                         a4.ost_beg/100 "п. 3.1.2",
                                         a5.ost_beg/100 "п. 3.1.3",
                                         a6.ost_beg/100 "п. 3.1.4",
                                         a7.ost_beg/100 "п. 3.2"
from (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''54'',''55'',''68'',''56'',''57'',''69'') 
          group by branch,kv
          ) a1 
          join 
         (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''17'',''A1'',''39'',''C3'')
          group by branch,kv
          ) a2 on a1.branch=a2.branch and a1.kv=a2.kv 
          join 
         (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''19'',''35'',''37'',''61'',''62'',''64'',''92'',''B9'',''C1'')
          group by branch,kv
          ) a3 on a1.branch=a3.branch and a1.kv=a3.kv 
          join 
         (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''36'',''63'')
          group by branch,kv
          ) a4 on a1.branch=a4.branch and a1.kv=a4.kv 
          join 
         (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''20'')
          group by branch,kv
          ) a5 on a1.branch=a5.branch and a1.kv=a5.kv 
          join 
         (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''C2'',''C7'',''C8'',''C9'',''D0'',''D1'',''D2'',''D3'',''D4'',''D5'',''D6'') or
                      nbs=''6509'' and ob22 in (''03'') or
                      nbs=''6514'' and ob22 in (''32'',''33'') or
                      nbs=''6519'' and ob22 in (''05'',''10'')
          group by branch,kv
          ) a6 on a1.branch=a6.branch and a1.kv=a6.kv 
          join 
         (select branch,kv,sum(fost(acc, to_date(:sFdat1,''dd/mm/yyyy'')-1 )) ost_beg
          from accounts
          where nbs=''6510'' and ob22 in (''51'',''65'')
          group by branch,kv
          ) a7 on a1.branch=a7.branch and a1.kv=a7.kv 
order by a1.branch,a1.kv';
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
