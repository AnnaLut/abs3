

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_54.sql =========*** Run **
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Реєстр купленої іноземної валюти(Ощадбанк)
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
   l_zpr.name := 'Реєстр купленої іноземної валюти(Ощадбанк)';
   l_zpr.pkey := '\BRS\SBM\REP\54';

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
    l_zpr.name         := 'Реєстр купленої іноземної валюти(Ощадбанк)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:BRANCH=''Відділення(всi-%)'',:Param0=''Виконавець ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'R_VALBUY.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0'',:BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with toper_main as (
  select o.ref, o.dk, o.kv, o.kv2, o.s, o.s2, o.pdat, o.nd, o.sos, o.userid, w.value, v.lcv, substr(bp.val, 1, 80) as branch, p.val as adress
    from oper              o
    join operw             w  on w.ref     = o.ref and w.tag = ''KURS''
    join tabval            v  on v.kv      = decode(o.dk, 1, o.kv, o.kv2)
    join branch_parameters p  on p.branch  = o.branch and p.tag = ''ADR_BRANCH''
    join branch_parameters bp on bp.branch = o.branch and bp.tag = ''NAME_BRANCH''
   where (o.sos = 5 or o.sos < 0)
     and o.pdat >= to_date(:sFdat1, ''DD/MM/YYYY'')
     and o.pdat < to_date(:sFdat1, ''DD/MM/YYYY'') + 1
     and o.branch like :BRANCH||''%''
     and o.userid = decode(:Param0, ''0'', o.userid, to_number(:Param0 /*було ''0''*/))
     and ((o.dk = 1 and o.kv <> 980 and o.kv2 = 980 and substr(o.nlsa, 1, 3) = ''100'')
          or
          (o.dk = 0 and o.kv = 980 and o.kv2 <> 980 and substr(o.nlsb, 1, 3) = ''100''))
     and o.tt <> ''202''),
toper_opldok as (
  select o.ref, v.lcv, a1.kv, op1.s as s_n, op2.s as s_g, c.rate_b, c.bsum, o.pdat, o.nd, o.sos, o.userid, SUBSTR(bp.val, 1, 80) as BRANCH, p.val as ADRESS
    from oper              o
    join opldok            op1 on op1.ref   = o.ref
    join opldok            op2 on op2.ref   = o.ref    and op1.tt  = op2.tt
    join v_gl              a1  on op1.dk    = 0        and op1.acc = a1.acc and substr(a1.nls, 1, 3) = ''100''
    join v_gl              a2  on op2.dk    = 1        and op2.acc = a2.acc and substr(a2.nls, 1, 3) = ''100''
    join cur_rates$base    c   on c.branch  = o.branch and c.vdate = o.vdat and c.kv                 = a1.kv
    join branch_parameters p   on p.branch  = o.branch and p.tag   = ''ADR_BRANCH''
    join branch_parameters bp  on bp.branch = o.branch and bp.tag  = ''NAME_BRANCH''
    join tabval            v   on v.kv = a1.kv
   where (o.sos = -2 or o.sos = 5)
     and o.pdat >= to_date(:sFdat1, ''DD/MM/YYYY'')
     and o.pdat < to_date(:sFdat1, ''DD/MM/YYYY'') + 1
     and o.branch like :BRANCH||''%''
     and o.userid = decode(:Param0, ''0'', o.userid, to_number(:Param0/*було ''0''*/))
     and op1.tt in (''VPF'', ''VPJ'', ''VPI'', ''046'', ''MUQ'', ''MVQ'')
     and ((a1.kv = 980 and a2.kv <> 980) or (a1.kv <> 980 and a2.kv = 980)))
select :sFdat1 as DAT,
       (select to_char(ov1.dat, ''HH24:MI:SS'') from oper_visa ov1 where ov1.ref = o.ref and ov1.status = 2) as TIME_OP,
       o.lcv as NAME,
       0 as REF,
       decode(o.dk, 1, o.kv, o.kv2) as KV,
       nvl(decode(o.dk, 1, o.s, o.s2), 0)/100 as SUM_N,
       nvl(decode(o.dk, 1, o.s2, o.s), 0)/100 as SUM_G,
       nvl(to_number(o.value, regexp_replace(o.value, ''\d'', ''9'')), 0) as KURS,
       o.pdat as PDAT,
       trim(o.nd) as ND1,
       case when trim(n.value) = ''1'' then to_char(o.ref) else null end AS ND2,
       o.sos as SOS,
       o.userid as USERID,
       o.branch as BRANCH,
       o.adress as ADRESS,
       null as DATS,
       null as NAME2, null as SUM_N2, ''0'' as IS_SAL, null as UNDERLINE
  from      toper_main o
  left join operw      n on n.ref = o.ref and n.tag = ''RE377''
 where o.sos = 5
 union all
select :sFdat1 as DAT,
       (select to_char(ov1.dat, ''HH24:MI:SS'') from oper_visa ov1 where ov1.ref = o.ref and ov1.status = 2) as TIME_OP,
       o.lcv as NAME,
       0 as REF,
       decode(o.dk, 1, o.kv, o.kv2) as KV,
       nvl(decode(o.dk, 1, o.s, o.s2), 0)/100 as SUM_N,
       nvl(decode(o.dk, 1, o.s2, o.s), 0)/100 as SUM_G,
       nvl(to_number(o.value, regexp_replace(o.value, ''\d'', ''9'')), 0) as KURS,
       o.pdat as PDAT,
       trim(o.nd) as ND1,
       case when trim(n.value) = ''1'' then to_char(o.ref) else null end AS ND2,
       o.sos as SOS,
       o.userid as USERID,
       o.branch as BRANCH,
       o.adress as ADRESS,
       decode(o.sos, -2, ov.backtime, null) as DATS,
       null as NAME2, null as SUM_N2, ''0'' as IS_SAL, null as UNDERLINE
  from      toper_main          o
  join (select to_char(dat, ''HH24:MI:SS'') backtime, ref
          from oper_visa
         where status = 3
           and groupid is null) ov on ov.ref = o.ref
  left join operw               n  on n.ref  = o.ref and n.tag = ''RE377''
 where o.sos < 0 
 union all
select :sFdat1 as DAT,
       (select to_char(ov1.dat, ''HH24:MI:SS'') from oper_visa ov1 where ov1.ref = o.ref and ov1.status = 2) as TIME_OP,
       o.lcv as NAME,
       0 as REF,
       o.kv as KV,
       o.s_n/100 as SUM_N,
       o.s_g/100 as SUM_G,
       o.rate_b/o.bsum as KURS,
       o.pdat as PDAT,
       trim(o.nd) as ND1,
       (case when trim(n.value) = ''1'' then to_char(o.ref) else null end) as ND2,
       o.sos as SOS,
       o.userid as USERID,
       o.branch as BRANCH,
       o.adress as ADRESS,
       decode(o.sos, -2, ov.backtime, null) as DATS,
       null as NAME2, null as SUM_N2, ''0'' as IS_SAL, null as UNDERLINE
  from      toper_opldok        o
  join (select to_char(dat, ''HH24:MI:SS'') backtime, ref 
          from oper_visa
         where status = 3
           and groupid is null) ov on ov.ref = o.ref
  left join operw               n  on n.ref  = o.ref and n.tag = ''RE377''
 where o.sos = -2
 union all
select :sFdat1 as DAT,
       (select to_char(ov1.dat, ''HH24:MI:SS'') from oper_visa ov1 where ov1.ref = o.ref and ov1.status = 2) as TIME_OP,
       o.lcv as NAME,
       0 as REF,
       o.kv as KV,
       o.s_n/100 as SUM_N,
       o.s_g/100 as SUM_G,
       o.rate_b/o.bsum as KURS,
       o.pdat as PDAT,
       trim(o.nd) as ND1,
       (case when trim(n.value) = ''1'' then to_char(o.ref) else null end) as ND2,
       o.sos as SOS,
       o.userid as USERID,
       o.branch as BRANCH,
       o.adress as ADRESS,
       null as DATS,
       null as NAME2, null as SUM_N2, ''0'' as IS_SAL, null as UNDERLINE
  from      toper_opldok o
  left join operw        n on n.ref = o.ref and n.tag = ''RE377''
 where o.sos = 5
 union all
select :sFdat1 as DAT, null as TIME_OP, ''Усього:''||lcv as NAME, -1 as REF, KV, sum(sum_n) as SUM_N, sum(sum_g) as SUM_G, KURS,
       bankdate as PDAT, null as ND1, null as ND2, 0 as SOS, 0 as USERID, null as BRANCH, '''' as ADRESS, '''' as DATS,
       null as NAME2, null as SUM_N2, ''0'' as IS_SAL, null as UNDERLINE
  from (select o.lcv,
               decode(o.dk, 1, o.kv, o.kv2) as KV,
               sum(nvl(decode(o.dk, 1, o.s, o.s2), 0))/100 as SUM_N,
               sum(nvl(decode(o.dk, 1, o.s2, o.s), 0))/100 as SUM_G,
               nvl(to_number(o.value, regexp_replace(o.value, ''\d'', ''9'')), 0) KURS
              from toper_main o
             where o.sos = 5
          group by decode(o.dk, 1, o.kv, o.kv2), o.lcv, nvl(to_number(o.value, regexp_replace(o.value, ''\d'', ''9'')), 0)
           union all
          select o.lcv,
                 o.kv,
                 sum(o.s_n/100) as SUM_N,
                 sum(o.s_g/100) as SUM_G,
                 o.rate_b/o.bsum as KURS
            from toper_opldok o
           where o.sos = 5
           group by o.kv, o.lcv, o.rate_b/o.bsum)
group by LCV, KV, KURS
 union all --COBUMMFO-10857 MDom т.я. банк користується тільки шаблоном QRP, довелося робити додаткові рядки
select :sFdat1 as DAT, null as TIME_OP, null as NAME, -2 as REF, KV, null as SUM_N, null as SUM_G, null as KURS, null as PDAT,
       null as ND1, null as ND2, null as SOS, null as USERID, null as BRANCH, '''' as ADRESS, '''' as DATS,
       ''Усього куплено/продано за валютою ''||kv||'': '' as NAME2,
       f_sumpr(nsum_      => sum(sum_n)*100,
               nccycode_  => kv,
               strgender_ => (select tv.gender from tabval tv where tv.kv = t.kv)) as SUM_N2,
       null as IS_SAL, ''-------'' as UNDERLINE
  from (select decode(o.dk, 1, o.kv, o.kv2) as KV,
               sum(nvl(decode(o.dk, 1, o.s, o.s2), 0))/100 as SUM_N,
               sum(nvl(decode(o.dk, 1, o.s2, o.s), 0))/100 as SUM_G,
               nvl(to_number(o.value, regexp_replace(o.value, ''\d'', ''9'')), 0) KURS
              from toper_main o
             where o.sos = 5
          group by decode(o.dk, 1, o.kv, o.kv2), nvl(to_number(o.value, regexp_replace(o.value, ''\d'', ''9'')), 0)
           union all
          select o.kv as KV,
                 sum(o.s_n/100) as SUM_N,
                 sum(o.s_g/100) as SUM_G,
                 o.rate_b/o.bsum as KURS
            from toper_opldok o
           where o.sos = 5
           group by o.kv, o.rate_b/o.bsum) t
group by KV, KURS
order by REF, KV, SUM_G, KURS';
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
    l_rep.description :='Реєстр купленої іноземної валюти(Ощадбанк)';
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
    l_rep.id          := 54;


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

exec umu.add_report2arm(54,'$RM_WCAS');
exec umu.add_report2arm(54,'$RM_WDOC');
exec umu.add_report2arm(54,'$RM_DRU1');
exec umu.add_report2arm(54,'$RM_MAIN');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_54.sql =========*** End **
PROMPT ===================================================================================== 
