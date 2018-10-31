CREATE OR REPLACE FUNCTION BARS.F_DATE_EXPIRED (p_date date, p_nd number, p_par number)                                
  RETURN date
  is
x_event_date date;
begin
    if p_par = 0 then
       begin
            select min(DAT_SPZ(a.ACC, p_date, 1))
              into x_event_date
              from BARS.ACCOUNTS a
              join BARS.ND_ACC   n
                on ( n.ACC = a.ACC )
             where n.nd = p_nd
               and a.TIP in ( 'SP ');
       end;
    else 
       begin
            select min(DAT_SPZ(a.ACC, p_date, 1))
              into x_event_date
              from BARS.ACCOUNTS a
              join BARS.ND_ACC   n
                on ( n.ACC = a.ACC )
             where n.nd = p_nd
               and a.TIP in ('SPN' );
       end;
    end if;
return x_event_date;
end;
/

grant execute on BARS.F_DATE_EXPIRED to bars_access_defrole;