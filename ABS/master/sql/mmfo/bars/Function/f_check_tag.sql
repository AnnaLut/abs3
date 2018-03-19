
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_tag.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_TAG (p_ref    oper.REF%TYPE,
                                             p_tag    operw.tag%TYPE)
   RETURN NUMBER
IS
   l_tt             tts.tt%TYPE;
   l_value          operw.VALUE%TYPE;
   l_value_parent   operw.VALUE%TYPE;
   g_modcode        VARCHAR2 (3) := 'DOC';
   l_tagname        op_field.name%TYPE;
BEGIN
 -- Читаємо код операції
   BEGIN
      SELECT o.tt
        INTO l_tt
        FROM oper o
       WHERE o.REF = p_ref;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
   END;

   FOR c IN (SELECT *
               FROM check_tag t
              WHERE t.tt = l_tt AND t.tag_parent = p_tag)
   LOOP
      BEGIN
         l_value := f_operw (p_ref, c.tag_child);
         l_value_parent := f_operw (p_ref, c.tag_parent);

         BEGIN
            SELECT name
              INTO l_tagname                   -- имя тэга для вывода в ошибку
              FROM op_field
             WHERE tag = c.tag_child;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_tagname := '';
            WHEN DUP_VAL_ON_INDEX
            THEN
               SELECT CONCATSTR (name)
                 INTO l_tagname
                 FROM op_field
                WHERE tag = c.tag_child;
         END;


         IF (l_value_parent != c.value_parent)
            OR (l_value_parent = c.value_parent AND c.required = 'N')
            OR (l_value_parent = c.value_parent
                AND c.required = 'Y'
                AND l_value IS NOT NULL)
            OR (L_TT IN ('AA3','AA5','TM8','TTI','TMP') AND L_VALUE IS NULL AND (l_value_parent !='Паспорт ID-картка' or l_value_parent is  null))
         THEN
            NULL;
         ELSE
            bars_error.raise_nerror (g_modcode, 'DJNR_NOT_FOUND', l_tagname);
         --raise_application_error(-20000,'Невірно заповнено реквізит <'||c.tag_child||'>!');
         END IF;
      END;
   END LOOP;

   RETURN 0;
END f_check_tag;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_TAG ***
grant EXECUTE                                                                on F_CHECK_TAG     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CHECK_TAG     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_tag.sql =========*** End **
 PROMPT ===================================================================================== 
 