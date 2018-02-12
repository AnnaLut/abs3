

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_BICACC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EDIT_BICACC ***

CREATE OR REPLACE PROCEDURE p_edit_bicacc (p_par number,
                                           p_kv in number,
                                           p_nls in varchar,
                                           p_bic in bic_acc.bic%type,
                                           p_acc in bic_acc.acc%type,
                                           p_transit in bic_acc.transit%type,
                                           p_their_acc in bic_acc.their_acc%type)
                                           AS
 l_acc accounts.acc%type;
 p_nls_test accounts%rowtype;
 p_ac accounts%rowtype;
BEGIN
 IF p_par=0 THEN
       UPDATE  bic_acc SET
               transit = p_transit,
               their_acc= p_their_acc
       WHERE bic=p_bic and acc=p_acc;

 ELSIF p_par=1 THEN
    begin
      SELECT * INTO p_nls_test FROM accounts WHERE nls = p_nls;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20000,'Такого рахунку ' || to_char(p_nls) || ' не існує');
    end;
    if (p_nls_test.nls is not null) then
      begin
        SELECT * INTO p_ac FROM accounts WHERE nls = p_nls;
        if (p_ac.kv = p_kv) then
          SELECT acc INTO l_acc  FROM accounts
           WHERE nls = p_nls AND kv = p_kv;
                 INSERT INTO bic_acc
                 (bic, acc, transit, their_acc)
                  VALUES
                 (p_bic, l_acc, p_transit, p_their_acc);
           else
          raise_application_error(-20000,'Не вірно обрана валюта ' || to_char(p_kv) || ' Вкаіжіть вірну валюту, яка відповідає рахунку ' || to_char(p_nls));
        end if;
      end;
    end if;
 ELSIF p_par=2 THEN
       DELETE FROM bic_acc
       WHERE bic = p_bic AND acc = p_acc;
 END IF;
END;
/
show err;

PROMPT *** Create  grants  P_EDIT_BICACC ***
grant EXECUTE                                                                on P_EDIT_BICACC   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_BICACC.sql =========*** End
PROMPT ===================================================================================== 
