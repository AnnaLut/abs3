prompt ===================================== 
prompt == Звіт по комісійних доходах швидких платіжних систем
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
   l_zpr.name := 'Звіт по комісійних доходах швидких платіжних систем';
   l_zpr.pkey := '\BRS\SBER\***\604';

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
    l_zpr.name         := 'Звіт по комісійних доходах швидких платіжних систем';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата з:'',:sFdat2=''Дата по:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'COM604.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with q1 as
(
select a2.branch,d1.ref,d1.fdat,d1.tt,d1.s,a2.nbs nbs2,a1.nls nls1,a1.ob22 ob22_1,a2.nls nls2,a2.ob22 ob22_2 from oper o, opldok d1, opldok d2, accounts a1, accounts a2
  where o.ref=d1.ref and o.ref=d2.ref and d1.ref=d2.ref and d1.tt=d2.tt and d1.dk=0 and d2.dk=1 and o.sos>1 and d1.acc=a1.acc and d2.acc=a2.acc
  and  d1.fdat >=  to_date(:sFdat1,''dd/mm/yyyy'') AND d1.fdat < to_date(:sFdat2,''dd/mm/yyyy'') + 1 
  and d1.tt=''R01'' and a1.nbs=''3739'' and a2.nbs=''6510''
union
select a2.branch,d1.ref,d1.fdat,d1.tt,d1.s,a2.nbs nbs2,a1.nls nls1,a1.ob22 ob22_1,a2.nls nls2,a2.ob22 ob22_2 from oper o, opldok d1, opldok d2, accounts a1, accounts a2
  where o.ref=d1.ref and o.ref=d2.ref and d1.ref=d2.ref and d1.tt=d2.tt and d1.dk=0 and d2.dk=1 and o.sos>1 and d1.acc=a1.acc and d2.acc=a2.acc
  and  d1.fdat >=  to_date(:sFdat1,''dd/mm/yyyy'') AND d1.fdat < to_date(:sFdat2,''dd/mm/yyyy'') + 1 
  and d1.tt=''CNC'' and a1.nbs=''2909'' and a2.nbs=''6510'' 
union
select a2.branch,d1.ref,d1.fdat,d1.tt,d1.s,a2.nbs nbs2,a1.nls nls1,a1.ob22 ob22_1,a2.nls nls2,a2.ob22 ob22_2 from oper o, opldok d1, opldok d2, accounts a1, accounts a2
  where o.ref=d1.ref and o.ref=d2.ref and d1.ref=d2.ref and d1.tt=d2.tt and d1.dk=0 and d2.dk=1 and o.sos>1 and d1.acc=a1.acc and d2.acc=a2.acc
  and  d1.fdat >=  to_date(:sFdat1,''dd/mm/yyyy'') AND d1.fdat < to_date(:sFdat2,''dd/mm/yyyy'') + 1 
  and d1.tt in (''K12'',''008'',''K61'',''KD1'',''428'',''I02'') and substr(a1.nbs,1,3)=''100''  and a2.nbs in (''6510'',''6514'') 
  order by branch,ref
  )
 select substr(branch,1,15) branch,
  sum(case when nbs2=''6510'' and ob22_2=''75'' then s/100 end) wu,
  sum(case when nbs2=''6510'' and ob22_2=''85'' then s/100 end) coinstar,
  sum(case when nbs2=''6510'' and ob22_2=''A5'' then s/100 end) zol_kor,
  sum(case when nbs2=''6510'' and ob22_2=''B4'' then s/100 end) ria,
  sum(case when nbs2=''6510'' and ob22_2=''B7'' then s/100 end) moneygram,
  sum(case when nbs2=''6510'' and ob22_2=''C5'' then s/100 end) hazri,
  sum(case when nbs2=''6510'' and ob22_2=''C6'' then s/100 end) intelexpress,
  sum(case when (nbs2=''6514'' and ob22_2 in (''14'',''15'')) or (nbs2=''6510'' and ob22_2=''96'') then s/100 end) swift
  from q1
  group by substr(branch,1,15)
  order by substr(branch,1,15)';
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
