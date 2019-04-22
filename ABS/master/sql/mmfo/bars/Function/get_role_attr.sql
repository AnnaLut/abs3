
CREATE OR REPLACE FUNCTION get_role_attr (
   p_res_code   IN VARCHAR2,
   p_user_id    IN INTEGER DEFAULT user_id)
   RETURN INT
IS
   l_state   INT := 0;
   l_id      INT;
BEGIN

   CASE
      WHEN p_res_code IS NULL
      THEN
         raise_application_error (
            -20666,
            'Не вкзано код атрибуту',
            TRUE); else null;
   END CASE ;

   BEGIN
      SELECT id
        INTO l_id
        FROM attribute_kind
       WHERE ATTRIBUTE_CODE = p_res_code;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error (
            -20666,
               'Не знайдено атрибут з кодом  '
            || p_res_code,
            TRUE);
   END;

   BEGIN
      SELECT MAX (ROLE_ID)
        INTO l_state
        FROM V_ROLE_RESOURCE
       WHERE     ROLE_ID IN (SELECT COLUMN_VALUE
                               FROM TABLE (
                                       user_utl.get_user_roles (p_user_id)))
             AND resource_code = p_res_code
             AND is_granted = 1;

      CASE
         WHEN l_state IS NULL
         THEN
            l_state := 0; else l_state := 1;
      END CASE;

   END;

   RETURN l_state;
END;
/
 show err;
 
PROMPT *** Create  grants  get_role_attr ***
GRANT EXECUTE ON get_role_attr TO bars_access_defrole;