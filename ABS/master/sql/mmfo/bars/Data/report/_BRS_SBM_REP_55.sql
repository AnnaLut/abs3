

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_55.sql =========*** Run **
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Реєстр проданої іноземної валюти(Ощадбанк)
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
   l_zpr.name := 'Реєстр проданої іноземної валюти(Ощадбанк)';
   l_zpr.pkey := '\BRS\SBM\REP\55';

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
    l_zpr.name         := 'Реєстр проданої іноземної валюти(Ощадбанк)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:BRANCH=''Відділення'',:Param0=''Виконавець ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'R_VALSAL.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0'',:BRANCH=''Поточне''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with t as (
  select coalesce((select to_char(ov.dat, ''HH24:MI:SS'') from oper_visa ov where ov.ref = o.ref and ov.status = 2), to_char(o.pdat, ''HH24:MI:SS'')) as time_op,
         v.lcv as name,
         decode(o.dk, 1, o.kv, o.kv2) as kv,
         coalesce(decode(o.dk, 1, o.s2, o.s), 0)/100 as sum_n,
         coalesce(decode(o.dk, 1, o.s, o.s2), 0)/100 as sum_g,
         decode(w.value, null, coalesce(decode(o.dk, 1, o.s, o.s2), 0)/coalesce(decode(o.dk, 1, o.s2, o.s), 1), to_number(w.value, regexp_replace(w.value, ''\d'', ''9''))) as kurs,
         o.pdat,
         trim(o.nd) as nd1,
         trim(w1.value) as nd2,
         o.sos,
         substr(bp.val, 1, 80) as branch,
         p.val as adress,
         o.ref as true_ref
    from      oper              o
    join      tabval            v  on v.kv      = decode(o.dk, 0, o.kv, o.kv2)
    left join operw             w  on w.ref     = o.ref     and w.tag like ''KUR%''
    join      operw             w1 on w1.ref    = o.ref     and w1.tag = ''ND377''
    join      branch            b  on b.branch  = o.branch
    join      branch_parameters bp on bp.branch = sys_context(''bars_context'', ''user_branch'') and bp.tag = ''NAME_BRANCH''
    join      branch_parameters p  on p.branch  = bp.branch and p.tag = ''ADR_BRANCH''
   where o.pdat >= to_date(:sFdat1, ''DD/MM/YYYY'')
     and o.pdat < to_date(:sFdat1, ''DD/MM/YYYY'') + 1
     and ((o.dk = 0 and o.kv <> 980 and o.kv2 = 980 and substr(o.nlsa, 1, 3) = ''100''
           or
           o.dk = 1 and o.kv = 980 and o.kv2 <> 980 and substr(o.nlsb, 1, 3) = ''100''))
     and o.branch like case :BRANCH
                         when ''Поточне'' then sys_context(''bars_context'', ''user_branch'')
                         else :BRANCH
                       end||''%''
     and o.userid = decode(:Param0, ''0'', o.userid, to_number(:Param0))),
t_sum as (
  select name, kv,
         sum(sum_n) as sum_n,
         sum(sum_g) as sum_g,
         kurs
    from t t3
   where t3.sos = 5
   group by name, kv, kurs)
select :sFdat1 as DAT, t1.TIME_OP, t1.NAME, 0 as REF, t1.KV, t1.SUM_N, t1.SUM_G, t1.KURS, t1.PDAT, t1.ND1, t1.ND2, t1.SOS, t1.BRANCH, t1.ADRESS,
       null as DATS, null as NAME2, null as SUM_N2, ''1'' as IS_SAL, null as UNDERLINE
  from t t1
 where t1.sos = 5
 union all
select :sFdat1 as DAT, t2.TIME_OP, t2.NAME, 0 as REF, t2.KV, t2.SUM_N, t2.SUM_G, t2.KURS, t2.PDAT, t2.ND1, t2.ND2, t2.SOS, t2.BRANCH, t2.ADRESS,
       ov.backtime DATS, null as NAME2, null as SUM_N2, ''1'' as IS_SAL, null as UNDERLINE
  from t t2,
       (select to_char(dat, ''HH24:MI:SS'') backtime, ref from oper_visa where status = 3 and groupid is null) ov
 where t2.sos < 0
   and ov.ref = t2.true_ref
 union all
select :sFdat1 as DAT, null as TIME_OP, ''Всього: ''||name as NAME, -1 as REF, t3.KV, t3.SUM_N, t3.SUM_G, t3.KURS,
       to_date(:sFdat1, ''DD/MM/YYYY'') as PDAT, null as ND1, null as ND2, 0 SOS, null as BRANCH, null as ADRESS,
       null as DATS, null as NAME2, null as SUM_N2, ''1'' as IS_SAL, null as UNDERLINE
  from t_sum t3
 union all --COBUMMFO-10857 MDom т.я. банк користується тільки шаблоном QRP, довелося робити додаткові рядки
select :sFdat1 as DAT, null as TIME_OP, null as name, -2 as REF, t4.KV,
       null as sum_n, null as sum_g,
       null as KURS, null as PDAT, null as ND1, null as ND2, null as SOS, null as BRANCH, null as ADRESS, null as DATS,
       ''Усього куплено/продано за валютою ''||val.kv||'':'' as NAME2,
       f_sumpr(nSum_      => t4.SUM_N*100,
               nCcyCode_  => val.kv,
               strGender_ => val.gender) as SUM_N2, null as IS_SAL, ''-------'' as UNDERLINE
  from t_sum t4
  join tabval val on val.lcv = t4.name
 ORDER BY 3 desc, 4, 7, 8';
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

    ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='Реєстр проданої іноземної валюти(Ощадбанк)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 70; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 202;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' изменен.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;                                  
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     

exec umu.add_report2arm(202,'$RM_WCAS');
exec umu.add_report2arm(202,'$RM_WDOC');
exec umu.add_report2arm(202,'$RM_DRU1');
exec umu.add_report2arm(202,'$RM_MAIN');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_55.sql =========*** End **
PROMPT ===================================================================================== 
