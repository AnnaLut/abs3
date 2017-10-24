

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ACCHIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ACCHIST ***

  CREATE OR REPLACE PROCEDURE BARS.P_ACCHIST (
  Mode_   number,  /* 1- Par_=Acc, 2- Par_=Rnk */
  Par_    number,
  Dat1_   date,
  Dat2_   date ) IS

--***************************************************************--
-- (C) BARS
-- Version 1.14 01/04/2014
-- Процедура отбора изменений параметров счета за период дат
-- 23.02.2016 LitvinSO Добавлена вычитка таблмцы Person_update для карточки клиента
--***************************************************************--

refcur SYS_REFCURSOR;
ColName_        varchar2(80);
ColType_        varchar2(1);
TextSql_	varchar2(4000);
ValOld_		varchar2(70);
ValNew_		varchar2(70);
sTmpOld_	varchar2(70);
sTmpNew_	varchar2(70);
nTmpOld_	number;
nTmpNew_	number;
dTmpOld_	date;
dTmpNew_	date;
nKey_           number;
Isp_		accounts_update.doneby%type;
Dat_		accounts_update.chgdate%type;
Idupd_          accounts_update.idupd%type;
bProc_          number:=0;
bTarif_         number:=0;
bAcc_           number:=0;
bAccw_          number:=0;
bCust_          number:=0;
bCustw_         number:=0;
bCustRel_       number:=0;
bCustp_         number:=0;
BEGIN
  DELETE FROM tmp_acchist WHERE iduser=user_id;

  FOR k IN ( SELECT a.tabid, t.tabname,
                    a.colid, c.colname, c.semantic, c.coltype
               FROM acc_par a, meta_tables t, meta_columns c
              WHERE a.tabid=t.tabid AND t.tabid=c.tabid AND a.colid=c.colid
                AND a.pr=Mode_
              ORDER BY a.tabid, a.colid )
  LOOP
     -- Mode_ = 1 - счета
     IF k.tabname = 'ACCOUNTS' THEN
        if bAcc_ = 0 then
           bAcc_ := 1 ;
           FOR q in (SELECT decode(a.chgaction,1,'Зарегистрирован',3,'Закрыт','Перерегистрирован') vid,
                            a.chgdate, s.logname, a.idupd
                       FROM accounts_update a, staff$base s
                      WHERE a.acc=Par_ AND a.doneby=s.logname
                        AND trunc(a.chgdate,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.chgdate,'dd')<=trunc(Dat2_,'dd')
                        AND a.chgaction in (1,3,0) )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, 'Счет',
                 '', q.vid, q.logname, q.chgdate, q.idupd);
           END LOOP;
        end if;
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.acc, b.'|| k.colname ||', a.'|| k.colname ||',
                a.chgdate, a.doneby, a.idupd, '''||k.semantic||'''
           FROM accounts_update a, accounts_update b
          WHERE a.acc='|| Par_ || '
            AND a.acc=b.acc
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM accounts_update
                           WHERE acc=b.acc AND idupd>b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM accounts_update
                           WHERE acc=a.acc AND idupd<a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.chgdate,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.chgdate,''dd'')<=trunc(:Dat2_,''dd'') ' ;
     ELSIF k.tabname = 'ACCOUNTSW' THEN
        if bAccw_ = 0 then
           bAccw_ := 1 ;
           FOR q in (SELECT decode(a.chgaction,'I',substr(a.value,1,70),'Удален') vid,
                            a.chgdate, s.logname, a.idupd, substr(f.name,1,100) name
                       FROM accountsw_update a, staff$base s, accounts_field f
                      WHERE a.acc = Par_ AND a.doneby = s.id
                        AND trunc(a.chgdate,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.chgdate,'dd')<=trunc(Dat2_,'dd')
                        AND a.chgaction in ('I','D')
                        and a.tag = f.tag )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, q.name,
                 '', q.vid, q.logname, q.chgdate, q.idupd);
           END LOOP;
        end if;
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.acc, substr(b.'|| k.colname ||',1,70), substr(a.'|| k.colname ||',1,70),
                a.chgdate, s.logname, a.idupd, f.name
           FROM accountsw_update a, accountsw_update b, accounts_field f, staff$base s
          WHERE a.acc='|| Par_ || '
            AND a.doneby = s.id
            AND a.acc = b.acc
            and a.tag = b.tag
            and a.chgaction = ''U''
            and b.chgaction in (''I'',''U'')
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM accountsw_update
                           WHERE acc = b.acc
                             and tag = b.tag
                             AND idupd > b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM accountsw_update
                           WHERE acc=a.acc
                             and tag = a.tag
                             AND idupd < a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.chgdate,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.chgdate,''dd'')<=trunc(:Dat2_,''dd'')
            and a.tag = f.tag ' ;
     ELSIF k.tabname = 'SPECPARAM' THEN
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.acc, b.'|| k.colname ||', a.'|| k.colname ||',
                a.fdat, a.user_name, a.idupd, '''||k.semantic||'''
           FROM specparam_update a, specparam_update b
          WHERE a.acc='|| Par_ || '
            AND a.acc=b.acc
            AND nvl(a.'|| k.colname ||',0)<>nvl(b.'|| k.colname ||',0)
            AND a.idupd=( SELECT min(idupd)
                            FROM specparam_update
                           WHERE acc=b.acc AND idupd>b.idupd
                             AND nvl('|| k.colname ||',0)<>nvl(b.'|| k.colname ||',0) )
            AND b.idupd=( SELECT max(idupd)
                            FROM specparam_update
                           WHERE acc=a.acc AND idupd<a.idupd
                             AND nvl('|| k.colname ||',0)<>nvl(a.'|| k.colname ||',0) )
            AND trunc(a.fdat,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.fdat,''dd'')<=trunc(:Dat2_,''dd'') ' ;
     ELSIF k.tabname = 'SPECPARAM_INT' THEN
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.acc, b.'|| k.colname ||', a.'|| k.colname ||',
                a.fdat, a.user_name, a.idupd, '''||k.semantic||'''
           FROM specparam_int_update a, specparam_int_update b
          WHERE a.acc='|| Par_ || '
            AND a.acc=b.acc
            AND nvl(a.'|| k.colname ||',0)<>nvl(b.'|| k.colname ||',0)
            AND a.idupd=( SELECT min(idupd)
                            FROM specparam_int_update
                           WHERE acc=b.acc AND idupd>b.idupd
                             AND nvl('|| k.colname ||',0)<>nvl(b.'|| k.colname ||',0) )
            AND b.idupd=( SELECT max(idupd)
                            FROM specparam_int_update
                           WHERE acc=a.acc AND idupd<a.idupd
                             AND nvl('|| k.colname ||',0)<>nvl(a.'|| k.colname ||',0) )
            AND trunc(a.fdat,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.fdat,''dd'')<=trunc(:Dat2_,''dd'') ' ;
     ELSIF k.tabname = 'INT_RATN' THEN
        if bProc_ = 0 then
           for q in (SELECT a.bdat, decode(a.vid,'I','Добавлен','Удален') vid,
                            a.fdat, s.logname, a.idupd
                       FROM int_ratn_arc a, staff$base s
                      WHERE a.acc=Par_ AND a.idu=s.id
                        AND trunc(a.fdat,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.fdat,'dd')<=trunc(Dat2_,'dd')
                        AND (a.vid='D' OR a.vid='I') )
           loop
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, '% ставка ' || to_char(q.bdat,'dd/MM/yyyy'),
                 '', q.vid, q.logname, q.fdat, q.idupd);
           end loop;
           bProc_ := 1 ;
           ColType_ := 'C' ;
           TextSql_ :=
           'SELECT a.acc,
                   decode(b.ir,null,'''',
                       trim(to_char(b.ir,''9999999999999990''||
                         decode(b.ir-floor(b.ir),0,'''',''D''||
                         rpad(''9'',length(to_char(b.ir-floor(b.ir)))-1,''9''))))||'' '') ||
                     decode(b.op,null,'''',o2.semantic||'' '')||
                     decode(b.br,null,'''',''[''||b2.name||'']''),
                   decode(a.ir,null,'''',
                       trim(to_char(a.ir,''9999999999999990''||
                         decode(a.ir-floor(a.ir),0,'''',''D''||
                         rpad(''9'',length(to_char(a.ir-floor(a.ir)))-1,''9''))))||'' '') ||
                     decode(a.op,null,'''',o1.semantic||'' '')||
                     decode(a.br,null,'''',''[''||b1.name||'']''),
                   a.fdat, s.logname, a.idupd,
                   ''% cтавка ''||to_char(b.bdat,''dd/MM/yyyy'')
              FROM int_ratn_arc a, int_ratn_arc b, staff$base s,
                   int_op o1, int_op o2,
                   brates b1, brates b2
             WHERE a.acc=' || Par_ || '
               AND a.acc=b.acc AND a.id=b.id AND a.bdat=b.bdat
               AND a.idu=s.id
               AND a.op=o1.op(+) AND a.br=b1.br_id(+)
               AND b.op=o2.op(+) AND b.br=b2.br_id(+)
               AND (   nvl(a.br,0)<>nvl(b.br,0)
                    OR nvl(a.ir,0)<>nvl(b.ir,0)
                    OR nvl(a.op,0)<>nvl(b.op,0) )
               AND a.idupd=( SELECT min(idupd)
                               FROM int_ratn_arc
                              WHERE acc=b.acc AND id=b.id AND bdat=b.bdat AND idupd>b.idupd
                                AND (   nvl(br,0)<>nvl(b.br,0)
                                     OR nvl(ir,0)<>nvl(b.ir,0)
                                     OR nvl(op,0)<>nvl(b.op,0) ) )
               AND b.idupd=( SELECT max(idupd)
                               FROM int_ratn_arc
                              WHERE acc=a.acc AND id=a.id AND bdat=a.bdat AND idupd<a.idupd
                                AND (   nvl(br,0)<>nvl(a.br,0)
                                     OR nvl(ir,0)<>nvl(a.ir,0)
                                     OR nvl(op,0)<>nvl(a.op,0) ) )
               AND trunc(a.fdat,''dd'')>=trunc(:Dat1_,''dd'')
               AND trunc(a.fdat,''dd'')<=trunc(:Dat2_,''dd'')
               AND a.vid=''U'' AND b.vid in (''I'', ''U'')' ;
        else TextSql_ := '' ;
        end if;
     ELSIF k.tabname = 'ACC_TARIF' THEN
        if bTarif_ = 0 then
           bTarif_ := 1;
           FOR q in (SELECT a.kod, decode(a.vid,'I','Добавлен','Удален') vid,
                            a.fdat, s.logname, a.idupd
                       FROM acc_tarif_arc a, staff$base s
                      WHERE a.acc=Par_ AND a.user_id=s.id
                        AND trunc(a.fdat,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.fdat,'dd')<=trunc(Dat2_,'dd')
                        AND (a.vid='D' OR a.vid='I') )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, 'Инд.Тариф ' || to_char(q.kod),
                 '', q.vid, q.logname, q.fdat, q.idupd);
           END LOOP;
        end if;
        ColType_ := 'C' ;
        TextSql_ :=
        'SELECT a.acc,
                to_char(b.'|| k.colname || Iif_S(k.coltype,'D','',',''dd/MM/yyyy''','') ||'),
                to_char(a.'|| k.colname || Iif_S(k.coltype,'D','',',''dd/MM/yyyy''','') ||'),
                a.fdat, s.logname, a.idupd,
                ''Инд.Тариф '' || to_char(a.kod) || ''. '' || '''||k.semantic||'''
           FROM acc_tarif_arc  a, acc_tarif_arc  b, staff$base s
          WHERE a.acc='|| Par_ || '
            AND a.acc=b.acc AND a.kod=b.kod
            AND a.user_id=s.id
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM acc_tarif_arc
                           WHERE acc=b.acc AND kod=b.kod AND idupd>b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM acc_tarif_arc
                           WHERE acc=a.acc AND kod=a.kod AND idupd<a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.fdat,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.fdat,''dd'')<=trunc(:Dat2_,''dd'')
            AND a.vid=''U'' AND b.vid in (''I'', ''U'') ' ;
     -- Mode_ = 2 - клиенты
     ELSIF k.tabname = 'CUSTOMER' THEN
        if bCust_ = 0 then
           bCust_ := 1 ;
           FOR q in (SELECT decode(a.chgaction,1,'Зарегистрирован',3,'Закрыт','Перерегистрирован') vid,
                            a.chgdate, s.logname, a.idupd
                       FROM customer_update a, staff$base s
                      WHERE a.rnk=Par_ AND a.doneby=s.logname
                        AND trunc(a.chgdate,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.chgdate,'dd')<=trunc(Dat2_,'dd')
                        AND a.chgaction in (1,3,0) )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, 'Контрагент',
                 '', q.vid, q.logname, q.chgdate, q.idupd);
           END LOOP;
        end if;
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.rnk, b.'|| k.colname ||', a.'|| k.colname ||',
                a.chgdate, a.doneby, a.idupd, '''||k.semantic||'''
           FROM customer_update a, customer_update b
          WHERE a.rnk='|| Par_ || '
            AND a.rnk=b.rnk
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM customer_update
                           WHERE rnk=b.rnk AND idupd>b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM customer_update
                           WHERE rnk=a.rnk AND idupd<a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.chgdate,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.chgdate,''dd'')<=trunc(:Dat2_,''dd'') ' ;
     ELSIF k.tabname = 'PERSON' THEN
       /* if bCustp_ = 0 then
           bCustp_ := 1 ;
           FOR q in (SELECT decode(a.chgaction,'I','Новий','D','Видалено','Змінено') vid,
                            a.chgdate, s.logname, a.idupd
                       FROM person_update a, staff$base s
                      WHERE a.rnk=Par_ AND a.doneby=s.id
                        AND trunc(a.chgdate,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.chgdate,'dd')<=trunc(Dat2_,'dd')
                        AND a.chgaction in ('I','D','U') )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, k.semantic,
                 '', q.vid, q.logname, q.chgdate, q.idupd);
           END LOOP;
        end if;*/
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.rnk, b.'|| k.colname ||', a.'|| k.colname ||',
                a.chgdate, s.logname, a.idupd, '''||k.semantic||'''
           FROM person_update a, person_update b, staff$base s
          WHERE a.rnk='|| Par_ || '
            AND a.rnk=b.rnk
            AND a.doneby=s.id
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM person_update
                           WHERE rnk=b.rnk AND idupd>b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM person_update
                           WHERE rnk=a.rnk AND idupd<a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.chgdate,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.chgdate,''dd'')<=trunc(:Dat2_,''dd'') ' ;
     ELSIF k.tabname = 'CUSTOMERW' THEN
        if bCustw_ = 0 then
           bCustw_ := 1 ;
           FOR q in (SELECT decode(a.chgaction,1,substr(a.value,1,70),'Удален') vid,
                            a.chgdate, s.logname, a.idupd, substr(f.name,1,100) name
                       FROM customerw_update a, staff$base s, customer_field f
                      WHERE a.rnk = Par_ AND a.doneby=s.logname
                        AND trunc(a.chgdate,'dd')>=trunc(Dat1_,'dd')
                        AND trunc(a.chgdate,'dd')<=trunc(Dat2_,'dd')
                        AND a.chgaction in (1,3)
                        and a.tag = f.tag )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, q.name,
                 '', q.vid, q.logname, q.chgdate, q.idupd);
           END LOOP;
        end if;
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.rnk, substr(b.'|| k.colname ||',1,70), substr(a.'|| k.colname ||',1,70),
                a.chgdate, a.doneby, a.idupd, f.name
           FROM customerw_update a, customerw_update b, customer_field f
          WHERE a.rnk='|| Par_ || '
            AND a.rnk = b.rnk
            and a.tag = b.tag
            and a.isp = b.isp
            and a.chgaction = 2
            and b.chgaction in (1,2)
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM customerw_update
                           WHERE rnk = b.rnk
                             and tag = b.tag
                             and isp = b.isp
                             AND idupd > b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM customerw_update
                           WHERE rnk=a.rnk
                             and tag = a.tag
                             and isp = a.isp
                             AND idupd < a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.chgdate,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.chgdate,''dd'')<=trunc(:Dat2_,''dd'')
            and a.tag = f.tag ' ;
     ELSIF k.tabname = 'CUSTOMER_REL' THEN
        if bCustRel_ = 0 then
           bCustRel_ := 1 ;
           FOR q in (SELECT decode(a.chgaction,1,'Добавлен','Удален') vid,
                            a.chgdate, s.logname, a.idupd, substr(v.nmk || ' - ' || r.relatedness,1,100) name
                       FROM customer_rel_update a, staff$base s, v_customerrel_list v, cust_rel r
                      WHERE a.rnk = Par_
                        AND trunc(a.chgdate,'dd') >= trunc(Dat1_,'dd')
                        AND trunc(a.chgdate,'dd') <= trunc(Dat2_,'dd')
                        AND a.chgaction in (1,3)
                        AND a.doneby = s.logname
                        and a.rel_rnk = v.rnk
                        and a.rel_id = r.id )
           LOOP
              INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
                 valold, valnew, isp, dat, idupd)
              VALUES(user_id, Par_, k.tabid, k.colid, q.name,
                 '', q.vid, q.logname, q.chgdate, q.idupd);
           END LOOP;
        end if;
        ColType_ := k.coltype ;
        TextSql_ :=
        'SELECT a.rnk, b.'|| k.colname ||', a.'|| k.colname ||',
                a.chgdate, a.doneby, a.idupd, '''||replace(k.semantic,'''','`')||'''
           FROM customer_rel_update a, customer_rel_update b
          WHERE a.rnk='|| Par_ || '
            AND a.rnk = b.rnk
            and a.rel_id = b.rel_id
            and a.rel_rnk = b.rel_rnk
            AND (   a.'|| k.colname ||' <> b.'|| k.colname ||'
                 OR a.'|| k.colname ||' is     null AND
                    b.'|| k.colname ||' is not null
                 OR a.'|| k.colname ||' is not null AND
                    b.'|| k.colname ||' is     null )
            AND a.idupd=( SELECT min(idupd)
                            FROM customer_rel_update
                           WHERE rnk = b.rnk
                             and rel_id = b.rel_id
                             and rel_rnk = b.rel_rnk
                             AND idupd > b.idupd
                             AND (   '|| k.colname ||' <> b.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   b.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   b.'|| k.colname ||' is     null ) )
            AND b.idupd=( SELECT max(idupd)
                            FROM customer_rel_update
                           WHERE rnk = a.rnk
                             and rel_id = a.rel_id
                             and rel_rnk = a.rel_rnk
                             AND idupd < a.idupd
                             AND (   '|| k.colname ||' <> a.'|| k.colname ||'
                                  OR '|| k.colname ||' is     null AND
                                   a.'|| k.colname ||' is not null
                                  OR '|| k.colname ||' is not null AND
                                   a.'|| k.colname ||' is     null ) )
            AND trunc(a.chgdate,''dd'')>=trunc(:Dat1_,''dd'')
            AND trunc(a.chgdate,''dd'')<=trunc(:Dat2_,''dd'') ' ;
     END IF;

     IF TextSql_ is not null THEN
        OPEN  refcur FOR TextSql_ USING Dat1_, Dat2_;
        LOOP
           IF Upper(ColType_) = 'N' THEN
              FETCH refcur INTO nKey_, nTmpOld_, nTmpNew_, Dat_, Isp_, Idupd_, ColName_ ;
              EXIT WHEN refcur%NOTFOUND;
              ValOld_ := to_char(nTmpOld_) ;
              ValNew_ := to_char(nTmpNew_) ;
           ELSIF Upper(ColType_) = 'D' THEN
              FETCH refcur INTO nKey_, dTmpOld_, dTmpNew_, Dat_, Isp_, Idupd_, ColName_ ;
              EXIT WHEN refcur%NOTFOUND;
              ValOld_ := to_char(dTmpOld_,'dd/MM/yyyy') ;
              ValNew_ := to_char(dTmpNew_,'dd/MM/yyyy') ;
           ELSE
              FETCH refcur INTO nKey_, sTmpOld_, sTmpNew_, Dat_, Isp_, Idupd_, ColName_ ;
              EXIT WHEN refcur%NOTFOUND;
              ValOld_ := sTmpOld_ ;
              ValNew_ := sTmpNew_ ;
           END IF;
           INSERT INTO tmp_acchist(iduser, acc, tabid, colid, parname,
              valold, valnew, isp, dat, idupd)
           VALUES(user_id, nKey_, k.tabid, k.colid, ColName_,
              ValOld_, ValNew_, Isp_, Dat_, Idupd_);
        END LOOP;
        CLOSE refcur;
     END IF;
  END LOOP;
END p_acchist;
/
show err;

PROMPT *** Create  grants  P_ACCHIST ***
grant EXECUTE                                                                on P_ACCHIST       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ACCHIST       to CUST001;
grant EXECUTE                                                                on P_ACCHIST       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ACCHIST       to WR_CUSTLIST;
grant EXECUTE                                                                on P_ACCHIST       to WR_ND_ACCOUNTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ACCHIST.sql =========*** End ***
PROMPT ===================================================================================== 
