prompt ===================================== 
prompt == ���������� ������ �� ������� (rahun.dbf) (super_new)
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
   l_zpr.name := '���������� ������ �� ������� (rahun.dbf) (super_new)';
   l_zpr.pkey := '\BRS\SBER\***\47';

   l_message  := '���� �������: '||l_zpr.pkey||'  '||nlchr;

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
    l_zpr.name         := '���������� ������ �� ������� (rahun.dbf) (super_new)';
    l_zpr.namef        := '27_rahun';
    l_zpr.bindvars     := ':Param0=''���� �������� <=''';
    l_zpr.create_stmt  := 'KU NUMBER(2), REGION CHAR(15),'||nlchr||
                           'Fizpot_NV NUMBER(8),'||nlchr||
                           'Fizpot_N NUMBER(8),'||nlchr||
                           'Pens_20V NUMBER(8),'||nlchr||
                           'Pens_2LI NUMBER(8),'||nlchr||
                           'Fizpot_IN NUMBER(8),'||nlchr||
                           'Kart_NV NUMBER(8),'||nlchr||
                           'Kart_IN NUMBER(8),'||nlchr||
                           'Fizstr_NV NUMBER(8),'||nlchr||
                           'Fizstr_N NUMBER(8),'||nlchr||
                           'Fizstr_IN NUMBER(8)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT 
  27 KU, 
  ''��� ���������'' REGION, 
  C3.CNT Fizpot_NV, 
  C4.cnt Fizpot_N, 
  C5.cnt Pens_20v, 
  C14.cnt Pens_2li, 
  C6.CNT Fizpot_IN, 
  C7.CNT Kart_NV, 
  C8.CNT Kart_IN, 
  C9.CNT Fizstr_NV, 
  C10.cnt Fizstr_N, 
  C11.CNT Fizstr_IN
FROM 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS LIKE ''2620'' AND KV=980 AND (DAZS IS NULL or dazs>:Param0) AND DAOS<=:Param0) C3, 
  (SELECT COUNT(a.acc) CNT FROM ACCOUNTS a, specparam_int s WHERE a.NBS =''2620'' AND a.KV=980 AND (a.DAZS IS NULL or a.dazs>:Param0) and s.acc=a.acc and s.ob22 in (''08'',''09'',''11'',''12'') AND DAOS<=:Param0) C4, 
  (SELECT COUNT(a.acc) CNT FROM ACCOUNTS a, specparam_int s WHERE a.NBS =''2620'' AND a.KV=980 AND (a.DAZS IS NULL or a.dazs>:Param0) and s.acc=a.acc and s.ob22 = ''20'' AND DAOS<=:Param0) C5, 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2620'' AND KV<>980 AND (DAZS IS NULL or dazs>:Param0) AND DAOS<=:Param0) C6, 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2625'' AND NLS NOT LIKE ''2625__8%'' AND KV=980 AND (DAZS IS NULL or dazs>:Param0) AND DAOS<=:Param0) C7, 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2625'' AND NLS NOT LIKE ''2625__8%'' AND KV<>980 AND (DAZS IS NULL or dazs>:Param0) AND DAOS<=:Param0) C8, 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2630'' AND KV=980 AND (DAZS IS NULL or dazs>:Param0) AND DAOS<=:Param0) C9, 
  (SELECT COUNT(a.acc) CNT FROM ACCOUNTS a, specparam_int s WHERE a.NBS =''2630'' and s.ob22 in (''11'',''12'',''13'',''14'',''B6'',''B7'',''B8'',''B9'') AND a.KV=980 AND (a.DAZS IS NULL or a.dazs>:Param0) and s.acc=a.acc AND DAOS<=:Param0) C10, 
  (SELECT COUNT(*) CNT FROM ACCOUNTS WHERE NBS =''2630'' AND KV<>980 AND (DAZS IS NULL or dazs>:Param0) AND DAOS<=:Param0) C11, 
  (SELECT COUNT(a.acc) CNT FROM ACCOUNTS a, specparam_int s WHERE a.NBS =''2620'' AND a.KV=980 AND (a.DAZS IS NULL or a.dazs>:Param0) and s.acc=a.acc and s.ob22 = ''21'' AND DAOS<=:Param0) C14 ';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'�������� ����� ���.������ �'||l_zpr.kodz||'.'; 
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
       l_message:=l_message||'���.������ c ����� ������ ��� ���������� ��� �'||l_zpr.kodz||', ��� ��������� ��������.'; 
                                                           
    end if;                                                
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
