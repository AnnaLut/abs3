prompt ===================================== 
prompt == Вклади фізичних осіб
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
   l_zpr.name := 'Вклади фізичних осіб';
   l_zpr.pkey := '\OLD\***\***\327';

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
    l_zpr.name         := 'Вклади фізичних осіб';
    l_zpr.namef        := 'vklad02.txt';
    l_zpr.bindvars     := ':Param0=''Бал.рахунок'',:Param1=''Звітна дата''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'vklad02.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := ':Param0=''V_ZAPROS2|NBS|TXT''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''ГОУ Ощадбанку'' BANKNAME,
       k.r020  NBS,
       k.txt   TXT,
       :Param1 ZVIT_DATE,
       c1.nmk  CLI_NAME, 
       c1.okpo INN,
       s1.nls  NLS1, 
       a1.daos DAOS, 
       a1.mdate MDATE, 
       s1.kv KV, 
       s1.ost OST1, 
       gl.p_icurval(s1.kv,s1.ost,:Param1) EQV,
       decode(a2.dazs,NULL,a2.nls,''Рах.закрито'') NLS2, 
       gl.p_icurval(s2.kv,s2.ost,:Param1) EQV2, 
       s2.app DAPP, 
       decode(i2.ir,NULL,(select rate 
                            from br_normal
                           where bdate=(select max(bdate) from br_normal 
                                         where bdate<=:Param1 
                                           and br_id=i2.br
                                           and kv=s1.kv)
                             and br_id=i2.br
                             and kv=s1.kv),
                         i2.ir) IR
  from customer c1,
       sal s1,
       (select acc, kv, app, ost/100 OST
          from sal where fdat=:Param1 and nbs=decode(:Param0,2620,2628,
                                                             2625,2628,
                                                             2630,2638,
                                                             2638,9999)) s2,
       saldo a1,
       saldo a2,
       int_accn i1,
       int_ratn i2,
       kl_r020 k
 where c1.rnk = a1.rnk
   and c1.custtype = 3
   and ( a1.dazs is null or a1.dazs > :Param1 ) 
--   and ( a2.dazs is null or a2.dazs > :Param1 ) 
   and s1.nbs  = :Param0
   and k.r020  = :Param0
   and s1.fdat = :Param1
   and a1.acc  = s1.acc
   and s1.acc  = i1.acc
   and i1.acra = a2.acc
   and a2.acc  = s2.acc
   and i2.acc  = s1.acc
   and i2.bdat = (select max(bdat) from int_ratn where acc=s1.acc and bdat<=:Param1)
 order by s1.kv, c1.nmk';
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
