prompt ===================================== 
prompt == БПК. 6110(19,20,36) за период
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
   l_zpr.name := 'БПК. 6110(19,20,36) за период';
   l_zpr.pkey := '\BRS\SBM\***\745\';

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
    l_zpr.name         := 'БПК. 6110(19,20,36) за период';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a.kv,a.nbs,a.ob22,sum(fkos(a.acc, to_date(:sFdat1,''dd/mm/yyyy''), to_date(:sFdat2,''dd/mm/yyyy''))) kos
from accounts a
where a.nbs=6510 and a.ob22 in (''55'',''57'',''68'',''69'',''C7'',''D0'',''D4'',''D5'',''54'',''56'',''51'',''65'',''A1'',''C2'',''C3'',''C8'',''C9'',''D1'',''D2'',''D3'',''D6'',''D7'',''E6'',''E7'',''E9'',''17'',''39'',''36'',''63'',''19'',''20'',''G2'',''G3'',''35'',''37'',''61'',''62'',''64'',''92'',''B9'',''C1'',''A4'',''A9'',''F4'',''52'',''53'',''66'',''67'',''D9'',''E0'',''E1'') or
      a.nbs=6509 and ob22 in (''03'') or
      a.nbs=6519 and ob22 in (''05'',''10'') or
      a.nbs=6511 and ob22 in (''27'',''28'',''29'',''30'',''31'',''32'',''33'',''34'',''35'',''36'')
group by a.kv,a.nbs,a.ob22
order by a.kv,a.nbs,a.ob22';
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
