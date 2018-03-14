create or replace type t_nbu_response_protected force as object
(
       alg      varchar2(32767 byte), -- Криптографічний алгоритм який буде використано при створенні JWS об'єкту
       typ      varchar2(32767 byte), -- Тип серіалізації JWS
       cty      varchar2(32767 byte), -- Тип контенту JWS об'єкту
       kid      varchar2(32767 byte), -- Унікальний ідентифікатор ключа системи захисту НБУ, яким було створено ЕЦП
       dateOper varchar2(32767 byte), -- Дата створення повідомлення
       appId    varchar2(32767 byte), -- Унікальний код задачі

       constructor function t_nbu_response_protected(
           p_protected in varchar2)
       return self as result
);
/
create or replace type body t_nbu_response_protected is

    constructor function t_nbu_response_protected(
        p_protected in varchar2)
    return self as result
    is
    begin
        return;
    end;
end;
/
