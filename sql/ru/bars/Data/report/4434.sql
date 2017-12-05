prompt ===================================== 
prompt == Аналiз депозитного портфелю ФО (Вид+Бранч)
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
   l_zpr.name := 'Аналiз депозитного портфелю ФО (Вид+Бранч)';
   l_zpr.pkey := '\SBR\BRS\DPT\404';

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
    l_zpr.name         := 'Аналiз депозитного портфелю ФО (Вид+Бранч)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_404.qrp ';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := '  SELECT K.BRANCH,
         K.KV,
         K.NBS,
         K.VIDD,
         K.VX,
         K.VXQ,
         K.DOS,
         K.DOSQ,
         K.KOS,
         K.KOSQ,
         K.IX,
         K.IXQ,
         K.SR,
         K.ST,
         K.KOL,
         B.NAME,
         T.TYPE_NAME VNAME,
         K.VX1,
         K.VX1Q,
         K.DOS1,
         K.DOS1Q,
         K.KOS1,
         K.KOS1Q,
         K.IX1,
         K.IX1Q,
         K.VKOL,
         K.DKOL,
         K.KKOL,
         K.IKOL
    FROM (      
            SELECT BRANCH,
                   kk.KV,
                   NBS,
                   VIDD,
                   SUM (VX) VX,
                   SUM (DOS) DOS,                   
                   SUM (KOS) KOS ,
                   SUM (IX) IX,
                   gl.p_icurval (kk.kv, SUM (kk.VX), TO_DATE (:sFdat1, ''DD.MM.YYYY'') - 1)        VXQ,   
                   SUM(DOSQ)  DOSQ ,
                   SUM(KOSQ)  KOSQ ,
                   gl.p_icurval (kk.kv, SUM (kk.IX), TO_DATE (:sFdat2, ''DD.MM.YYYY''))            IXQ,
                   gl.p_icurval (kk.kv, SUM (kk.SR * kk.IX), TO_DATE (:sFdat2, ''DD.MM.YYYY''))    SR,
                   gl.p_icurval (kk.kv, SUM (kk.ST * kk.IX), TO_DATE (:sFdat2, ''DD.MM.YYYY''))    ST,
                   COUNT (*) KOL,
                   SUM (VX1)  VX1 ,                   
                   SUM (DOS1) DOS1, 
                   SUM (KOS1) KOS1, 
                   SUM (IX1)  IX1,
                   gl.p_icurval (kk.kv, SUM (kk.VX1), TO_DATE (:sFdat1, ''DD.MM.YYYY'')-1)          VX1Q,
                   SUM(DOS1Q) DOS1Q, 
                   SUM(KOS1Q) KOS1Q,
                   gl.p_icurval (kk.kv, SUM (kk.IX1), TO_DATE (:sFdat2, ''DD.MM.YYYY''))            IX1Q,
                   SUM (VKOL) VKOL,
                   SUM (DKOL) DKOL,
                   SUM (KKOL) KKOL,
                   SUM (IKOL) IKOL
            FROM              
              (
              SELECT D.BRANCH,                           
                           A.KV,                           
                           A.NBS,
                           D.VIDD,
                           CASE WHEN TO_DATE (:sFdat1, ''DD.MM.YYYY'') - 1 >= a.dapp
                                THEN a.ostc
                                ELSE a.ostc - (SELECT SUM (kos - dos)
                                                 FROM saldoa
                                                WHERE acc = d.acc
                                                  AND fdat >TO_DATE (:sFdat1, ''DD.MM.YYYY'')- 1)
                           END                                                                          VX,
                           nvl((SELECT SUM (dos)
                              FROM saldoa
                             WHERE acc = d.acc
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) DOS,
                           nvl((SELECT SUM (gl.p_icurval(a.kv,dos,fdat))
                              FROM saldoa
                             WHERE acc = d.acc
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) DOSQ,                               
                           nvl((SELECT SUM (kos)
                              FROM saldoa
                             WHERE acc = d.acc
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) KOS,
                           nvl((SELECT SUM(gl.p_icurval(a.kv,kos,fdat))
                              FROM saldoa
                             WHERE acc = d.acc
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) KOSQ,
                           CASE WHEN TO_DATE (:sFdat2, ''DD.MM.YYYY'') >= a.dapp
                                THEN a.ostc
                                ELSE a.ostc - (SELECT SUM (kos - dos)
                                                 FROM saldoa
                                                WHERE acc = d.acc
                                                 AND fdat > TO_DATE (:sFdat2, ''DD.MM.YYYY''))
                           END                                                                                       IX,
                           ACRN.FPROCN(D.ACC,1, TO_DATE(:sFdat2,''DD.MM.YYYY'') )                                      SR,
                           (D.DAT_END-D.DAT_BEGIN)                                                                   ST,
                           CASE WHEN TO_DATE (:sFdat1, ''DD.MM.YYYY'') - 1 >= ar.dapp
                                THEN ar.ostc
                                ELSE ar.ostc -(SELECT SUM (kos - dos)
                                                 FROM saldoa
                                                WHERE acc = I.ACRA
                                                  AND fdat >TO_DATE (:sFdat1, ''DD.MM.YYYY'')- 1)
                           END                                                                                       VX1,          
                           nvl((SELECT SUM (dos)
                              FROM saldoa
                             WHERE acc = I.ACRA
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) DOS1,               
                           nvl((SELECT SUM (gl.p_icurval(a.kv,dos,fdat))
                              FROM saldoa
                             WHERE acc = I.ACRA
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) DOS1Q,                               
                           nvl((SELECT SUM (kos)
                              FROM saldoa
                             WHERE acc = I.ACRA
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) KOS1,               
                           nvl((SELECT SUM(gl.p_icurval(a.kv,kos,fdat))
                              FROM saldoa
                             WHERE acc = I.ACRA
                               AND fdat between TO_DATE (:sFdat1, ''DD.MM.YYYY'') and TO_DATE (:sFdat2, ''DD.MM.YYYY'')),0) KOS1Q,
                           CASE WHEN TO_DATE (:sFdat2, ''DD.MM.YYYY'') >= ar.dapp
                                THEN ar.ostc
                                ELSE ar.ostc -(SELECT SUM (kos - dos)
                                                 FROM saldoa
                                                WHERE acc = I.ACRA
                                                  AND fdat >TO_DATE (:sFdat2, ''DD.MM.YYYY''))
                           END                                                                          IX1,    
                           CASE WHEN A.DAOS < TO_DATE (:sFdat1, ''DD.MM.YYYY'')
                                THEN 1
                                ELSE 0
                           END     VKOL,
                           CASE WHEN A.DAOS >= TO_DATE (:sFdat1, ''DD.MM.YYYY'')
                                THEN 1
                                ELSE 0
                           END     KKOL,
                           CASE WHEN A.DAZS <= TO_DATE (:sFdat2, ''DD.MM.YYYY'')
                                THEN 1
                                ELSE 0
                           END     DKOL,
                           CASE WHEN A.DAZS >= TO_DATE (:sFdat2, ''DD.MM.YYYY'') OR A.DAZS IS NULL
                                THEN 1
                                ELSE 0
                           END     IKOL
                      FROM DPT_DEPOSIT D,
                           accounts A,
                           accounts AR,
                           (SELECT ACC, ACRA FROM INT_ACCN WHERE ID = 1) I                   
                     WHERE     A.ACC = D.ACC
                           AND D.ACC = I.ACC(+)
                           AND AR.ACC = I.ACRA
                           AND a.nbs IN (''2620'', ''2630'', ''3320'')                          
                           ) KK                                
          WHERE (VX+IX+DOS+KOS<>0)
          GROUP BY BRANCH,
                   kk.KV,
                   NBS,
                   VIDD                   
                   ) K,
         BRANCH B,
         DPT_VIDD T
   WHERE B.BRANCH = K.BRANCH AND T.VIDD = K.VIDD
ORDER BY K.VIDD, K.BRANCH';
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
