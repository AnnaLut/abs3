

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_RESERVE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_RESERVE ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_RESERVE 
   (type_ IN NUMBER,
    idz_  IN NUMBER,
    sum_  OUT NUMBER,
    msg_  OUT VARCHAR2)
IS
  point1_ CHAR(1);
  point2_ CHAR(1);
  zay     zayavka%ROWTYPE;
  koefPF_ NUMBER;
  sumG_   NUMBER;
  sumP_   NUMBER;
  sumK_   NUMBER;
  sumB_   NUMBER;
  ost_    NUMBER;
  nls_    VARCHAR2(14);
BEGIN

  sum_ := 0;
  msg_ := '';

  SELECT substr(to_char(1/10),1,1) INTO point1_ FROM dual;

  IF point1_ = '.' THEN
     point2_ := ',';
  ELSE
     point2_ := '.';
  END IF;


  BEGIN
    SELECT to_number(replace(val,point2_,point1_)) INTO koefPF_
      FROM birja
     WHERE par = 'PEN_FOND';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN koefPF_ := 0;
  END;

  SAVEPOINT dg;

  -- ��������� ������
  BEGIN
    SELECT * INTO zay FROM zayavka
     WHERE id = idz_ AND dk = 1 AND
          (type_ = 1 AND sos = 0 AND viza = 0
           OR
           type_ = 0 AND sos = 1 AND viza >= 1)
       FOR UPDATE NOWAIT;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      msg_ := '������ � '||idz_||'�����������!';
      ROLLBACK TO dg;
      RETURN;
  END;

  IF zay.acc0 IS NULL THEN
     msg_ := '�� ������ ���� � ���.������ ��� ������ � '||idz_||'!';
     ROLLBACK TO dg;
     RETURN;
  END IF;

  IF nvl(zay.s2,0) <= 0 THEN
     msg_ := '�� ������� ����� ������ � '||idz_||'!';
     ROLLBACK TO dg;
     RETURN;
  END IF;

  IF nvl(zay.kurs_z,0) <= 0 THEN
     msg_ := '�� ������ ���� ������ � '||idz_||'!';
     ROLLBACK TO dg;
     RETURN;
  END IF;

  IF type_ = 1 THEN      -- ��������� ����������
    -- ����� ������
    sumG_ := round(zay.s2 * zay.kurs_z);
    -- ����� ��������
    sumK_ := round(sumG_ * nvl(zay.kom,0)/100) + nvl(zay.skom,0)*100;
    -- ���������� � ���������� ����
    IF nvl(zay.fl_pf, 0) = 1 THEN
       sumP_ := round(sumG_* koefPF_/100);
    ELSE
       sumP_ := 0;
    END IF;
    -- ����� �����
    sumB_ := sumG_ + sumP_ + sumK_;

    -- ������� �� �������� ����� � ������ ������ � ������.�������
    BEGIN
      SELECT nvl(ostc,0) + nvl(lim,0), nls
        INTO ost_, nls_
        FROM accounts WHERE acc = zay.acc0;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        msg_ := '�� ������ ���� � ���.������ ��� ������ � '||idz_||'!';
        ROLLBACK TO dg;
        RETURN;
    END;

    IF ost_ < sumB_ THEN
       msg_ :='������������ ������� �� ����� '||nls_||'/980 !'||CHR(13)||CHR(10)||CHR(13)||CHR(10)||
              '������� ������� � ������ ������� � ��������� ������ = '||to_char( ost_/100,'9999999999.99')||' ���.'||CHR(13)||CHR(10)||
              '����� ������, ����������� ��� ������� ������        = '||to_char(sumB_/100,'9999999999.99')||' ���.';
      ROLLBACK TO dg;
      RETURN;
    ELSE

      UPDATE zayavka SET lim = sumB_ WHERE id = idz_;
      IF SQL%ROWCOUNT = 0 THEN
        msg_ :='������ ��� ���������� ����� ����������.������ ��� ������ � '||idz_||'!';
        ROLLBACK TO dg;
        RETURN;
      END IF;

      UPDATE accounts SET lim = nvl(lim,0) - sumB_ WHERE acc = zay.acc0;
      IF SQL%ROWCOUNT = 0 THEN
        msg_ :='������ ��� ��������� ������.������� �� ����� � ���.������ ��� ������ � '||idz_||'!';
        ROLLBACK TO dg;
        RETURN;
      END IF;

      sum_ := sumB_;
      msg_ := '������� ������������� ����� '||sum_/100||'���. ��� ����� �'||idz_||'!'; RETURN;

    END IF;

  ELSE                   -- ������ ����������
    IF zay.lim IS NOT NULL THEN
       UPDATE accounts SET lim = nvl(lim,0) + zay.lim
        WHERE acc = zay.acc0 AND zay.lim IS NOT NULL;
       IF SQL%ROWCOUNT = 0 THEN
          msg_ := '������ ��� ������ ���������� �� ����� � ���.������ ��� ������ � '||idz_||'!';
          ROLLBACK TO dg;
          RETURN;
       END IF;
       sum_ := zay.lim;
       msg_ := '������� ����� ���������� ����� '||sum_/100||'���. ��� ������ �'||idz_||'!'; RETURN;
    END IF;

  END IF;

END;
/
show err;

PROMPT *** Create  grants  P_ZAY_RESERVE ***
grant EXECUTE                                                                on P_ZAY_RESERVE   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAY_RESERVE   to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ZAY_RESERVE   to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_RESERVE.sql =========*** End
PROMPT ===================================================================================== 
