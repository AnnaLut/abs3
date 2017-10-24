
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/patch.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PATCH IS
/******************************************************************************
   NAME:       PATCH
   PURPOSE:    Intelectual patch work

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/11/2000  Ivan             1. Created this package.

   REQUREMENTS: P0000000.sql script executed

******************************************************************************/

   /*
     Цель: проверка наличия связанных патчей
     Возвращаемое значение:

		<0	- патч не установлен или установлена предидущая версия патча,
			  в переменной PATCH_VERSION возвращается установленая версия патча,
			  если патч не установлен в PATCH_VERSION возвращается Null

		0	- установлен патч с номером PATCH_N и версией PATCH_VERSION;

		>0	- установлен патч с номером PATCH_N и версией выше PATCH_VERSION?
			  в переменной PATCH_VERSION возвращается установленая версия патча;
	  Параметры:
	    PATCH_N
		      Номер патча
	    PATCH_VERSION
		      версия патча (Если NULL допускается любая), допускаются только цифры
	*/
   FUNCTION CHECK_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION OUT VARCHAR2  ) Return Number;

   /*
     Цель: проверка возможности применения патча
     Возвращаемое значение:
		1	- патч с указаным номером и версией может быть установлен
              (т.е. на данной БД не установлен патч с данным номером или
			  установлен, но с предидущей версией И тип БД совпадает)

		0	- патч с указаным номером и версией НЕ может быть установлен
			  (т.е. на данной БД УЖЕ установлен патч с данным номером или
			  установлен со следующей версией ИЛИ тип БД НЕ совпадает)
	  Параметры:
	    PATCH_N
		      Номер патча
	    PATCH_VERSION
		      версия патча (Если NULL допускается любая), допускаются только цифры
	    DB_TYPE
		      Тип базы данных (см. Params.DB_TYPE)
			  Применяется если существует несколько версий БД
			  (Грузия, Украина...)
			  Умолчательное значение GENERIC
			  !!! Патчи для типа БД GENERIC должны запускаться на всех базах
			  Патчи с другим типом запускаются только на БД типа DB_TYPE
   */
   FUNCTION CAN_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2, DB_TYPE VARCHAR2 DEFAULT 'GENERIC' ) Return Number;

   /*
      Цель: Регистрация патча после успешного выполнения
	  Параметры:
	    PATCH_N
		      Номер патча
	    PATCH_VERSION
		      версия патча (Если NULL допускается любая), допускаются только цифры
   */
   PROCEDURE REGISTER ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2 );

END PATCH;
/
CREATE OR REPLACE PACKAGE BODY BARS.PATCH AS

FUNCTION CHECK_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION OUT VARCHAR2 ) Return Number IS
tmp VARCHAR2(10);
BEGIN
  BEGIN
    SELECT patch_version INTO tmp FROM patches WHERE patch_number = PATCH_N;
	IF PATCH_VERSION IS NULL THEN
	  RETURN 0;
	ELSIF PATCH_VERSION > tmp THEN
	  PATCH_VERSION := tmp;
	  RETURN  -1;
	ELSIF PATCH_VERSION < tmp THEN
	  PATCH_VERSION := tmp;
	  RETURN  1;
	ELSIF PATCH_VERSION = tmp THEN
	  RETURN  0;
	END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	BEGIN
	  PATCH_VERSION := NULL;
	  RETURN -1;
	END;
  END;
  RETURN -1;
END CHECK_PATCH;

FUNCTION CAN_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2, DB_TYPE VARCHAR2 DEFAULT 'GENERIC' ) Return Number IS
tmp VARCHAR2(50);
BEGIN
  BEGIN
    SELECT val INTO tmp FROM params WHERE par='DB_TYPE';
	IF (DB_TYPE<>'GENERIC') AND (DB_TYPE<>tmp) THEN
	  RETURN 0;   --Wrong DB_TYPE
	END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
  END;
  BEGIN
    SELECT patch_version INTO tmp FROM patches WHERE patch_number = PATCH_N;
	IF PATCH_VERSION IS NULL THEN
	  RETURN 1;
	ELSIF PATCH_VERSION > tmp THEN
	  RETURN 1;
	ELSE
	  RETURN 0;
	END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	  RETURN 1;
  END;
END CAN_PATCH;

PROCEDURE REGISTER ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2 )IS
tmp VARCHAR2(10);
BEGIN
  IF PATCH_N IS NOT NULL THEN
    BEGIN
      SELECT patch_version INTO tmp FROM patches WHERE patch_number = PATCH_N;
	  UPDATE patches SET
	    patch_version=PATCH_VERSION,
	    apply_date=sysdate
	  WHERE
	    patch_number = PATCH_N;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
	  BEGIN
	    INSERT INTO patches
		(patch_number,patch_version,apply_date)
		VALUES
		(PATCH_N, PATCH_VERSION, sysdate);
      END;
    END;
  END IF;
END REGISTER;

END PATCH;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/patch.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 