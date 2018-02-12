DECLARE
    l_spid   SPARAM_LIST.SPID%TYPE;
BEGIN
    begin 
        SELECT  t.SPID
          INTO  l_spid
          FROM  SPARAM_LIST t
          WHERE t.TABNAME = 'ACCOUNTSW' AND t.TAG = 'DATEOFKK'; --Дата визнання кредиту проблемним на КК
    EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        DBMS_OUTPUT.PUT_LINE ('NO SPID FOUND IN TABLE SPARAM_LIST WITH CONDITITION TABNAME = ACCOUNTSW and TAG=DATEOFKK');          
    WHEN TOO_MANY_ROWS
    THEN
        DBMS_OUTPUT.PUT_LINE ('TOO MANY ROWS IN TABLE SPARAM_LIST WITH CONDITITION TABNAME = ACCOUNTSW and TAG=DATEOFKK');    
    end;
    --если нашлась таблица - делаем MERGE для новых записей

    IF l_spid IS NOT NULL THEN
        MERGE INTO PS_SPARAM p
             USING (SELECT 3550 NBS, l_spid SPID FROM DUAL
                    UNION ALL
                    SELECT 3551 NBS, l_spid SPID FROM DUAL
                    UNION ALL
                    SELECT 3552 NBS, l_spid SPID FROM DUAL
                    UNION ALL
                    SELECT 3559 NBS, l_spid SPID FROM DUAL
                    UNION ALL
                    SELECT 3510 NBS, l_spid SPID FROM DUAL
                    UNION ALL
                    SELECT 3519 NBS, l_spid SPID FROM DUAL) d
                ON (p.nbs = d.nbs AND p.spid = d.spid)
        WHEN NOT MATCHED
        THEN
            INSERT     (p.nbs, p.spid)
                VALUES (d.nbs, l_spid);
                            
        IF SQL%ROWCOUNT>0 
        THEN 
            DBMS_OUTPUT.PUT_LINE ('MERGED '|| TO_CHAR (SQL%ROWCOUNT) || ' ROWS' ); 
        ELSE 
            DBMS_OUTPUT.PUT_LINE ('NO ROWS MERGED ');
        END IF;        

        COMMIT;
    END IF;
END;
/
