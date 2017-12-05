prompt ===================================== 
prompt == 413/Депозити ФО за % ст. на місяць, в тис (консолiд)
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
   l_zpr.name := '413/Депозити ФО за % ст. на місяць, в тис (консолiд)';
   l_zpr.pkey := '\BRS\***\ANI\59';

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
    l_zpr.name         := '413/Депозити ФО за % ст. на місяць, в тис (консолiд)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ANI_7.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT a.kv ID, t.LCV,  t.NAME, a.IR,  
  a.S1 ,a.S2 ,a.S3 ,a.S4 ,a.S5 ,a.S6 ,a.S7 ,a.S8 ,a.S9 ,a.S10, 
  a.S11,a.S12,a.S13,a.S14,a.S15,a.S16,a.S17,a.S18,a.S19,a.S20, 
  a.S21,a.S22,a.S23,a.S24,a.S25,a.S26,a.S27,a.S28,a.S29,a.S30,a.S31, 
  a.IR*a.S1  R1 ,a.IR*a.S2  R2 ,a.IR*a.S3  R3 ,a.IR*a.S4 R4  ,a.IR*a.S5  R5 , 
  a.IR*a.S6  R6 ,a.IR*a.S7  R7 ,a.IR*a.S8  R8 ,a.IR*a.S9 R9  ,a.IR*a.S10 R10, 
  a.IR*a.S11 R11,a.IR*a.S12 R12,a.IR*a.S13 R13,a.IR*a.S14 R14,a.IR*a.S15 R15, 
  a.IR*a.S16 R16,a.IR*a.S17 R17,a.IR*a.S18 R18,a.IR*a.S19 R19,a.IR*a.S20 R20, 
  a.IR*a.S21 R21,a.IR*a.S22 R22,a.IR*a.S23 R23,a.IR*a.S24 R24,a.IR*a.S25 R25, 
  a.IR*a.S26 R26,a.IR*a.S27 R27,a.IR*a.S28 R28,a.IR*a.S29 R29,a.IR*a.S30 R30, 
  a.IR*a.S31 R31, 
  a.K1 ,a.K2 ,a.K3 ,a.K4 ,a.K5 ,a.K6 ,a.K7 ,a.K8 ,a.K9, a.K10, 
  a.K11,a.K12,a.K13,a.K14,a.K15,a.K16,a.K17,a.K18,a.K19,a.K20, 
  a.K21,a.K22,a.K23,a.K24,a.K25,a.K26,a.K27,a.K28,a.K29,a.K30, a.K31, a.DOS, a.KOS 
FROM tabval t, 
(select b.kv, b.ir,  sum(kos) KOS, sum(dos) DOS, 
       sum(decode(b.D, 1,b.s,0)) S1,  sum(decode(b.D, 2,b.s,0)) S2,  sum(decode(b.D, 3,b.s,0)) S3 ,  
       sum(decode(b.D, 4,b.s,0)) S4,  sum(decode(b.D, 5,b.s,0)) S5,  sum(decode(b.D, 6,b.s,0)) S6 ,  
       sum(decode(b.D, 7,b.s,0)) S7,  sum(decode(b.D, 8,b.s,0)) S8,  sum(decode(b.D, 9,b.s,0)) S9 , 
       sum(decode(b.D,10,b.s,0)) S10, sum(decode(b.D,11,b.s,0)) S11, sum(decode(b.D,12,b.s,0)) S12,  
       sum(decode(b.D,13,b.s,0)) S13, sum(decode(b.D,14,b.s,0)) S14, sum(decode(b.D,15,b.s,0)) S15,  
       sum(decode(b.D,16,b.s,0)) S16, sum(decode(b.D,17,b.s,0)) S17, sum(decode(b.D,18,b.s,0)) S18,  
       sum(decode(b.D,19,b.s,0)) S19, sum(decode(b.D,20,b.s,0)) S20, sum(decode(b.D,21,b.s,0)) S21,  
       sum(decode(b.D,22,b.s,0)) S22, sum(decode(b.D,23,b.s,0)) S23, sum(decode(b.D,24,b.s,0)) S24,  
       sum(decode(b.D,25,b.s,0)) S25, sum(decode(b.D,26,b.s,0)) S26, sum(decode(b.D,27,b.s,0)) S27, 
       sum(decode(b.D,28,b.s,0)) S28, sum(decode(b.D,29,b.s,0)) S29, sum(decode(b.D,30,b.s,0)) S30,   
       sum(decode(b.D,31,b.s,0)) S31,   
       sum(decode(b.D, 1,b.P,0)) K1 , sum(decode(b.D, 2,b.P,0)) K2 , sum(decode(b.D, 3,b.P,0)) K3 ,  
       sum(decode(b.D, 4,b.P,0)) K4 , sum(decode(b.D, 5,b.P,0)) K5 , sum(decode(b.D, 6,b.P,0)) K6 ,  
       sum(decode(b.D, 7,b.P,0)) K7 , sum(decode(b.D, 8,b.P,0)) K8 , sum(decode(b.D, 9,b.P,0)) K9 , 
       sum(decode(b.D,10,b.P,0)) K10, sum(decode(b.D,11,b.P,0)) K11, sum(decode(b.D,12,b.P,0)) K12,  
       sum(decode(b.D,13,b.P,0)) K13, sum(decode(b.D,14,b.P,0)) K14, sum(decode(b.D,15,b.P,0)) K15,  
       sum(decode(b.D,16,b.P,0)) K16, sum(decode(b.D,17,b.P,0)) K17, sum(decode(b.D,18,b.P,0)) K18,  
       sum(decode(b.D,19,b.P,0)) K19, sum(decode(b.D,20,b.P,0)) K20, sum(decode(b.D,21,b.P,0)) K21,  
       sum(decode(b.D,22,b.P,0)) K22, sum(decode(b.D,23,b.P,0)) K23, sum(decode(b.D,24,b.P,0)) K24,  
       sum(decode(b.D,25,b.P,0)) K25, sum(decode(b.D,26,b.P,0)) K26, sum(decode(b.D,27,b.P,0)) K27, 
       sum(decode(b.D,28,b.P,0)) K28, sum(decode(b.D,29,b.P,0)) K29, sum(decode(b.D,30,b.P,0)) K30,   
       sum(decode(b.D,31,b.P,0)) K31 
from   ( select a.kv, to_number(to_char ( c.CALDT_DATE, ''dd'' )) D,  ACRN.FPROC(a.acc, c.CALDT_DATE )  IR,  
                  sum(m.ost)/100000 S, SUM(m.kOS) /100000 KOS,  SUM(m.DOS) /100000 DOS,  SUM(m.kOS-m.DOS) /100000  P 
            from V_GL a, ACCM_CALENDAR c, ACCM_SNAP_BALANCES m 
            where c.CALDT_DATE >=  trunc( to_date( :sFdat1, ''dd.mm.yyyy'' ),''MM'') 
              and c.CALDT_DATE <  add_months( trunc( to_date( :sFdat1, ''dd.mm.yyyy'' ),''MM''), 1) 
              and c.CALDT_ID = m.CALDT_ID  
              and a.acc= m.acc
              and  a.nbs in (''2630'') 
              and (m.ost>0  or m.dos>0 or m.kos>0)  
            group by  a.kv, c.CALDT_DATE, ACRN.FPROC(a.acc,c.CALDT_DATE )   
     ) B  
 group by b.KV, b.IR ) A 
WHERE a.kv=t.KV  
ORDER BY  a.kv , a.IR  
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
