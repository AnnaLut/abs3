
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs180_def.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS180_DEF (nbs_ in varchar2, type_ in number) RETURN VARCHAR2
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ������� ������������ �������� �� ��������� ��� ���� �����
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   09/09/2013 (25.10.2007)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: nbs_ - ���������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
25.10.2007 - ��� ���.������ 4400,4409,4430,4431,4500,4509,4530 ������
             �������������� �������� NULL ������������� �������� "C".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

IS
   kod_ varchar2(1):='0';
begin
    -- �������� �� ���������
    IF  nbs_ IN
              ('1600',
               '1819',
               '2600',
               '2601',
               '2603',
               '2604',
               '2605',
               '2620',
               '2625',
               '2628',
               '2650',
               '2655',
               '2900',
               '2901',
               '2902',
               '2903',
               '2905',
               '2909'
              )
    THEN
       kod_ := '1';
    END IF;

    IF SUBSTR (nbs_, 1, 3) IN ('140', '301')
    THEN
       kod_ := '1';
    END IF;

    IF nbs_ IN ('1521', '1621','1310','1510','1610')
    THEN
       kod_ := '2';
    END IF;

    IF nbs_ IN ('4400', '4409', '4430', '4431', '4500', '4509', '4530')
    THEN
        if type_ = 1 then
           kod_ := '9';
        else
           kod_ := 'C';   --null; -- ??????????????
        end if;
    END IF;

 return kod_;
END;
/
 show err;
 
PROMPT *** Create  grants  FS180_DEF ***
grant EXECUTE                                                                on FS180_DEF       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs180_def.sql =========*** End *** 
 PROMPT ===================================================================================== 
 