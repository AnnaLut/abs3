
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs242.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS242 (odat_ IN DATE, acc_ IN NUMBER, s240_ in varchar2 default null) RETURN VARCHAR2 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ������� ������� ��������� s242 (���������� ��� ����� �� ���������
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   29.01.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: odat_ - �������� ����
			   acc_  - ������������� �����
			   s240_ - ����� ������ �������� s240 ���� �� ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	kod_ VARCHAR2(2):='0';
	kod240_ VARCHAR2(2):=s240_;
BEGIN
   if kod240_ is null then
   	  kod240_ := nvl(fs240(odat_, acc_), '0');
   end if;

   if kod240_ <> '0' then
	   BEGIN
	      SELECT NVL (s242, '0')
	        INTO kod_
	        FROM kl_s240
	       WHERE s240 = kod240_;
	   EXCEPTION
	      WHEN NO_DATA_FOUND THEN
	         kod_ := '0';
	   END;
   end if;

   RETURN kod_;
END FS242;
/
 show err;
 
PROMPT *** Create  grants  FS242 ***
grant EXECUTE                                                                on FS242           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs242.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 