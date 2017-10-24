

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_983O.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_983O ***

  CREATE OR REPLACE TRIGGER BARS.TU_983O 
  BEFORE UPDATE OF SOS ON "BARS"."OPER"
  REFERENCING FOR EACH ROW
    WHEN (
OLD.sos>0 AND NEW.sos<0 AND
     (OLD.nlsa like '983%' or  OLD.nlsb like '983%' or
      OLD.nazn like '����������� ����_� �� �����%' )
      ) DECLARE
/* �������������� ������� ��������� ����� ( ������� CH_1 ) �� �������� ���
   ���������:
   1) ������ � ���� ��� BAK �������� �� ����� �������� �����
      - �������� � ��������� ��������������� REF1 �� ���� ����� ���� ������
   2) ������ � ���� ��� BAK �������� �� ������������ �������
      - �������� � ��������� ��������������� REF2 �� ���� ����� �������, �.�.
        "���������" �������
   4) ������ � ���� ��� BAK �������� �� �������� ����
      - �������� � ��������� ��������������� REF4
   5) ������ � ���� ��� BAK �������� �� ���������� �������
      - �������� � ��������� ��������������� REF5
   *) ����������� ������� ����� � ���� ��� BAK � ���������� ������������������:
      983* - KAPTOTEKA CH_1
*/

 R1_  int;  R2_ int; R3_ int; R4_ int; R4m_ int; R4p_ int; R5_ int;
 ern CONSTANT POSITIVE := 333;  err EXCEPTION;
 erm  VARCHAR2(80):='983* - KAPTOTEKA CH_1';
BEGIN
 begin
   select ref1, ref2, ref3, ref4, ref5
   into    R1_,  R2_,  R3_,  R4_,  R5_  from ch_1
   where :OLD.REF in (nvl(REF1,0),      nvl(REF2,0),
                      nvl(Abs(ref4),0), nvl(REF5,0)
                      ) and rownum=1;
  if    R4_ >0 then R4p_:= + R4_;
  elsIf R4_ <0 then R4m_:= - R4_;
  end if;

 EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
 end;
--------------------------------------------------
 If    R1_=:OLD.REF    and
       R2_ is null     and R3_ is null and R4_ is null and R5_ is null THEN
    update ch_1 set ref1=null where ref1 = R1_; /* 1.����� ��������� ���� */

 elsIf R2_=:OLD.REF    and
       R1_ is not null and R3_ is null and R4_ is null AND R5_ is null THEN
    update ch_1 set ref2=null where ref2 = R2_; /* 2.��������� ������� */

 elsIf R4m_=:OLD.REF   and R1_ is not null and r2_ is not null  THEN
    update ch_1 set ref4=null where ref4 = R4_; /* 4- ����� ����.���� �� 1 */

 elsIf R4p_=:OLD.REF   and R1_ is not null and r2_ is not null  THEN

    update ch_1 set ref4=null where ref4 = R4_; /* 4+ ����� ����.���� �� ������� */
    update ch_1 set ref3=null where ref3 = R3_;
    update nlk_ref set ref2=NULL where ref1=R3_;

 elsIf R5_=:OLD.REF    and R1_ is not null and r2_ is not null  THEN
    update ch_1 set ref5=null where ref5 = R5_; /* 5.����� ���������� ������� */
 else
   RAISE err;
 end if;
EXCEPTION WHEN err THEN
 raise_application_error(-(20000+ern),'\' ||erm,TRUE);

END tu_983o;


/
ALTER TRIGGER BARS.TU_983O ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_983O.sql =========*** End *** ===
PROMPT ===================================================================================== 
