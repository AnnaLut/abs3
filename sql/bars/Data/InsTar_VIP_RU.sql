---------------------------------------------------------------
--             ������ COBUSUPABS-5836
--
--   ���� 4-�� ����� ������� �� �������� �� ������� �� �� SWIFT  (�������� ���/�12)                          
--                                                                                                                                          ������� ��������  
--    12   1.2.10.1 �i���������� �������i� �� �� SWIFT (� ����� ������)
--   119   1.2.10.2 �i���������� �������i� I� �� SWIFT (�� ��� ������)
--   120   1.6.2.3.1 �i���������� �������i� I� �� SWIFT VIP-��. (� ����� ������)
--   121   1.6.2.3.2 �i���������� �������i� I� �� SWIFT VIP-��. (�� ��� ������)
--   ������ COBUMMFO-6106
--    31   2.1.3.3.1. ����� ���i��� ��� �� ��� ��i���� <5000
--   331   2.1.3.3.2. ����� ���i��� ��� �� ��� ��i���� >5000
---------------------------------------------------------------

BEGIN

  Suda;

  UPDATE TARIF set PR=0.2, SMIN=500
    where KOD = 31 ;


  UPDATE TARIF set PR=0, 
             NAME='2.1.3.3.2. ����� ���i��� ��� �� ��� ��i���� >5000'
    where KOD = 331 ;


  UPDATE TARIF set PR=1, TAR=1500, SMIN=0, SMAX=null,
             NAME='1.2.10.1 �i���������� �������i� �� �� SWIFT (� ����� ������)'
    where KOD=12 ;
END;
/
commit;

BEGIN

  Suda;

  INSERT INTO TARIF 
  ( KOD,
    KV, NAME, TAR, PR, 
    SMIN, SMAX, TIP, NBS, OB22, KF)
  VALUES  
  (119, 
   840,'1.2.10.2 �i���������� �������i� I� �� SWIFT (�� ��� ������)', 0, 1,
   1500, 50000, 0, NULL, NULL, f_ourmfo_g );

EXCEPTION WHEN dup_val_on_index then
  null;  
END;
/
commit;

BEGIN

  Suda;

  INSERT INTO TARIF 
  ( KOD,
    KV, NAME, TAR, PR, 
    SMIN, SMAX, TIP, NBS, OB22, KF)
  VALUES  
  (120, 
   840,'1.6.2.3.1 �i���������� �������i� I� �� SWIFT VIP-��. (� ����� ������)', 0, 1,
   5000, null, 0, NULL, NULL, f_ourmfo_g );

EXCEPTION WHEN dup_val_on_index then
  null;  
END;
/
commit;

BEGIN

  Suda;

  INSERT INTO TARIF 
  ( KOD,
    KV, NAME, TAR, PR, 
    SMIN, SMAX, TIP, NBS, OB22, KF)
  VALUES  
  (121, 
   840,'1.6.2.3.2 �i���������� �������i� I� �� SWIFT VIP-��. (�� ��� ������)', 0, 1,
   5000, 50000, 0, NULL, NULL, f_ourmfo_g );

EXCEPTION WHEN dup_val_on_index then
  null;  
END;
/
commit;
