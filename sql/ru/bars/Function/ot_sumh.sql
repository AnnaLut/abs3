
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ot_sumh.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OT_SUMH (acc_ number, datr1_ DATE, datr2_ DATE, tp_ in number,
                        dat_ in date := null, kv_ in number := null)
  RETURN NUMBER DETERMINISTIC
IS
/******************************************************************************
 �����      : ot_sumh
 ����������: �����?� �� �?�������� ����������������?����� ������� �� �������
 �����    : 5 �� 08/07/2014
******************************************************************************

 ��������� :
   acc_  - �������
   dat1_ - ������� ���?���
   dat2_ - �?���� ���?���

 ?���      �����  ����
 --------  ------ -------------------------------------------------------------
 19.09/2012  VIRKO  1. ��������
 20/09/2013  VIRKO  2. ��?�� ��������� ���������� (�?���� ��������� �� �������)
 08/07/2014  VIRKO  5. ��?�� ��������� ���������� ����� ��?��? ������ ��
            ����� �����
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
                            -- ���� ����� ���� ��?����� ���?��� �� ������. ��?���� ������� - ������� �� ������?� ���� ������������ �?���
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- ���� ����� ���� ��?����� ���?��� �� ������. ��?���� ������� - ������� ������� �� ��������� �?���
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- ���� ������?� ���� ��?����� ���?��� �� �������, �� ������ � ������������ �������� ��
                            select acc,  dat2_ fdat, ost
                            from SAL_DRAPS
                            where fdat =  datr2_ and
                                  dat2_ >  datr2_ and
                                  acc =  acc_
                            union all
                            -- ���� ����� ����  ��?����� ���?��� ������. ��?���� ������� - ������� �� ������?� ���� ������������ �?���
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SAL_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ =  datr1_ and
                                  acc =  acc_
                            union all
                            -- ������� �� ������ �� ������?� �ݚ�Ŀ� ����
                            select acc, fdat, ost
                            from SAL_DRAPS
                            where fdat in ( datr1_,   datr2_) and
                                  acc =  acc_
                            union all
                            -- ��?�� ������?� ������� ��?����� ���?���
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
                            -- ���� ����� ���� ��?����� ���?��� �� ������. ��?���� ������� - ������� �� ������?� ���� ������������ �?���
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SALB_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- ���� ����� ���� ��?����� ���?��� �� ������. ��?���� ������� - ������� ������� �� ��������� �?���
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SALB_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ <  datr1_ and
                                  acc =  acc_
                            union all
                            -- ���� ������?� ���� ��?����� ���?��� �� �������, �� ������ � ������������ �������� ��
                            select acc,  dat2_ fdat, ost
                            from SALB_DRAPS
                            where fdat =  datr2_ and
                                  dat2_ >  datr2_ and
                                  acc =  acc_
                            union all
                            -- ���� ����� ����  ��?����� ���?��� ������. ��?���� ������� - ������� �� ������?� ���� ������������ �?���
                            select acc,  dat1_ fdat, ost + dos - kos ost
                            from SALB_DRAPS
                            where fdat =  datr1_ and
                                  dat1_ =  datr1_ and
                                  acc =  acc_
                            union all
                            -- ������� �� ������ �� ������?� �ݚ�Ŀ� ����
                            select acc, fdat, ost
                            from SALB_DRAPS
                            where fdat in ( datr1_,   datr2_) and
                                  acc =  acc_
                            union all
                            -- ��?�� ������?� ������� ��?����� ���?���
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
 