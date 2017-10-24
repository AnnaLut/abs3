

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DAY_DOCS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DAY_DOCS ***

  CREATE OR REPLACE PROCEDURE BARS.P_DAY_DOCS ( Mode_     VARCHAR2,
                                              DatBegin_ VARCHAR2,
                                              DatEnd_   VARCHAR2,
                                              UserID_   VARCHAR2,
                                              OtdelID_  VARCHAR2 ) IS
  UserFIO       VARCHAR2(70);
  OtdelName     VARCHAR2(70);
  OtdelNum_     NUMBER;
  CheckDate     DATE;
  Kol_Prov_     NUMBER;
  Kol_Docs_     NUMBER;
  Sum_Eqv_      NUMBER;
  Sum_Nom_      NUMBER;
  Val_ISO_      NUMBER;
  Val_Name_     VARCHAR2(30);
  TT_ID_        VARCHAR2(3);
  TT_Name_      VARCHAR2(70);
  fdat_         DATE;
  s_nom_        NUMBER;
  s_eqv_        NUMBER;
  user_id_      NUMBER;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования печатных отчетов
% COPYRIGHT   : Макаренко И.В. 2010-
% VERSION     : 1.00
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
--=======================================================================================================
-- выборка проводок
CURSOR Sel_Prov_494_495 IS
    SELECT o2.fdat, o1.userid, s.fio, a.kv,t1.name, o2.tt, t2.name,
           count(*), sum(o2.s), sum(gl.p_icurval(a.kv,o2.s,o2.fdat))
      FROM oper o1, opl o2, accounts a, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.tt  = o2.tt
       AND o1.tt NOT IN ('PVP','PO1','PO3')
       AND o1.kv  = o2.kv
       AND o1.dk  = o2.dk
       AND o2.acc = a.acc
       AND a.kv      = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    SELECT o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name,
           count(*), sum(o2.s), sum(gl.p_icurval(a.kv,o2.s,o2.fdat))
      FROM oper o1, opl o2, accounts a, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.tt  = o2.tt
       AND o1.kv  <> o2.kv
       AND o1.dk  = o2.dk
       AND o2.acc = a.acc
       AND a.kv      = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    SELECT o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name,
           count(*), sum(o2.s), sum(gl.p_icurval(a.kv,o2.s,o2.fdat))
      FROM oper o1, opl o2, accounts a, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.tt  <> o2.tt
       AND o2.tt NOT IN ('PO3')
       AND o1.kv  = o2.kv
       AND o1.dk  = o2.dk
       AND o2.acc = a.acc
       AND a.kv      = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    SELECT o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name,
           count(*), sum(o2.s), sum(gl.p_icurval(a.kv,o2.s,o2.fdat))
      FROM oper o1, opl o2, accounts a, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.tt  <> o2.tt
       AND o1.kv  <> o2.kv
       AND o2.tt NOT IN ('PO3')
       AND o1.dk  = o2.dk
       AND o2.acc = a.acc
       AND a.kv      = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, a.kv, t1.name, o2.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    SELECT o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk,3,4)),
                                  'IME', hex_to_num(substr(o1.chk,21,4)),
                                  'IMI', hex_to_num(substr(o1.chk,21,4)),
                                  'KLO', hex_to_num(substr(o1.chk,21,4)),
                                  'KL7', hex_to_num(substr(o1.chk,21,4)),
                                  'KL8', hex_to_num(substr(o1.chk,21,4)) ) userid,
           s.fio, a.kv, t1.name, o2.tt, t2.name,
           count(*), sum(o2.s), sum(gl.p_icurval(a.kv,o2.s,o2.fdat))
      FROM oper o1, opl o2, accounts a, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.dk  = o2.dk
       AND o2.acc = a.acc
       AND a.kv      = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk,3,4)),
                                                           'IME', hex_to_num(substr(o1.chk,21,4)),
                                                           'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                           'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                           'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                           'KL8', hex_to_num(substr(o1.chk,21,4)) ) )
            or ( Mode_ = 494 and o1.tt in ('PRI','IMI','IME','KLO','KL7','KL8')
                             and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk,3,4)),
                                     'IME', hex_to_num(substr(o1.chk,21,4)),
                                     'IMI', hex_to_num(substr(o1.chk,21,4)),
                                     'KLO', hex_to_num(substr(o1.chk,21,4)),
                                     'KL7', hex_to_num(substr(o1.chk,21,4)),
                                     'KL8', hex_to_num(substr(o1.chk,21,4)) ), s.fio, a.kv, t1.name, o2.tt, t2.name;
--==================================================================================================================
-- выборка документов
CURSOR Sel_Docs_494_495 IS
    -- все оплаченные документы за исключением перечисленных --
    SELECT o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o2.tt, t2.name, count(*), 0, 0
      FROM oper o1, opl o2, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.dk  = o2.dk
       AND o1.kv  = o2.kv
       AND o1.tt  = o2.tt
       AND o1.s   = o2.s
       AND o1.tt NOT IN ('SIF','PVP','PO1','PO3')
       AND o1.kv     = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o2.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    -- специфические операции "217", "218"
    SELECT o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o2.tt, t2.name, count(*), sum(o1.s), 0
      FROM oper o1, opl o2, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.dk  = o2.dk
       AND o1.kv  = o2.kv
       AND o1.tt IN ('217','218')
       AND o1.kv     = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o2.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    -- специфическая операция "D90"
    SELECT o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o1.tt, t2.name, count(*),
                                                                      sum(o1.s),
                                                                      sum(gl.p_icurval(o1.kv,o1.s,o2.fdat))
      FROM oper o1, opl o2, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.dk  = o2.dk
       AND o1.kv  = o2.kv
       AND o2.s   = ROUND((o1.s/100)/10,2)*100
       AND o1.tt IN ('D90')
       AND o1.kv     = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o1.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    -- специфическая операция "CLI"
    SELECT o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o1.tt, t2.name, count(unique o1.ref), sum(o1.s), 0
      FROM oper o1, opl o2, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.dk  = o2.dk
       AND o1.tt  = 'CLI'
       AND o2.tt  = 'CLD'
       AND o1.kv     = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = UserID_ )
            or ( Mode_ = 494 and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, o1.userid, s.fio, o1.kv, t1.name, o1.tt, t2.name
   UNION ALL -------------------------------------------------------------------------------------------
    -- операции по системе "Банк-Клиент"
    SELECT o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                  'IME', hex_to_num(substr(o1.chk,21,4)),
                                  'IMI', hex_to_num(substr(o1.chk,21,4)),
                                  'KLO', hex_to_num(substr(o1.chk,21,4)),
                                  'KL7', hex_to_num(substr(o1.chk,21,4)),
                                  'KL8', hex_to_num(substr(o1.chk,21,4)) ) userid,
           s.fio, o1.kv, t1.name, o2.tt, t2.name, count(*), sum(o1.s), 0
      FROM oper o1, opl o2, tabval t1, tts t2, staff s
     WHERE o2.fdat BETWEEN DatBegin_ AND DatEnd_
       AND o1.sos = 5 AND o1.ref = o2.ref
       AND o1.dk  = o2.dk
       AND o1.kv     = t1.kv -- выборка наименования валюты
       AND o1.userid = s.id  -- выборка Ф.И.О. исполнителя
       AND o2.tt     = t2.tt -- выборка наименования операции
       AND (   ( Mode_ = 495 and o1.userid = decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk,3,4)),
                                                           'IME', hex_to_num(substr(o1.chk,21,4)),
                                                           'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                           'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                           'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                           'KL8', hex_to_num(substr(o1.chk,21,4)) ) )
            or ( Mode_ = 494 and o1.tt in ('PRI','IMI','IME','KLO','KL7','KL8')
                             and o1.userid in (select unique userid from otd_user where otd=OtdelID_ ) ) )
     GROUP BY o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk,3,4)),
                                     'IME', hex_to_num(substr(o1.chk,21,4)),
                                     'IMI', hex_to_num(substr(o1.chk,21,4)),
                                     'KLO', hex_to_num(substr(o1.chk,21,4)),
                                     'KL7', hex_to_num(substr(o1.chk,21,4)),
                                     'KL8', hex_to_num(substr(o1.chk,21,4)) ), s.fio, o1.kv, t1.name, o2.tt, t2.name;
--==================================================================================================================

-- +===================================================================+
-- |                                                                   |
-- |                       Начало тела процедуры                       |
-- |                                                                   |
-- +===================================================================+
BEGIN

  -- очистим таблицу от старого "мусора"
  EXECUTE IMMEDIATE('TRUNCATE TABLE tmp_day_docs');

  -- получим Ф.И.О. пользователя
  IF UserID_ IS NOT NULL THEN
    BEGIN
      SELECT fio INTO UserFIO FROM staff WHERE id=UserID_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        UserFIO := 'Користувач з кодом `'|| UserID_ || '` не знайдений !';
        INSERT INTO tmp_day_docs( datefrom,   dateto, userid,     fio )
                          VALUES( DatBegin_, DatEnd_,      0, UserFIO );
        COMMIT;
        RETURN;
      END;
    END;
  END IF;

  -- получим наименование отдела
  IF OtdelID_ IS NOT NULL THEN
    SELECT id, name INTO OtdelNum_, OtdelName FROM otdel WHERE id=OtdelID_;
  ELSE
    IF UserID_ IS NOT NULL THEN
      BEGIN
        SELECT id, name INTO OtdelNum_, OtdelName FROM otdel WHERE id=(SELECT otd
                                                                         FROM otd_user
                                                                        WHERE userid=269
                                                                          AND pr=1);
      EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
          OtdelName := 'Назва відділу не визначена !';
          UserFIO   := 'Можливо для користувача `'|| UserID_ ||'` не вказана ознака основного відділу !';
          INSERT INTO tmp_day_docs( datefrom,   dateto,  otd_id,  otd_name,     fio )
                            VALUES( DatBegin_, DatEnd_,       0, OtdelName, UserFIO );
          COMMIT;
          RETURN;
        END;
      END;
    ELSE
      BEGIN
        OtdelName := 'Не вказаний номер відділу !';
        UserFIO   := 'Не вказаний код користувача !';
        INSERT INTO tmp_day_docs( datefrom,   dateto,  otd_id,  otd_name, userid,     fio )
                          VALUES( DatBegin_, DatEnd_,       0, OtdelName,      0, UserFIO );
          COMMIT;
          RETURN;
      END;
    END IF;
  END IF;

  -- сводный отчет по документам дня по операционисту (495) / отделу (494)
  IF Mode_ IN (494,495) THEN
    BEGIN

      OPEN Sel_Prov_494_495;
      LOOP
        FETCH Sel_Prov_494_495 INTO fdat_, user_id_, UserFIO, Val_ISO_, Val_Name_, TT_ID_, TT_Name_, Kol_Prov_, s_nom_, s_eqv_;
        EXIT WHEN Sel_Prov_494_495%NOTFOUND;
        INSERT INTO tmp_day_docs ( datefrom, dateto, fdat, otd_id, otd_name, userid, fio, val_iso, val_name,
                                   tt_id, tt_name, cnt_prov, cnt_docs, sum_nom, sum_eqv )
                          VALUES ( DatBegin_, DatEnd_, fdat_, OtdelNum_, OtdelName, user_id_, UserFIO, Val_ISO_, Val_Name_,
                                   TT_ID_, TT_Name_, Kol_Prov_, 0, s_nom_, s_eqv_);
      END LOOP;
      CLOSE Sel_Prov_494_495;

      OPEN Sel_Docs_494_495;
      LOOP
        FETCH Sel_Docs_494_495 INTO fdat_, user_id_, UserFIO, Val_ISO_, Val_Name_, TT_ID_, TT_Name_, Kol_Docs_, s_nom_, s_eqv_;
        EXIT WHEN Sel_Docs_494_495%NOTFOUND;
        INSERT INTO tmp_day_docs ( datefrom, dateto, fdat, otd_id, otd_name, userid, fio, val_iso, val_name,
                                   tt_id, tt_name, cnt_prov, cnt_docs, sum_nom, sum_eqv )
                          VALUES ( DatBegin_, DatEnd_, fdat_, OtdelNum_, OtdelName, user_id_, UserFIO, Val_ISO_, Val_Name_,
                                   TT_ID_, TT_Name_, 0, Kol_Docs_, s_nom_, s_eqv_);
      END LOOP;
      CLOSE Sel_Docs_494_495;

    END;
  END IF;

/*
select fdat, id, namo, userid, fio, kv, name, tt, nt,
       sum(KOLPROV) CNT_PROV,
       sum(S_NOM) s,
       sum(S_EQV) sq,
       sum(KOLDOC) CNT_DOC
-- +===============================================================+
-- | *** 495 - Zvit po zvodu dokumntiv dnya (po operacionistu) *** |
-- | 06/10/2010 12:30                                              |
-- +===============================================================+
from
 (select K.FDAT, O.ID, O.NAME NAMO, K.USERID, F.FIO,
         K.KV, T.NAME NAME, K.TT, S.NAME NT, K.KOLPROV, K.S_NOM, K.S_EQV, 0 KOLDOC
  from staff    f,
       tabval   t,
       tts      s,
       OTDEL    o,
       OTD_USER u,
       ( ---------------------------------------------------------------------------
         --------                  selecting PROVODKI                 --------------
         ---------------------------------------------------------------------------
       ) k
  where k.userid = f.id and k.kv = t.kv and s.tt = k.tt and
        k.userid = u.userid(+) and o.ID = u.otd and f.id = :Param1 and u.otd = :Param2
  union all
  select v.fdat, o.id, o.name NAMO, v.userid, f.fio, v.kv, t.name NAME, v.tt, s.name NT, 0 KOLPROV, v.s_nom, v.s_eqv, v.koldoc
  from staff f,
       tabval t,
       tts s,
       otdel o,
       otd_user u,
       ( ---------------------------------------------------------------------------
         --------                  selecting DOCUMENTS                --------------
         ---------------------------------------------------------------------------
       ) v
  where v.userid=f.id and v.kv=t.kv and s.tt=v.tt and
        v.userid=u.userid(+) and o.ID=u.otd and f.id=:Param1 and u.otd=:Param2
 ) tabl1
group by fdat, id, namo, userid, fio, kv, name, tt, nt
order by kv, s;
*/

  COMMIT;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DAY_DOCS.sql =========*** End **
PROMPT ===================================================================================== 
