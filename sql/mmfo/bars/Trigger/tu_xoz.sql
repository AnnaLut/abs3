

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_XOZ.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_XOZ ***

  CREATE OR REPLACE TRIGGER BARS.TU_XOZ 
  BEFORE UPDATE OF ostc, ostb, ostf ON accounts FOR EACH ROW
 WHEN (old.tip like 'XOZ' 
--AND NEW.ostc < OLD.ostc 
  AND NEW.pap = 1  and old.kv=980  
   ) declare
  xr xoz_ref%rowtype;
  MDAT_ date;
  ------------

  function def_dat( p_ACC number, p_FDAT date) return date  is
         l_s180 char(1) := null;   l_MDAT date := null;
  begin
     begin
       select s180 into l_s180 from specparam where acc = p_ACC;
     EXCEPTION WHEN NO_DATA_FOUND THEN  null;
     end;

     If    l_s180 = '4' then l_MDAT := p_FDAT +  21 ;            -- �i� 8 �� 21 ���
     ElsIf l_s180 = '4' then l_MDAT := p_FDAT +  21 ;            -- �i� 8 �� 21 ���
     ElsIf l_s180 = '5' then l_MDAT := p_FDAT +  30 ;            -- �i� 22 �� 31 ���
     ElsIf l_s180 = '6' then l_MDAT := p_FDAT +  90 ;            -- �i� 32 �� 92 ��i�
     ElsIf l_s180 = '7' then l_MDAT := p_FDAT + 183 ;            -- �i� 93 �� 183 ��i�
     ElsIf l_s180 = 'A' then l_MDAT := p_FDAT + 274 ;            -- �i� 184 �� 274 ��i�
     ElsIf l_s180 = 'B' then l_MDAT := add_months(p_FDAT,  12);  -- �i� 275 �� 365(366) ��i�
     ElsIf l_s180 = 'C' then l_MDAT := add_months(p_FDAT,  18);  -- ³� 366(367) �� 548(549) ��i�
     ElsIf l_s180 = 'D' then l_MDAT := add_months(p_FDAT,  24);  -- ³� 549(550) ��� �� 2 ����
     ElsIf l_s180 = 'E' then l_MDAT := add_months(p_FDAT,  36);  -- ������ 2 �� 3 ����
     ElsIf l_s180 = 'F' then l_MDAT := add_months(p_FDAT,  60);  -- ������ 3 �� 5 ����
     ElsIf l_s180 = 'G' then l_MDAT := add_months(p_FDAT, 120);  -- ������ 5 �� 10 ����
     ElsIf l_s180 = 'H' then l_MDAT := add_months(p_FDAT,1200);  -- ����� 10 ����
     end if;                                    

     return l_MDAT ;

  end def_dat;
  ------------

BEGIN

  for k in (select * from opldok where ref = gl.Aref and acc = :old.acc order by decode (tt,'BAK',2,1) )
  loop

     If k.dk=0 and k.tt != 'BAK' and :NEW.ostc < :OLD.ostc then 
        --------------------------------------- ������ ����� �� ����� = ��������� � ���������
        begin
          MDAt_ := def_dat(k.ACC,k.fdat);
          INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (k.acc,k.ref,k.stmt,k.s,k.s,k.fdat, MDAt_ );
        exception when others then  
          if SQLCODE = -00001 then null;   else raise; end if; 
        end;

     elsIf k.dk = 0 and k.tt = 'BAK' then 
        -------------------------------------- �����= ��� ������� = �������� ���2, ���� �� ����
        update XOZ_ref set ref2 = null  where ref2 = k.ref  ;

     elsIf k.dk = 1 and k.tt = 'BAK' then 
        -------------------------------------- ������ = ��� ������ = ������ ���1 �� ���������, ���� �� ����
        delete from XOZ_ref where acc = k.acc and ref1 = k.ref ;

     else --------------------------------------- ���������
       -- k.dk = 0 ������ ����� �� ����� = ������� ��������� � ���������
       -- k.dk = 1 ��������� �������� ���������
       null;
    end if ;

  end loop ;

END tu_XOZ ;
/
ALTER TRIGGER BARS.TU_XOZ ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_XOZ.sql =========*** End *** ====
PROMPT ===================================================================================== 
