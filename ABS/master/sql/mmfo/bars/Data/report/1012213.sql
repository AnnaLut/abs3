prompt ===================================== 
prompt == Реєстр угод МБДК за період
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
   l_zpr.name := 'Реєстр угод МБДК за період';
   l_zpr.pkey := '\BRS\SBR\MKD\3121';

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
    l_zpr.name         := 'Реєстр угод МБДК за період';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'mbk3121.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select distinct c.nmk , 
       cc.rnk  rnk, 
       c.OKPO okpo , 
       cc.cc_id  id, 
       cc.sdate bdat , 
       ca.s/100 suma, 
       ca.kv kv, 
       gl.p_icurval(ca.kv,ca.s, cc.sdate)/100 sumq,  
       cc.wdate edat ,
       nvl(t.name,''-'')  zalog,
       t.nd,
       :sFdat1  dat1, :sFdat2 dat2
    from  cc_deal cc, customer c, 
          cc_add ca,
          (select distinct cp.pawn, cp.name, pc.acc, pa.nd 
                        from cc_pawn cp,  pawn_acc pc, cc_accp pa 
                        where cp.pawn=pc.pawn and
                               pc.acc=pa.acc ) t
where cc.rnk=c.rnk and ca.nd=cc.nd
and   cc.sdate>=:sFdat1 and cc.wdate<=:sFdat2
and  cc.nd=T.ND(+)
and cc.vidd in (1211, 1310, 1312, 1322, 1327, 1502,1510, 1511,  
1515,  1521, 1522,  1524, 1526, 
1602, 1610, 1611,  1621, 1622, 1623,  
 2701, 3660, 3902, 3903,9001,9100)';
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
