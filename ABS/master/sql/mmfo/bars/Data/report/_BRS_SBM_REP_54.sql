prompt ===================================== 
prompt == Реєстр купленої іноземної валюти(Ощадбанк)
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
   l_zpr.name := 'Реєстр купленої іноземної валюти(Ощадбанк)';
   l_zpr.pkey := '\BRS\SBM\REP\54';

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
    l_zpr.name         := 'Реєстр купленої іноземної валюти(Ощадбанк)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:BRANCH=''Відділення(всi-%)'',:Param0=''Виконавець ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'R_VALBUY.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0'',:BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT :sFdat1 DAT,'||nlchr||
                           '       (SELECT TO_CHAR (ov1.dat, ''hh24:mi:ss'') FROM oper_visa ov1 WHERE ov1.REF = o.REF AND ov1.status = 2) TIME_OP,'||nlchr||
                           '       v.lcv NAME,'||nlchr||
                           '       0 REF,'||nlchr||
                           '       DECODE (o.dk, 1, o.kv, o.kv2) KV,'||nlchr||
                           '       NVL (DECODE (o.dk, 1, o.s, o.s2), 0) / 100 SUM_N,'||nlchr||
                           '       NVL (DECODE (o.dk, 1, o.s2, o.s), 0) / 100 SUM_G,'||nlchr||
                           '       NVL (TO_NUMBER (w.VALUE), 0) KURS,'||nlchr||
                           '       o.pdat PDAT,'||nlchr||
                           '       TRIM (o.nd) ND1,'||nlchr||
                           '       (CASE WHEN TRIM (n.VALUE) = ''1'' THEN TO_CHAR (o.REF) ELSE NULL END)  AS ND2,'||nlchr||
                           '       o.sos SOS,'||nlchr||
                           '       o.userid,'||nlchr||
                           '       SUBSTR (bp.VAL, 1, 80) BRANCH,'||nlchr||
                           '       p.val ADRESS,'||nlchr||
                           '       NULL DATS'||nlchr||
                           '  FROM oper o,'||nlchr||
                           '       tabval v,'||nlchr||
                           '       branch b,'||nlchr||
                           '       branch_parameters p,'||nlchr||
                           '       branch_parameters bp,'||nlchr||
                           '       operw w,'||nlchr||
                           '       operw n'||nlchr||
                           ' WHERE     o.sos = 5'||nlchr||
                           '       AND o.pdat >= TO_DATE ( :sFdat1, ''dd/MM/yyyy'')'||nlchr||
                           '       AND o.pdat < TO_DATE ( :sFdat1, ''dd/MM/yyyy'') + 0.99999'||nlchr||
                           '       AND DECODE (o.dk, 1, o.kv, o.kv2) = v.kv'||nlchr||
                           '       AND ( (       o.kv <> 980'||nlchr||
                           '                 AND o.kv2 = 980'||nlchr||
                           '                 AND o.dk = 1'||nlchr||
                           '                 AND SUBSTR (o.nlsa, 1, 3) = ''100'''||nlchr||
                           '              OR     o.kv = 980'||nlchr||
                           '                 AND o.kv2 <> 980'||nlchr||
                           '                 AND o.dk = 0'||nlchr||
                           '                 AND SUBSTR (o.nlsb, 1, 3) = ''100''))'||nlchr||
                           '       AND o.branch LIKE :BRANCH || ''%'''||nlchr||
                           '       AND o.userid = DECODE ( :Param0, ''0'', o.userid, TO_NUMBER ( :Param0))'||nlchr||
                           '       AND o.branch = b.branch'||nlchr||
                           '       AND o.branch = p.branch'||nlchr||
                           '       and o.TT <> ''202'''||nlchr||
                           '       AND p.tag = ''ADR_BRANCH'''||nlchr||
                           '       AND o.branch = bp.branch'||nlchr||
                           '       AND bp.tag = ''NAME_BRANCH'''||nlchr||
                           '       AND w.REF = o.REF'||nlchr||
                           '       AND TRIM (w.tag) = ''KURS'''||nlchr||
                           '       AND o.REF = n.REF(+)'||nlchr||
                           '       AND n.tag(+) = ''RE377'''||nlchr||
                           '       '||nlchr||
                           'UNION ALL'||nlchr||
                           ''||nlchr||
                           'SELECT :sFdat1 DAT,'||nlchr||
                           '       (SELECT TO_CHAR (ov1.dat, ''hh24:mi:ss'') FROM oper_visa ov1 WHERE ov1.REF = o.REF AND ov1.status = 2) TIME_OP,'||nlchr||
                           '       v.lcv NAME,'||nlchr||
                           '       0 REF,'||nlchr||
                           '       DECODE (o.dk, 1, o.kv, o.kv2) KV,'||nlchr||
                           '       NVL (DECODE (o.dk, 1, o.s, o.s2), 0) / 100 SUM_N,'||nlchr||
                           '       NVL (DECODE (o.dk, 1, o.s2, o.s), 0) / 100 SUM_G,'||nlchr||
                           '       NVL (TO_NUMBER (w.VALUE), 0) KURS,'||nlchr||
                           '       o.pdat PDAT,'||nlchr||
                           '       TRIM (o.nd) ND1,'||nlchr||
                           '       (CASE WHEN TRIM (n.VALUE) = ''1'' THEN TO_CHAR (o.REF) ELSE NULL END) AS ND2,'||nlchr||
                           '       o.sos SOS,'||nlchr||
                           '       o.userid,'||nlchr||
                           '       SUBSTR (bp.VAL, 1, 80) BRANCH,'||nlchr||
                           '       p.val ADRESS,'||nlchr||
                           '       DECODE (o.sos, -2, ov.backtime, NULL) DATS'||nlchr||
                           '  FROM oper o,'||nlchr||
                           '       tabval v,'||nlchr||
                           '       branch b,'||nlchr||
                           '       branch_parameters p,'||nlchr||
                           '       branch_parameters bp,'||nlchr||
                           '       (SELECT TO_CHAR (dat, ''HH24:MI:SS'') backtime, REF FROM oper_visa WHERE status = 3 AND groupid IS NULL) ov,'||nlchr||
                           '       operw w,'||nlchr||
                           '       operw n'||nlchr||
                           ' WHERE     o.sos < 0'||nlchr||
                           '       AND o.pdat >= TO_DATE ( :sFdat1, ''dd/MM/yyyy'')'||nlchr||
                           '       AND o.pdat < TO_DATE ( :sFdat1, ''dd/MM/yyyy'') + 0.99999'||nlchr||
                           '       AND DECODE (o.dk, 1, o.kv, o.kv2) = v.kv'||nlchr||
                           '       AND ( (       o.kv <> 980'||nlchr||
                           '                 AND o.kv2 = 980'||nlchr||
                           '                 AND o.dk = 1'||nlchr||
                           '                 AND SUBSTR (o.nlsa, 1, 3) = ''100'''||nlchr||
                           '              OR     o.kv = 980'||nlchr||
                           '                 AND o.kv2 <> 980'||nlchr||
                           '                 AND o.dk = 0'||nlchr||
                           '                 AND SUBSTR (o.nlsb, 1, 3) = ''100''))'||nlchr||
                           '       AND o.branch LIKE :BRANCH || ''%'''||nlchr||
                           '       AND o.userid = DECODE ( :Param0, ''0'', o.userid, TO_NUMBER ( :Param0))'||nlchr||
                           '       AND o.branch = b.branch'||nlchr||
                           '       and o.TT <>''202'''||nlchr||
                           '       AND o.branch = p.branch'||nlchr||
                           '       AND p.tag = ''ADR_BRANCH'''||nlchr||
                           '       AND o.branch = bp.branch'||nlchr||
                           '       AND bp.tag = ''NAME_BRANCH'''||nlchr||
                           '       AND o.REF = ov.REF'||nlchr||
                           '       AND o.REF = w.REF'||nlchr||
                           '       AND TRIM (w.tag) = ''KURS'''||nlchr||
                           '       AND o.REF = n.REF(+)'||nlchr||
                           '       AND n.tag(+) = ''RE377'''||nlchr||
                           '       '||nlchr||
                           'UNION ALL'||nlchr||
                           ''||nlchr||
                           'SELECT :sFdat1 DAT,'||nlchr||
                           '       (SELECT TO_CHAR (ov1.dat, ''hh24:mi:ss'') FROM oper_visa ov1 WHERE ov1.REF = o.REF AND ov1.status = 2) TIME_OP,'||nlchr||
                           '       v.lcv NAME,'||nlchr||
                           '       0 REF,'||nlchr||
                           '       a1.kv KV,'||nlchr||
                           '       op1.s / 100 SUM_N,'||nlchr||
                           '       op2.s / 100 SUM_G,'||nlchr||
                           '       c.rate_b / c.bsum KURS,'||nlchr||
                           '       o.pdat PDAT,'||nlchr||
                           '       TRIM (o.nd) ND1,'||nlchr||
                           '       (CASE WHEN TRIM (n.VALUE) = ''1'' THEN TO_CHAR (o.REF) ELSE NULL END)'||nlchr||
                           '          AS ND2,'||nlchr||
                           '       o.sos SOS,'||nlchr||
                           '       o.userid,'||nlchr||
                           '       SUBSTR (bp.VAL, 1, 80) BRANCH,'||nlchr||
                           '       p.val ADRESS,'||nlchr||
                           '       DECODE (o.sos, -2, ov.backtime, NULL) DATS'||nlchr||
                           '  FROM oper o,'||nlchr||
                           '       tabval v,'||nlchr||
                           '       opldok op1,'||nlchr||
                           '       opldok op2,'||nlchr||
                           '       v_gl a1,'||nlchr||
                           '       v_gl a2,'||nlchr||
                           '       cur_rates$base c,'||nlchr||
                           '       branch b,'||nlchr||
                           '       branch_parameters p,'||nlchr||
                           '       branch_parameters bp,'||nlchr||
                           '       operw n,'||nlchr||
                           '       (SELECT TO_CHAR (dat, ''HH24:MI:SS'') backtime, REF  FROM oper_visa WHERE status = 3 AND groupid IS NULL) ov'||nlchr||
                           ' WHERE     o.sos = -2'||nlchr||
                           '       AND o.pdat >= TO_DATE ( :sFdat1, ''dd/MM/yyyy'')'||nlchr||
                           '       AND o.pdat < TO_DATE ( :sFdat1, ''dd/MM/yyyy'') + 0.99999'||nlchr||
                           '       AND o.REF = op1.REF'||nlchr||
                           '       AND o.REF = op2.REF'||nlchr||
                           '       AND op1.tt IN (''VPF'',''VPJ'',''VPI'',''046'',''MUQ'',''MVQ'')'||nlchr||
                           '       AND op1.tt = op2.tt'||nlchr||
                           '       AND (op1.dk = 0 AND op1.acc = a1.acc AND SUBSTR (a1.nls, 1, 3) = ''100'')'||nlchr||
                           '       AND (op2.dk = 1 AND op2.acc = a2.acc AND SUBSTR (a2.nls, 1, 3) = ''100'')'||nlchr||
                           '       AND ( (a1.kv = 980 AND a2.kv <> 980) OR (a1.kv <> 980 AND a2.kv = 980))'||nlchr||
                           '       AND a1.kv = v.kv'||nlchr||
                           '       AND a1.kv = c.kv'||nlchr||
                           '       AND o.branch = c.branch'||nlchr||
                           '       AND o.vdat = c.vdate'||nlchr||
                           '       AND o.branch LIKE :BRANCH || ''%'''||nlchr||
                           '       AND o.userid = DECODE ( :Param0, ''0'', o.userid, TO_NUMBER ( :Param0))'||nlchr||
                           '       AND o.branch = b.branch'||nlchr||
                           '       AND o.REF = ov.REF'||nlchr||
                           '       AND o.branch = p.branch'||nlchr||
                           '       AND p.tag = ''ADR_BRANCH'''||nlchr||
                           '       AND o.branch = bp.branch'||nlchr||
                           '       AND bp.tag = ''NAME_BRANCH'''||nlchr||
                           '       AND o.REF = n.REF(+)'||nlchr||
                           '       AND n.tag(+) = ''RE377'''||nlchr||
                           '       '||nlchr||
                           'UNION ALL'||nlchr||
                           ''||nlchr||
                           'SELECT :sFdat1 DAT,'||nlchr||
                           '       (SELECT TO_CHAR (ov1.dat, ''hh24:mi:ss'') FROM oper_visa ov1 WHERE ov1.REF = o.REF AND ov1.status = 2) TIME_OP,'||nlchr||
                           '       v.lcv NAME,'||nlchr||
                           '       0 REF,'||nlchr||
                           '       a1.kv KV,'||nlchr||
                           '       op1.s / 100 SUM_N,'||nlchr||
                           '       op2.s / 100 SUM_G,'||nlchr||
                           '       c.rate_b / c.bsum KURS,'||nlchr||
                           '       o.pdat PDAT,'||nlchr||
                           '       TRIM (o.nd) ND1,'||nlchr||
                           '       (CASE WHEN TRIM (n.VALUE) = ''1'' THEN TO_CHAR (o.REF) ELSE NULL END) AS ND2,'||nlchr||
                           '       o.sos SOS,'||nlchr||
                           '       o.userid,'||nlchr||
                           '       SUBSTR (bp.VAL, 1, 80) BRANCH,'||nlchr||
                           '       p.val ADRESS,'||nlchr||
                           '       NULL'||nlchr||
                           '  FROM oper o,'||nlchr||
                           '       tabval v,'||nlchr||
                           '       opldok op1,'||nlchr||
                           '       opldok op2,'||nlchr||
                           '       v_gl a1,'||nlchr||
                           '       v_gl a2,'||nlchr||
                           '       cur_rates$base c,'||nlchr||
                           '       branch b,'||nlchr||
                           '       branch_parameters p,'||nlchr||
                           '       branch_parameters bp,'||nlchr||
                           '       operw n'||nlchr||
                           ' WHERE     o.sos = 5'||nlchr||
                           '       AND o.pdat >= TO_DATE ( :sFdat1, ''dd/MM/yyyy'')'||nlchr||
                           '       AND o.pdat < TO_DATE ( :sFdat1, ''dd/MM/yyyy'') + 0.99999'||nlchr||
                           '       AND o.REF = op1.REF'||nlchr||
                           '       AND o.REF = op2.REF'||nlchr||
                           '       AND op1.tt IN (''VPF'', ''VPJ'', ''VPI'', ''046'', ''MUQ'', ''MVQ'')'||nlchr||
                           '       AND op1.tt = op2.tt'||nlchr||
                           '       AND (op1.dk = 0 AND op1.acc = a1.acc AND SUBSTR (a1.nls, 1, 3) = ''100'')'||nlchr||
                           '       AND (op2.dk = 1 AND op2.acc = a2.acc AND SUBSTR (a2.nls, 1, 3) = ''100'')'||nlchr||
                           '       AND ( (a1.kv = 980 AND a2.kv <> 980) OR (a1.kv <> 980 AND a2.kv = 980))'||nlchr||
                           '       AND a1.kv = v.kv'||nlchr||
                           '       AND a1.kv = c.kv'||nlchr||
                           '       AND o.branch = c.branch'||nlchr||
                           '       AND o.vdat = c.vdate'||nlchr||
                           '       AND o.branch LIKE :BRANCH || ''%'''||nlchr||
                           '       AND o.userid = DECODE ( :Param0, ''0'', o.userid, TO_NUMBER ( :Param0))'||nlchr||
                           '       AND o.branch = b.branch'||nlchr||
                           '       AND o.branch = p.branch'||nlchr||
                           '       AND p.tag = ''ADR_BRANCH'''||nlchr||
                           '       AND o.branch = bp.branch'||nlchr||
                           '       AND bp.tag = ''NAME_BRANCH'''||nlchr||
                           '       AND o.REF = n.REF(+)'||nlchr||
                           '       AND n.tag(+) = ''RE377'''||nlchr||
                           '       '||nlchr||
                           'UNION ALL'||nlchr||
                           ''||nlchr||
                           '  SELECT :sFdat1,NULL,NAME,-1,KV,SUM (SUM_N),SUM (SUM_G),KURS,bankdate,NULL,NULL,0,0,NULL, '''', '''''||nlchr||
                           '    FROM (  SELECT :sFdat1 DAT,'||nlchr||
                           '                   ''Всього:'' || v.lcv NAME,'||nlchr||
                           '                   -1 REF,'||nlchr||
                           '                   DECODE (o.dk, 1, o.kv, o.kv2) KV,'||nlchr||
                           '                   SUM (NVL (DECODE (o.dk, 1, o.s, o.s2), 0)) / 100 SUM_N,'||nlchr||
                           '                   SUM (NVL (DECODE (o.dk, 1, o.s2, o.s), 0)) / 100 SUM_G,'||nlchr||
                           '                   NVL (TO_NUMBER (VALUE), 0) KURS,'||nlchr||
                           '                   NULL,                       ---substr(bp.VAL,1,80) BRANCH ,'||nlchr||
                           '                   NULL                                    ----, p.val  ADRESS'||nlchr||
                           '              FROM oper o,'||nlchr||
                           '                   tabval v,'||nlchr||
                           '                   branch b,'||nlchr||
                           '                   branch_parameters p,'||nlchr||
                           '                   branch_parameters bp,'||nlchr||
                           '                   operw w'||nlchr||
                           '             WHERE     o.sos = 5'||nlchr||
                           '                   AND o.pdat >= TO_DATE ( :sFdat1, ''dd/MM/yyyy'')'||nlchr||
                           '                   AND o.pdat < TO_DATE ( :sFdat1, ''dd/MM/yyyy'') + 0.99999'||nlchr||
                           '                   AND DECODE (o.dk, 1, o.kv, o.kv2) = v.kv'||nlchr||
                           '                   AND ( (       o.kv <> 980'||nlchr||
                           '                             AND o.kv2 = 980'||nlchr||
                           '                             AND o.dk = 1'||nlchr||
                           '                             AND SUBSTR (o.nlsa, 1, 3) = ''100'''||nlchr||
                           '                          OR     o.kv = 980'||nlchr||
                           '                             AND o.kv2 <> 980'||nlchr||
                           '                             AND o.dk = 0'||nlchr||
                           '                             AND SUBSTR (o.nlsb, 1, 3) = ''100''))'||nlchr||
                           '                   AND o.branch LIKE :BRANCH || ''%'''||nlchr||
                           '                   AND o.userid ='||nlchr||
                           '                          DECODE ( :Param0, ''0'', o.userid, TO_NUMBER ( :Param0))'||nlchr||
                           '                   AND o.branch = b.branch'||nlchr||
                           '                   AND o.branch = p.branch'||nlchr||
                           '                   AND p.tag = ''ADR_BRANCH'''||nlchr||
                           '                   AND o.branch = bp.branch'||nlchr||
                           '                   AND bp.tag = ''NAME_BRANCH'''||nlchr||
                           '                   and o.tt <> ''202'''||nlchr||
                           '                   AND o.REF = w.REF'||nlchr||
                           '                   AND TRIM (w.tag) = ''KURS'''||nlchr||
                           '          GROUP BY DECODE (o.dk, 1, o.kv, o.kv2),'||nlchr||
                           '                   ''Всього:'' || v.lcv,'||nlchr||
                           '                   NVL (TO_NUMBER (w.VALUE), 0),'||nlchr||
                           '                   NVL (TO_NUMBER (w.VALUE), 0),'||nlchr||
                           '                   NULL,'||nlchr||
                           '                   NULL,'||nlchr||
                           '                   NULL'||nlchr||
                           '          -----substr(bp.VAL,1,80),  p.val'||nlchr||
                           '          UNION ALL'||nlchr||
                           '            SELECT :sFdat1,'||nlchr||
                           '                   ''Всього:'' || v.lcv,'||nlchr||
                           '                   -1,'||nlchr||
                           '                   a1.kv,'||nlchr||
                           '                   SUM (op1.s / 100),'||nlchr||
                           '                   SUM (op2.s / 100), --round(sum(op2.s/100)/sum(op1.s/100),4)'||nlchr||
                           '                   c.rate_b / c.bsum,'||nlchr||
                           '                   NULL,                       ---substr(bp.VAL,1,80) BRANCH ,'||nlchr||
                           '                   NULL                                            ----, p.val'||nlchr||
                           '              FROM oper o,'||nlchr||
                           '                   tabval v,'||nlchr||
                           '                   opldok op1,'||nlchr||
                           '                   opldok op2,'||nlchr||
                           '                   v_gl a1,'||nlchr||
                           '                   v_gl a2,'||nlchr||
                           '                   cur_rates$base c,'||nlchr||
                           '                   branch b,'||nlchr||
                           '                   branch_parameters p,'||nlchr||
                           '                   branch_parameters bp'||nlchr||
                           '             WHERE     o.sos = 5'||nlchr||
                           '                   AND o.pdat >= TO_DATE ( :sFdat1, ''dd/MM/yyyy'')'||nlchr||
                           '                   AND o.pdat < TO_DATE ( :sFdat1, ''dd/MM/yyyy'') + 0.99999'||nlchr||
                           '                   --o.vdat=:sFdat1 AND'||nlchr||
                           '                   AND o.REF = op1.REF'||nlchr||
                           '                   AND o.REF = op2.REF'||nlchr||
                           '                   AND op1.tt IN (''VPF'',''VPJ'',''VPI'',''046'',''MUQ'',''MVQ'')'||nlchr||
                           '                   AND op1.tt = op2.tt'||nlchr||
                           '                   AND (    op1.dk = 0'||nlchr||
                           '                        AND op1.acc = a1.acc'||nlchr||
                           '                        AND SUBSTR (a1.nls, 1, 3) = ''100'')'||nlchr||
                           '                   AND (    op2.dk = 1'||nlchr||
                           '                        AND op2.acc = a2.acc'||nlchr||
                           '                        AND SUBSTR (a2.nls, 1, 3) = ''100'')'||nlchr||
                           '                   AND (   (a1.kv = 980 AND a2.kv <> 980)'||nlchr||
                           '                        OR (a1.kv <> 980 AND a2.kv = 980))'||nlchr||
                           '                   AND a1.kv = v.kv'||nlchr||
                           '                   AND a1.kv = c.kv'||nlchr||
                           '                   AND o.branch = c.branch'||nlchr||
                           '                   AND o.vdat = c.vdate'||nlchr||
                           '                   AND o.branch LIKE :BRANCH || ''%'''||nlchr||
                           '                   AND o.userid ='||nlchr||
                           '                          DECODE ( :Param0, ''0'', o.userid, TO_NUMBER ( :Param0))'||nlchr||
                           '                   AND o.branch = b.branch'||nlchr||
                           '                   AND o.branch = p.branch'||nlchr||
                           '                   AND p.tag = ''ADR_BRANCH'''||nlchr||
                           '                   AND o.branch = bp.branch'||nlchr||
                           '                   AND bp.tag = ''NAME_BRANCH'''||nlchr||
                           '          GROUP BY a1.kv,'||nlchr||
                           '                   ''Всього:'' || v.lcv,'||nlchr||
                           '                   c.rate_b / c.bsum,'||nlchr||
                           '                   NULL,'||nlchr||
                           '                   NULL)'||nlchr||
                           'GROUP BY name,'||nlchr||
                           '         kv,'||nlchr||
                           '         KURS,'||nlchr||
                           '         NULL,'||nlchr||
                           '         NULL,'||nlchr||
                           '         NULL'||nlchr||
                           'ORDER BY 3 DESC,'||nlchr||
                           '         4,'||nlchr||
                           '         7,'||nlchr||
                           '         8';
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
    l_rep.description :='Реєстр купленої іноземної валюти(Ощадбанк)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 70; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 54;


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
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
