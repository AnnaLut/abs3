prompt ===================================== 
prompt == Інвентаризація депозитного портфеля корпоративних клієнтів
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
   l_zpr.name := 'Інвентаризація депозитного портфеля корпоративних клієнтів';
   l_zpr.pkey := '\BRS\SBM\DPU\007';

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
    l_zpr.name         := 'Інвентаризація депозитного портфеля корпоративних клієнтів';
    l_zpr.namef        := '=''ZvitInvDepCorp''||SubStr(f_oursab(),1,3)||substr(bars_report.frmt_date(gl.bd,''DMY''),1,3)||''.txt''';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := 'DAT_NOW   [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'DAT_FIRST [10,'' '',L,''dd.MM.yyyy''];
'||nlchr||
                           ''||nlchr||
                           'NAME_RU   [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'KF        [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'BRANCH    [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'NMK       [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'OKPO      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'UUDV      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'NBS       [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'OB22      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'NLS       [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'K061      [1, '' '',R];
'||nlchr||
                           ''||nlchr||
                           'K030      [1, '' '',R];
'||nlchr||
                           ''||nlchr||
                           'ND        [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'TYPE_NAME [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'KV        [1, '' '',R];
'||nlchr||
                           ''||nlchr||
                           'DAT_BEGIN [10,'' '',L,''dd.MM.yyyy''];
'||nlchr||
                           ''||nlchr||
                           'DAT_END   [10,'' '',L,''dd.MM.yyyy''];
'||nlchr||
                           ''||nlchr||
                           'OST_DEP   [13,'' '',L];
'||nlchr||
                           ''||nlchr||
                           'OSTQ_DEP  [13,'' '',L];
'||nlchr||
                           ''||nlchr||
                           'NBS_INT   [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'OB22_INT  [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'OST_INT   [13,'' '',L];
'||nlchr||
                           ''||nlchr||
                           'DSK_PRM   [1, '' '',R];
'||nlchr||
                           ''||nlchr||
                           'RATE      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'FREQV     [1, '' '',R];
'||nlchr||
                           ''||nlchr||
                           'S240      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'S180      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'K110      [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'KOS_INT   [12,'' '',L];
'||nlchr||
                           ''||nlchr||
                           'DPU_ID    [0, '' '',L];
'||nlchr||
                           ''||nlchr||
                           'Delim=chr(9)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT DAT_NOW, DAT_FIRST,
       (select name from DPU_RU where kf = gl.kf) as name_ru,
       d.kf, d.branch, c.nmk, c.okpo, 
       (select SubStr(value,1,10) from customerw where rnk = c.rnk and TAG=''UUDV '') as UUDV,
       ad.nbs, ad.ob22, ad.nls,
       decode(c.prinsider, 99, 2, 0, 2, 1) as K061,
       decode(c.codcagent,  4, 2, 6, 2, 1) as K030,
       d.nd,
       (select txt from SB_OB22 where r020 = ad.nbs and ob22 = ad.ob22 and rownum = 1) as TYPE_NAME, 
       ad.kv,
       ad.daos as dat_begin, d.dat_end, 
       to_char(fost(ad.acc, f.dat_last)/100,''FM9999999990D00'') as ost_dep, 
       to_char(fostQ(ad.acc,f.dat_last)/100,''FM9999999990D00'') as ostQ_dep,
       ai.nbs as NBS_INT,
       ai.ob22 as OB22_INT,
       to_char(fostQ(ai.acc,f.dat_last)/100,''FM9999990D00'') as OST_INT,
       0 as DSK_PRM,
       to_char(acrn.fproc (ad.acc, f.dat_last),''FM00D00'')||''%'' as RATE,
       decode(d.freqv, 5, 1, 7, 2, 360, 4, 400, 3, d.freqv) as FREQV,
       Substr(fs240(dat_last,ad.acc),1,1) as S240,
       SubStr(fs180(ad.acc),1,1) as S180,
       c.ved as K110,
       to_char(fkosQ(ai.acc, dat_start, dat_last)/100,''FM999999990D00'') as KOS_INT,
       to_char(d.dpu_id) as DPU_ID
  from DPU_DEAL_update d,
       accounts ad,
       int_accn i,
       accounts ai,
       customer c,
       ( select to_char(sysdate, ''dd.mm.yyyy hh24:mi:ss'') as dat_now, trunc(fdat,''MM'') as dat_first, 
                last_day(fdat) as dat_last, trunc(fdat,''YY'') as dat_start 
           from fdat 
          where fdat = to_date(:sFdat1,''dd/mm/yyyy'') ) f
 where d.closed = 0
   and d.acc  = ad.acc
   and ad.nbs in (''2525'',''2546'',''2600'',''2610'',''2650'',''2651'')
   and d.acc  = i.acc
   and i.id   = 1
   and i.acra = ai.acc 
   and d.rnk  = c.rnk
   and (d.idu, d.dpu_id) in ( select max(idu), dpu_id 
                                from dpu_deal_update 
                               where bdate <= f.dat_last
                               group by dpu_id )';
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
