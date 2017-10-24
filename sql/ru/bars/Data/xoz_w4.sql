prompt ..........................................
prompt В модуле ХОЗ.деб считать равноценными типы счетов XOZ И W4X
prompt ..........................................


prompt Ввести новый тип счета W4X для бал.счетов 3550, 3551 ( хоз.деб для ПЦ)
prompt ТАБЛИЦІЫ TIPS NBS_TIPS W4_TIPS


begin suda;  insert into tips (tip, name) values ('W4X','Госп.Деб.забор, що пов`язана з ПЦ');
exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
end;
/

exec bpa.alter_policy_info( 'NBS_TIPS', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'NBS_TIPS', 'FILIAL', NULL,'E' , 'E' , 'E'  );
exec bpa.alter_policies('NBS_TIPS'); 


begin suda; Insert into BARS.NBS_TIPS   (NBS, TIP) Values   ('3550', 'W4X');
exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
end;
/

begin suda; Insert into BARS.NBS_TIPS   (NBS, TIP) Values   ('3551', 'W4X');
exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
end;
/


begin suda; Insert into BARS.W4_TIPS   (TIP, TERM_MIN, TERM_MAX) Values   ('W4X', 12, 36);
exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
end;
/

COMMIT;

prompt ..........................................
/*
2) В модуле ХОЗ.деб считать равноценными типы счетов XOZ И W4X
   Триггер  вюшки  пАКЕДЖ
*/

prompt  
prompt  ОБНОВИТЬ ТИП СЧЕТА ДЛЯ 3550 И 3510

BEGIN SUDA;

  FOR K1 IN (SELECT DISTINCT KF FROM  ACCOUNTS WHERE  NBS IN ('3550','3551') AND DAZS IS NULL )
  LOOP BC.GO (K1.KF); 

       FOR K2 IN ( SELECT *      FROM  ACCOUNTS WHERE  NBS IN ('3550','3551') AND DAZS IS NULL )
       LOOP IF K2.TIP LIKE 'W4_' THEN  K2.TIP := 'W4X' ;
            ELSE                       K2.TIP := 'XOZ' ;
            END IF;
            UPDATE  ACCOUNTS SET TIP = K2.TIP  WHERE ACC = K2.ACC ; 
       END LOOP ; -- K2
       SUDA ;
  END LOOP  ; ---K1
END ;
/
COMMIT;
prompt ..........................................

prompt 	Изьять из модуля ХОЗ.деб бал.сч 3500 
prompt 	Справочник
prompt 	Картотека
prompt 	Табл.счетов (тип счета)

DECLARE      L_NBS CHAR(4) := '3500' ; 
BEGIN SUDA;  DELETE FROM XOZ_OB22_CL     WHERE  SUBSTR(DEB,1,4) = L_NBS ;
             DELETE FROM XOZ_OB22        WHERE  SUBSTR(DEB,1,4) = L_NBS ;
  FOR K1 IN (SELECT DISTINCT KF  FROM  ACCOUNTS WHERE  NBS      = L_NBS  AND DAZS IS NULL )
  LOOP BC.GO (K1.KF); 
       FOR K2 IN ( SELECT *      FROM  ACCOUNTS WHERE  NBS      = L_NBS  AND DAZS IS NULL )
       LOOP  UPDATE  ACCOUNTS SET TIP = 'ODB'   WHERE ACC = K2.ACC ; 
             DELETE FROM XOZ_REF WHERE ACC = K2.ACC;
       END LOOP ; -- K2
       SUDA ;
  END LOOP  ; ---K1
END ;
/
COMMIT;
-------------------------