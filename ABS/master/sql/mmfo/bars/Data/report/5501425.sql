prompt ===================================== 
prompt == CORP. Доходи за бізнес-напрямком клієнта
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
   l_zpr.name := 'CORP. Доходи за бізнес-напрямком клієнта';
   l_zpr.pkey := '\BRS\SBM\***\844\';

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
    l_zpr.name         := 'CORP. Доходи за бізнес-напрямком клієнта';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''6510(99,A4,A6,A7)'' dohod,c.rnk,c.okpo,c.nmk,c.branch,cw.value "Напрямок",sum(o.s) "Сума"
from
(select * 
     from opldok
     where (ref,tt) in
     (select ref,tt
      from opldok where fdat between to_date(:sFdat1,''dd/mm/yyyy'') and to_date(:sFdat2,''dd/mm/yyyy'') and months_between(:sFdat2,:sFdat1)<1.1 and
           acc in (select acc from accounts where nbs=''6510'' and ob22 in (''99'',''A4'', ''A6'',''A7'') ) and dk=1 and sos=5
     )  and dk=0
) o, accounts a,customer c,customerw cw
where o.acc=a.acc and a.rnk=c.rnk and c.rnk=cw.rnk and cw.tag=''BUSSL''
group by c.rnk,c.okpo,c.nmk,c.branch,cw.value

UNION ALL
select ''6510;6516;6518;6519;6501;6508;6509'' dohod,c.rnk,c.okpo,c.nmk,c.branch,cw.value,sum(o.s)
from
(select * 
     from opldok
     where (ref,tt) in
     (select ref,tt
      from opldok where kf=''335106'' and fdat between to_date(''01/05/2016'',''dd/mm/yyyy'') and to_date(''10/05/2016'',''dd/mm/yyyy'') and months_between(:sFdat2,:sFdat1)<1.1 and
           acc in (select acc from accounts where kf=''335106'' and
                                                  nbs=''6510'' and ob22 in (''01'',''06'',''07'',''09'',''12'',''23'',''28'',''29'',''42'',''43'',''46'',''45'',''48'',''49'',''83'',''93'',''B2'',''B5'',''B8'',''E3'',''E8'') or
                                                  nbs=''6516'' or
                                                  nbs=''6518'' and ob22 in (''03'') or
                                                  nbs=''6519'' and ob22 in (''02'',''03'',''06'',''08'',''12'',''13'',''19'',''20'',''24'',''25'') or
                                                  nbs=''6510'' and ob22 in (''31'', ''32'',''33'',''44'',''47'',''50'') or
                                                  nbs=''6500'' and ob22 in (''01'',''04'',''05'', ''06'',''07'',''08'',''09'') or
                                                  nbs=''6501'' or 
                                                  nbs=''6508'' or
                                                  nbs=''6509'' and ob22 in (''01'',''04'',''05'')
                  ) and dk=1 and sos=5
     )  and dk=0
) o, accounts a,customer c,customerw cw
where o.acc=a.acc and a.rnk=c.rnk and c.rnk=cw.rnk and cw.tag=''BUSSL''
group by c.rnk,c.okpo,c.nmk,c.branch,cw.value';
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
