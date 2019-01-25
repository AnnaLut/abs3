PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_TELLER_EQUIPMENT_DICT.sql ==
PROMPT ===================================================================================== 

declare
l_TELLER_EQUIPMENT_DICT  TELLER_EQUIPMENT_DICT%rowtype;

procedure p_merge(p_TELLER_EQUIPMENT_DICT TELLER_EQUIPMENT_DICT%rowtype) 
as
Begin
   insert into TELLER_EQUIPMENT_DICT
      values p_TELLER_EQUIPMENT_DICT; 
 exception when dup_val_on_index then  
   update TELLER_EQUIPMENT_DICT
      set row = p_TELLER_EQUIPMENT_DICT
    where EQUIP_CODE = p_TELLER_EQUIPMENT_DICT.EQUIP_CODE;
End;
Begin

l_TELLER_EQUIPMENT_DICT.EQUIP_CODE :=10;
l_TELLER_EQUIPMENT_DICT.EQUIP_NAME :='GLORY RBG200';
l_TELLER_EQUIPMENT_DICT.EQUIP_LIMIT :=150000;
l_TELLER_EQUIPMENT_DICT.IS_BLOCKED :=0;
l_TELLER_EQUIPMENT_DICT.EQUIP_TYPE :='A';

 p_merge( l_TELLER_EQUIPMENT_DICT);


l_TELLER_EQUIPMENT_DICT.EQUIP_CODE :=20;
l_TELLER_EQUIPMENT_DICT.EQUIP_NAME :='Tempokassa';
l_TELLER_EQUIPMENT_DICT.EQUIP_LIMIT :=20000;
l_TELLER_EQUIPMENT_DICT.IS_BLOCKED :=0;
l_TELLER_EQUIPMENT_DICT.EQUIP_TYPE :='M';

 p_merge( l_TELLER_EQUIPMENT_DICT);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_TELLER_EQUIPMENT_DICT.sql ==
PROMPT ===================================================================================== 
