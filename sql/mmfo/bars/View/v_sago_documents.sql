create or replace view bars.v_sago_documents as
select "REF_OUR","REF_SAGO","ACT","ACT_TYPE","ACT_DATE","TOTAL_AMOUNT","REG_ID",(select s.name from sago_document_state s where s.id = f_state) f_state,"N_DOC","D_DOC","USER_ID","FIO_REG","SIGN","REQUEST_ID","ID"
    from sago_documents;

grant select on bars.v_sago_documents to bars_access_defrole;
