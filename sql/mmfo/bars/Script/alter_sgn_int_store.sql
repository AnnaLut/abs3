PROMPT *** Create index I2_SGN_INT_STORE_SIGN_ID ***
declare
    name_already_used exception;
    column_already_indexed exception;

    pragma exception_init(name_already_used, -955);
    pragma exception_init(column_already_indexed, -1408);
begin
    execute immediate 'create index i2_sgn_int_store_sign_id on BARS.SGN_INT_STORE (sign_id) tablespace brsbigi';
exception
    when column_already_indexed or name_already_used then
         null;
end;
/

