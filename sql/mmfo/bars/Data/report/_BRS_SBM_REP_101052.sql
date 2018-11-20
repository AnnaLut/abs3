

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_101052.sql =========*** Ru
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Cальдова вiдомiсть Пiдроздiлу по OB22
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
   l_zpr.name := 'Cальдова вiдомiсть Пiдроздiлу по OB22';
   l_zpr.pkey := '\BRS\SBM\REP\101052';

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
    l_zpr.name         := 'Cальдова вiдомiсть Пiдроздiлу по OB22';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:nls_z=''Б/Рахунок_З_(%вс_)'',:nls_po=''Б/Рахунок_ПО_(%вс_)'',:kv=''Вал(%вс_)'',:kf=''Код_в_дд_лення(виб_р)'',:ob22=''OB22_Один__з(01,02..10)'',:tag1=''TAG in (tag1, tag2, tag3) <br> <b>tag1 </b> '',:tag2''<b>tag2 </b> '',:tag3=''<b>tag3 </b> ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'OWPay.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':nls_z=''%'',:nls_po=''%'',:kf=''%'',:ob22=''%'',:kv=''%'',:tag1=''OW_DS'',:tag2=''OW_LD'',:tag3=''OWDRN''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select op.ref,
       op.tt, 
       nam_a, 
       nam_b, 
       --op.s,op.dk,
       op.s*(decode(dk,0,1,0)) debit,
       op.s*op.dk credit,
       nazn, 
       pdat, 
       vdat, 
       (select value from operw opw 
         where opw.ref=op.ref
               and opw.tag in (''OW_DS'')) edesc, --доп реквизит описание way4
       (select value from operw opw 
         where opw.ref=op.ref
               and opw.tag in (''OW_LD'')) edate, --доп реквизит date
       (select value from operw opw 
         where opw.ref=op.ref
               and opw.tag in (''OWDRN'')) eref  
  from oper op
       
 where op.pdat between to_date(:sFdat1,''dd.mm.yyyy'') and to_date(:sFdat2,''dd.mm.yyyy'')
       and op.branch like :kf||''%''
       and op.kv like :kv
       and 0<(select count(acc) --проверка на нужный ОВ22
                from accounts acc
               where ((op.nlsa=acc.nls and op.kv=acc.kv) or (op.nlsb=acc.nls and acc.kv=op.kv2))
                     and nbs between decode(:nls_z,''%'',nbs,:nls_z) and decode(:nls_po,''%'',nbs,:nls_po) 
                     and acc.kf=op.kf
                     and acc.ob22 like :ob22
                     )
       and 0<(select count(tag) --Поиск по заданым тегам
                from operw opw 
               where op.ref=opw.ref
                     and opw.tag in (:tag1,:tag2,:tag3)) ';
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
    l_rep.description :='Cальдова вiдомiсть Пiдроздiлу по OB22';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 21; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 101052;


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

exec umu.add_report2arm(101052,'$RM_DRU1');
exec umu.add_report2arm(101052,'$BIL');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_101052.sql =========*** En
PROMPT ===================================================================================== 
