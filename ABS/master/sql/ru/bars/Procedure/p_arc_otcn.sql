

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ARC_OTCN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ARC_OTCN ***

  CREATE OR REPLACE PROCEDURE BARS.P_ARC_OTCN (pdat_ in date, pmode_ in number := 2)
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%is
% DESCRIPTION :    Допоміжгна функція для формування #A7
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    29/07/2015 (24/07/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 параметры: PDAT_ - звітна дата
            PMODE_ - ознака режиму формування
               0 - з процедури P_FA7_NN (для підстраховки) для декади
               1 - з процедури P_FA7_NN (для підстраховки) для ANI-звітів
               2 - з триггера
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    ln_npp  number;
    dc_     number;
    datr_   date;
    datn_   date;
    cnt1_   number := 0;
    cnt2_   number := 0;
    mfo_    number;
    dat1_   date;
    dat2_   date;
begin
    tuda;

    mfo_ := f_ourmfo ();

    if pmode_ in (0, 2) then
        -- фактична дата кінця декади
        dc_ := TO_NUMBER (LTRIM (TO_CHAR (pdat_, 'DD'), '0'));

        FOR i IN 1 .. 3
        LOOP
           IF dc_ BETWEEN 10 * (i - 1) + 1 AND 10 * i + iif (i, 3, 0, 1, 0)
           THEN
              IF i < 3
              THEN
                  datn_ :=
                     TO_DATE (LPAD (10 * i, 2, '0')
                              || TO_CHAR (pdat_, 'mmyyyy'),
                              'ddmmyyyy'
                             );
              ELSE
                 datn_ := LAST_DAY (pdat_);
              END IF;

              EXIT;
           END IF;
        END LOOP;

        select max(fdat)
        into datr_
        from fdat
        where fdat<=datn_;

        IF mfo_ in (353575, 380674) then
           datn_ := datr_;
        end if;
    else
        datn_ := pdat_;
        datr_ := pdat_;
    end if;

    -- з поцедури формування звытності на всяк випадок (якщо не накопились дані на тригері)
    if pmode_ in (0, 1) then
       select count(*)
       into cnt1_
       from OTC_ARC_CC_LIM
       where DAT_OTC = datn_;

       select count(*)
       into cnt2_
       from OTC_ARC_CC_TRANS
       where DAT_OTC = datn_;

       if cnt1_ > 0 and cnt2_ > 0 and trunc(sysdate) > datn_ then
       -- було збережено раніше, тому не чіпаємо історію
          return;
       elsif trunc(sysdate) <= datn_ then
       -- до настяння звітної дати весь час чистимо та наповнюємо знову
          delete from OTC_ARC_CC_LIM where DAT_OTC = datn_;
          delete from OTC_ARC_CC_TRANS where DAT_OTC = datn_;

          cnt1_ := 0;
          cnt2_ := 0;
       end if;
    end if;

    select s_otc_arc.nextval
    into ln_npp
    from dual;

    insert into OTC_ARC_INFO (NPP, DAT_OTC, DAT_SYS, DAT_BANK, USERID)
    values (ln_npp, datn_, sysdate, bankdate, user_id);

    -- працює job один після настання звітної дати і зберігає історію
    if pmode_ = 2 then
       delete from OTC_ARC_CC_LIM where DAT_OTC = datn_;
       delete from OTC_ARC_CC_TRANS where DAT_OTC = datn_;

       cnt1_ := 0;
       cnt2_ := 0;

       -- читимо проміжні результати, якщо накоплені дані кожен день для ANI-звітів
       if datn_ = last_day(datn_) then
          dat1_ := trunc(datn_, 'mm') + 9;
          dat2_ := trunc(datn_, 'mm') + 9;

          delete
          from OTC_ARC_CC_LIM
          where dat_otc between trunc(datn_, 'mm') and datn_ and
             dat_otc not in (dat1_, dat2_);

          delete
          from OTC_ARC_CC_TRANS
          where dat_otc between trunc(datn_, 'mm') and datn_ and
             dat_otc not in (dat1_, dat2_);
       end if;
    end if;

    if cnt1_ = 0 then
        insert /*+APPEND*/ into OTC_ARC_CC_LIM (DAT_OTC, ND, FDAT, LIM2, ACC, SUMG, SUMO)
        select /*+parallel */ datn_, nd, fdat, lim2, acc, sumg, sumo
        from cc_lim c
        where nd in  (select n.nd
                      from accounts s, nd_acc n, snap_balances b
                      where s.acc = n.acc and
                            s.nbs in (select r020
                                      from kod_r020
                                      where a010 = 'A7' and
                                            d_close is null) and
                            s.acc = b.acc and
                            b.fdat = datr_ and
                            b.ostq <> 0);
    end if;

    if cnt2_ = 0 then
        insert /*+APPEND*/ into OTC_ARC_CC_TRANS (DAT_OTC, NPP, REF, ACC, FDAT, SV, SZ, D_PLAN, D_FAKT, DAPP, REFP, COMM)
        select /*+parallel */ datn_, t.NPP, t.REF, t.ACC, t.FDAT, t.SV, t.SZ, t.D_PLAN, t.D_FAKT, t.DAPP, t.REFP, t.COMM
        from cc_trans t
        where t.acc in  (select n.acc
                        from accounts s, nd_acc n, snap_balances b
                        where s.acc = n.acc and
                              s.nbs in (select r020
                                        from kod_r020
                                        where a010 = 'A7' and
                                              d_close is null) and
                              s.acc = b.acc and
                              b.fdat = datr_ and
                              b.ostq <> 0);
    end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ARC_OTCN.sql =========*** End **
PROMPT ===================================================================================== 
