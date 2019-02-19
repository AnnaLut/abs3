

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_REP_101012.sql =========*** R
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Звіт данні пов''язаних осіб
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
   l_zpr.name := 'Звіт данні пов''язаних осіб';
   l_zpr.pkey := '\BRS\SBER\REP\101012';

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
    l_zpr.name         := 'Звіт данні пов''язаних осіб';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''(%) усі, діапазон дат через кому (01.01.2018,30.01.2018), або (Оператор)'',:sFdat1=''Дата виповнення 25/45 років (Оператор)(Дата)'',:Param1=''(%) усі, або (Оператор)'',:sFdat2=''Термін дії паспорта (Оператор)(Дата)'',:photo=''Наявність велеєного фото (1-да, 2-ні, 0 - усі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'PPasRel.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''%'',:Param1=''%'',:photo=''0''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select c.nmk,
       c.okpo,
       vcr.name,
       to_char(vcr.birthday,''dd.mm.yyyy'') birthday,
       to_char(vcr.doc_date,''dd.mm.yyyy'') doc_date,
       to_char(vcr.date_photo,''dd.mm.yyyy'') date_photo,
       decode(vcr.doc_type,1,''not ID'','''')||to_char(vcr.actual_date,''dd.mm.yyyy'') actual_date,
       to_char(trunc(add_months(vcr.birthday,12*25),''DD''),''dd.mm.yyyy'') day25,
       to_char(trunc(add_months(vcr.birthday,12*45),''DD''),''dd.mm.yyyy'') day45,
       (SELECT psp.name FROM passp psp WHERE psp.passp=vcr.doc_type) doc_type
  from v_cust_relations vcr,
       customer c,
       (select trim(:Param0) param0,
               trim(:Param1) param1,
               trim(:photo) photo,
               trunc(to_date(:sFdat1,''dd.mm.yyyy''),''DD'') sFdat1,
               trunc(to_date(:sFdat2,''dd.mm.yyyy''),''DD'') sFdat2
          from dual
       ) params
 where c.rnk=vcr.rnk
       AND C.CUSTTYPE=2
       AND C.DATE_OFF IS NULL
       and (case when param0 = ''%''
                 then 1
                 when param0 = ''='' and trunc(add_months(vcr.birthday,12*45),''DD'')=sFdat1--Умова по кількості повних років
                 then 1
                 when param0 = ''>'' and add_months(vcr.birthday,12*45)>sFdat1
                 then 1
                 when param0 = ''<'' and add_months(vcr.birthday,12*45)<sFdat1
                 then 1
                 when param0 = ''>='' and trunc(add_months(vcr.birthday,12*45),''DD'')>=sFdat1
                 then 1
                 when param0 = ''<='' and trunc(add_months(vcr.birthday,12*45),''DD'')<=sFdat1
                 then 1
                 when param0 = ''<>'' and trunc(add_months(vcr.birthday,12*45),''DD'')<>sFdat1
                 then 1
                 when param0 = ''='' and trunc(add_months(vcr.birthday,12*25),''DD'')=sFdat1
                 then 1
                 when param0 = ''>'' and add_months(vcr.birthday,12*25)>sFdat1
                 then 1
                 when param0 = ''<'' and add_months(vcr.birthday,12*25)<sFdat1
                 then 1
                 when param0 = ''>='' and trunc(add_months(vcr.birthday,12*25),''DD'')>=sFdat1
                 then 1
                 when param0 = ''<='' and trunc(add_months(vcr.birthday,12*25),''DD'')<=sFdat1
                 then 1
                 when param0 = ''<>'' and trunc(add_months(vcr.birthday,12*25),''DD'')<>sFdat1
                 then 1
                 when param0 like ''%,%'' and (trunc(add_months(vcr.birthday,12*25),''DD'') between  (to_date(regexp_substr(param0, ''[^,]+'', 1, 1),''dd.mm.yyyy'')) and (to_date(regexp_substr(param0, ''[^,]+$'', 1, 1),''dd.mm.yyyy'')))
                 then 1
                 when param0 like ''%,%'' and (trunc(add_months(vcr.birthday,12*45),''DD'') between  (to_date(regexp_substr(param0, ''[^,]+'', 1, 1),''dd.mm.yyyy'')) and (to_date(regexp_substr(param0, ''[^,]+$'', 1, 1),''dd.mm.yyyy'')))
                 then 1
                else 0
            end =1)
       and (case when param1 = ''%''
                 then 1
                 when param1 = ''='' and trunc(vcr.actual_date,''DD'')=sFdat2--Умова по терміну діЇ паспорту
                 then 1
                 when param1 = ''>'' and trunc(vcr.actual_date,''DD'')>sFdat2
                 then 1
                 when param1 = ''<'' and trunc(vcr.actual_date,''DD'')<sFdat2
                 then 1
                 when param1 = ''>='' and trunc(vcr.actual_date,''DD'')>=sFdat2
                 then 1
                 when param1 = ''<='' and trunc(vcr.actual_date,''DD'')<=sFdat2
                 then 1
                 when param1 = ''<='' and trunc(vcr.actual_date,''DD'')<=sFdat2
                 then 1
                 when param1 = ''<>'' and trunc(add_months(vcr.birthday,12*25),''DD'') <> sFdat2
                 then 1
                else 0
             end=1
            )
       and (case when photo = ''1'' and vcr.date_photo is not null
                 then 1
                 when photo = ''2'' and vcr.date_photo is null
                 then 1
                 when photo = ''0''
                 then 1
                else 0
             end=1
            ) ';
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
    l_rep.description :='Звіт данні пов''язаних осіб';
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
    l_rep.id          := 101012;


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

exec umu.add_report2arm(101012,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_REP_101012.sql =========*** E
PROMPT ===================================================================================== 
