

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ACCTORNK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ACCTORNK ***

  CREATE OR REPLACE PROCEDURE BARS.P_ACCTORNK (p_acc number, p_rnk number)
is
  l_nls  accounts.nls%type;
  l_daos date;
  l_dat1 date;
  l_dat2 date;
begin
   if p_acc is not null and p_rnk is not null then
      begin
         select nls, daos into l_nls, l_daos from accounts where acc = p_acc;
      exception when no_data_found then
         bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', p_acc);
      end;
      begin
         select date_on, date_off into l_dat1, l_dat2 from customer where rnk = p_rnk;
      exception when no_data_found then
         raise_application_error(-20000, 'Не знайдено РНК ' || p_rnk);
      end;
      if l_daos < l_dat1 then
         raise_application_error(-20000, 'Дата відкриття рахунку ' || l_nls || ' менше дати реєстрації клієнта РНК ' || p_rnk );
      end if;
      if l_dat2 is not null then
         raise_application_error(-20000, 'Клієнт РНК ' || p_rnk || ' закритий');
      end if;
      update accounts set rnk = p_rnk where acc = p_acc;
      update tmp_acctornk set new_rnk = p_rnk where acc = p_acc;
   end if;
end p_acctornk;
/
show err;

PROMPT *** Create  grants  P_ACCTORNK ***
grant EXECUTE                                                                on P_ACCTORNK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ACCTORNK      to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ACCTORNK.sql =========*** End **
PROMPT ===================================================================================== 
