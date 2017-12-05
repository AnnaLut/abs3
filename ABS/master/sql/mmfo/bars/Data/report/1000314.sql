prompt ===================================== 
prompt == 1. Інвентаризація кредитів
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
   l_zpr.name := '1. Інвентаризація кредитів';
   l_zpr.pkey := '\OLD\***\***\193';

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
    l_zpr.name         := '1. Інвентаризація кредитів';
    l_zpr.namef        := 'inv_kred';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''0'',
       ''300465'',
       substr(tab1.NMK,1,40) "Name",
       tab1.NBS,        		
       tab1.NLS,            
       ''№№'',
       tab1.DataOp "DateOper",
       '' '',
       '' '',
       ''12345678901234'',
       ''999,999.99'',
       tab1.IR "PS",
       abs(s.ost/100) "Summa",
       a.nls,
       abs(i.s/100)
from accounts a,
     ( select c.NMK,      
              a.NBS,      
              a.NLS,      
              a.DAOS DataOp,
              i.IR,      
              abs(a.OSTC/100) summa1,
              a.acc
       from
          Accounts a,
          Customer c,
          Cust_Acc d,
          Int_Ratn i
       where
          a.ACC = d.ACC and 
          c.RNK = d.RNK and
          a.ACC = i.ACC and
          ( ( a.NBS in (2210,2211,2213,2214,2216,2217,2290,2291) and 
              a.KV  = 980 ) or
            ( a.NBS = 2201 and a.KV = 840 and substr(a.NMS,1,2)=''ОЖ'' ) or
            ( a.NBS = 2214 and a.KV = 840 ) ) and
          dazs is null ) tab1,
     int_accn i,
     sal s
where   i.acra   = a.acc and
        tab1.acc = i.acc and
      ( tab1.acc = s.acc and s.fdat = ''29/03/2002'' )
order by tab1.nmk';
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
