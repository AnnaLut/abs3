prompt ===================================== 
prompt == SBER. Переразмещение деп. портфеля
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
   l_zpr.name := 'SBER. Переразмещение деп. портфеля';
   l_zpr.pkey := '\BRS\SBM\***\804\';

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
    l_zpr.name         := 'SBER. Переразмещение деп. портфеля';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата с'',:sFdat2=''Дата по''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select substr(ttt.branch,19,3) "N ТОБО",null "Дата заяв.",ttt.action_id "Пр снятия",to_char(ttt.dapp,''dd.mm.yyyy'') "Дата сн деп",ttt.rnk,ttt.okpo "ОКПО",ttt.nmk "ФИО",ttt.s_out/100 "Выдача в ном",
          ttt.kv "вал выдачи",decode(ttt.kv,980,ttt.s_out/100,round((ttt.s_out*cur.rate_o)/cur.bsum/100,2)) "Выдача в грн.",ttt.s_in/100 "Размещ в ном", ttt.kv "вал размещ",
          decode(ttt.kv,980,ttt.s_in/100,round((ttt.s_in*cur.rate_o)/cur.bsum/100,2)) "Размещ. в грн.",decode(ttt.s_in,0,0,srok) "Срок размещ",decode(ttt.s_in,0,null,ttt.dat_end) "Дата окон.н.деп",
          null "ФИО сотрудника",null "ФИО операциониста"
from
(select a.branch,c.rnk,c.okpo,c.nmk,a.nls,a.kv,a.dapp ,dpt.action_id,dpt.dat_end,a.dos,dpt.vidd,V.TYPE_NAME, dpt.deposit_id,a.dos s_out, 0 s_in ,dpt.dat_end-dpt.dat_begin srok , a.dapp dat 
from accounts a,customer c, dpt_deposit_clos dpt,dpt_vidd v
where a.nbs in (2630) and a.dapp>=to_date(:sFdat1,''dd/mm/yyyy'') and a.dapp<=to_date(:sFdat2,''dd/mm/yyyy'') and a.ostc=0    
          and a.rnk=c.rnk and a.acc=dpt.acc and dpt.action_id in (1,2) and
          dpt.vidd=V.VIDD
union all
select a_o.branch,c_o.rnk,c_o.okpo,c_o.nmk,a_o.nls,to_number(a_o.kv) kv,null dapp ,null action_id,dpt_o.dat_end,null dos,dpt_o.vidd,V.TYPE_NAME, dpt_o.deposit_id,0 s_out, dpt_o.limit s_in,dpt_o.dat_end-dpt_o.dat_begin srok, dpt_o.dat_begin dat 
from dpt_deposit dpt_o,accounts a_o,customer c_o,dpt_vidd v
where   dpt_o.dat_begin>=to_date(:sFdat1,''dd/mm/yyyy'') and dpt_o.dat_begin<=to_date(:sFdat2,''dd/mm/yyyy'') and a_o.nbs in (''2630'') and
            dpt_o.acc=a_o.acc and a_o.rnk=c_o.rnk and A_O.DAOS>=to_date(:sFdat1,''dd/mm/yyyy'') and A_O.DAOS<=to_date(:sFdat2,''dd/mm/yyyy'') and 
            dpt_o.vidd=V.VIDD and a_o.ostc>0
union all
select a.branch,c.rnk,c.okpo,c.nmk,a.nls,a.kv,a.dapp ,decode((dpt.dat_end-a.dapp),abs(dpt.dat_end-a.dapp),2,1) action_id,dpt.dat_end,a.dos,dpt.vidd,V.TYPE_NAME, dpt.deposit_id,a.dos s_out, 0 s_in ,dpt.dat_end-dpt.dat_begin srok , a.dapp dat 
from accounts a,customer c, dpt_deposit dpt,dpt_vidd v
where a.nbs in (2630) and a.dapp>=to_date(:sFdat1,''dd/mm/yyyy'') and a.dapp<=to_date(:sFdat2,''dd/mm/yyyy'') and a.ostc=0 and A.DAOS<to_date(:sFdat2,''dd/mm/yyyy'')   and dpt.dat_begin<to_date(:sFdat2,''dd/mm/yyyy'') 
          and a.rnk=c.rnk and a.acc=dpt.acc and --dpt.action_id in (1,2) and
          dpt.vidd=V.VIDD             
) ttt,cur_rates$base cur
where months_between(:sFdat2,:sFdat1)<0.2 and ttt.dat=cur.vdate(+) and ttt.branch=cur.branch(+) and ttt.kv=cur.kv(+)
order by substr(ttt.branch,19,3),ttt.okpo';
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
