prompt ===================================== 
prompt == Інформація о сумах кред.ліній по філіях
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
   l_zpr.name := 'Інформація о сумах кред.ліній по філіях';
   l_zpr.pkey := '\BRS\SBM\REP\WAY4_KRED_LINES';

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
    l_zpr.name         := 'Інформація о сумах кред.ліній по філіях';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'BPK_KR_F.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select substr(branch, 1, 15) branch, sum(ost)*(-1) ost_kred, sum(ost2)*(-1) ost_kred2, to_date(:sFdat1,''dd.mm.yyyy'') dt
from
(

-- 2 new
select b.branch, b.nls, b.nms, a.ost/100 ost, 0 ost2
from (select acc_pk, 
        case when acc_ovr is not null then fostq(acc_ovr, to_date(:sFdat1, ''dd.mm.yyyy'')) else 0 end +
        case when acc_2203 is not null then fostq(acc_2203, to_date(:sFdat1, ''dd.mm.yyyy'')) else 0 end +
        case when acc_2207 is not null then fostq(acc_2207, to_date(:sFdat1, ''dd.mm.yyyy'')) else 0 end +
        case when acc_9129 is not null then fostq(acc_9129, to_date(:sFdat1, ''dd.mm.yyyy'')) else 0 end ost
      from w4_acc
      where acc_9129 is not null) a,
     accounts b
where a.acc_pk=b.acc
  and b.dazs is null
  and b.branch like sys_context(''bars_context'',''user_branch'') || 
    decode(length(sys_context(''bars_context'',''user_branch'')),8,''%'',15,''%'','''')
       UNION ALL
    select b.branch, b.nls, b.nms, 0 ost, fostq(b.acc,to_date(:sFdat1, ''dd.mm.yyyy''))/100 ost2
      from accounts b
      where b.dazs is null
        and b.branch like sys_context(''bars_context'',''user_branch'') || 
       decode(length(sys_context(''bars_context'',''user_branch'')),8,''%'',15,''%'','''')
       b.nbs = 2203 and ob22 in (''15'',''16'',''29'',''36'',''37'',''38'',''39'',''40'',''41'',''42'',''43'',''44'',''49'',''50'',''59'',''60'',''70'')
)
group by substr(branch, 1, 15)
order by substr(branch, 1, 15)';
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
