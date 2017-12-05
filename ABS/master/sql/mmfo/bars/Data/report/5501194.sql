prompt ===================================== 
prompt == погашение по телу юрики на дату(проблемн)
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
   l_zpr.name := 'погашение по телу юрики на дату(проблемн)';
   l_zpr.pkey := '\zap\SBER\CCK\16';

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
    l_zpr.name         := 'погашение по телу юрики на дату(проблемн)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  o.ref,o.s/100,
abs( gl.p_icurval(a.kv,o.s,to_date(o.DATD,''dd.mm.yy''))/100) as summ,
o.nlsa,substr(O.NLSA,1,4) as balsa, o.nam_a,o.nlsb,substr(O.NLSB,1,4) as balsbb,o.NAM_B,o.kv,d.branch,d.cc_id,d.sdate, O.NAZN, D.ND,o.tt,o.datd from oper o left join accounts a on o.nlsb=a.nls and o.kv=a.kv
left join nd_acc n on  a.acc=n.acc left join cc_deal d on n.nd=d.nd
where  
((  o.nlsa like ''3739%''  or o.nlsa like ''3739692705''  or o.nlsa like ''3739604605''  or o.nlsa like ''37391032505''  or o.nlsa like ''37395929205''  or o.nlsa like ''37399926505''  
or o.nlsa like ''37393925405''  or
o.nlsa like ''3739090105''  or o.nlsa like ''3739998005''  or o.nlsa like ''3739897005''  or o.nlsa like ''3739796005'' or   o.nlsa like ''3600%'') 
and   ( o.nlsb like ''2063%''  or o.nlsb like ''2072%''  or o.nlsb like ''2073%'') 
  and (tt=''ASG'' or tt=''015'') 
             and o.sos=5)
and( O.DATD  > to_date(:sFdat1,''dd.mm.yy'')
and  O.DATD  < to_date(:sFdat2,''dd.mm.yy'') ) order by o.kv,D.ND,o.datd';
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
