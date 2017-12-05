prompt ===================================== 
prompt == SBER. ���-�� � ����� �������� ������.
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
   l_zpr.name := 'SBER. ���-�� � ����� �������� ������.';
   l_zpr.pkey := '\BRS\SBM\***\787\';

   l_message  := '���� �������: '||l_zpr.pkey||'  '||nlchr;

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
    l_zpr.name         := 'SBER. ���-�� � ����� �������� ������.';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''���� �'',:sFdat2=''���� ��'',:kv=''��� ������''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':kv=''980''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select br.branch, :kv "��� ������",
         nvl(a1.k_vo,0) "���-�� 2620",nvl(a1.ost,0) "������� 2620", 
         nvl(a2.k_vo,0) "���-�� 2625",nvl(a2.ost,0) "������� 2625",
         nvl(a3.k_vo,0) "���-�� 2630",nvl(a3.ost,0) "������� 2630"
from (select branch from branch where  length(branch)=15) br,
(select substr(branch,1,15) branch, count(*) k_vo, sum(ostc)/100 ost
from accounts 
where nbs in (''2620'') and daos>= to_date(:sFdat1,''dd/mm/yyyy'') and daos<= to_date(:sFdat2,''dd/mm/yyyy'') and dazs is null and kv=:kv
group by substr(branch,1,15)
) a1,
(select substr(branch,1,15) branch, count(*) k_vo, sum(ostc)/100 ost
from accounts 
where nbs in (''2625'') and daos>= to_date(:sFdat1,''dd/mm/yyyy'') and daos<= to_date(:sFdat2,''dd/mm/yyyy'') and dazs is null and kv=:kv
group by substr(branch,1,15)
) a2,
(select substr(branch,1,15) branch, count(*) k_vo, sum(ostc)/100 ost
from accounts 
where nbs in (''2630'') and daos>= to_date(:sFdat1,''dd/mm/yyyy'') and daos<= to_date(:sFdat2,''dd/mm/yyyy'') and dazs is null and kv=:kv
group by substr(branch,1,15)
) a3
where br.branch=a1.branch(+) and br.branch=a2.branch(+) and br.branch=a3.branch(+)
order by br.branch';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'�������� ����� ���.������ �'||l_zpr.kodz||'.'; 
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
       l_message:=l_message||'���.������ c ����� ������ ��� ���������� ��� �'||l_zpr.kodz||', ��� ��������� ��������.'; 
                                                           
    end if;                                                
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
