---------------------------------------------------------------
--             ������ COBUSUPABS-5836
--
--   ���� 4-�� ����� ������� �� �������� �� ������� �� �� SWIFT  (�������� ���/�12)                          
--                                                                                                                                          ������� ��������  
--    12   1.2.10.1 �i���������� �������i� �� �� SWIFT (� ����� ������)
--   119   1.2.10.2 �i���������� �������i� I� �� SWIFT (�� ��� ������)
--   120   1.6.2.3.1 �i���������� �������i� I� �� SWIFT VIP-��. (� ����� ������)
--   121   1.6.2.3.2 �i���������� �������i� I� �� SWIFT VIP-��. (�� ��� ������)
---------------------------------------------------------------

BEGIN

  Bc.go('/') ;

  For k in (Select KF from MV_KF)

  Loop


    UPDATE TARIF set PR=1, TAR=1500, SMIN=0, SMAX=null,
               NAME='1.2.10.1 �i���������� �������i� �� �� SWIFT (� ����� ������)'
      where KOD = 12 and KF = k.KF;
    

    INSERT INTO TARIF 
    ( KOD,
      KV, NAME, TAR, PR, 
      SMIN, SMAX, TIP, NBS, OB22, KF)
    VALUES  
    (119, 
     840,'1.2.10.2 �i���������� �������i� I� �� SWIFT (�� ��� ������)', 0, 1,
     1500, 50000, 0, NULL, NULL, k.KF );
    
    
    INSERT INTO TARIF 
    ( KOD,
      KV, NAME, TAR, PR, 
      SMIN, SMAX, TIP, NBS, OB22, KF)
    VALUES  
    (120, 
     840,'1.6.2.3.1 �i���������� �������i� I� �� SWIFT VIP-��. (� ����� ������)', 0, 1,
     5000, null, 0, NULL, NULL, k.KF );
    
    
    INSERT INTO TARIF 
    ( KOD,
      KV, NAME, TAR, PR, 
      SMIN, SMAX, TIP, NBS, OB22, KF)
    VALUES  
    (121, 
     840,'1.6.2.3.2 �i���������� �������i� I� �� SWIFT VIP-��. (�� ��� ������)', 0, 1,
     5000, 50000, 0, NULL, NULL, k.KF );

  End Loop;

  Bc.home();

EXCEPTION WHEN OTHERS then
   null;
END;
/
commit;
