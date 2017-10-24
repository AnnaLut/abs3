
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/otcn_pkg.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OTCN_PKG IS
	   ret OTCN_NBUC:=OTCN_NBUC(NULL);

	   FUNCTION f_RET_EMPT_NBUC(type_ NUMBER,
	   							datf_	DATE,
								kodf_ VARCHAR2)  RETURN OTCN_SET_NBUC PIPELINED;
	 -----------------------------------------------------------------------------
	 -- ������� f_RET_EMPT_NBUC (�������� ���������� � F_CODOBL_TOBO)
	 -----------------------------------------------------------------------------
	 -- ���������� �������� �����
	 -- 	������� ��� ������������� ��������� ��� �������������, �� ���.
	 --     ���� �����, �� ��� ������� � �������������� �����������������
	 -- 	����� (��� ������� ������ ����� ���� #1=<��� ������� ��� �������������>)
	 -- ���������:
	 --    type_ -
	 --          =1 - ��-������� ++++++++++ (��� offline - �������������) ++++++++++++++
	 --
	 --     	 =2 - ��-������, ����� ��. ���. ���� ������������� (B040) ++++++++++ (������������� �������� ����� ������������) ++++++++++
	 --     	 =3 - ���������� ��� ������� � ��� ������������� (�� ���� 2)
	 --
	 --     	 =4 - ����� ������� ACCOUNTS ���� TOBO ++++++++++ (��� online - �������������) ++++++++++
	 --     	 =5 - ���������� ��� ������� � ��� ������������� (�� ���� 4)
	 --
	 --     	 =6 - ��������� ��� ++++++++++ (���� ���� � offline, � online - �������������) ++++++++++
	 --     	 =7 - ���������� ��� ������� � ��� ������������� (�� ���� 6)
	 --
	 --		kodf_ - ��� �������
	 -- 	datf_ - ���� ������������

	 -- ������������ ����� 31 ��� �������� (R013=2), ��� ������� ������
	 FUNCTION f_GET_R013(acc_ NUMBER,dat_	DATE)RETURN NUMBER;


END Otcn_Pkg;
/
CREATE OR REPLACE PACKAGE BODY BARS.OTCN_PKG 
IS
-----------------------------------------------------------------------------
-- ������:  20/03/2013 (07/09/2012, 30/08/2012, 30/03/2011)
-- 20.03.2013 �������� ��� 8 ��� ����� #94 (����� ����������)
-----------------------------------------------------------------------------
   FUNCTION f_ret_empt_nbuc (type_ NUMBER, datf_ DATE, kodf_ VARCHAR2)
      RETURN otcn_set_nbuc PIPELINED
   IS
      b040_          VARCHAR2 (20);
      type_branch_   NUMBER;
      bpos_          NUMBER;
      nbuc_          VARCHAR2 (20);
      exists_        NUMBER;
      sql_           VARCHAR2 (1000);

      TYPE cursortype IS REF CURSOR;

      curs_          cursortype;
      r_type_        NUMBER;
   BEGIN
      IF type_ IN (6, 7, 8)
      THEN
         IF type_ = 6
         THEN
            r_type_ := 1;
         ELSE
            r_type_ := 3;
         END IF;
      ELSE
         r_type_ := type_;
      END IF;

      IF r_type_ in (1, 2, 4) -- ���� ��������
      THEN                                                            -- ��� 1
         sql_ :=
               'select lpad(ku, 2, ''0'') nbuc '||
               'from spr_b040 '||
               'where (d_open is null or d_open <= :dat_) and  '||
                '     (d_close is null or d_close > :dat_) and '||
                '     a012 = ''1'' '||
               'group by lpad(ku, 2, ''0'') '||
			   'order by 1 ';
      ELSIF r_type_ IN (3, 5)
      THEN                                                            -- ��� 2
         sql_ :=
               'select lpad(ku, 2, ''0'')||b041 nbuc '||
               'from spr_b040 '||
               'where (d_open is null or d_open <= :dat_) and  '||
                '     (d_close is null or d_close > :dat_) and '||
                '     a012 = ''1'' '||
               'group by lpad(ku, 2, ''0'')||b041 '||
			   'order by 1';
      ELSE
         sql_ := NULL;
      END IF;

      IF sql_ IS NOT NULL
      THEN
         OPEN curs_ FOR sql_ USING datf_, datf_;

         LOOP
            FETCH curs_
             INTO nbuc_;

            EXIT WHEN curs_%NOTFOUND;
            nbuc_ := TRIM (nbuc_);

            IF nbuc_ IS NOT NULL
            THEN
               -- ���������� �� � �������������� ����� ������ � ����� �����
               BEGIN
                  SELECT 1
                    INTO exists_
                    FROM DUAL
                   WHERE EXISTS (
                            SELECT 1
                              FROM v_banks_report
                             WHERE kodf = kodf_
                               AND datf = datf_
                               AND nbuc = nbuc_);
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     exists_ := 0;
               END;

               -- ���� - ���
               IF exists_ = 0
               THEN
                  ret.nbuc := nbuc_;
                  PIPE ROW (ret);
               END IF;
            END IF;
         END LOOP;

         CLOSE curs_;

         IF type_ IN (6, 7)
         THEN
            IF type_ = 6
            THEN
               r_type_ := 4;
            ELSE
               r_type_ := 5;
            END IF;

            FOR k IN (SELECT nbuc
                        FROM TABLE (f_ret_empt_nbuc (r_type_, datf_, kodf_)))
            LOOP
               ret.nbuc := k.nbuc;
               PIPE ROW (ret);
            END LOOP;
         END IF;
      END IF;

      RETURN;
   END;

   FUNCTION f_get_r013 (acc_ NUMBER, dat_ DATE)
      RETURN NUMBER
   IS
      /* acc_ - ���� ������������ ���������
        dat_ - �������� ���� */
      olddat_    DATE;     -- ��������� ������� ���� ������ ���� dat_-31 ����
      nbspr_     VARCHAR2 (2000)
         := '1419,1429,1509,1519,1529,2029,2039,2069,2079,2089,2109,2119,2209,2219,2129,2139,2229,2239,3119,3219,3579';
      ostf1_     NUMBER;                          -- ������� �� �������� ����
      ostf2_     NUMBER;                  -- ������� �� �������� ����-31 ����
      skor1_     NUMBER;
      skor2_     NUMBER;
      kos_       NUMBER;
      ost_       NUMBER;
      s_         NUMBER;
      account_   accounts%ROWTYPE;
   BEGIN

    --dbms_output.put_line('1');

      SELECT *
        INTO account_
        FROM accounts
       WHERE acc = acc_;

	   dbms_output.put_line(account_.nbs);

      IF INSTR ( nbspr_, account_.nbs) = 0
      THEN
	  dbms_output.put_line('xxx');
         RETURN 0;
      END IF;

    --dbms_output.put_line('2');
      olddat_ := dat_ - 31;



      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= olddat_
                               GROUP BY acc);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ost_ := 0;
      END;



	  dbms_output.put_line(ost_);
      SELECT ost_ + NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
        INTO ost_
        FROM opldok o, oper p
       WHERE o.REF = p.REF
         AND o.sos = 5
         AND p.vob = 96
         AND o.acc = acc_
         AND o.fdat > olddat_
         AND o.fdat <= olddat_+28
         AND p.vdat <= olddat_;
dbms_output.put_line(ost_);
        --���� ������� �� 31 ����� = 0, �� ������� � ������� ������ ������ �� �����
        --
        if ost_ = 0 then return 0; end if; --T 05.05.2009

      SELECT ost_ + NVL (SUM (o.s), 0)
        INTO ost_
        FROM opldok o, oper p, ref_back r
       WHERE o.acc = acc_
         AND o.fdat > dat_ - 31
         AND o.fdat <= dat_
         AND o.sos = 5
         AND o.dk = 1
         AND p.REF = o.REF
         AND (  (p.vob <> 96 AND o.fdat <= dat_)
                          OR (    p.vob = 96
                              AND o.fdat > dat_
                              AND o.fdat <= dat_ + 28
                             )
             )
         and p.REF = r.ref(+)
         --��������� �������� ������
         and o.tt <> 'BAK'
         --��������� �������� ������� ���� ������������, ���� ���� ������������� ������ ��������
         and nvl(r.dt,to_date('01014000','ddmmyyyy')) >  dat_
         ;

dbms_output.put_line(ost_);
     if ost_ >= 0 then return 0; end if;

      RETURN NVL (ost_, 0);
   END;
END otcn_pkg;
/
 show err;
 
PROMPT *** Create  grants  OTCN_PKG ***
grant EXECUTE                                                                on OTCN_PKG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTCN_PKG        to RCC_DEAL;
grant EXECUTE                                                                on OTCN_PKG        to RPBN002;
grant EXECUTE                                                                on OTCN_PKG        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/otcn_pkg.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 