prompt ===================================== 
prompt == Аналіз "Клієнт - продукт" (ФО)
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
   l_zpr.name := 'Аналіз "Клієнт - продукт" (ФО)';
   l_zpr.pkey := '\BRS\SBR\DPT\154';

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
    l_zpr.name         := 'Аналіз "Клієнт - продукт" (ФО)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':BRANCH=''Відділення'',:zDATE=''Звітна дата (DD.MM.YYYY): ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select cp2.okpo,
       v2.branch,
       case
         when cp2.nmk is NULL then
          (select f.nmk from customer f where f.rnk = prv.rnk)
         else
          cp2.nmk
       end as nmk,
       case
         when cp2.rnk is NULL then
          prv.rnk
         else
          cp2.rnk
       end as rnk,
       kt.kat,
       pp2.bday,
       case
         when pp2.bday is NULL then
          NULL
         else
          trunc((sysdate - pp2.bday) / (365.25) + 0.001)
       end as v,
       cw2.value as mobtel,
       pp2.teld as domtel,
       nvl(pr3.ost_KR, 0) as ost_kr_rah,
       nvl(pr3.ost_pr, 0) as ost_pot_rah,
       nvl(pr3.ost_dr, 0) as ost_dep_rah,
       case
         when pr3.INF190 = 1 then
          ''так''
         else
          ''ні''
       end as F190,
       case
         when pr3.inkr = 1 then
          ''так''
         else
          ''ні''
       end as KRED,
       case
         when pr3.inpr = 1 then
          ''так''
         else
          ''ні''
       end as POTN,
       case
         when pr3.indr = 1 then
          ''так''
         else
          ''ні''
       end as DEPO,
       case
         when pr3.inzp = 1 then
          ''так''
         else
          ''ні''
       end as ZP,
       case
         when pr3.inpens = 1 then
          ''так''
         else
          ''ні''
       end as PENS,
       case
         when pr3.ingold = 1 then
          ''так''
         else
          ''ні''
       end as GOLD,
       case
         when pr3.inplat = 1 then
          ''так''
         else
          ''ні''
       end as PLAT,
       case
         when pr3.innacn = 1 then
          ''так''
         else
          ''ні''
       end as NATN,
       case
         when pr3.instnd = 1 then
          ''так''
         else
          ''ні''
       end as STND,
       case
         when pr3.inECNM = 1 then
          ''так''
         else
          ''ні''
       end as ECNM,
       case
         when pr3.insoc = 1 then
          ''так''
         else
          ''ні''
       end as SOC,
       case
         when pr3.invirt = 1 then
          ''так''
         else
          ''ні''
       end as VIRT,
       pr3.intbpk as Count_BPK,
       case
         when pr3.inlim = 1 then
          ''так''
         else
          ''ні''
       end as BPK_LIM,
       case
         when pr3.inkr_ipt = 1 then
          ''так''
         else
          ''ні''
       end as KR_IPOT,
       case
         when pr3.inkr_avt = 1 then
          ''так''
         else
          ''ні''
       end as KR_AVTO,
       case
         when pr3.inkr_ktl = 1 then
          ''так''
         else
          ''ні''
       end as KR_KOTL,
       case
         when pr3.inkr_dpt = 1 then
          ''так''
         else
          ''ні''
       end as KR_DEPO,
       nvl(zac.sz_zp, 0) as sz_zp,
       nvl(zac.sz_pens, 0) as sz_pens,
       nvl(prv.nWU, 0) as WU,
       nvl(prv.nMG, 0) as MG,
       nvl(prv.nUNI, 0) as UNI,
       nvl(prv.nCON, 0) as CON,
       nvl(prv.nBLI, 0) as BLI,
       nvl(prv.nLID, 0) as LID,
       nvl(prv.nRIA, 0) as RIA,
       nvl(prv.nCOI, 0) as COI,
       nvl(prv.nIE, 0) as IE,
       nvl(prv.nHZR, 0) as HZR,
       nvl(prv.nANL, 0) as ANL,
       nvl(prv.nXM, 0) as XM,
       nvl(prv.PSUM, 0) as PSUM
  from (select z1.rnk, z2.branch
          from (select bc.rnk, max(bc.q) as mq
                  from (select c.rnk,
                               lpad(count(a.nls), 3, ''0'') ||
                               lpad(to_char(to_number(to_date(:zDATE,
                                                              ''dd.mm.yyyy'') -
                                                      min(a.daos))),
                                    8,
                                    ''0'') as q
                          from customer c, accounts a, branch b
                         where c.rnk = a.rnk
                           and a.branch = b.branch
                           and b.date_closed is NULL
                           and (a.dazs is NULL or
                               a.dazs > to_date(:zDATE, ''dd';
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
