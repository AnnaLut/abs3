prompt ===================================== 
prompt == Инспекция НБУ (запрос по письму)
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
   l_zpr.name := 'Инспекция НБУ (запрос по письму)';
   l_zpr.pkey := '\OLD\***\***\209';

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
    l_zpr.name         := 'Инспекция НБУ (запрос по письму)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT ''300465'' MFO, a.NBS,  c.NMK FIO, c.OKPO,
       ltrim(w.VALUE||''  ''||c.ADR)   INDEX_ADR,
       ltrim(p.SER||''  ''||p.NUMDOC)  PASPORT,
       a.NLS, 
       nvl(d.ND,to_char(d.DEPOSIT_ID)) N_DOG,
       a.KV VAL,   
       d.DAT_BEGIN, d.DAT_END,
       acrn.fproc(a.ACC,to_date(''01/10/2007'',''dd/mm/yyyy'')) PROC,
       fost(a.acc,to_date(''31/08/2007'',''dd/mm/yyyy'')) OST_010907,
       fdos(a.acc,to_date(''01/09/2007'',''dd/mm/yyyy''),to_date(''30/09/2007'',''dd/mm/yyyy'')) DOS_0907,
       fkos(a.acc,to_date(''01/09/2007'',''dd/mm/yyyy''),to_date(''30/09/2007'',''dd/mm/yyyy'')) KOS_0907,
       fost(a.acc,to_date(''28/09/2007'',''dd/mm/yyyy'')) OST_011007,
       fdos(a.acc,to_date(''01/10/2007'',''dd/mm/yyyy''),to_date(''31/10/2007'',''dd/mm/yyyy'')) DOS_1007,
       fkos(a.acc,to_date(''01/10/2007'',''dd/mm/yyyy''),to_date(''31/10/2007'',''dd/mm/yyyy'')) KOS_1007,
       fost(a.acc,to_date(''31/10/2007'',''dd/mm/yyyy'')) OST_011107
FROM  Accounts a, Customer c, Person p, Dpt_Deposit d, CustomerW w
WHERE 
  a.RNK=c.RNK and c.RNK=p.RNK(+) and a.ACC=d.ACC(+) and
  c.RNK=w.RNK(+) and w.TAG(+)=''FGIDX'' and
  a.NBS in (''2600'',''2620'',''2625'',''2630'') and 
 (( fost(a.acc,to_date(''28/09/2007'',''dd/mm/yyyy''))>=1000000 and a.KV=980 )  OR
  ( fost(a.acc,to_date(''28/09/2007'',''dd/mm/yyyy''))>= 500000 and a.KV=840 )  OR
  ( fost(a.acc,to_date(''28/09/2007'',''dd/mm/yyyy''))>= 500000 and a.KV=978 ))
ORDER BY 2';
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
