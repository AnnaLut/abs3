
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/c_sls.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.C_SLS (
  nP1_ NUMBER,  --REF
  nP2_ NUMBER,  --S
  nP3_ INT)  --kv
 RETURN NUMBER IS
  COL_     NUMBER;
  VES_     NUMBER;
  DIG_     INT;
  val_kurs bank_slitky.kurs_p%type;
  kurs_p_  bank_slitky.kurs_p%type; 
  err      EXCEPTION;
  erm      VARCHAR2(80);
---  ������� ��� �������� ������������ ���������� �������� BMP.
---  � ����� ��������  BMK �������� ���������� �������(�����) 
---   � ���. �������� B_SLC �������� ������� ������ (������), 
---   � ���. �������� B_SLI �������� ��� ������ (������). 
--- ������� ��������� ��������� �� ������ ������� ��� ���������� ���������� �������.

 BEGIN
  --- bars_audit.trace('C_SLS:1 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );

    BEGIN
     SELECT dig
       INTO DIG_
       FROM tabval
      WHERE kv=nP3_;
     EXCEPTION WHEN NO_DATA_FOUND THEN erm:= '�� �������� ���������� DIG'|| DIG_; RAISE err ;
    END;

    BEGIN
     SELECT TO_NUMBER(w.value,'99999990D999')
       INTO COL_
       FROM operw w
      WHERE w.ref=nP1_ AND w.tag='B_SLC';
     EXCEPTION WHEN NO_DATA_FOUND THEN erm:= '�� �������� ���������� ���. ������� B_SLC'; RAISE err ;
    END;
   
  --- bars_audit.trace('C_SLS:2 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );

    BEGIN
      SELECT TO_NUMBER(w.value)--,'99999990D99')
        INTO KURS_P_
        FROM operw w
       WHERE w.ref=nP1_ AND w.tag='KUR_P';
      EXCEPTION WHEN NO_DATA_FOUND THEN erm:= '�� �������� ���������� ���. ������� "���� �����-�������"'; RAISE err ;
    END;
    
---    bars_audit.trace('C_SLS:3 nP1_= '||to_char(nP1_)||'  KURS_P_='||to_char( KURS_P_) );

    BEGIN
     SELECT decode(nvl(s.ves_un,0),0, s.ves,s.ves_un), s.kurs_p
       INTO VES_ , val_kurs
       FROM operw w,bank_slitky s
      WHERE w.ref=nP1_ AND w.tag = 'B_SLI' AND N_SLI( s.kod ) = w.value and s.branch= NVL(tobopack.GetTOBO,0 );
     EXCEPTION WHEN NO_DATA_FOUND THEN erm:= '�� �������� ��������� ��������  ���. ��������  B_SLI'; RAISE err ;
    END;

   --- bars_audit.trace('C_SLS:4 nP1_= '||to_char(nP1_)||' VES_= '||to_char(VES_)||' val_kurs='||to_char(val_kurs) );
    
---  bars_audit.trace('C_SLS:5 nP1_= '||to_char(nP1_)||' val_kurs/100-KURS_P_ '||to_char(val_kurs/100-KURS_P_));
    
    IF nP2_/power(10,DIG_)*VES_ <> COL_
        THEN erm:= 'ʳ������ ������ �� ������ ������ �� ���������� ��������� ���� ������!'; RAISE err ;
        
     ELSIF val_kurs/100<>KURS_P_
         THEN erm:= '���� ������ (������) �� ��������  ��������� ���� ������ (������)!'; RAISE err ;
     ELSE RETURN 0;
    END IF;

    
  exception
  WHEN err THEN raise_application_error(-(20000),erm,TRUE);
  when others then RETURN 0;

END C_SLS; 
 
/
 show err;
 
PROMPT *** Create  grants  C_SLS ***
grant EXECUTE                                                                on C_SLS           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on C_SLS           to PYOD001;
grant EXECUTE                                                                on C_SLS           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/c_sls.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 