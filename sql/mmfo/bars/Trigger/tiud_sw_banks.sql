

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /tiud_sw_banks                    =========*** Run *** 
PROMPT ===================================================================================== 



CREATE OR REPLACE TRIGGER tiud_sw_banks
 AFTER
  INSERT OR DELETE OR UPDATE
 ON sw_banks
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    id_upd            INT;
    l_change_action   sw_banks_upd.action%TYPE;
BEGIN
    SELECT s_sw_banks_upd.NEXTVAL INTO id_upd FROM DUAL;

    l_change_action :=
        CASE
            WHEN INSERTING THEN 'I'
            WHEN UPDATING THEN 'U'
            WHEN DELETING THEN 'D'
        END;

    INSERT INTO sw_banks_upd (idupd,
                              bic,
                              name,
                              office,
                              city,
                              country,
                              chrset,
                              transback,
                              action,
                              datupd)
  VALUES      (id_upd,
                 nvl(:old.bic , :new.bic ), 
                 nvl(:old.name , :new.name ), 
                 nvl(:old.office , :new.office ), 
                 nvl(:old.city , :new.city ), 
                 nvl(:old.country , :new.country ), 
                 nvl(:old.chrset , :new.chrset ), 
                 nvl(:old.transback , :new.transback ), 
                 l_change_action,
                 SYSDATE);
END td_sw_banks;

/