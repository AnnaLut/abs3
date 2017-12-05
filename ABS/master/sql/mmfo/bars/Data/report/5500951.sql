prompt ===================================== 
prompt == ДЕЛЬТА БАНК Залучення на депозити
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
   l_zpr.name := 'ДЕЛЬТА БАНК Залучення на депозити';
   l_zpr.pkey := '\BRS\SBR\DPT\196';

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
    l_zpr.name         := 'ДЕЛЬТА БАНК Залучення на депозити';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':sFdat1=''Дата з (DD.MM.YYYY) :'',:sFdat2=''Дата по (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':sFdat1=''11.06.2015''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select * 
from (
select o.branch
      ,substr(o.branch,1,15)br_gl
      ,c.rnk
      ,a.nls
      ,c.nmk,c.okpo,p.SER,p.NUMDOC 
      ,to_char(a.daos,''MM/DD/YYYY'') daos
      ,to_char(d.dat_begin,''MM/DD/YYYY'') dat_begin
      ,to_CHAR(d.dat_end,''MM/DD/YYYY'') dat_end
      ,to_char(o.datd) dat_pr
      ,o.kv,d.vidd,dv.TYPE_NAME
      ,s/100 as sum_val,round(o.s*f_ret_rate(o.kv,o.vdat)/100,2) as sum_uah
      ,o.tt
  ,(case when o.TT in (''DP0'',''DPD'')  then ''old'' else ''new'' end) TT_dep
  ,(case when o.branch in  (select bp.branch from branch_parameters bp where bp.tag=''DEPARTS6'' and bp.val=''Y'') then ''New_TVBV'' else ''Old_TVBV'' end) TVBV_tip
from oper o inner join accounts a on o.nlsb=a.nls 
            inner join customer c on a.rnk=c.rnk and date_off is null
            inner join person p on p.rnk=c.rnk
            inner join dpt_deposit d on a.acc=d.ACC
            inner join dpt_vidd dv on d.vidd=dv.vidd
where substr(nlsb,1,4)in (2630)
   and datd between :sFdat1 and :sFdat2
   and (o.id_b in (select inn from test_k_delta where DATETRANSH <= to_date(''08.10.2015'',''DD.MM.YYYY'') and inn=0 group by inn) 
     or o.id_b in (select inn from test_k_delta group DATETRANSH <= to_date(''08.10.2015'',''DD.MM.YYYY'') and inn=0 group by inn))
   and o.sos=5 
  and o.TT in (''DP2'',''I02'')
UNION All 
select o.branch branch,substr(o.branch,1,15)br_gl,c.rnk,a.nls,c.nmk,c.okpo,p.SER,p.NUMDOC 
  ,to_char(a.daos,''MM/DD/YYYY'') daos
  ,to_char(d.dat_begin,''MM/DD/YYYY'') dat_begin
  ,to_CHAR(d.dat_end,''MM/DD/YYYY'') dat_end
  ,to_char(o.vdat) dat_pr
  ,o.kv,d.vidd,dv.TYPE_NAME,s/100 as sum_val,round(o.s*f_ret_rate(o.kv,o.vdat)/100,2) as sum_uah
  ,o.tt
  ,(case when o.TT in (''DP0'',''DPD'')  then ''old'' else ''new'' end) TT_dep
  ,(case when o.branch in  (select bp.branch from branch_parameters bp where bp.tag=''DEPARTS6'' and bp.val=''Y'') then ''New_TVBV'' else ''Old_TVBV'' end) TVBV_tip
from oper o inner join accounts a on o.nlsa=a.nls 
            inner join customer c on a.rnk=c.rnk and date_off is null
            inner join person p on p.rnk=c.rnk
            inner join dpt_deposit d on a.acc=d.ACC
            inner join dpt_vidd dv on d.vidd=dv.vidd
where substr(nlsa,1,4)in (2630)
   and datd between :sFdat1 and :sFdat2
   and (o.id_b in (select inn from test_k_delta where DATETRANSH <= to_date(''08.10.2015'',''DD.MM.YYYY'') and inn=0 group by inn) 
     or o.id_b in (select inn from test_k_delta group DATETRANSH <= to_date(''08.10.2015'',''DD.MM.YYYY'') and inn=0 group by inn))
   and o.sos=5 --and o.kv<>980
   and o.TT in (''DP0'',''DPD'',''DPA'',''DPB'',''DPC'')
)
order by  branch';
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
