prompt ===================================== 
prompt == ЗДК(old): ТВБВ: Звiт по зводу дня
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
   l_zpr.name := 'ЗДК(old): ТВБВ: Звiт по зводу дня';
   l_zpr.pkey := '\BRS\SBM\REP\163';

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
    l_zpr.name         := 'ЗДК(old): ТВБВ: Звiт по зводу дня';
    l_zpr.namef        := '=''ZD3_3''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:SHIFT=''№ зміни''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'sbm_zk3t.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':SHIFT=''1''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  flg,  :SHIFT shift, 
            to_number(substr(nls,1,1)) nlstype,
            nls, a.kv, t.name kvname, nms, ostf, sdb,  skr, obdb, obkr, ost,  tt, ttname, '''' fio
from (
        select  0 flg,  ''1''  nls, kv,  '''' nms, 0 ostf, tt, ttname,
                   sum( decode(optype, 0, s, 0)) sdb,
                   sum( decode(optype, 1, s, 0)) skr, 
                   0 obdb, 0 obkr, 0 ost, count(*)  cnt                   
        from   v_cashpayed2
        where  opdate between to_date(:sFdat1) and to_date(:sFdat1) + 0.999 and shift = :SHIFT
        group by kv, tt, ttname
        union all
        select  0 flg,  ''2''  nls, v.kv,  '''' nms, 0 ostf,
                   l.tt, s.name ttname,
                   sum(  decode(l.dk, 0, l.s, 0  )) sdb,
                   sum(  decode(l.dk, 0,  0, l.s )) skr, 
                    0 obdb, 0 obkr, 0 ost, 
                   count(*)  cnt                   
        from   oper o, opldok l, accounts v, opldok l2, accounts v2,  tts s, staff$base sb,
               (  select  branch, decode(:SHIFT,1 , trunc(opdate), opdate)      opdate,
                                bars_cash.next_shift_date(:SHIFT, opdate) ndate 
                  from cash_open
                  where opdate >= to_date(:sFdat1) and opdate < to_date( :sFdat1)   + 0.999   and shift = :SHIFT
                         and  branch = sys_context(''bars_context'',''user_branch'')
                ) ko 
        where   pdat  between  to_date(:sFdat1) and  to_date( :sFdat1)   + 0.999
              and pdat >= ko.opdate  and pdat <  ko.ndate  
              and o.ref = l.ref and l.acc = v.acc  and l.sos = 5 and l.tt = s.tt
              and substr(v.nls,1,4)  in (''2620'',''2628'',''2630'',''2638'',''9760'') 
              and l.ref = l2.ref and l.stmt = l2.stmt and l.dk <> l2.dk
              and l2.acc = v2.acc and substr(v2.nls,1,1) <> 1
              and sb.id = o.userid and sb.branch = sys_context(''bars_context'',''user_branch'')
              and v.branch = sys_context(''bars_context'',''user_branch'')             
        group by v.kv, l.tt, s.name        
        union all
        select 1 flg, a.nls, a.kv, a.nms, decode(a.pap,1,-1,1) * ks.ostf ostf, '''' tt,  '''' ttname, 
                    0 sdb, 0 skr, sdb, skr,  decode(a.pap,1,-1,1) * ks.ostf   - nvl(sdb,0)  +  nvl(skr,0)  as  ost,  
                    0 cnt
        from  ( select v.acc, sum( decode(optype, 0, s, 0)) sdb,
                                            sum( decode(optype, 1, s, 0)) skr
                      from   v_cashpayed2 v
                      where  opdate between to_date(:sFdat1) and to_date(:sFdat1) + 0.999 and shift = :SHIFT                
                     group by v.acc
              ) v, accounts a, cash_snapshot ks, cash_open ko
       where  ks.acc = a.acc and  ks.acc = v.acc (+)
                   and ks.opdate = ko.opdate
                   and ko.opdate >= to_date(:sFdat1) and ko.opdate <  to_date( :sFdat1)   + 0.999
                   and ko.shift = :SHIFT      
                  and  ks. branch = sys_context(''bars_context'',''user_branch'')                
                  and  ko. branch = sys_context(''bars_context'',''user_branch'')                
                   and (   ((ks.ostf <>0 or v.sdb<>0 or v.skr<>0 or a.ostc<>0 ) and substr(a.nls,1,1) = ''9'') or
                           ( a.ostc<>0 and substr(a.nls,1,4) = ''9812'' )  or
                           substr(a.nls,1,1) = ''1''
                       )        
             ) a, tabval t
where a.kv = t.kv
order by substr(nls,1,1),   flg, kv,   tt , obdb,  nls';
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
