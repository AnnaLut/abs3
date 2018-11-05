create or replace package audit_pkg
as
procedure check_val( l_table_name in varchar2,
l_tag_name in varchar2,
l_new in varchar2,
l_old in varchar2,
l_key in number);

procedure check_val( l_table_name in varchar2,
l_tag_name in varchar2,
l_new in date,
l_old in date,
l_key in number );

procedure check_val( l_table_name in varchar2,
l_tag_name in varchar2,
l_new in number,
l_old in number,
l_key in number );
end;
/
create or replace package body audit_pkg
as

procedure check_val( l_table_name in varchar2,
l_tag_name in varchar2,
l_new in varchar2,
l_old in varchar2,
l_key number )
is
begin
if ( l_new <> l_old or
(l_new is null and l_old is not NULL) or
(l_new is not null and l_old is NULL) )
then
insert into ASVO_IMMOBILE_HISTORY
  (key, tag, old, new, chgdate,donebuy, table_name)
values
  (l_key,
   upper(l_tag_name),
   l_old,
   l_new,
   sysdate,
   sys_context('bars_global', 'user_id'),
   upper(l_table_name)
   );
end if;
end;

procedure check_val( l_table_name in varchar2, l_tag_name in varchar2,
l_new in date, l_old in date ,l_key number)
is
begin
if ( l_new <> l_old or
(l_new is null and l_old is not NULL) or
(l_new is not null and l_old is NULL) )
then
insert into ASVO_IMMOBILE_HISTORY
  (key, tag, old, new, chgdate,donebuy,  table_name)
values
  (l_key,
   upper(l_tag_name),
   to_char( l_old, 'dd-mon-yyyy hh24:mi:ss' ),
   to_char( l_new, 'dd-mon-yyyy hh24:mi:ss' ),
   sysdate,
   sys_context('bars_global', 'user_id'),
   upper(l_table_name)
   );
end if;
end;

procedure check_val( l_table_name in varchar2, l_tag_name in varchar2,
l_new in number, l_old in number,l_key number )
is
begin
if ( l_new <> l_old or
(l_new is null and l_old is not NULL) or
(l_new is not null and l_old is NULL) )
then
insert into ASVO_IMMOBILE_HISTORY
  (key, tag, old, new, chgdate,donebuy, table_name)
values
  (l_key,
   upper(l_tag_name),
   l_old,
   l_new,
   sysdate,
   sys_context('bars_global', 'user_id'),
   upper(l_table_name)
   );
end if;
end;

end audit_pkg;
/
show err;
 
PROMPT *** Create  grants  audit_pkg ***
grant EXECUTE                                                                on audit_pkg         to BARS_ACCESS_DEFROLE;
 
 
