

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F02_SNP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F02_SNP ***

  CREATE OR REPLACE PROCEDURE BARS.P_F02_SNP 
(p_DAT    DATE,                   -- �������� ����
 p_SHM    VARCHAR2 DEFAULT 'G',   -- �����
 p_TIP    VARCHAR2 DEFAULT 'S',   --��� ��������
 p_KODF   VARCHAR2 DEFAULT '02'  --��� ����� IS
 ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ��������� ������������ 02 ����� �� SNAP-������
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 11,01,2012 (09/08/2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

01.11.2011 �����
        �� ����� � ������ ���� ������ �������������� ���.������� =  ����������.
        � ������ ��������� ����������� �������������� ���������� 50 � 60 (�������������)

02.06.2011 SERG
        ��� ������������� ������� ������� ����� ���� ������������ ����������
        ������� ���������� recid, userid ��� ������� � rnbu_trace

13/05/2011 Virko
        �������� ��������� ���������� �� ������,
        �.�. � ��������� ������� �� ������������ (���� ����������� � ��������).

28-02-2010 Virko
        ���� ������������ �������

����� Sta 	 ��������� ������������ #02 �� SNP-����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  l_DAT01d_ date      ;
  l_DAT01t_ date      ;
  Di_          number ;   -- accm_calendar.caldt_id%type
  l_caldt_DATE date   ;   -- accm_calendar.caldt_DATE%type
  l_nbuc  VARCHAR2(12);  l_typ   NUMBER;
  l_userid	number := user_id;

BEGIN

logger.info('STA -0 ������ ');

  --1) Id ���.����
  l_DAT01t_ := last_day  ( p_DAT) +  1 ; --01 ����� ��������� ������   - ����
  l_DAT01d_ := add_months(l_DAT01t_,-1); --01 ����� ����.�� ��� ������ - ����

  select caldt_ID into Di_ from accm_calendar where caldt_DATE=l_DAT01d_;

  --2) ���� ��������� ������������ �������������
  bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);

  -- ������?��� ���������
  P_REV_SNP (p_DAT);

  --3) ������� ��������� ����.����a (�� a�.������)
  EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

  --4) ����������� ��������� ���������� (��� �������)
  P_Proc_Set( p_KODF, p_SHM, L_nbuc, l_typ );
------------------------------------------------------------------------
  --5) ������������ ��������� � ����. RNBU_TRACE

INSERT INTO RNBU_TRACE (recid, userid, nbuc, nls, kv, acc, odate, znap, kodp)
select s_rnbu_record.nextval, l_userid, L_nbuc, d.NLS, d.KV, d.acc1, d.DAOS, d.value,
       SUBSTR(d.colname,2,2) ||
       d.nbs                 ||
       substr('000'||d.kv,-3)|| d.K041    KODP
from (select K041, decode(nbs, null, substr(nls,1,4), nbs) nbs,nls, KV, acc1, daos, colname, value
      from (select a.nls,a.kv, a.daos, a.nbs,
                   substr(F_K041 (c.country),1,1) K041,
                   b.*
            from (select ACC1,RNK,
            decode( sign(ostq),1, 0, -ostq) P10,
            decode( sign(ostq),1, ostq, 0 ) P20,
            decode( sign(ost ),1, 0, -ost ) P11,
            decode( sign(ost ),1, ost , 0 ) P21, P50,P60,P51,P61,P70,P80,P71,P81
                  from (   select ACC1, RNK, OST, OSTQ,
                                (case when p60<0 then p50 + abs(p60) else p50 end) P50,
                                (case when p50<0 then p60 + abs(p50) else p60 end) P60,
                                P51,P61,P70,P80,P71,P81
                           from ( select acc ACC1,RNK, ost -CRdos +CRkos  OST,
                                         ostq-CRdosq+CRkosq OSTQ,
                                         dosQ - CUdosQ P50,kosQ - CUkosQ P60,
                                         dos  - CUdos  P51,kos  - CUkos  P61,
                                         CRdosQ        P70,CRkosQ        P80,
                                         CRdos         P71,CRkos         P81
                                    from ACCM_AGG_MONBALS where caldt_ID=Di_
                                 )
                        )
                  ) b,
                  accounts a , customer c
            where b.rnk=c.rnk and b.ACC1=a.acc and (a.nbs not like '8%')
           )
      unpivot (value for colname in (P10,P20,P11,P21,P50,P60,P51,P61,P70,P80,P71,P81))
     ) d
where  (d.kv<>980 or d.colname like 'P_0' ) and d.value <>0;

  --6) ����������� � ���������
 P_OTC_VE9 (p_DAT, p_KODF);

  -- ������� ����� � �������.
  DELETE FROM TMP_NBU WHERE kodf=p_KODF AND datf= p_DAT;
  INSERT INTO TMP_NBU (kodf, datf, nbuc, kodp, znap)
  select p_KODF, p_DAT, nbuc, KODP, SUM(znap)
  from  RNBU_TRACE   GROUP BY nbuc, kodp ;


  -- ���.
  commit;
--------------------------------------------------------
END P_F02_SNP;
/
show err;

PROMPT *** Create  grants  P_F02_SNP ***
grant EXECUTE                                                                on P_F02_SNP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F02_SNP       to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F02_SNP.sql =========*** End ***
PROMPT ===================================================================================== 
