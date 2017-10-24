CREATE OR REPLACE PROCEDURE BARS.P_NBUR_TMP_DEL(p_ref number, p_kodf varchar2)
is
l_datef date;

begin
        BEGIN
           SELECT datf
             INTO l_datef
             FROM V_OTCN_TRACE_70_ALL
            WHERE REF = p_ref AND kodf = p_kodf;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
             raise_application_error(-20203,  'Не визначена звітна дата документа, перевірте значення в таблиці otcn_trace_70', TRUE);
        END;
        
        begin
           insert into NBUR_TMP_DEL_70(ref,kodf,datf, userid) 
           values(p_ref, p_kodf, l_datef, user_id);
        EXCEPTION
          WHEN DUP_VAL_ON_INDEX
          THEN null;
        end;
    
end;
/

grant execute on BARS.P_NBUR_TMP_DEL to bars_access_defrole;