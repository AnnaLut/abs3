

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_CHECK_DATA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_CHECK_DATA ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_CHECK_DATA 
   (p_dk     NUMBER,  -- �������(1) / �������(2)
    p_id     NUMBER,  -- �� ������
    p_kv     NUMBER,  -- ��� ������
    p_sum    INTEGER, -- ���� ������
    p_rate   INTEGER, -- ���� ������
    p_dat    DATE     -- ���� ������
   )
IS
 l_BLK       number  := 0;  -- 0/1 - ���������� ������ �������
 l_DilerRate diler_kurs.kurs_b%type;
 l_nCount    number  := 0;
 
 ern        NUMBER;          -- ��� ������ (�� err_zay)
 msg        VARCHAR2(254);   -- ��������� ������ "��� ����"
 err        EXCEPTION;
 prm        VARCHAR2(25)  := null;  -- ��������, ������������ � ��������� �� ������
 l_title    varchar2(100) := 'ZAY. p_zay_check_data. ';

 function f_GetDilerRate (p_dk NUMBER, p_kv NUMBER)
 RETURN number
 IS
 l_BuyRate  diler_kurs.kurs_b%type;
 l_SalRate  diler_kurs.kurs_s%type;
 BEGIN
   begin
     SELECT kurs_b, kurs_s
       INTO l_BuyRate, l_SalRate
       FROM diler_kurs
      WHERE kv = p_kv
        AND dat = (SELECT max(dat)
                     FROM diler_kurs
                    WHERE trunc(dat) = trunc(sysdate)
                      AND kv = p_kv);
   exception when no_data_found then l_BuyRate:=null; l_SalRate:=null;
   end;
  if p_dk = 1 then return l_BuyRate;
  elsif p_dk = 2 then return l_SalRate;
  end if;
 END;

BEGIN

  bars_audit.trace('%s Params: p_dk=%s, p_id=%s, p_kv=%s, p_sum=%s, p_rate=%s, p_dat=%s',
        l_title, to_char(p_dk), to_char(p_id), to_char(p_kv), to_char(p_sum), to_char(p_rate), to_char(p_dat,'dd/mm/yyyy'));

    -- ������ ������������� �������
    begin
    SELECT nvl(blk,0)
       INTO l_BLK
       FROM diler_kurs
      WHERE kv = p_kv
        AND dat = (SELECT max(dat)
                     FROM diler_kurs
                    WHERE trunc(dat) = trunc(sysdate)
                      AND kv = p_kv);
    exception when no_data_found then null;
    end;

    if l_BLK = 1 then
         msg  := '������ ' || p_kv || ' ������������� �������!' ;
         ern  := 20;
         prm := p_kv;
         bars_audit.trace('%s ���������� ����������� ������ � %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

  -- �������/������ �����
    if nvl(p_sum,0) = 0 then
         msg  := '�� ������� ����� ������ ' || p_id;
         ern  := 21;
         prm := p_id;
         bars_audit.trace('%s ���������� ����������� ������ � %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

  -- ������ ����
    if p_dat is null then
         msg  := '�� ������� ���� ������ ' || p_id;
         ern  := 22;
         prm := p_id;
         bars_audit.trace('%s ���������� ����������� ������ � %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

  -- �������/������ ����
    if nvl(p_rate,0) = 0 then
      l_DilerRate := f_GetDilerRate(p_dk, p_kv);
      if l_DilerRate is null then
           msg  := '�� ������ ���� ������ ' || p_id;
           ern  := 23;
           prm := p_id;
           bars_audit.trace('%s ���������� ����������� ������ � %s - %s', l_title, to_char(p_id), to_char(msg));
           raise err;
      else
           UPDATE zayavka SET kurs_z = l_DilerRate WHERE id = p_id;
           bars_audit.trace('%s ��� ����������� ������ � %s ������������� ���������� ���� �� �����.������ ������ %s', l_title, to_char(p_id),
                                                                                                                      to_char(l_DilerRate));
      end if;
    end if;

  -- �������� �볺������������� (������� ����. ������) �� ���� ������ 
  -- �� ������������ ������� �� ���'���� ����������������� �������� ������ �� ��������� ���'���� ������������ ��������, 
  -- ������������ ������� 37 ������ ������ "��� ����������������� ��������" (98 ����). 
    select nvl(f_client_check_sanction(z.rnk, bankdate),0) into l_nCount 
      from zayavka z
     where z.id = p_id;
  
    if l_nCount > 1 then
           msg  := '�����! �� �볺��� ����������� �������!';
           ern  := 44;
           prm := p_id;
           bars_audit.trace('%s �� �볺��� ����������� ������� (������ %s)', l_title, to_char(p_id));
           raise err;
    end if;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('ZAY', ern, prm);
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_CHECK_DATA.sql =========*** 
PROMPT ===================================================================================== 
