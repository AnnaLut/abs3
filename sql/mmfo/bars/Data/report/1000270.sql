prompt ===================================== 
prompt == Сал.ведомость по дебеторской задолжености с парам.(с 01/11/2012)
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
   l_zpr.name := 'Сал.ведомость по дебеторской задолжености с парам.(с 01/11/2012)';
   l_zpr.pkey := '\OLD\***\***\356';

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
    l_zpr.name         := 'Сал.ведомость по дебеторской задолжености с парам.(с 01/11/2012)';
    l_zpr.namef        := 'sal_pros2.txt';
    l_zpr.bindvars     := ':Param0=''За дату''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'SAL_PROS.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select
  ''300465'' MFO,
  a.nbs R020,
  a.nls NLS,
  a.nms NMS,
  s.ob22 OB22,
  s.deb01 ZMIST,
  s.deb07 TYPE_Z,
  c.nmk DEBITOR,
  a.dapp DAPP, 
  s.deb02 D_VIN,
  s.deb03 D_ZAK,
  a.kv KOD_VALUT,
  FOST(A.ACC,to_date(:Param0,''DD/MM/YYYY''))/100*(-1) ZALISHOKNOM,
  FOSTQ(A.ACC,to_date(:Param0,''DD/MM/YYYY''))/100*(-1) ZALISHOK,
  '''' KDP,
  '''' KDNB,
  s.deb04 GRUPA,
  decode(s.deb04,1,0,
                   decode(s.deb04,2,FOSTQ(A.ACC,to_date(:Param0,''DD/MM/YYYY''))/100*(-1)*0.2,
                                    decode(s.deb04,3,FOSTQ(A.ACC,to_date(:Param0,''DD/MM/YYYY''))/100*(-1)*0.5,
                                                     decode(s.deb04,4,FOSTQ(A.ACC,to_date(:Param0,''DD/MM/YYYY''))/100*(-1),0)))) RSR,
  '''' FSR,
  '''' NSR,
--  s.deb06 "?i?????i?_??_????",
  s.deb05 ZAHOD,
  FOST(A.ACC,to_date(:Param0,''DD/MM/YYYY''))/100*(-1) ZAL_VALUT,
  0 FSR_VALUT
from accounts a, customer c, cust_acc ca, specparam_int s
where a.nbs in (1811,1819,1880,
                2800,2801,2805,2806,2809,2887,2888,2889,
                3510,3511,3519,3520,3521,3522,3540,3541,3542,3548,3550,3551,3552,3559,3570,3578,3580,
                3710)
  and FOSTQ(A.ACC,to_date(:Param0,''DD/MM/YYYY''))<>0
  and c.rnk=ca.rnk 
  and ca.acc=a.acc and ca.acc=s.acc
order by a.nbs';
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
