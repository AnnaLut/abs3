prompt ===================================== 
prompt == ���. �� ���-��  ���. 2630,2635 (���� �.�.)
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
   l_zpr.name := '���. �� ���-��  ���. 2630,2635 (���� �.�.)';
   l_zpr.pkey := '\BRS\SBR\DPT\126';

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
    l_zpr.name         := '���. �� ���-��  ���. 2630,2635 (���� �.�.)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate=''����� ����(DD.MM.YYYY) :'',:nbs=''���.������� (����� - ��, ����,����...- �����):'',:kv=''������ (0 ��� ����� - ��, 1 - �� ��� UAH, ��� - ��� ���.)
 :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 
     case when (substr(x1.branch,9,6)=''000000'' or substr(x1.branch,9,6) is NULL) then ''�� �� �. ���� �� ���.''
          when  substr(x1.branch,9,6)=''000001'' then ''����������''
          when  substr(x1.branch,9,6)=''000020'' then ''��i��������''
          when  substr(x1.branch,9,6)=''000045'' then ''���������''
          when  substr(x1.branch,9,6)=''000066'' then ''����������''
          when  substr(x1.branch,9,6)=''000084'' then ''�����"������''
          when  substr(x1.branch,9,6)=''000104'' then ''���i������''
          when  substr(x1.branch,9,6)=''000124'' then ''������������''
          when  substr(x1.branch,9,6)=''000143'' then ''����������''
          when  substr(x1.branch,9,6)=''000159'' then ''�������i�����''
          when  substr(x1.branch,9,6)=''000187'' then ''���������''
          when  substr(x1.branch,9,6)=''000538'' then ''����i�����''
          when  substr(x1.branch,9,6)=''000559'' then ''�����i�����''
          when  substr(x1.branch,9,6)=''000583'' then ''������������''
          when  substr(x1.branch,9,6)=''000594'' then ''����������''
          when  substr(x1.branch,9,6)=''000614'' then ''�����������''
          when  substr(x1.branch,9,6)=''000638'' then ''������������''
          when  substr(x1.branch,9,6)=''000657'' then (case when substr(x1.branch,16,6)=''000668'' then ''����i����� (������)'' else ''����i�����'' end) 
          when  substr(x1.branch,9,6)=''000671'' then (case when substr(x1.branch,16,6)=''000638'' then ''�����i����� (��������)'' else ''�����i�����'' end)
          when  substr(x1.branch,9,6)=''000688'' then ''�������i�����''
          when  substr(x1.branch,9,6)=''000712'' then ''���i�����''
          when  substr(x1.branch,9,6)=''000726'' then (case when substr(x1.branch,16,6)=''000559'' then ''������������ (������)'' else ''������������'' end)
          when  substr(x1.branch,9,6)=''000741'' then ''����������''
          when  substr(x1.branch,9,6)=''000773'' then ''�����i�����''
          when  substr(x1.branch,9,6)=''000790'' then ''�����������''
          when  substr(x1.branch,9,6)=''000805'' then ''���i������''
          when  substr(x1.branch,9,6)=''000830'' then ''�-������������''
          when  substr(x1.branch,9,6)=''000849'' then ''�-�����������''
          when  substr(x1.branch,9,6)=''000877'' then (case when substr(x1.branch,16,6)=''000583'' then ''��������i����� (�������)'' 
                                                          when substr(x1.branch,16,6)=''000898'' then ''��������i����� (���������)'' else ''��������i�����'' end)
          when  substr(x1.branch,9,6)=''000901'' then (case when substr(x1.branch,16,6)=''000916'' then ''������i������ (���������)'' else ''������i������'' end)
          else ''''
     end as Name_TVBV     
     , x1.branch as Nom_TVBV
     , x1.TIP as Tip_TVBV
     , x1.obl as Priznak_Obl
     , nvl(sum(x2.ost),0) as Sum_Ost_UAH
     , count(x2.nbs) as Kol_NLS
     , case when nvl(count(x2.nbs),0)=0 then 0 else round(nvl(sum(x2.ost),0)/count(x2.nbs),2) end as Ser_SUM_Ost_UAH
     , nvl(sum(x2.ost_td),0) as Sum_Ost_UAH_CurTD
     , case when nvl(count(x2.nbs),0)=0 then 0 else round(nvl(sum(x2.ost_td),0)/count(x2.nbs),2) end as Ser_SUM_Ost_UAH_CurTD
     , nvl(sum(x2.ost_0115),0) as Sum_Ost_UAH_Cur0115
     , case when nvl(count(x2.nbs),0)=0 then 0 else round(nvl(sum(x2.ost_0115),0)/count(x2.nbs),2) end as Ser_SUM_Ost_UAH_Cur0115
from (       
select b.branch, b.description as TIP, b.obl
from branch b
where (b.date_closed is NULL or b.date_closed > to_date(:zDate,''dd.mm.yyyy''))
  and to_date(to_char(b.date_opened,''dd.mm.yyyy''),''dd.mm.yyyy'') <= to_date(:zDate,''dd.mm.yyyy'')
  and b.branch<>''/'' and nvl(b.description,''0'')<>''5''
  and nvl(b.branch,''0'') in (select branch from branch_parameters where tag=''DEPARTS6'' and val=''Y'')
group by b.branch,  b.description, b.obl
order by b.branch ) x1 left join 
(
select a.branch, a.nbs 
    , nvl(round(case when fost(a.acc,to_date(:zDate,''dd.mm.yyyy''))<0 then 0 
                      else fost(a.acc,to_date(:zDate,''dd.mm.yyyy'')) *nvl((select rate_o/bsum as kf 
                                                          ';
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
