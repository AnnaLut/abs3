prompt ===================================== 
prompt == Звіт про вилучення коштів із ЦРНВ
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
   l_zpr.name := 'Звіт про вилучення коштів із ЦРНВ';
   l_zpr.pkey := '\BRS\SBR\***\3037';

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
    l_zpr.name         := 'Звіт про вилучення коштів із ЦРНВ';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':BRANCH=''Код відділення'',:sFdat1=''Дата з:'',:sFdat2=''Дата по:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep3037.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''BRANCH|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select rownum rown,nls,KV,Source,FIO,OST,branch,comments,fl,kol,dat1,dat2'||nlchr||
                           ' from (select a.NLS nls,'||nlchr||
                           '       a.KV KV,'||nlchr||
                           '       a.Source Source,'||nlchr||
                           '       a.FIO FIO,'||nlchr||
                           '       a.OST/100 OST,'||nlchr||
                           '       a.branch branch,'||nlchr||
                           '       a.comments comments, '||nlchr||
                           '       a.fl fl,'||nlchr||
                           '       1 kol,'||nlchr||
                           '       :sFdat1 dat1,'||nlchr||
                           '       :sFdat2 dat2 '||nlchr||
                           '       from asvo_immobile a'||nlchr||
                           '              where a.fl = 15 '||nlchr||
                           '              and a.branch like  substr(:BRANCH,8)||''%'''||nlchr||
                           '              and A.KV  = 980'||nlchr||
                           '              and a.ost <=10000'||nlchr||
                           '              and A.DATE_OFF between  :sFdat1 and :sFdat2)';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
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
    l_rep.description :='Звіт про вилучення коштів із ЦРНВ';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

 -- Фиксированный № печатного отчета   
    l_rep.id          := 3037;


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