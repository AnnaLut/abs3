
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ot_sumh.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OT_SUMH (acc_ number, datr1_ DATE, datr2_ DATE, tp_ in number,
                        dat_ in date := null, kv_ in number := null)
  RETURN NUMBER DETERMINISTIC
IS
/******************************************************************************
 Назва      : ot_sumh
 Њризначенн§: Сункц?§ дл§ п?драхунку середньохронолог?чного залишку по рахунку
 ђерси§    : 5 от 08/07/2014
******************************************************************************

 Њараметри :
   acc_  - рахунок
   dat1_ - початок пер?оду
   dat2_ - к?нець пер?оду

 ?ата      Љвтор  Эпис
 --------  ------ -------------------------------------------------------------
 19.09/2012  VIRKO  1. створенн§
 20/09/2013  VIRKO  2. Ђм?на алгоритму розрахунку (б?льше наближено до формули)
 08/07/2014  VIRKO  5. Ђм?на алгоритму розрахунку через зм?нн? прот§го дн§
            курси валют
******************************************************************************/
  dat1_ date := trunc(datr1_, 'mm');
  dat2_ date := last_day(datr2_);
  osth_ number := 0;
  kol_  number := dat2_ - dat1_;
BEGIN
    if dat_ is null or dat_ is not null and dat_ < to_date('30092013','ddmmyyyy') then
        kol_  := dat2_ - dat1_;

        select decode(kol_, 0, sum(ost), nvl(round(sum(ost) / kol_), 0))
        into osth_
        from
        (select (case when fdat in (dat1_,  datr2_)
                               then ost / 2 + ost * (cnt - 1)
                               else ost * cnt
                          end) ost, cnt
                  from (
                    select acc, fdat, ost, ndat, ndat - fdat + 1 cnt
                    from (
                        select acc, fdat,
                            (case when sign(ost) = tp_ then ost else 0 end) ost,
                            nvl((lead(fdat, 1) over (partition by acc order by fdat)) - 1, dat2_) ndat
                        from (
                            select acc, dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat = datr1_ and
                                  dat1_ < datr1_ and
                                  acc = acc_
                            union all
                            select acc, fdat, ost
                            from SAL_DRAPS
                            where fdat in (datr1_,  datr2_) and
                                        acc = acc_
                            union all
                            select acc, fdat, ostf - dos + kos ost
                                  from saldoa
                                  where fdat between dat1_ and datr2_-1 and
                                        acc = acc_
                            order by fdat )     )   ) )
        where cnt<>0;
    else
        kol_  := dat2_ - dat1_ + 1;

        if kv_ is null or kv_ = 980 then
            select decode(kol_, 0, sum(ost), nvl(round(sum(ost) / kol_), 0))
            into osth_
            from
                 (select fdat, (case when fdat = dat1_ and cnt = 0 then ost / 2
                                   when fdat = dat2_ then ost / 2
                                   else ost * cnt
                                end) ost,
                         cnt
                  from (
                    select acc, fdat, ost, ndat, ndat - fdat + 1 cnt
                    from (
                        select acc, fdat,
                            (case when sign(ost) =  tp_ then ost else 0 end) ost,
                            nvl((lead(fdat, 1) over (partition by acc order by fdat)) - 1,  dat2_) ndat
                        from (
                            -- коли перша дата зв?тного пер?оду не робоча. вх?дний залишок - залишок на останн?й день попереднього м?с§ц§
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- коли перша дата зв?тного пер?оду не робоча. вх?дний залишок - залишок першого дн§ поточного м?с§ц§
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- коли останн?й день зв?тного пер?оду не робочий, то беремо з попереднього роьочого дн§
                            select acc,  dat2_ fdat, ost
                            from SAL_DRAPS
                            where fdat =  datr2_ and
                                  dat2_ >  datr2_ and
                                  acc =  acc_
                            union all
                            -- коли перша дата  зв?тного пер?оду робоча. вх?дний залишок - залишок на останн?й день попереднього м?с§ц§
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ =  datr1_ and
                                  acc =  acc_
                            union all
                            -- залишки на перщий та останн?й ЦЭљЭДїЕ день
                            select acc, fdat, ost
                            from SAL_DRAPS
                            where fdat in ( datr1_,   datr2_) and
                                  acc =  acc_
                            union all
                            -- зм?на залишк?в прот§гом зв?тного пер?оду
                            select acc, fdat, ostf - dos + kos ost
                                  from saldoa
                                  where fdat between  datr1_+1 and  datr2_-1 and
                                        acc =  acc_
                            order by fdat )     )   ) );
        else
            select decode(kol_, 0, sum(ost), nvl(round(sum(ost) / kol_), 0))
            into osth_
            from
                 (select fdat, (case when fdat = dat1_ and cnt = 0 then ost / 2
                                   when fdat = dat2_ then ost / 2
                                   else ost * cnt
                                end) ost,
                         cnt
                  from (
                    select acc, fdat, ost, ndat, ndat - fdat + 1 cnt
                    from (
                        select acc, fdat,
                            (case when sign(ost) =  tp_ then ost else 0 end) ost,
                            nvl((lead(fdat, 1) over (partition by acc order by fdat)) - 1,  dat2_) ndat
                        from (
                            -- коли перша дата зв?тного пер?оду не робоча. вх?дний залишок - залишок на останн?й день попереднього м?с§ц§
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SALB_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- коли перша дата зв?тного пер?оду не робоча. вх?дний залишок - залишок першого дн§ поточного м?с§ц§
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SALB_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- коли останн?й день зв?тного пер?оду не робочий, то беремо з попереднього роьочого дн§
                            select acc,  dat2_ fdat, ost
                            from SALB_DRAPS
                            where fdat =  datr2_ and
                                  dat2_ >  datr2_ and
                                  acc =  acc_
                            union all
                            -- коли перша дата  зв?тного пер?оду робоча. вх?дний залишок - залишок на останн?й день попереднього м?с§ц§
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SALB_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ =  datr1_ and
                                  acc =  acc_
                            union all
                            -- залишки на перщий та останн?й ЦЭљЭДїЕ день
                            select acc, fdat, ost
                            from SALB_DRAPS
                            where fdat in ( datr1_,   datr2_) and
                                  acc =  acc_
                            union all
                            -- зм?на залишк?в прот§гом зв?тного пер?оду
                            select acc, fdat, ostf - dos + kos ost
                                  from saldob
                                  where fdat between  datr1_+1 and  datr2_-1 and
                                        acc =  acc_
                            order by fdat )     )   ) );
        end if;
    end if;

    RETURN osth_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ot_sumh.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 