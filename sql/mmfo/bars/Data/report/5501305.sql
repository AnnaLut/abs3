prompt ===================================== 
prompt == CORP. Залишки за кред.рахунками в розрізі за кред.операціями
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
   l_zpr.name := 'CORP. Залишки за кред.рахунками в розрізі за кред.операціями';
   l_zpr.pkey := '\BRS\SBR\***\739';

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
    l_zpr.name         := 'CORP. Залишки за кред.рахунками в розрізі за кред.операціями';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select distinct a.branch,CC.ND,a.nls,a.kv,a.nms,
         abs(fost(a.acc,to_date(:sFdat1,''dd.mm.yyyy'')-1)/100) ost_b,
         fdos(a.acc,to_date(:sFdat1,''dd/mm/yyyy''),to_date(:sFdat2,''dd/mm/yyyy''))/100 dos,
         fkos(a.acc,to_date(:sFdat1,''dd/mm/yyyy''),to_date(:sFdat2,''dd/mm/yyyy''))/100 kos,
         abs(fost(a.acc,to_date(:sFdat2,''dd.mm.yyyy'')-1)/100)  ost_end,
         a.ob22                  
from accounts a,cc_accp cc
where ((a.nbs in (''2063'',''2600'',''2066'',''2068'',''2607'')  ) 
          or (a.nbs=''9129'' and ob22 in (''02'',''04'') and a.acc=cc.accs)) and a.acc=cc.accs
           and (dazs is null or dazs>=to_date(:sFdat1,''dd.mm.yyyy''))
order by a.nls';
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
