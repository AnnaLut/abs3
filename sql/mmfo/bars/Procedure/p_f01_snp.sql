

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F01_SNP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F01_SNP ***

  CREATE OR REPLACE PROCEDURE BARS.P_F01_SNP 
(p_DAT    DATE,                   -- �������� ����
 p_SHM    VARCHAR2 DEFAULT 'G',   -- �����
 p_TIP    VARCHAR2 DEFAULT 'S',   --��� ��������
 p_KODF   VARCHAR2 DEFAULT '01'  --��� ����� IS
 ) IS

--22-09-2015 OAB         ������� ����� ���������� ������ �������
--01-06-2011 SERG        ������� ����������� ���������� ������ ������� �� ��������
--                       ��� ������� � RNBU_TRACE ������� ���� recid, userid
--                       ����� ��� ������ ������� �� �������� ������� before insert
--                       patchy75.sql - ���������� ���� ������������������ s_rnbu_record �� 1000
--
--20-04-2011 Virko	 �������� FULL-mode ���������� SNAP
--15-11-2010 Virko	 �������� ����� � �������� acc, rnk
--28-02-2010 Virko	 ���� ������������ �������
--20-07-2009 Sta 	 ��������� ������������ #01 �� SNP-����

  l_caldt_ID   number;   -- accm_calendar.caldt_id%type
  l_caldt_DATE date  ;   -- accm_calendar.caldt_DATE%type
  l_Sql   varchar2(3000) := '' ;
  l_nbuc  VARCHAR2(12);
  l_typ   NUMBER;
  l_userid	number := user_id;
  pr_ int;
 nls_ varchar2(15);
 kv_ int;
 kodp_ varchar2(10);
----------------------

BEGIN

  --1) Id ���.����
  select caldt_ID into l_caldt_ID from accm_calendar where caldt_DATE=p_DAT;

  --2) ������������ �������������
  --   ��������: ������������ ������ ��� ��������� ������ � SALDOA, SALDOB �� �������� ����
  --bars_accm_sync.sync_snap('BALANCE', p_DAT);
  -- ����� ������� ������������ �������������
--  BARS_UTL_SNAPSHOT.SYNC_SNAP(p_DAT);

  --3) ������� ��������� ����.����a (�� a�.������)
  EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

  --4) ����������� ��������� ���������� (��� �������)
  P_Proc_Set( p_KODF, p_SHM, L_nbuc, l_typ );

------------------------------------------------------------------------
  --5) ������������ ��������� � ����. RNBU_TRACE
  IF p_TIP<> 'R' THEN
     -- HE �������

     INSERT INTO RNBU_TRACE (recid, userid, acc, nls, kv, odate, kodp, znap, nbuc, rnk)
     select s_rnbu_record.nextval, l_userid, acc, nls, KV, daos, kodp, ZNAP, L_nbuc, rnk
     from
      (select acc, nls, KV, daos,
              decode(Sign(value), 1    , '2','1') ||
              decode(colname    , 'OST', '1','0') ||
              nbs ||
              substr('000'||kv,-3)                || RZ KODP,
              abs(value) ZNAP, rnka rnk
       from (select a.rnk rnka, a.nls,a.kv, a.daos, a.nbs,
                    decode( nvl(c.country,804),804,'1','2') RZ,
                    b.*
             from accm_snap_balances b, accounts a, customer c
             where a.rnk  = c.rnk
               and (a.nbs not like '8%')
               and b.ostQ <> 0
               and b.acc =  a.acc
               and b.caldt_id = l_caldt_id )
       unpivot (value for colname in (OST, OSTQ) )
      ) where  kodp not like '_1____980_' and znap<>0
      ;

  end if;

  --6) ����������� � ���������
  P_OTC_VE9 (p_DAT, p_KODF);

  --7) ������� ����� � �������.
  DELETE FROM TMP_NBU WHERE kodf=p_KODF AND datf= p_DAT;

  INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
  select p_KODF, p_DAT, kodp, nbuc, SUM(znap)
  from RNBU_TRACE  GROUP BY kodp, nbuc;

  --���.
  commit;

--------------------------------------------------------
END P_F01_SNP;
/
show err;

PROMPT *** Create  grants  P_F01_SNP ***
grant EXECUTE                                                                on P_F01_SNP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F01_SNP       to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F01_SNP.sql =========*** End ***
PROMPT ===================================================================================== 
