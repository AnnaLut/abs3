prompt ===================================== 
prompt == Звіт з реалізації пам''ятних монет
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
   l_zpr.name := 'Звіт з реалізації пам''ятних монет';
   l_zpr.pkey := '\BRS\SBM\REP\699';

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
    l_zpr.name         := 'Звіт з реалізації пам''ятних монет';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:BRANCH=''Відділення''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'mon699.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select'||nlchr||
                           '   kod, '||nlchr||
                           '   branch,'||nlchr||
                           '   (select namemoney from spr_mon where kod_money = kod) as name,'||nlchr||
                           '   (select namemetal from spr_mon where kod_money = kod) as metal,'||nlchr||
                           '   nom,'||nlchr||
                           '   sum(kk) as kol'||nlchr||
                           '   from('||nlchr||
                           'select                   branch, '||nlchr||
                           '                             ref, '||nlchr||
                           '      (select distinct nvl((kod_nbu),kod) from bank_mon where kod = f_dop(REF, ''BM__C'') and rownum = 1 and kod_nbu is not null )  as kod, '||nlchr||
                           '      f_dop(REF, ''BM__N'') as name,'||nlchr||
                           '      f_dop(REF, ''BM__Y'') as nom,'||nlchr||
                           '      f_dop(REF, ''BM__K'') as kk'||nlchr||
                           '   from oper where ref in ('||nlchr||
                           'SELECT distinct ref'||nlchr||
                           '  FROM opldok o, v_gl a'||nlchr||
                           ' WHERE o.acc = a.acc '||nlchr||
                           '   AND a.nbs = ''2909''  AND ob22 = ''23'''||nlchr||
                           '  and fdat in (select fdat from saldoa where acc = a.acc and  fdat between :sFdat1 and :sFdat2)'||nlchr||
                           '  and branch like :BRANCH                    '||nlchr||
                           '    )'||nlchr||
                           '    )'||nlchr||
                           '     group by  ( branch, kod,  name, nom)'||nlchr||
                           '     order by   branch ';
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
    l_rep.description :='Звіт з реалізації пам''ятних монет';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',8,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 699;


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
