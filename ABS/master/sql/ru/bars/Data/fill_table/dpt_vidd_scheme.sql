
begin 
  for k in (select vidd, dv.type_id from dpt_vidd dv, dpt_types dt where (DT.TYPE_ID = DV.TYPE_ID and DT.FL_WEBBANKING = 1))
   loop
     begin
        insert INTO DPT_VIDD_SCHEME 
        SELECT k.type_id AS TYPE_ID,
               k.vidd AS VIDD,
               38 AS FLAGS,
               '' AS ID,
               'WB_CREATE_DEPOSIT' AS ID_FR
          FROM DUAL;      
        insert INTO DPT_VIDD_SCHEME 
        SELECT k.type_id AS TYPE_ID,
               k.vidd AS VIDD,
               39 AS FLAGS,
               '' AS ID,
               'WB_CHANGE_ACCOUNT' AS ID_FR
          FROM DUAL; 
        insert INTO DPT_VIDD_SCHEME 
        SELECT k.type_id AS TYPE_ID,
               k.vidd AS VIDD,
               40 AS FLAGS,
               '' AS ID,
               'WB_DENY_AUTOLONGATION' AS ID_FR
          FROM DUAL;   
    exception when dup_val_on_index then null;
    end;                                 
   end loop;
end;
/
commit;
/