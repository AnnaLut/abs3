

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INTEREST_FINE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INTEREST_FINE ***

  CREATE OR REPLACE PROCEDURE BARS.P_INTEREST_FINE (p_type    IN NUMBER DEFAULT 0,
                                            p_date_to IN DATE,
                                            p_mode    in number default 0,
                                            p_group   in number default 0) IS

  /*

    ЮЛ   ФЛ
    p_type = 1 , 11 НА ВИМОГУ - по ВСІМ - Щомiсячне Нар. %%  та комісії
    p_type = 2 , 12 НА ВИМОГУ - з залишками на SG
    p_type=  5,15  ануїтет   ЩОДЕННЕ   - по пл. датах
    p_type = 3 , 13 ЩОДЕННЕ   - по пл. датах
    p_type = 4 , 14 ЩОДЕННЕ   - по прострочених дог.
    p_type = 17   для Києва тимчасово

    p_type < 0 НА ВИМОГУ - по 1 КД


    p_mode  - щоденний запуск по регламенту 1,щомісячно -1
    p_group - для всіх РУ 0
  */
  nint_  NUMBER;
  ddat2_ DATE; -- пл.дата из ГПК -1 или заданная дата  = ПО
  d_prev DATE; -- пред.банк-да та
  d_next DATE; -- след.банк-дата
  l_nazn VARCHAR2(160);
  dd     cc_deal%ROWTYPE;
  k1     SYS_REFCURSOR;
  l_mode INT := 1;

  l_bdat_real DATE;
  l_bdat_next DATE;

BEGIN

  IF p_type >= 0 AND p_type NOT IN (1, 2, 3, 4, 11, 12, 13, 14, 15, 15, 17) THEN
    RETURN;
  END IF;
  interest_utl.start_reckoning;

  ddat2_ := nvl(p_date_to, gl.bd);
  d_prev := dat_next_u(ddat2_, -1);
  d_next := ddat2_ + 1;

  IF p_type < 0 AND p_type <> -999 THEN
    -- НА ВИМОГУ- по 1 КД
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE nd = (-p_type)
         AND sos >= 10
         AND sos < 14
         AND vidd IN (1, 2, 3, 11, 12, 13);
    -- RAISE_APPLICATION_ERROR(-20008,p_type);
    pul.put('ND', substr(p_type, 2)); --для коректного вібображення view
  elsif p_type = 17 then
    OPEN k1 FOR
      SELECT d.nd, d.cc_id, d.sdate, d.wdate
        FROM cc_deal d, accounts a8, int_accn ia, nd_acc n, nd_txt tz
       WHERE p_type = 17
         AND vidd IN (11, 12, 13)
         AND ia.acc = a8.acc
         and ia.stp_dat is null
         AND n.acc = a8.acc
         AND n.nd = d.nd
         and tz.nd = d.nd
         AND ia.id in (0, 1)
         and tz.tag = 'FLAGS'
         and ia.s = 25
         and substr(tz.txt, 2, 1) = '0'
         and d.sos <> 15;
  ELSIF p_type = -999 THEN
    -- НА ВИМОГУ- по 1 КД
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE nd = (-to_number(pul.get_mas_ini_val('ND')))
         AND sos >= 10
         AND sos < 14
         AND vidd IN (1, 2, 3, 11, 12, 13);

  ELSIF p_type IN (1, 11) THEN

    -- НА ВИМОГУ- по ВСІМ
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 1 AND vidd IN (1, 2, 3) OR
             p_type = 11 AND vidd IN (11, 12, 13));

  ELSIF p_type IN (2, 12) THEN
    -- НА ВИМОГУ- з залишками на SG
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 2 AND vidd IN (1, 2, 3) OR
             p_type = 12 AND vidd IN (11, 12, 13))
         AND EXISTS (SELECT 1
                FROM accounts a, nd_acc n
               WHERE a.ostc > 0
                 AND a.tip = 'SG '
                 AND a.acc = n.acc
                 AND n.nd = d.nd);

  ELSIF p_type IN (3, 13) THEN
    -- ЩОДЕННЕ   - по пл. датах
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 3 AND vidd IN (1, 2, 3) OR
             p_type = 13 AND vidd IN (11, 12, 13))
         AND EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = d.nd
                 AND fdat > d_prev
                 AND fdat < d_next);
  ELSIF p_type IN (5, 15) THEN
    -- ЩОДЕННЕ   - по пл. датах АНУЇТЕТ
    OPEN k1 FOR
      SELECT UNIQUE d.nd, d.cc_id, d.sdate, d.wdate
        FROM cc_deal d, accounts a8, int_accn ia, nd_acc n
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 5 AND vidd IN (1, 2, 3) OR
             p_type = 15 AND vidd IN (11, 12, 13))
         AND ia.acc = a8.acc
            --and ia.stp_dat is null
         AND ia.id = 0
         AND n.acc = a8.acc
         AND n.nd = d.nd
         AND ia.basey = 2
         AND ia.basem = 1
         AND ia.id = 0
         AND EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = d.nd
                 AND fdat > d_prev
                 AND fdat < d_next);

  ELSIF p_type IN (3, 13) THEN
    -- ЩОДЕННЕ   - по пл. датах
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 3 AND vidd IN (1, 2, 3) OR
             p_type = 13 AND vidd IN (11, 12, 13))
         AND EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = d.nd
                 AND fdat > d_prev
                 AND fdat < d_next);

  ELSIF p_type IN (4, 14) THEN
    -- ЩОДЕННЕ  - по прострочених дог.
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos = 13
         AND d.wdate < ddat2_
         AND (p_type = 4 AND vidd IN (1, 2, 3) OR
             p_type = 14 AND vidd IN (11, 12, 13));

  END IF;

  IF NOT k1%ISOPEN THEN
    RETURN;
  END IF;

  LOOP
    FETCH k1
      INTO dd.nd, dd.cc_id, dd.sdate, dd.wdate;
    EXIT WHEN k1%NOTFOUND;
    --------------------------------------------

    IF p_type IN (3, 13, 5, 15) THEN
      SELECT MAX(fdat) - 1
        INTO ddat2_
        FROM cc_lim
       WHERE nd = dd.nd
         AND fdat > d_prev
         AND fdat < d_next;
    END IF;

    FOR p IN (SELECT a.nls,
                     a.accc,
                     a.acc,
                     a.tip,
                     i.basem,
                     i.basey,
                     greatest(nvl(i.acr_dat, a.daos - 1), dd.sdate - 1) + 1 ddat1,
                     i.metr,
                     i.id,
                     n.nd

                FROM accounts a, int_accn i, nd_acc n
               WHERE n.nd = dd.nd
                 AND n.acc = a.acc
                 AND a.acc = i.acc
                 AND (i.stp_dat IS NULL or i.stp_dat >= ddat2_)
                 AND (a.tip IN ('SS ', 'SP ', 'LIM', 'SPN', 'SK9', 'CR9') AND
                     i.id IN (0, 2) OR i.metr = 4 AND i.id = 1)
                 AND i.acra IS NOT NULL
                 AND i.acrb IS NOT NULL
                 AND i.acr_dat < ddat2_
                /* and a.kf='322669'*/) LOOP-- змінити
      DELETE FROM acr_intn;
      l_nazn := NULL;

      IF p.tip IN ('SP ', 'SPN', 'SK9') AND p.id = 2 THEN
      /* if p.acc=344310311 then
       RAISE_APPLICATION_ERROR(-20008, p.ddat1);
      end if; */
       acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ начисление пени

        l_nazn := substr('Нарахування пені. КД № ' || dd.cc_id ||  ', рах.' ||
                         p.nls,
                         1,
                         160);
      end if;

      interest_utl.take_reckoning_data(p_base_year => p.basey,
                                       p_purpose   => l_nazn,
                                       p_deal_id   => dd.nd);

    END LOOP; -- p\
    update INT_RECKONING t
       set t.purpose =  substr(substr(t.purpose,1,160) || ' Період: з ' ||
                       to_char(t.date_from, 'dd.mm.yyyy') || ' по ' ||
                       to_char(t.DATE_TO, 'dd.mm.yyyy') || ' вкл.',1,160)
     where t.deal_id = dd.nd
         and t.state_id=1;
  END LOOP; --k1

  CLOSE k1;

END p_interest_fine;
/
show err;

PROMPT *** Create  grants  P_INTEREST_FINE ***
grant EXECUTE                                                                on P_INTEREST_FINE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INTEREST_FINE.sql =========*** E
PROMPT ===================================================================================== 
