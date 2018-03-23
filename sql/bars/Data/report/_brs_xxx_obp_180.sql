prompt =====================================
prompt == БПК. Дебіторська заборгованність
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
   l_zpr.name := 'БПК. Дебіторська заборгованність';
   l_zpr.pkey := '\BRS\***\OBP\180';

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
    l_zpr.name         := 'БПК. Дебіторська заборгованність';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':Branch1=''Відділення (%-всі)'',:OKPO1=''ІНН клієнта (%-всі)'',:NLS_PK1=''Рахунок клієнта (%-всі)'',:LCV1=''Валюта рахунку'',:ZP_OKPO=''ЄДРПОУ ЗП проекту (%-всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5503.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':ZP_OKPO=''%'',:Branch1=''%'',:OKPO1=''%'',:NLS_PK1=''%'',:LCV1=''UAH''';
    l_zpr.bind_sql     := ':Branch1=''V_BRANCH_OWN|BRANCH|NAME|WHERE ''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT sel1.BRANCH,
       sel1.NMK,
       sel1.OKPO,
       sel1.NLS_PK,
       sel1.LCV,
       sel1.NLS_3570,
       sel1.OST_3570,
       sel1.NLS_3579,
       sel1.OST_3579,
       o2.VALUE OW_DS
  FROM (SELECT a.branch,
               r.nmk,
               r.okpo,
               a.nls NLS_PK,
               DECODE (a.kv,  980, ''UAH'',  840, ''USD'',  ''EUR'') LCV,
               a_3570.nls NLS_3570,
               a_3570.acc acc_3570,
               a_3570.DAPP DAPP_3570,
               a_3570.ostc OST_3570,
               a_3579.nls NLS_3579,
               a_3579.acc acc_3579,
               a_3579.DAPP DAPP_3579,
               a_3579.ostc OST_3579,
               NVL (B_PR.OKPO, 0) ZP_OKPO,
               REGEXP_SUBSTR (a_zp.VALUE, ''[0-9]{1,}'') ZP_VALUE
          FROM w4_acc p
               LEFT JOIN accounts a ON p.acc_pk = a.acc
               LEFT JOIN accounts a_3570 ON p.acc_3570 = a_3570.acc
               LEFT JOIN accounts a_3579 ON p.acc_3579 = a_3579.acc
               LEFT JOIN customer r ON a.rnk = r.rnk
               LEFT JOIN accountsw a_ZP ON P.ACC_PK = A_ZP.ACC AND A_ZP.TAG = ''PK_PRCT''
               LEFT JOIN BPK_PROECT b_pr ON REGEXP_SUBSTR (a_zp.VALUE, ''[0-9]{1,}'') = B_PR.ID AND B_PR.USED_W4 = 1
         WHERE A_3579.OSTC <> 0) sel1,
       opldok o1,
       operw o2
 WHERE     sel1.acc_3570 = o1.acc
       AND o1.DK = 0
       AND o1.FDAT = (SELECT MAX (FDAT)
                        FROM opldok
                       WHERE acc = sel1.acc_3570 AND DK = 0)
       AND o1.SOS = 5
       AND o1.REF = o2.REF
       AND o2.TAG = ''OW_DS''
       AND sel1.branch LIKE NVL(:Branch1,''%'')
       AND sel1.OKPO LIKE NVL(:OKPO1,''%'')
       AND sel1.NLS_PK LIKE NVL(:NLS_PK1,''%'')
       AND sel1.LCV LIKE NVL(:LCV1,''%'')
       AND sel1.ZP_OKPO like NVL(:ZP_OKPO,''%'')';
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

    ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='БПК. Дебіторська заборгованність';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5503;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' изменен.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;                                  
		
    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів';
    end;


    bars_report.print_message(l_message);
end;
/

commit;
  