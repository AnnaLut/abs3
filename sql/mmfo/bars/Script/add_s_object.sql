declare
    sequence_doesnt_exist exception;
    pragma exception_init(sequence_doesnt_exist, -2289);
    l_next_object_id integer;
begin
    select nvl(max(trunc(o.id / 100)), 0) + 1
    into   l_next_object_id
    from   object o;

    begin
        execute immediate 'drop sequence s_object';
    exception
        when sequence_doesnt_exist then
             null;
    end;

    execute immediate 'create sequence s_object start with ' || l_next_object_id;
end;
/
