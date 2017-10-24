CREATE OR REPLACE PROCEDURE p_set_pawn_acc_list
(
  deal_id IN NUMBER 
) IS
  l_acc_list VARCHAR(4000);
BEGIN
  -- Для заданого ID угоди відбирає всі рахунки, прив*язані до неї

 BEGIN
    SELECT listagg(t.acc, ',') within GROUP(ORDER BY t.nd)
      INTO l_acc_list
      FROM nd_acc t,accounts t1
     WHERE 1=1
     and t1.acc=t.acc 
     and t1.dazs is null
     and t.nd = deal_id;
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  pul.set_mas_ini('ACC_LIST', l_acc_list, NULL);

eND p_set_pawn_acc_list;
/
