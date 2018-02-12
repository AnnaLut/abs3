create or replace type t_sign_doc_rec force
as object
(
       id                number,
       key_id            varchar2(256),
       sign              varchar2(32676),
       doc_buffer        varchar2(730)
)
/
grant execute on t_sign_doc_rec to bars_access_defrole;
/
create or replace type t_sign_doc_set  force as table of  t_sign_doc_rec;
/
grant execute on t_sign_doc_set to bars_access_defrole;
/
