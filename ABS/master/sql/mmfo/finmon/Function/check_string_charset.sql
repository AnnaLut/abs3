
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/FINMON/function/check_string_charset.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION FINMON.CHECK_STRING_CHARSET (--
                                      --  Функция проверки на смешение различных наборов символов в строке
                                      --  Находит и возвращает позицию символа нарушителя (последовательно с конца)
                                      --  Параметры:
                                      --      проверяемая строка,
                                      --      код набора символов в кот. должна быть строка ('RU' - 'US')
                                      --  Возвращаемое значение:
                                      --      число >0 - позиция символа-нарушителя.
                                      --       0       - строка не содержит недопустимых символов
                                      --      -1       - строка пустая
                                      --
                                      STRING_    VARCHAR2,
                                      CHRSET_    VARCHAR2 DEFAULT 'RU' )
   RETURN NUMBER
IS
   CHARSET_   VARCHAR2 (50);
   TMPSTR_    VARCHAR2 (4000);
   RETVAL_    NUMBER;
BEGIN
   IF STRING_ IS NULL
   THEN
      RETURN -1;
   END IF;

   RETVAL_ := 0;

   IF UPPER (LTRIM (RTRIM (CHRSET_))) = 'RU'
   THEN
      CHARSET_ := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   ELSE
      CHARSET_ := 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯІЇЄ№';
   END IF;

   TMPSTR_ := UPPER (LTRIM (RTRIM (STRING_)));

   FOR i IN 1 .. LENGTH (TMPSTR_)
   LOOP
      IF INSTR (CHARSET_, SUBSTR (TMPSTR_, i, 1)) > 0
      THEN
         RETVAL_ := i;
      END IF;
   END LOOP;

   RETURN RETVAL_;
END CHECK_STRING_CHARSET;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/FINMON/function/check_string_charset.sql ========
 PROMPT ===================================================================================== 
 