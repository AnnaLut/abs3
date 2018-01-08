
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_swift_country.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SWIFT_COUNTRY (p_ref in number, 
                                               p_typ in number := 1) return varchar2 
is
    l_b010      varchar2(20);
    l_k040      varchar2(20);
    l_swift_k   varchar2(200);
begin
    BEGIN
       SELECT substr(trim(value), 1, 12)
          INTO l_swift_k
       FROM OPERW
       WHERE REF=p_ref
         AND TAG LIKE '58A%'
         AND ROWNUM=1;

       BEGIN
          SELECT k040, b010
                INTO l_k040, l_b010
          FROM RC_BNK
          WHERE SWIFT_CODE LIKE l_swift_k||'%'
            AND ROWNUM=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          l_swift_k := substr(l_swift_k,1,4)||' '||substr(l_swift_k,5,2)||
                   ' '||substr(l_swift_k,7,2);
                   
          BEGIN
             SELECT k040, b010
                INTO l_k040, l_b010
             FROM RC_BNK
             WHERE SWIFT_CODE LIKE l_swift_k||'%'
               AND ROWNUM=1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             raise;
          END;
       END;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       BEGIN
          SELECT substr(trim(value), 1, 12)
             INTO l_swift_k
          FROM OPERW
          WHERE REF=p_ref
            AND TAG LIKE '57A%'
            AND ROWNUM=1;

          BEGIN
             SELECT k040, b010
                INTO l_k040, l_b010
             FROM RC_BNK
             WHERE SWIFT_CODE LIKE l_swift_k||'%'
               AND ROWNUM=1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             l_swift_k := substr(l_swift_k,1,4)||' '||substr(l_swift_k,5,2)||
                      ' '||substr(l_swift_k,7,2);
                      
             BEGIN
                SELECT k040, b010
                    INTO l_k040, l_b010
                FROM RC_BNK
                WHERE SWIFT_CODE LIKE l_swift_k||'%'
                  AND ROWNUM=1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                raise;
             END;
          END;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          BEGIN
             SELECT substr(trim(value), 1, 12)
                INTO l_swift_k
             FROM OPERW
             WHERE REF=p_ref
               AND TAG LIKE '57D%'
               AND ROWNUM=1;

             BEGIN
                SELECT k040, b010
                INTO l_k040, l_b010
                FROM RC_BNK
                WHERE SWIFT_CODE LIKE l_swift_k||'%'
                  AND ROWNUM=1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                l_swift_k := substr(l_swift_k,1,4)||' '||substr(l_swift_k,5,2)||
                         ' '||substr(l_swift_k,7,2);
                         
                BEGIN
                   SELECT k040, b010
                   INTO l_k040, l_b010
                   FROM RC_BNK
                   WHERE SWIFT_CODE LIKE l_swift_k||'%'
                     AND ROWNUM=1;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   raise;
                END;
             END;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                SELECT substr(trim(value), 1, 12)
                   INTO l_swift_k
                FROM OPERW
                WHERE REF=p_ref
                  AND TAG='57'
                  AND length(trim(value))>3
                  AND ROWNUM=1;

                BEGIN
                   SELECT k040, b010
                   INTO l_k040, l_b010
                   FROM RC_BNK
                   WHERE SWIFT_CODE LIKE l_swift_k||'%'
                     AND ROWNUM=1;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   l_swift_k := substr(l_swift_k,1,4)||' '||substr(l_swift_k,5,2)||
                               ' '||substr(l_swift_k,7,2);
                               
                   BEGIN
                      SELECT k040
                         INTO l_k040
                      FROM RC_BNK
                      WHERE SWIFT_CODE LIKE l_swift_k||'%'
                        AND ROWNUM=1;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      raise;
                   END;
                END;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                BEGIN
                   SELECT substr(trim(value), 1, 12)
                      INTO l_swift_k
                   FROM OPERW
                   WHERE REF=p_ref
                     AND TAG='NOS_B'
                     AND ROWNUM=1;

                   l_swift_k := substr(l_swift_k,1,4)||' '||substr(l_swift_k,5,2)||
                               ' '||substr(l_swift_k,7,2);
                               
                   BEGIN
                      SELECT k040, b010
                      INTO l_k040, l_b010
                      FROM RC_BNK
                      WHERE SWIFT_CODE LIKE l_swift_k||'%'
                        AND ROWNUM=1;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      null;
                   END;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   null;
                END;
             END;
          END;
       END;
    END;
    
    if p_typ = 1 then
        l_k040 := lpad(l_k040, 3, '0');
        
        return l_k040;
    else
        l_b010 := lpad(l_b010, 10, '0');
        
        return l_b010;
        
    end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_swift_country.sql =========**
 PROMPT ===================================================================================== 
 