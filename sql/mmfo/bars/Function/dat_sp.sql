
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_sp.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_SP (ACC_  NUMBER, -- ����
                                  Fdat_ date -- ���� �� ������� �����
                                  ) RETURN date is
  -- ���������� �������� ���� ��������� � ������ ��������� ���������,
  -- ������� ������ "����� ������" ���������
  KOS_ number; --������� ����� �������� �� �������� ����
begin
  select Nvl(sum(kos), 0)
    into kos_
    from saldoa
   where acc = ACC_
     and fdat <= FDAT_;
  --����� ����������?� ��������
  For k in (select fdat, dos
              from saldoa
             where acc = ACC_
               and fdat <= FDAT_
               and dos > 0
             order by fdat) loop
    KOS_ := KOS_ - k.DOS;
    If KOS_ < 0 then
      return k.FDAT;
    end if;
  end loop;
  RETURN to_date(null);
end DAT_SP;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_sp.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 