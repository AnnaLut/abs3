prompt ===================================== 
prompt ==  Вантажно-митнi декларацiї (MМ)
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
   l_zpr.name := 'Вантажно-митнi декларацiї (MМ)';
   l_zpr.pkey := '\OLD\SBER\***\5900';

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
    l_zpr.name         := 'Вантажно-митнi декларацiї (MМ)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5900.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select SUBSTR(CONVERT(DOC    , ''CL8MSWIN1251'',''RU8PC866''),1,50)  '||nlchr||
                           '                      DOC    ,  '||nlchr||
                           '       S, CDAT, ISNULL, NDAT, MDAT,  '||nlchr||
                           '       SUBSTR(CONVERT(CTYPE  , ''CL8MSWIN1251'',''RU8PC866''),1,2)  '||nlchr||
                           '                      CTYPE  ,  '||nlchr||
                           '       CNUM_CST, CNUM_YEAR, CNUM_NUM, '||nlchr||
						   '      CONVERT(MVM_FEAT  , ''CL8MSWIN1251'',''RU8PC866'')  '||nlchr||
						   '                            MVM_FEAT, S_OKPO,  '||nlchr||
                           '       SUBSTR(CONVERT(S_NAME , ''CL8MSWIN1251'',''RU8PC866''),1,200)  '||nlchr||
                           '                      S_NAME ,  '||nlchr||
                           '       SUBSTR(CONVERT(S_ADRES, ''CL8MSWIN1251'',''RU8PC866''),1,200)  '||nlchr||
                           '                      S_ADRES,  '||nlchr||
                           '       S_TYPE, S_TAXID, R_OKPO,  '||nlchr||
                           '       SUBSTR(CONVERT(R_NAME , ''CL8MSWIN1251'',''RU8PC866''),1,200)  '||nlchr||
                           '                      R_NAME ,  '||nlchr||
                           '       CONVERT(R_ADRES, ''CL8MSWIN1251'',''RU8PC866'')  '||nlchr||
                           '                      R_ADRES,  '||nlchr||
                           '       R_TYPE, R_TAXID, F_OKPO,  '||nlchr||
                           '       SUBSTR(CONVERT(F_NAME , ''CL8MSWIN1251'',''RU8PC866''),1,200)  '||nlchr||
                           '                      F_NAME ,  '||nlchr||
                           '       CONVERT(F_ADRES, ''CL8MSWIN1251'',''RU8PC866'')  '||nlchr||
                           '                      F_ADRES,  '||nlchr||
                           '       F_TYPE, F_TAXID, F_COUNTRY,  '||nlchr||
                           '       UAH_NLS, CCY_NLS, KV, KURS,  '||nlchr||
                           '       ALLOW_DAT, CMODE_CODE, BEG_DATE, END_DATE, DAT, '||nlchr||
                           '       CHARACTER, FN_MM, UAH_MFO_NEW , CCY_MFO_NEW,  '||nlchr||
                           '       case when kv = 980 then UAH_MFO_NEW else CCY_MFO_NEW end  '||nlchr||
                           '                     NEW_MFO, '||nlchr||
                           '       case when kv = 980 then UAH_MFO else CCY_MFO end  '||nlchr||
                           '                     OLD_MFO '||nlchr||
                           '       from vmd  '||nlchr||
                           'WHERE dat>=:sFdat1 AND dat-0.9999<=:sFdat2 and UAH_MFO =F_OURMFO  '||nlchr||
                           '      and FN_MM like ''MM%''  '||nlchr||
                           '';
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
    l_rep.description :='Вантажно-митнi декларацiї (MM)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5900;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id||'.';
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id||'.';
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
    
    begin
    Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_WCIM', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в "АРМ Валютний контроль "';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в "АРМ Валютний контроль "';
    end;        
                                  
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;