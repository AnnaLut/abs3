prompt ===================================== 
prompt == 414/Депозити ФО за % ст. "до погашення", в тис (консолiд)
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
   l_zpr.name := '414/Депозити ФО за % ст. "до погашення", в тис (консолiд)';
   l_zpr.pkey := '\BRS\***\ANI\55';

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
    l_zpr.name         := '414/Депозити ФО за % ст. "до погашення", в тис (консолiд)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ANI_6.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT a.kv ID, t.LCV,  t.NAME, a.IR,   
  a.S_,  a.S1,  a.S2,  a.S3,  a.S4,  a.S5,  a.S6,  a.S7,  a.S8,  a.S9, 
  a.S_*a.IR S_R,  a.S1*a.IR  S1R, a.S2*a.IR S2R, a.S3*a.IR S3R, a.S4*a.IR S4R, 
  a.S5*a.IR S5R,  a.S6*a.IR  S6R, a.S7*a.IR S7R, a.S8*a.IR S8R, a.S9*a.IR S9R 
FROM tabval t,  
(SELECT b.KV,  b.IR,  
       sum(decode(b.S240,''0'',b.s, 0)) S_, 
       sum(decode(b.S240,''1'',b.s, 0)) S1,  sum(decode(b.S240,''2'',b.s, 0)) S2,  
       sum(decode(b.S240,''3'',b.s, 0)) S3,  sum(decode(b.S240,''4'',b.s, 0)) S4,  
       sum(decode(b.S240,''5'',b.s, 0)) S5,  sum(decode(b.S240,''6'',b.s, 0)) S6,  
       sum(decode(b.S240,''7'',b.s, 0)) S7,  sum(decode(b.S240,''8'',b.s, 0)) S8,  
       sum(decode(b.S240,''9'',b.s, 0)) S9  
 from          
 (select a.KV, FS240 (c.CALDT_DATE, a.acc) S240, ACRN.FPROC(a.acc,c.CALDT_DATE) IR, sum(m.ost)/100000 S               
      from V_GL a,  ACCM_CALENDAR c, ACCM_SNAP_BALANCES m              
      where c.CALDT_ID = m.CALDT_ID    and a.acc= m.acc
          and m.ost >0    and a.nbs in ( ''2630'' )   
          and c.CALDT_DATE = to_date( :sFdat1, ''dd.mm.yyyy'' )
       group by a.kv, FS240 (c.CALDT_DATE,a.acc), ACRN.FPROC(a.acc,c.CALDT_DATE )       
     ) B   
GROUP BY b.KV, b.IR  ) A 
WHERE t.kv=a.KV 
ORDER BY  a.KV, a.IR  
  ';
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
