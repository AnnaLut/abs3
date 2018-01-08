CREATE OR REPLACE PROCEDURE p_set_pawn_acc_list
(
  deal_id IN NUMBER
) IS
  l_acc_list VARCHAR(4000);
  l_cc_deal_row cc_deal%rowtype;
  l_account_types string_list;

BEGIN
    l_cc_deal_row := cck_utl.read_cc_deal(deal_id);
   if (mbk.check_if_deal_belong_to_mbdk(l_cc_deal_row.vidd) = 'N') then
       l_account_types := string_list('SS ','CR9','ODB');
   else
       l_account_types := string_list('SS ','ODB','DEP','DEN');
   end if;

 BEGIN
      SELECT listagg(t.acc, ',') within GROUP(ORDER BY t.nd)
        INTO l_acc_list
        FROM nd_acc t,accounts t1,cc_deal d
       WHERE 1=1
       and t1.acc=t.acc
       and d.nd=t.nd
       and t1.dazs is null
       and t1.tip member of l_account_types
       and( d.nd =deal_id or d.ndg=deal_id );
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
  pul.set_mas_ini('ACC_LIST', l_acc_list, NULL);

END p_set_pawn_acc_list;
/
