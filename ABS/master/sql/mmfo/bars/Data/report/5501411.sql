prompt ===================================== 
prompt == SBER. Пополнение деп. портфеля
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
   l_zpr.name := 'SBER. Пополнение деп. портфеля';
   l_zpr.pkey := '\BRS\SBM\***\805\';

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
    l_zpr.name         := 'SBER. Пополнение деп. портфеля';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select branch,rnk,okpo,nmk,nls,kv, dapp ,action_id, dat_end, dos, kos,vidd,TYPE_NAME, deposit_id,s_out, s_in, srok, dat
from
(select a_o.acc, a_o.branch,c_o.rnk,c_o.okpo,c_o.nmk,a_o.nls,to_number(a_o.kv) kv,null dapp ,null action_id,dpt_o.dat_end,obr.dos, obr.kos,dpt_o.vidd,V.TYPE_NAME, dpt_o.deposit_id,0 s_out, dpt_o.limit s_in,dpt_o.dat_end-dpt_o.dat_begin srok, dpt_o.dat_begin dat 
from dpt_deposit dpt_o,accounts a_o,customer c_o,dpt_vidd v,
        (select o.acc,sum(decode(o.dk,0,s/100,0)) dos,sum(decode(o.dk,0,sq/100,0)) dosq,sum(decode(o.dk,0,0,s/100)) kos,sum(decode(o.dk,0,0,sq/100)) kosq 
         from opldok o join accounts a on o.acc=a.acc
         where o.fdat=to_date(:sFdat1,''dd/mm/yyyy'') and
               a.nbs in (''2630'') and o.dk=0 and fost(a.acc,to_date(:sFdat1,''dd/mm/yyyy''))<>0
         group by o.acc      
      
         union      
      
         select o.acc,sum(decode(o.dk,0,s/100,0)) dos,sum(decode(o.dk,0,sq/100,0)) dosq,sum(decode(o.dk,0,0,s/100)) kos,sum(decode(o.dk,0,0,sq/100)) kosq
         from opldok o join accounts a on o.acc=a.acc
         where o.fdat=to_date(:sFdat1,''dd/mm/yyyy'') and
               a.nbs in (''2630'') and o.dk=1 and  a.daos<>to_date(:sFdat1,''dd/mm/yyyy'')  
         group by o.acc   
         ) obr
where   dpt_o.dat_begin<=to_date(:sFdat1,''dd/mm/yyyy'')  and a_o.acc =obr.acc  and
            dpt_o.acc=a_o.acc and a_o.rnk=c_o.rnk and A_O.DAOS<=to_date(:sFdat1,''dd/mm/yyyy'')  and 
            dpt_o.vidd=V.VIDD
union all
select a_o.acc, a_o.branch,c_o.rnk,c_o.okpo,c_o.nmk,a_o.nls,to_number(a_o.kv) kv,null dapp ,null action_id,dpt_o.dat_end,obr.dos, obr.kos,dpt_o.vidd,V.TYPE_NAME, dpt_o.deposit_id,0 s_out, dpt_o.limit s_in,dpt_o.dat_end-dpt_o.dat_begin srok, dpt_o.dat_begin dat 
from dpt_deposit_clos dpt_o,accounts a_o,customer c_o,dpt_vidd v,
        (select o.acc,sum(decode(o.dk,0,s/100,0)) dos,sum(decode(o.dk,0,sq/100,0)) dosq,sum(decode(o.dk,0,0,s/100)) kos,sum(decode(o.dk,0,0,sq/100)) kosq 
         from opldok o join accounts a on o.acc=a.acc
         where o.fdat=to_date(:sFdat1,''dd/mm/yyyy'') and
               a.nbs in (''2630'') and o.dk=0 and fost(a.acc,to_date(:sFdat1,''dd/mm/yyyy''))<>0
         group by o.acc      
      
         union      
      
         select o.acc,sum(decode(o.dk,0,s/100,0)) dos,sum(decode(o.dk,0,sq/100,0)) dosq,sum(decode(o.dk,0,0,s/100)) kos,sum(decode(o.dk,0,0,sq/100)) kosq
         from opldok o join accounts a on o.acc=a.acc
         where o.fdat=to_date(:sFdat1,''dd/mm/yyyy'') and
               a.nbs in (''2630'') and o.dk=1 and  a.daos<>to_date(:sFdat1,''dd/mm/yyyy'')  
         group by o.acc   
         ) obr
where   dpt_o.dat_begin<=to_date(:sFdat1,''dd/mm/yyyy'') and dpt_o.action_id in (1,2)  and a_o.acc =obr.acc  and
            dpt_o.acc=a_o.acc and a_o.rnk=c_o.rnk and A_O.DAOS<=to_date(:sFdat1,''dd/mm/yyyy'')  and 
            dpt_o.vidd=V.VIDD
)
where  fkos(acc,to_date(:sFdat1,''dd/mm/yyyy''),to_date(:sFdat1,''dd/mm/yyyy''))<>0 or
       fdos(acc,to_date(:sFdat1,''dd/mm/yyyy''),to_date(:sFdat1,''dd/mm/yyyy''))<>0                       
order by branch,okpo';
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
