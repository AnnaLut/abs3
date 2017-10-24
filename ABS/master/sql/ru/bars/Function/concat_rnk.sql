create or replace function concat_rnk(rnkA varchar2, rnkB varchar2)
return varchar2
as
begin
  --least and greatest to replicate previous logic
  return TO_CHAR(least(rnkA, rnkB))||'/'||TO_CHAR(greatest(rnkA, rnkB));
end;
/
