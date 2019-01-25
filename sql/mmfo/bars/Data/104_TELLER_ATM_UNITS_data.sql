PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_TELLER_ATM_UNITS.sql =======
PROMPT ===================================================================================== 

declare
l_TELLER_ATM_UNITS  TELLER_ATM_UNITS%rowtype;

procedure p_merge(p_TELLER_ATM_UNITS TELLER_ATM_UNITS%rowtype) 
as
Begin
   insert into TELLER_ATM_UNITS
      values p_TELLER_ATM_UNITS; 
 exception when dup_val_on_index then  
   update TELLER_ATM_UNITS
      set row = p_TELLER_ATM_UNITS
    where EQUIP_ID = p_TELLER_ATM_UNITS.EQUIP_ID
      and UNITNO = p_TELLER_ATM_UNITS.UNITNO;
End;
Begin

l_TELLER_ATM_UNITS.EQUIP_ID :=10;
l_TELLER_ATM_UNITS.UNITNO :='4056';
l_TELLER_ATM_UNITS.UNIT_TYPE :='Collect';

 p_merge( l_TELLER_ATM_UNITS);


l_TELLER_ATM_UNITS.EQUIP_ID :=10;
l_TELLER_ATM_UNITS.UNITNO :='4057';
l_TELLER_ATM_UNITS.UNIT_TYPE :='Collect';

 p_merge( l_TELLER_ATM_UNITS);


l_TELLER_ATM_UNITS.EQUIP_ID :=10;
l_TELLER_ATM_UNITS.UNITNO :='4058';
l_TELLER_ATM_UNITS.UNIT_TYPE :='Collect';

 p_merge( l_TELLER_ATM_UNITS);


l_TELLER_ATM_UNITS.EQUIP_ID :=10;
l_TELLER_ATM_UNITS.UNITNO :='4059';
l_TELLER_ATM_UNITS.UNIT_TYPE :='Collect';

 p_merge( l_TELLER_ATM_UNITS);


l_TELLER_ATM_UNITS.EQUIP_ID :=10;
l_TELLER_ATM_UNITS.UNITNO :='4060';
l_TELLER_ATM_UNITS.UNIT_TYPE :='Collect';

 p_merge( l_TELLER_ATM_UNITS);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_TELLER_ATM_UNITS.sql =======
PROMPT ===================================================================================== 
