prompt ===================================== 
prompt == ЗДК: ТВБВ: Безготiвковий об/с журнал
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
   l_zpr.name := 'ЗДК: ТВБВ: Безготiвковий об/с журнал';
   l_zpr.pkey := '\BRS\SBM\REP\61';

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
    l_zpr.name         := 'ЗДК: ТВБВ: Безготiвковий об/с журнал';
    l_zpr.namef        := '=''ZD3_2''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'sbm_zk2o.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  fio, nlstype, ob22txt, ob22,  a.kv,  t.name kvname,  
             sum(ostf/100) ostf, sum(dos/100) dos, sum(kos/100) kos, sum(ost/100) ost
from ( select o.txt ob22txt, a.nbs||''(''||i.ob22||'')'' ob22,
           case substr(nls,1,1) 
              when ''1'' then ''1.Готівкові''
              when ''9'' then ''3.Позабалансові''
              else          ''2.Безготівкові''
              end  as nlstype,
              '''' fio, kv, s.ostf, s.dos, s.kos, s.ostf - s.dos +  s.kos ost  
       from saldoa s, accounts a, specparam_int i, sb_ob22 o 
            where (s.acc, s.fdat) in (select  acc, l.fdat from opl l, oper p 
                                where l.ref = p.ref and l.sos = 5
                                   and l.fdat = to_date(:sFdat1,''dd-mm-yyyy'') )
       and s.acc = a.acc 
       and a.acc= i.acc 
       and a.nbs = o.r020
       and i.ob22 = o.ob22
       and a.nbs  in (''2620'',''2628'',''2630'',''2638'',''9760'') 
       and a.branch like sys_context(''bars_context'',''user_branch'')||''%''
    ) a, tabval t
where a.kv = t.kv
group by fio, nlstype,  a.kv ,  t.name, ob22txt,  ob22   
order by nlstype,  kv, ob22';
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
