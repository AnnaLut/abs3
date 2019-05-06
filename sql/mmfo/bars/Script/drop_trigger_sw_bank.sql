
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /drop_trigger_sw_bank.sql                     ========
PROMPT ===================================================================================== 

BEGIN
    FOR rec
        IN (SELECT 'drop trigger ' || trigger_name st
            FROM   user_triggers
            WHERE      table_owner = 'BARS'
                   AND table_name = 'SW_BANKS'
                   AND trigger_name IN
                           ('TD_SW_BANKS', 'TI_SW_BANKS', 'TU_SW_BANKS'))
    LOOP
        EXECUTE IMMEDIATE rec.st;
    END LOOP;
END;

/