

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ARC_OTCN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ARC_OTCN ***

  CREATE OR REPLACE PROCEDURE BARS.P_ARC_OTCN 
( pdat_  in date
, pmode_ in number := 2
) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%is
% DESCRIPTION :    ��������� ������� ��� ���������� #A7
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    27/01/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ���������: PDAT_ - ����� ����
            PMODE_ - ������ ������ ����������
               0 - � ��������� P_FA7_NN (��� �����������) ��� ������
               1 - � ��������� P_FA7_NN (��� �����������) ��� ANI-����
               2 - � �����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  dc_     number(2);
  datr_   date;
  datn_   date;
  cnt1_   number := 0;
  cnt2_   number := 0;
  mfo_    char(6);
  dat1_   date;
  dat2_   date;
begin

  bars_audit.trace( '%s: Entry with ( pdat_=%s, pmode_=%s ).'
                  , $$PLSQL_UNIT, to_char(pdat_,'dd.mm.yyyy'), to_char(pmode_) );

  mfo_ := f_ourmfo();

  if ( pmode_ in ( 0, 2 ) )
  then

    -- �������� ���� ���� ������
    dc_ := extract( day from pdat_ );

    case
      when dc_ <= 10
      then datn_ := trunc(pdat_,'MM') + 9;
      when dc_ <= 20
      then datn_ := trunc(pdat_,'MM') + 19;
      else datn_ := last_day(pdat_);
    end case;

    --
    select max(FDAT)
      into datr_
      from FDAT
     where FDAT <= datn_;

  else

    datn_ := pdat_;
    datr_ := pdat_;

  end if;

  bars_audit.info( $$PLSQL_UNIT||': mfo_='||mfo_||', datn_='||to_char(datn_,'dd.mm.yyyy')
                                                ||', datr_='||to_char(datr_,'dd.mm.yyyy') );

  case
    when pmode_ in ( 0, 1 )
    then -- � �������� ���������� ������� �� ���� ������� ( ���� �� ���������� ��� �� ���� )

      if trunc(sysdate) <= datn_
      then -- �� �������� ����� ���� ���� ��� ������� �� ���������� �����

        delete OTC_ARC_CC_LIM
         where KF = mfo_
           and DAT_OTC = datn_;

        delete OTC_ARC_CC_TRANS
         where KF = mfo_
           and DAT_OTC = datn_;

        cnt1_ := 0;
        cnt2_ := 0;

      else

        select count(*)
          into cnt1_
          from OTC_ARC_CC_LIM
         where KF = mfo_
           and DAT_OTC = datn_;

        select count(*)
          into cnt2_
          from OTC_ARC_CC_TRANS
         where KF = mfo_
           and DAT_OTC = datn_;

      end if;

    when ( pmode_ = 2 )
    then -- ������ job ���� ���� �������� ����� ���� � ������ ������

      if ( datn_ = last_day(datn_) )
      then -- ������ ������ ����������, ���� �������� ��� ����� ���� ��� ANI-����

        dat1_ := trunc(datn_, 'mm') + 09;
        dat2_ := trunc(datn_, 'mm') + 19;

        delete OTC_ARC_CC_LIM
         where KF = mfo_
           and DAT_OTC between trunc(datn_, 'mm') and datn_
           and DAT_OTC not in (dat1_, dat2_);

        delete OTC_ARC_CC_TRANS
         where KF = mfo_
           and DAT_OTC between trunc(datn_, 'mm') and datn_
           and DAT_OTC not in (dat1_, dat2_);

      else

        delete OTC_ARC_CC_LIM
         where KF = mfo_
           and DAT_OTC = datn_;

        delete OTC_ARC_CC_TRANS
         where KF = mfo_
           and DAT_OTC = datn_;

      end if;

      cnt1_ := 0;
      cnt2_ := 0;

    else
      null;

  end case;

  insert
    into OTC_ARC_INFO
       ( NPP, KF, DAT_OTC, DAT_SYS, DAT_BANK, USERID )
  values
       ( S_OTC_ARC.NextVal, mfo_, datn_, sysdate, bankdate, user_id );

  commit;

  if cnt1_ = 0
  then

    insert /*+ APPEND */
      into OTC_ARC_CC_LIM ( KF, DAT_OTC, ND, FDAT, LIM2, ACC, SUMG, SUMO)
    select /*+ PARALLEL */  KF, datn_,   ND, FDAT, LIM2, ACC, SUMG, SUMO
      from CC_LIM c
     where ( KF, ND ) in ( select n.KF, n.ND
                             from ACCOUNTS s
                             join ND_ACC   n
                               on ( n.KF = s.KF and n.ACC = s.ACC )
                             join SNAP_BALANCES b
                               on ( b.KF = s.KF and b.ACC = s.ACC )
                            where s.KF = mfo_
                              and s.NBS in ( select r020
                                               from KOD_R020
                                              where a010 = 'A7'
                                                and d_close is null )
                              and b.FDAT = datr_
                              and b.OSTQ <> 0 );

  else -- ���� ��������� �����, ���� �� ������ ������
    null;
  end if;

  if cnt2_ = 0
  then

    insert /*+ APPEND */
      into OTC_ARC_CC_TRANS ( KF, DAT_OTC, NPP, REF, ACC, FDAT, SV, SZ, D_PLAN, D_FAKT, DAPP, REFP, COMM )
    select /*+ PARALLEL */    KF, datn_,   NPP, REF, ACC, FDAT, SV, SZ, D_PLAN, D_FAKT, DAPP, REFP, COMM
      from CC_TRANS
     where ( KF, ACC ) in ( select n.KF, n.ACC
                              from ACCOUNTS s
                              join ND_ACC   n
                                on ( n.KF = s.KF and n.ACC = s.ACC )
                              join SNAP_BALANCES b
                                on ( b.KF = s.KF and b.ACC = s.ACC )
                             where s.KF = mfo_
                               and s.NBS in ( select r020
                                                from KOD_R020
                                               where a010 = 'A7'
                                                 and d_close is null )
                               and b.FDAT = datr_
                               and b.OSTQ <> 0 );

  else -- ���� ��������� �����, ���� �� ������ ������
    null;
  end if;

  bars_audit.trace( '%s: Exit.', $$PLSQL_UNIT );

end P_ARC_OTCN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ARC_OTCN.sql =========*** End **
PROMPT ===================================================================================== 
