prompt ===================================== 
prompt == БПК. 2924(16)
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
   l_zpr.name := 'БПК. 2924(16)';
   l_zpr.pkey := '\BRS\SBM\***\792\';

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
    l_zpr.name         := 'БПК. 2924(16)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select acc2924.branch,acc2924.nls,acc2924.nms,obr2600.s/100 s2600,mfob ,obr6510.s/100 s6510,obr7500.s/100 s7500
from (select *  from accounts where nbs=''2924'' and ob22 in (''16'') and dazs is null) acc2924,
--2924(16)-2600,2605
(select acc,nvl(sum(s),0) s, mfob
 from
(select distinct opl2924.acc, opl2924.s, mfob
from 
(select *
 from opldok
 where ref in          
(         select ref from opldok where fdat>=to_date(:sFdat1,''dd/mm/yyyy'') and fdat<=to_date(:sFdat2,''dd/mm/yyyy'') and dk=0 and sos=5 and 
                                 acc in (select acc from accounts where nbs=''2924'' and ob22 in (''16'')) 
) 
)opl2924 join
  (select opldok.ref,oper.mfob
   from opldok,oper
   where opldok.ref in          
            (select ref from oper where vdat>=to_date(:sFdat1,''dd/mm/yyyy'') and vdat<=to_date(:sFdat2,''dd/mm/yyyy'') and sos=5 and nlsa in (select nls from accounts where nbs=''2924'' and ob22 in (''16'')) and  
                                                        substr(nlsb,1,4) in (''2600'',''2605'') 
            ) and opldok.ref=oper.ref
   )  opl on opl2924.ref=OPL.REF
where opl2924.dk=0
) ttt 
group by acc,mfob
)obr2600, 
--2924(16)-6510(20)
(select acc,nvl(sum(s),0) s
 from
(select distinct opl2924.acc, opl2924.s
from 
(select *
 from opldok
 where ref in          
(         select ref from opldok where fdat>=to_date(:sFdat1,''dd/mm/yyyy'') and fdat<=to_date(:sFdat2,''dd/mm/yyyy'') and dk=0 and sos=5 and 
                                 acc in (select acc from accounts where nbs=''2924'' and ob22 in (''16'')) 
) 
)opl2924 join
  (select *
   from opldok
   where ref in          
            (         select ref from opldok where fdat>=to_date(:sFdat1,''dd/mm/yyyy'') and fdat<=to_date(:sFdat2,''dd/mm/yyyy'') and dk=1 and sos=5 and 
                                 acc in (select acc from accounts where nbs=''6510'' and ob22 in (''20'')) 
            ) 
   )  opl on opl2924.ref=OPL.REF
where opl2924.dk=0 and opl2924.acc in (select acc from accounts where nbs=''2924'' and ob22=''16'')
) ttt
group by acc 
) obr6510,
--2924(16)-7500
(select acc,nvl(sum(s),0) s
 from
(select distinct opl2924.acc, opl2924.s
from 
(select *
 from opldok
 where ref in          
(         select ref from opldok where fdat>=to_date(:sFdat1,''dd/mm/yyyy'') and fdat<=to_date(:sFdat2,''dd/mm/yyyy'') and dk=1 and sos=5 and 
                                 acc in (select acc from accounts where nbs=''2924'' and ob22 in (''16'')) 
) 
)opl2924 join
  (select *
   from opldok
   where ref in          
            (         select ref from opldok where fdat>=to_date(:sFdat1,''dd/mm/yyyy'') and fdat<=to_date(:sFdat2,''dd/mm/yyyy'') and dk=0 and sos=5 and 
                                 acc in (select acc from accounts where nbs=''7500'' )
            ) 
   )  opl on opl2924.ref=OPL.REF
where opl2924.dk=1 and opl2924.acc in (select acc from accounts where nbs=''2924'' and ob22=''16'')
 ) ttt
group by acc 
) obr7500
 where (to_date(:sFdat2,''dd/mm/yyyy'')-to_date(:sFdat1,''dd/mm/yyyy''))<=190 and acc2924.acc=obr2600.acc(+) and acc2924.acc=obr6510.acc(+) and acc2924.acc=obr7500.acc(+)';
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
