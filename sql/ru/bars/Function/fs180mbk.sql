
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs180mbk.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS180MBK (acc_ IN NUMBER, odat_ in date default null) RETURN VARCHAR2 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Функция расчета кода срока для межбанка
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   30.01.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: acc_ - идентификатор счета
			   odat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
BEGIN
   RETURN FS180(acc_, '1', odat_);
END FS180MBK;
/
 show err;
 
PROMPT *** Create  grants  FS180MBK ***
grant EXECUTE                                                                on FS180MBK        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs180mbk.sql =========*** End *** =
 PROMPT ===================================================================================== 
 