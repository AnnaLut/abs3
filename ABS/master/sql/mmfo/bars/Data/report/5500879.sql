prompt ===================================== 
prompt == Отчет движения средств по 2620,2625,2628,2630,2635(в разрезе)
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
   l_zpr.name := 'Отчет движения средств по 2620,2625,2628,2630,2635(в разрезе)';
   l_zpr.pkey := '\BRS\SBM\OTC\121214';

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
    l_zpr.name         := 'Отчет движения средств по 2620,2625,2628,2630,2635(в разрезе)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '26_bal1.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT :sFdat1 DAT1, :sFdat2 DAT2,    
                     decode(t.b040 ,NULL,''04'',substr(t.b040,9,12)) TOBO, 
                     a1.nbs NBSA_D,  a2.nbs NBSB_D,   
          sum(decode(op1.dk,0,op1.s,0))/100 SD,     
          a2.nbs NBSA_K, a1.nbs NBSB_K,    
          sum(decode(op1.dk,1,op1.s,0))/100 SK   
FROM accounts a1, accounts a2, opldok op1, opldok op2, tobo t 
WHERE op1.fdat>=:sFdat1 AND op1.fdat<=:sFdat2 AND    
                op2.fdat>=:sFdat1 AND op2.fdat<=:sFdat2 AND    
      op1.acc=a1.acc  
      AND a1.nbs in (''2620'',''2625'',''2628'',''2630'',''2638'')     
         AND op1.SOS=5 AND op2.dk=1-op1.dk   
                    AND op1.ref=op2.ref       ---OAB 15.1.2004  
                    AND op1.tt=op2.tt            ---  
                    AND op1.fdat=op2.fdat   ---  
                    AND op1.s=op2.s             ---  
---      AND op1.stmt=op2.stmt    
         AND a2.acc=op2.acc  AND a1.kv=980 AND a2.kv=980  
         AND nvl(a1.tobo,0)=t.tobo(+)  
GROUP BY decode(t.b040,NULL,''04'',substr(t.b040,9,12)), a1.nbs, a2.nbs 
ORDER BY 3,4';
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
