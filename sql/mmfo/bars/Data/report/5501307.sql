prompt ===================================== 
prompt == tip<>DEP Об-сальдова вiдомiсть Пiдроздiлу по OB22   (данi ф.#02)
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
   l_zpr.name := 'tip<>DEP Об-сальдова вiдомiсть Пiдроздiлу по OB22   (данi ф.#02)';
   l_zpr.pkey := '\BRS\SBM\REP\722';

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
    l_zpr.name         := 'tip<>DEP Об-сальдова вiдомiсть Пiдроздiлу по OB22   (данi ф.#02)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Б/Рахунок_З_(%всі)'',:Param1=''Б/Рахунок_ПО_(%всі)'',:Param2=''Вал(%всі)'',:Param3=''Код_відділення(вибір)'',:Param4=''OB22_(%всі)_або_Один_із(01,02)'',:Param5=''1(Детально)_або_0(Бал.рахунки)'',:Param6=''1(З_підсумком_ ОВ22)_або_0(Без підсумка_ОБ22)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'SBM_31_7.qrp';
    l_zpr.form_proc    := 'P_SAL_SNP (102, to_date(:sFdat1,''dd-mm-yyyy''), to_date(:sFdat2,''dd-mm-yyyy''),:Param3)';
    l_zpr.default_vars := ':Param0=''%'',:Param1=''%'',:Param2=''%'',:Param3=''%'',:Param4=''%'',:Param5=''1'',:Param6=''1''';
    l_zpr.bind_sql     := ':Param3=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select s.dat1,   s.dat2,        s.kv,                  s.nbs,       s.nls,                   s.nms,
          s.ostd ostd1,   s.ostk ostk1,     s.dos dos1,        s.kos kos1,          s.ostid ostid1,         s.ostik ostik1,          
          s.ostqd,          s.ostqk,     s.dosq,      s.kosq,        s.ostiqd,       s.ostiqk,
          s.ob22, 
          decode(s.nbs,  ''2620'',  0,  ''2628'',  0,  ''2630'',  0,  ''2638'',  0,  s.det_b) det_b,   s.det_ob,   
          s.pnbs1,         s.pnbs2,     s.pkv,        s.pbranch,    s.pob22,      s.pnbsi,     s.pob22i ,
          s.nbsob22,     s.nlssort     
from
(SELECT   :sFdat1 DAT1,      :sFdat2  DAT2,   
       nbs||name   nbsob22,  tip,     substr(nls,1,4)||substr(nls,6,9)||name    nlssort,
       kv,   nbs nbs,  nls  nls , substr(name1,1,27)    nms,  name ob22,
       case    when n1<0    then ABS(n1)   else 0   end     OSTD,    
       case    when n1>0    then  n1            else 0   end     OSTK,  
       case    when n2<0    then ABS(n2)   else 0   end     OSTQD,    
       case    when n2>0    then  n2            else 0   end     OSTQK,  
       n3 DOS,      n4       DOSQ,  
       n5 KOS,      zalq     KOSQ,  
       case    when zal<0      then ABS(zal)       else 0   end     OSTID,    
       case    when zal>0      then  zal                else 0   end     OSTIK,  
       case    when rezq<0    then ABS(rezq)    else 0   end     OSTIQD,    
       case    when rezq>0    then  rezq             else 0   end     OSTIQK,  
       to_number(:Param5)  DET_B, to_number(:Param6)  DET_OB,
       :Param0 PNBS1,  :Param1 PNBS2,  :Param2 PKV,  :Param3 PBRANCH,  :Param4 POB22,  
       decode(:Param5,''1'',''Детально по аналітичних'',''0'' ,''Стисло по балансових'')  PNBSI,
       decode(:Param6,''1'',''Виводити підсумок по ОБ22'',''0'' ,''Не виводити підсумок по ОБ22'')   POB22I
FROM  cck_an_tmp 
WHERE nbs in (2620,2628,2630,2638) and kv=  decode(:Param2,''%'',kv, substr(:Param2,1,3))                          AND      
     to_number(nbs)>=
          decode(:Param0,''%'',to_number(nbs),to_number(substr(:Param0,1,4)))     AND
     to_number(nbs)<=
         decode(:Param1,''%'',to_number(nbs),to_number(substr(:Param1,1,4)))     AND
        name in    (substr      (decode(:Param4,''%'', name, :Param4), 1, 2),
                       substr(:Param4,4,2),substr(:Param4,7,2), substr(:Param4,10,2),substr(:Param4,13,2),
                       substr(:Param4,16,2),substr(:Param4,19,2),substr(:Param4,22,2),substr(:Param4,25,2))
) s,accounts a
where s.nls=a.nls and s.kv=a.kv and a.tip <> ''DEP''
order by s.NBS,s.NBSOB22,s.tip, s.NLSSORT';
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
