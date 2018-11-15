

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_REP693.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Рахунки та акти 3570/04
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
   l_zpr.name := 'Рахунки та акти 3570/04';
   l_zpr.pkey := '\BRS\SBER\REP693';

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
    l_zpr.name         := 'Рахунки та акти 3570/04';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:p_branch=''Маска бранчу'',:p_coun=''Кількість екземплярів''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep693.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_branch=''%'',:p_coun=''1''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with par as (    select  /*+ materialize*/'||nlchr||
                           '                            (SELECT VAL FROM bars.PARAMS WHERE PAR = ''BOSS'') AS BOSS,'||nlchr||
                           '                            (SELECT VAL FROM bars.PARAMS WHERE PAR = ''ACCMAN'') AS buch,'||nlchr||
                           '                            (SELECT VAL FROM bars.PARAMS WHERE PAR = ''NAME'') AS name,'||nlchr||
                           '                            (SELECT VAL FROM bars.PARAMS WHERE PAR = ''ADDRESS'') AS adres,'||nlchr||
                           '                            num'||nlchr||
                           '                            from conductor  where num <=:p_coun'||nlchr||
                           '             ),'||nlchr||
                           ' cl as (  select  /*+ materialize*/ a.acc, a.nls, c.*, cs.RUK, s.fdat'||nlchr||
                           '    from bars.accounts a, bars.saldoa s ,  bars.customer c, bars.CORPS CS                 '||nlchr||
                           'where (a.nbs = ''3570'' and a.ob22 = ''04'') and a.acc = s.acc and s.fdat between to_date(:sFdat1,''dd-mm-yyyy'') and to_date(:sFdat2,''dd-mm-yyyy'')'||nlchr||
                           '  and c.rnk = a.rnk'||nlchr||
                           '  and a.branch like decode(:p_branch, null, ''%'', :p_branch)'||nlchr||
                           '  AND C.RNK = CS.RNK(+))             '||nlchr||
                           'select max(o.ref) as ref, '||nlchr||
                           '       bars.F_DAT_LIT(to_date(:sFdat2,''dd-mm-yyyy''), ''UAH'') as fdat, '||nlchr||
                           '       bars.f_ourmfo as mfo, '||nlchr||
                           '       bars.f_ourokpo as okpob, '||nlchr||
                           '       a.nls nlsa, '||nlchr||
                           '       max(o.nazn) nazn,                                                  '||nlchr||
                           '       sum(p.s)/100 as sump, '||nlchr||
                           '       a.NMK,'||nlchr||
                           '       case when a.custtype = 2 then nvl(a.RUK,''____________________________________________'') else nvl(a.RUK,'' '') end as ruk, '||nlchr||
                           '       bars.f_sumpr(sum(p.s), ''980'', ''F'' ) as fsumpr,'||nlchr||
                           '       par.boss  AS BOSS,'||nlchr||
                           '       par.buch  AS buch,'||nlchr||
                           '       par.name  AS name,'||nlchr||
                           '       par.adres AS adres,'||nlchr||
                           '       num'||nlchr||
                           ' from cl a, bars.opldok p, bars.opldok p1,   bars.oper o, par                  '||nlchr||
                           'where  p.fdat = a.fdat and p.acc = a.acc and p.dk=0    '||nlchr||
                           '      and p1.ref = p.ref and p1.stmt = p.stmt and p1.fdat = p.fdat '||nlchr||
                           '      AND p1.dk = 1 '||nlchr||
                           '      and exists ( SELECT acc  FROM bars.accounts   WHERE   nbs = ''6510'' )'||nlchr||
                           '      and o.ref = p.ref  '||nlchr||
                           '      and p.sos >= 1'||nlchr||
                           '  group by a.nmk, a.RUK, a.nls , a.custtype, par.boss, par.buch,par.name,    par.adres, num       '||nlchr||
                           '  order by a.nmk';
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
    l_rep.description :='Рахунки та акти 3570/04';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 693;


    if l_isnew = 2 then                     
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

exec umu.add_report2arm(693,'$RM_BVBB');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_REP693.sql =========*** End *
PROMPT ===================================================================================== 
