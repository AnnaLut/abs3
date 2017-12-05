prompt ===================================== 
prompt == Количество счетов по классам (rahun.dbf)
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
   l_zpr.name := 'Количество счетов по классам (rahun.dbf)';
   l_zpr.pkey := '\OLD\***\***\169';

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
    l_zpr.name         := 'Количество счетов по классам (rahun.dbf)';
    l_zpr.namef        := '27_rahun';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := 'KU NUMBER(2), REGION CHAR(15), R25 NUMBER(8),
'||nlchr||
                           ''||nlchr||
                           'R260_261 NUMBER(8),R2620_NV NUMBER(8),R2620_IN NUMBER(8),
'||nlchr||
                           ''||nlchr||
                           'R2625_NV NUMBER(8),R2625_IN NUMBER(8),R2630_NV NUMBER(8),
'||nlchr||
                           ''||nlchr||
                           'R2630_IN NUMBER(8),R2635_NV NUMBER(8),R2635_IN NUMBER(8)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT 
  27 KU,
  ''ГОУ Ощадбанку'' REGION,
  C1.CNT R25,
  C2.CNT R260_261,
  C3.CNT R2620_NV,
  C4.CNT R2620_IN,
  C5.CNT R2625_NV,
  C6.CNT R2625_IN,
  C7.CNT R2630_NV,
  C8.CNT R2630_IN 
FROM 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS LIKE ''25%'') C1,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS LIKE ''260%'' OR NBS LIKE ''261%'') C2,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2620'' AND KV=980) C3,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2620'' AND KV<>980) C4,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2625'' AND KV=980) C5,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2625'' AND KV<>980) C6,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2630'' AND KV=980) C7,
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2630'' AND KV<>980) C8';
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
