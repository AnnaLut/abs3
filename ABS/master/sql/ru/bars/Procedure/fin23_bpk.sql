

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FIN23_BPK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FIN23_BPK ***

  CREATE OR REPLACE PROCEDURE BARS.FIN23_BPK (l_2625        NUMBER,
                                            l_nd          w4_acc.nd%type,
                                            l_obs23       NUMBER,
                                            l_fin23   OUT NUMBER,
                                            l_kat23   OUT NUMBER,
                                            l_k23     OUT NUMBER)
AS
-- 27-08-2016 LSO Заявка COBUSUPABS-4435 є ще хоча б один договір клієнта із ненульовим залишком на 9129 – наслідувати клас і ВКР з такого договору.
-- 21-07-2016 LUDA Ограничено в CC_DEAL RNK
-- 18-07-2016 LUDA Вставила exception "Неможливо визначити показники"
-- 01/04/2016 LSO  vncr_ is not null
   rnk_    ACCOUNTS.RNK%TYPE;
   cus_    CUSTOMER.CUSTTYPE%TYPE;
   vncr_   VARCHAR2 (3);
   l_col   number;
procedure GET_FIN_BPK( p_rnk number , p_fin23 OUT number, p_vncrr out VARCHAR2)
  is
    pragma autonomous_transaction;
  begin
    SELECT MAX (fin23), MAX (bars_ow.get_nd_param(nd, 'VNCRR'))
      INTO p_fin23, p_vncrr
      from W4_ACC
    where  acc_9129 in (SELECT acc
                                         FROM accounts
                                         WHERE rnk = p_rnk AND dazs IS NULL and nbs = '9129' and ostc <> 0);
  end GET_FIN_BPK;

BEGIN
   --- визначимо рнк і тип клієнта
   SELECT c.rnk, c.custtype
     INTO rnk_, cus_
     FROM customer c, accounts a
    WHERE a.acc = l_2625 AND a.rnk = c.rnk;

   -- наявність активних операцій
  begin
   SELECT MAX (fin23), MAX (cck_app.get_nd_txt (nd, 'VNCRR'))
     INTO l_fin23, vncr_
     FROM cc_deal c
    WHERE rnk = rnk_ and nd IN (SELECT nd FROM nd_acc  WHERE acc IN (SELECT acc FROM accounts WHERE rnk = rnk_ AND dazs IS NULL));

    if l_fin23 is null THEN
       GET_FIN_BPK(rnk_, l_fin23, vncr_);
    end if;
  end;

   select count(1) into l_col from customerw where rnk=RNK_ and tag='VNCRR' and isp !=0;
   if l_col >= 1 then
      delete from customerw where rnk=RNK_ and tag='VNCRR';
   end if;


   IF NVL (l_fin23, 0) = 0
   THEN
      IF cus_ = 2
      THEN
         l_fin23 := 8;
         bars_ow.set_nd_param  (l_nd, 'VNCRR', 'ГГГ');
         kl.setCustomerElement (RNK_, 'VNCRR', 'ГГГ',  0);
      ELSE
         l_fin23 := 4;
         bars_ow.set_nd_param  (l_nd, 'VNCRR', 'Г');
         kl.setCustomerElement (RNK_, 'VNCRR', 'Г',    0);
      END IF;
   ELSE
           if vncr_ is not null then                     -- проставим внутрішній кредитний рейтинг
                bars_ow.set_nd_param  (l_nd, 'VNCRR', vncr_);
                kl.setCustomerElement (RNK_, 'VNCRR', vncr_,  0);
           end if;
   END IF;

   begin
      --визначимо категорію
      SELECT kat    INTO l_kat23  FROM FIN_OBS_KAT  WHERE obs = l_obs23 AND fin = l_fin23 AND cus = cus_;
      -- визначимо максимальний коефіцієнт покриття боргу
      SELECT k_max  INTO l_k23    FROM STAN_KAT23   WHERE kat = l_kat23;
   exception when NO_DATA_FOUND THEN
      raise_application_error(-(20000),'\ ' ||' Неможливо визначити показники FIN = '|| l_fin23 || '/Обс.= ' || l_obs23 || '/Тип.кл= ' || cus_ ,TRUE);
   end;
END;
/
show err;

PROMPT *** Create  grants  FIN23_BPK ***
grant EXECUTE                                                                on FIN23_BPK       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FIN23_BPK       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FIN23_BPK.sql =========*** End ***
PROMPT ===================================================================================== 
