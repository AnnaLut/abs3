prompt ===================================== 
prompt == Касові документи по вал. та грн. по виконавцеві
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
   l_zpr.name := 'Касові документи по вал. та грн. по виконавцеві';
   l_zpr.pkey := '\OLD\***\***\275';

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
    l_zpr.name         := 'Касові документи по вал. та грн. по виконавцеві';
    l_zpr.namef        := 'kasisp';
    l_zpr.bindvars     := ':Param0=''Дата:'',:Param1=''Виконавець:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'kasisp.qrp';
    l_zpr.form_proc    := 'p_kj_grc(TRUE,USER_ID,:Param0,:Param0)';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT
--=========================================
--| 418 - Kassovy documenty po vykonavtcu |
--| 19.10.2010                            |
--=========================================
--
-- selecting all kassa documents where kv <> 980
--
  distinct o1.ref, o1.kv, o1.s,
           gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
           o1.nazn,
           :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'') 
  and o1.sos  = 5
  and o1.ref  = o2.ref 
  and (    substr(o2.nls,1,4) in (''1001'',''1101'') 
       or (substr(o2.nls,1,4)=''3800'' and o2.tt=''F14'') )
  and o2.kv  <> 980 
  and o1.tt  = o2.tt
  and o1.kv  = o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'') 
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv <> 980
  and o1.tt =  o2.tt
  and o1.kv <> o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id   
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'')  
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv <> 980
  and o1.tt <> o2.tt
  and o1.kv =  o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id   
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'')
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv <> 980
  and o1.tt <> o2.tt
  and o1.kv <> o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id    
--
-- selecting all kassa documents where kv = 980
--
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'')  
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv = 980
  and o1.tt = o2.tt
  and o1.kv = o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id   
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'')  
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv = 980
  and o1.tt =  o2.tt
  and o1.kv <> o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id   
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'')  
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv =  980
  and o1.tt <> o2.tt
  and o1.kv =  o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id   
UNION ALL
select o2.ref, o2.kv, o2.s,
       gl.p_icurval(o2.kv,o2.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'')  
  and o1.sos  = 5
  and o2.ref  = o1.ref
  and substr(o2.nls,1,4) in (''1001'',''1101'') 
  and o2.kv =  980
  and o1.tt <> o2.tt
  and o1.kv <> o2.kv  
  and o1.userid = :Param1
  and o1.userid = s.id
UNION ALL  
--
-- selecting nobalans kassa documents
--     
select o1.ref, o1.kv, o1.s,
       gl.p_icurval(o1.kv,o1.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where   (    o2.fdat = to_date(:Param0,''DD/MM/YYYY'') 
         and o2.sos  = 5
         and o1.ref  = o2.ref
         and o1.s    = o2.s
         and o1.nlsa = o2.nls 
         and o1.kv   = o2.kv
         and o1.tt not in (''102'',''012'')
         and o2.tt <> ''K25''
         and substr(o2.nls,1,1)=''9'' 
         and substr(o2.nls,1,4) not in (
                                        ''9000'',
                                        ''9030'',''9031'',
                                        ''9111'',''9122'',''9129'',
                                        ''9500'',''9510'',''9520'',''9521'',''9523'',
                                        ''9601'',''9603'',''9611'',
                                        ''9802'',''9809'',''9831'',''9892'',''9898'',''9899'',
                                        ''9900'',''9910'')
         and o1.userid = :Param1
         and o1.userid = s.id)
      or
        (    o2.fdat = to_date(:Param0,''DD/MM/YYYY'') 
         and o2.sos  = 5
         and o1.ref  = o2.ref
         and o1.s    = o2.s
         and o1.nlsa = o2.nls 
         and o1.kv   = o2.kv
         and o1.tt in (''012'',''102'',''022'',''100'')
         and substr(o2.nls,1,1)=''9'' 
         and substr(o2.nls,1,4) not in (''9129'',''9831'',''9900'',''9500'',''9031'',''9521'',''9520'')
         and o1.userid = :Param1
         and o1.userid = s.id)
UNION ALL
--
-- selecting kassa documents (inkasso)
--
select o1.ref, o1.kv, o1.s,
       gl.p_icurval(o1.kv,o1.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       o1.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o1, opl o2, staff s
where o2.fdat = to_date(:Param0,''DD/MM/YYYY'') 
  and o1.sos  = 5
  and o1.ref  = o2.ref
  and o1.s    = o2.s
  and o1.nlsa = o2.nls
  and o1.kv   = o2.kv
  and substr(o2.nls,1,4)=''9831''
  and o2.dk     = 0
  and o1.userid = :Param1
  and o1.userid = s.id
UNION ALL
--
-- selecting kassa documents (plastic_card and pin_code) 
--
select o.ref, o.kv, o.s,
       gl.p_icurval(o.kv,o.s,to_date(:Param0,''DD/MM/YYYY'')) sq,
       p.nazn,
       :Param0 DATA, :Param1 ISP, s.fio
from oper o, provodki p, staff s
where p.fdat = to_date(:Param0,''DD/MM/YYYY'') 
  and o.sos  = 5
  and o.ref  = p.ref
  and p.tt in (''BPK'',''BPP'')
  and o.userid = :Param1
  and p.isp    = s.id   
order by 2,3';
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
