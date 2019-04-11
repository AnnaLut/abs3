 PROMPT =====================================================================================
 PROMPT *** Run *** = Scripts /Sql/BARS/function/f_zvt_check_usr_access.sql =*** Run *** ====
 PROMPT =====================================================================================

CREATE OR REPLACE FUNCTION BARS.f_zvt_check_usr_access (
   p_user_id          INT,
   p_users_list       VARCHAR2,
   p_role_code        VARCHAR2,
   p_sector_id        VARCHAR2,
   p_team_id          VARCHAR2,
   p_division_id      VARCHAR2,
   p_department_id    VARCHAR2)
   RETURN INT
IS
   l_users_list         VARCHAR2 (255);
   l_result             INT;
   l_RESOURCE_TYPE_ID   INT := 10;
   l_GRANTEE_TYPE_ID    INT := 11;
BEGIN
   /*?сли вкратце - смотрим по иерархии снизу вверх
   если не % - провер¤ем сначала роль, есть ли у этого пользовател¤, потом сектор, отдел, управление, департамент.
    важно, если указано 2 параметра или больше - провер¤ем только тот, что ниже по иерархии
   ?сли все % - показываем и ничего не провер¤ем*/
   IF     p_role_code = '%'
      AND p_sector_id = '%'
      AND p_team_id = '%'
      AND p_division_id = '%'
      AND p_department_id = '%'
   THEN
      l_result := 1;
   ELSE
      BEGIN
         SELECT 1
           INTO l_result
           FROM ZVT_ROLE z,
                (SELECT RESOURCE_ID
                   FROM ADM_RESOURCE
                  WHERE     GRANTEE_TYPE_ID = l_GRANTEE_TYPE_ID
                        AND GRANTEE_ID = p_user_id
                        AND RESOURCE_TYPE_ID = l_RESOURCE_TYPE_ID) a
          WHERE     z.role_id = a.RESOURCE_ID
                AND CASE
                       WHEN p_role_code != '%'
                       THEN
                          DECODE (z.role_code, p_role_code, 1, 0)
                       WHEN p_sector_id != '%'
                       THEN
                          DECODE (z.sector_id, TO_NUMBER (p_sector_id), 1, 0)
                       WHEN p_team_id != '%'
                       THEN
                          DECODE (z.team_id, TO_NUMBER (p_team_id), 1, 0)
                       WHEN p_division_id != '%'
                       THEN
                          DECODE (z.division_id,
                                  TO_NUMBER (p_division_id), 1,
                                  0)
                       WHEN p_department_id != '%'
                       THEN
                          DECODE (z.department_id,
                                  TO_NUMBER (p_department_id), 1,
                                  0)
                       ELSE
                          1
                    END = 1
                AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_result := 0;
      END;
   END IF;

   /*Проверим еще список пользователей. Если он не пустой, проверяем на вхождение*/
   IF p_users_list IS NOT NULL AND p_users_list != '0'
   THEN
      BEGIN
         /*вот тут куоск магии для парсинга той ерунды,
         которую в теории могут ввести пользователи вместо списка исполнителей*/
         EXECUTE IMMEDIATE
            (q'[
       select listagg(s, ',') within group(order by 1)
        from (select distinct trim(REGEXP_SUBSTR(str,'[^,]+', 1,row_number()
                                                 over(order by 1))) as s
                from (select REGEXP_REPLACE(trim(:1), '(\D)', ',') as str
                        from dual) t,
                     table (select collect(rownum)
                              from dual
                            CONNECT BY INSTR(str, ',', 1, level - 1) > 0))]')
            INTO l_users_list
            USING p_users_list;


         EXECUTE IMMEDIATE
               'select 1 from dual where '
            || p_user_id
            || ' in ('
            || REGEXP_REPLACE (TRIM (l_users_list), '(\D)', ',')
            || ')'
            INTO l_result;
      EXCEPTION
         WHEN OTHERS
         THEN
            l_result := 0;
      END;
   ELSE
      l_result := 1;
   END IF;

   RETURN l_result;
END f_zvt_check_usr_access;
/

GRANT EXECUTE ON BARS.f_zvt_check_usr_access TO BARS_ACCESS_DEFROLE;
GRANT EXECUTE ON BARS.f_zvt_check_usr_access TO WR_REFREAD;

 SHOW ERR;