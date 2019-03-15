create or replace view v_sago_requests as
select sr."ID",sr."CREATE_DATE",sr."DATA",sr."STATE",sr."COMM",sr."USER_ID",sr."DOC_COUNT",
         (select sb.fio from staff$base sb where sb.id = sr.user_id) user_name,
         sago_utl.get_count_doc(sr.id) doc_count_payed
    from sago_requests sr;
/
 
grant select on v_sago_requests to bars_access_defrole;
