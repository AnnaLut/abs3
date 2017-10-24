

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VIP_RELATION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VIP_RELATION ***

  CREATE OR REPLACE PROCEDURE BARS.P_VIP_RELATION (p_rnk NUMBER, p_rel_rnk number)
IS
   l_rel_rnk          NUMBER;
   l_fiomanager       VARCHAR2 (100);
   l_phonemanager     VARCHAR2 (100);
   l_mailmanager      VARCHAR2 (100);
   l_accountmanager   NUMBER;
   l_mfo              VARCHAR2 (6):=sys_context('bars_context', 'user_mfo');
BEGIN
    
    
   begin
    select rnk  into l_rel_rnk from customer where rnk = p_rel_rnk and custtype = 3;
    EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
        --raise_application_error( -20445, 'Встановлення типу зв`язку заборонено, дозволяється приєднувати зареєстрованих клієнтів фіз. осіб', true );
        bars_error.raise_nerror('CAC', 'ERR_REL_FAMILY');
   end;
   
   BEGIN
      -- l_rel_rnk:= p_rel_rnk;
      SELECT v.fio_manager,
             V.PHONE_MANAGER,
             V.MAIL_MANAGER,
             V.ACCOUNT_MANAGER
        INTO l_fiomanager,
             l_phonemanager,
             l_mailmanager,
             l_accountmanager
        FROM  v_vip_deal v
       WHERE    /* l_rel_rnk NOT IN (SELECT rnk FROM v_vip_deal)
             AND*/ v.rnk = p_rnk;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN;
   END;

   BEGIN
      INSERT INTO customerw (RNK,
                             tag,
                             VALUE,
                             isp)
           VALUES (l_rel_rnk,
                   'RLVIP',
                   'Так',
                   0);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         UPDATE customerw
            SET VALUE = 'Так'
          WHERE rnk = l_rel_rnk AND tag = 'RLVIP';
   END;
   
 /*  BEGIN
    bars_audit.info('REL_INS');
      INSERT INTO customer_rel (RNK,
                               rel_id,
                               rel_rnk,
                               rel_intext)
           VALUES (l_rel_rnk,
                   60,
                   p_rnk,
                   1);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN null;
   end;*/
   
 

   begin
    insert into vip_flags(mfo, rnk, fio_manager, phone_manager, mail_manager, account_manager, datbeg, datend)
        values(l_mfo, l_rel_rnk,l_fiomanager, l_phonemanager, l_mailmanager, l_accountmanager, sysdate, sysdate);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
      update vip_flags
      set fio_manager=l_fiomanager, phone_manager=l_phonemanager, mail_manager=l_mailmanager, account_manager=l_accountmanager
      where mfo=l_mfo and rnk= l_rel_rnk;
   end;


END p_vip_relation;
/
show err;

PROMPT *** Create  grants  P_VIP_RELATION ***
grant EXECUTE                                                                on P_VIP_RELATION  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VIP_RELATION.sql =========*** En
PROMPT ===================================================================================== 
