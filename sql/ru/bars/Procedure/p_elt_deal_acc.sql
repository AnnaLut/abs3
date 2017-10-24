create or replace procedure bars.p_elt_deal_acc(
  p_nd     e_deal$base.nd%type,
  p_opt    int,
  p_acc26  e_deal$base.acc26%type
)
is
begin
  if p_opt = 1 then
    begin
     update e_deal$base d
     set d.ACC26 = p_acc26
     where d.nd = p_nd;
    end;
  end if;
end;
/

show errors;

grant execute on bars.p_elt_deal_acc to bars_access_defrole;