

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VAR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VAR ***

  CREATE OR REPLACE PROCEDURE BARS.P_VAR (dat_ DATE, a_95 NUMBER, a_99 NUMBER)
IS

/* ANI.  Var-������
   ������ : ���� patchP18.ani + PROCEDURE P_Var.sql + Bin\v_balans.apd
   ������� ���������:
   22.04.08 - �������� (STA + MARY)
   23.05.08 - ��� �������� ������������ ���������, � �� �� ������
   12.11.08 - ���� ��� ������ ����� �� ��������� ���� <= ������ ������ ���,
              ������� ���� �� ������ ���� > ������ (MARY)
*/

   TYPE vector IS VARRAY(20) OF NUMBER;   -- �� �������
   TYPE matrix IS VARRAY(100) OF vector;  -- �� �����
   kvlist  vector := vector();		  -- ������ ����� (��� �������� �������)
   x_avg   vector := vector();		  -- ������ ������� x ��� ������ ������
   sigm    vector := vector();		  -- "�������������" ������ ������
   v       vector := vector();		  -- �������� ������� ������ ������
   e       matrix := matrix();		  -- �����
   x       matrix := matrix();            -- ��������� ��������� ������ �� ���������������� ���
   c       matrix := matrix();            -- �������������� �������
   i       INTEGER;
   j       INTEGER;
   l       INTEGER;
   nkv     INTEGER;
   ndat    INTEGER;
   sigm_all NUMBER;


BEGIN
   DELETE FROM TMP_VAR;
   DELETE FROM TMP_KOVAR;
   DELETE FROM tmp_korel;

   INSERT INTO TMP_VAR ( KV,  BSUM,  RATE_O,  LCV,  NAME,  NLS,  Ostc, OSTQ )
   SELECT              a.KV,c.BSUM,C.RATE_O,t.LCV,t.NAME,a.NLS, Fost(a.ACC,DAT_),
                                    Gl.P_Icurval(a.kv, Fost(a.ACC,DAT_),DAT_)
   FROM ACCOUNTS a, TABVAL t, CUR_RATES c,  VP_LIST v
   WHERE v.acc3800=a.acc AND a.kv=t.kv AND c.kv=t.kv
     AND a.dazs IS NULL
     AND (c.kv,c.vdate)=
         (SELECT kv,MAX(vdate) FROM CUR_RATES
          WHERE kv=c.KV AND vdate<=DAT_ GROUP BY kv);

   INSERT INTO TMP_VAR (KV,LCV,NAME,OSTQ)
   SELECT 0,'ALL','��������',SUM(OSTQ) FROM TMP_VAR;

   -- 0. ������ ����� � �������� ������� �� ������
   i:=1;
   FOR k IN (SELECT DISTINCT kv FROM tmp_var where kv!=0)
   LOOP
      kvlist.extend;
      kvlist(i):=k.kv;
      i:=i+1;
   END LOOP;
   nkv:=i-1;
   x_avg.extend(nkv);
   sigm.extend(nkv);
   v.extend(nkv);
   FOR i IN 1..nkv
   LOOP
      SELECT SUM(ostq)
        INTO v(i)
        FROM TMP_VAR
       WHERE kv=kvlist(i);
      x_avg(i):=0;
      sigm(i):=0;
   END LOOP;

   -- 1. ����������� ��������� ��� � ����������� ���������� e (������ �����)
   j:=1;
   FOR k IN (SELECT dat_ - (c.num -1)  vdate
               FROM CONDUCTOR c
              WHERE c.num < 90
                AND (dat_ - (c.num -1) ) not in (select holiday from holiday)
	      ORDER BY c.num DESC )
   LOOP
      -- ���� �������������, ��� ������ ���� ���������� ��� ������
      e.extend;
      e(j):=vector();
      FOR i IN 1..nkv
      LOOP
      begin
         e(j).extend;
         -- ������� ������� ���� ������ �� ����� ������� ���� ����� ���� �����
         SELECT rate_o/bsum INTO e(j)(i)
           FROM CUR_RATES
          WHERE kv=kvlist(i)
            AND vdate=(SELECT MAX(vdate)
                         FROM CUR_RATES
                        WHERE kv=kvlist(i) AND vdate<=k.vdate);
      exception when no_data_found then
         -- ���� ����� ����� ����� ���, ������� ������� ���� ������ �� ����� ������ ���� ����� ���� ����
         -- ���� ��, ���� �� �����, �.�. ������ ����� ������� � ������ ������ ���� ��� ���� � cur_rates
         select rate_o/bsum into e(j)(i)
           from cur_rates
          where kv=kvlist(i)
            and vdate=(select min(vdate)
                         FROM CUR_RATES
                        WHERE kv=kvlist(i) AND vdate>k.vdate);
      end;
      END LOOP;
      j:=j+1;
   END LOOP;
   ndat:=j-1;

   -- 2. ������� ������ ����� � ���������� x (��������� ��������� ������ �� ���������������� ���)
   --    ��� �������� ��������� ���
   x.extend(ndat);
   FOR j IN 2..ndat
   LOOP
      x(j):=vector();
      x(j).extend(nkv);
      FOR i IN 1..nkv
      LOOP
         x(j)(i):=ABS(LN(e(j)(i)/e(j-1)(i)));
         -- � ��������� ��� � �������� �� ������
         x_avg(i):=x_avg(i)+x(j)(i);
      END LOOP;
   END LOOP;

   -- 3. ���������� �������� x ��� ������ ������
   --    ���������� ���� ��� ������ ������
   FOR i IN 1..nkv
   LOOP
      x_avg(i):=x_avg(i)/(ndat-1);	-- ���������� �� 1 ������, ��� ���
      FOR j IN 2..ndat
      LOOP
         sigm(i):=sigm(i)+(x_avg(i)-x(j)(i))*(x_avg(i)-x(j)(i));
      END LOOP;
      sigm(i):=SQRT(sigm(i)/(ndat-1));
   END LOOP;

   -- 4. ���������� ������� ���������� (���������� - ���������� ����� ���)
   c.extend(nkv);
   FOR i IN 1..nkv
   LOOP
      c(i):=vector();
      c(i).extend(nkv);
   END LOOP;
   FOR i IN 1..nkv
   LOOP
      FOR j IN 1..nkv
      LOOP
         c(i)(j):=0;
         FOR l IN 2..ndat
         LOOP
            c(i)(j):=c(i)(j)+(x(l)(i)-x_avg(i))*(x(l)(j)-x_avg(j));
         END LOOP;
         c(i)(j):=c(i)(j)/(ndat-1);
      END LOOP;
   END LOOP;

   -- 5. ���������� ����� ����� �������
   sigm_all:=0;
   FOR i IN 1..nkv
   LOOP
      FOR j IN 1..nkv
      LOOP
         sigm_all:=sigm_all+c(i)(j)*v(i)*v(j);
      END LOOP;
   END LOOP;
   sigm_all:=SQRT(sigm_all);	-- ��� �� ����������� �� ����� ������� ���� �����, �.�. ����� ��� ����� �� ��� ��������

   -- 6. ������ ��������� ����������
   UPDATE TMP_VAR
      SET var_95=sigm_all*a_95, var_99=sigm_all*a_99
    WHERE kv=0;
   FOR i IN 1..nkv
   LOOP
      UPDATE TMP_VAR
         SET var_95=sigm(i)*a_95*ostq, var_99=sigm(i)*a_99*ostq, vol=sigm(i)
       WHERE kv=kvlist(i);
   END LOOP;

   -- 7. ������ ������ ���������� � ����������
   FOR i IN 1..nkv
   LOOP
      FOR j IN 1..nkv
	  LOOP
	     INSERT INTO TMP_KOVAR(dat, kv1, kv2, koef)
		                VALUES(dat_, kvlist(i), kvlist(j), c(i)(j));
		 if sigm(i)!=0 and sigm(j)!=0
		 then
            INSERT INTO tmp_korel(dat, kv1, kv2, koef)
		                   VALUES(dat_, kvlist(i), kvlist(j), c(i)(j)/sigm(i)/sigm(j));
		 else
            INSERT INTO tmp_korel(dat, kv1, kv2, koef)
		                   VALUES(dat_, kvlist(i), kvlist(j), NULL);
		 end if;
	  END LOOP;
   END LOOP;

END P_Var;
/
show err;

PROMPT *** Create  grants  P_VAR ***
grant EXECUTE                                                                on P_VAR           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_VAR           to RPBN001;
grant EXECUTE                                                                on P_VAR           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VAR.sql =========*** End *** ===
PROMPT ===================================================================================== 
