

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_MULTIPLE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_MULTIPLE ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_MULTIPLE (p_id number, p_sum1 int default null, p_sum2 int default null)
-- ��������� ��������� ������ �� �������/������� ������ (�����, ��� ���������� �������������� ������)
-- ver 1.0  04/05/2012
is

 ern        NUMBER;          -- ��� ������ (�� err_zay)
 msg        VARCHAR2(254);   -- ��������� ������ "��� ����"
 err        EXCEPTION;
 prm        VARCHAR2(25)  := null;  -- ��������, ������������ � ��������� �� ������
 l_title    varchar2(100) := 'ZAY. p_zay_multiple. ';

 r_zay      zayavka%ROWTYPE;    -- ������ ������ ��� �������������� ������
 r_zay1     zayavka%ROWTYPE;


 --
 -- �����.���������  ���������� ������� ����� ������
 --
 procedure p_zay_ins (p_s int, r_rt in out zayavka%ROWtype)
 is
  l_id  number;
 begin
        l_id := bars_sqnc.get_nextval('s_zayavka');
        r_rt.comm := '��������� ������ � '||r_rt.id||' ������� '||r_rt.rnk||' ����� '||r_rt.s2;
        r_rt.id := l_id;
        r_rt.s2 := p_s*100;
        r_rt.identkb:=l_id;--COBUMMFO-9206
        r_rt.datedokkb := null;  -- ����� ������� tbi_zayavka ������� ������� �����
        insert into zayavka  values r_rt;
        -- ������ ��� ������� tbi_zayavka �������� ������� ����������, � ��� ���������� ��������������
        update zayavka set isp = r_rt.isp, tobo = r_rt.tobo where id = l_id;
 end;

begin
 -- ������ �������� ����������
  bars_audit.trace('%s Params: p_id=%s, p_sum1=%s, p_sum2=%s',
        l_title, to_char(p_id), to_char(p_sum1), to_char(p_sum2));

    -- �������� - ������ �����������
    begin
     select z.* into r_zay from zayavka z where z.id = p_id and z.sos >= 0;
    exception when no_data_found then
         msg  := '������ ' || p_id || ' �� �������!' ;
         ern  := 6;
         prm  := p_id;
         bars_audit.trace('%s ���������� ���������� ��������� ������ � %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end;

    -- �������� - ��������� ����� �� ����� ����� �������������� ������
    if (nvl(p_sum1,0) + nvl(p_sum2,0) )  <> r_zay.s2/100 or nvl(p_sum1,0) = 0 or nvl(p_sum2,0) = 0 then
         msg  := '�������� ����� �� ���������!' ;
         ern  := 24;
         prm  := p_id;
         bars_audit.trace('%s ���������� ���������� ��������� ������ � %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

    -- ��������� �������������� ������ � �����
    r_zay1 := r_zay;
    -- ��������� �����.��������� ��� ������ ����� � ��������.��������
    p_zay_ins (p_sum1, r_zay);
    -- ��������� �����.��������� ��� ������ ����� � ��������.�������� (������, ��������� r_zay � out ����������� ������� ��� �������)
    p_zay_ins (p_sum2, r_zay1);
    -- �������������� ������ ������ sos
    update zayavka set sos = -1 where id = p_id;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('ZAY', ern, prm);

end;
/
show err;

PROMPT *** Create  grants  P_ZAY_MULTIPLE ***
grant EXECUTE                                                                on P_ZAY_MULTIPLE  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAY_MULTIPLE  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_MULTIPLE.sql =========*** En
PROMPT ===================================================================================== 
