PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_TELLER_BOSS_ROLES.sql ======
PROMPT ===================================================================================== 

declare
l_TELLER_BOSS_ROLES  TELLER_BOSS_ROLES%rowtype;

procedure p_merge(p_TELLER_BOSS_ROLES TELLER_BOSS_ROLES%rowtype) 
as
Begin
   insert into TELLER_BOSS_ROLES
      values p_TELLER_BOSS_ROLES; 
 exception when dup_val_on_index then  
   update TELLER_BOSS_ROLES
      set row = p_TELLER_BOSS_ROLES
    where USERROLE = p_TELLER_BOSS_ROLES.USERROLE;
End;
Begin

l_TELLER_BOSS_ROLES.USERROLE :='RHO016';
l_TELLER_BOSS_ROLES.PRIORITY :=1;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RHO026';
l_TELLER_BOSS_ROLES.PRIORITY :=2;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RHO045';
l_TELLER_BOSS_ROLES.PRIORITY :=3;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RHO049';
l_TELLER_BOSS_ROLES.PRIORITY :=4;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RRU009';
l_TELLER_BOSS_ROLES.PRIORITY :=5;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RRU023';
l_TELLER_BOSS_ROLES.PRIORITY :=6;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RTVBV07';
l_TELLER_BOSS_ROLES.PRIORITY :=7;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RTVBV08';
l_TELLER_BOSS_ROLES.PRIORITY :=8;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RTVBV09';
l_TELLER_BOSS_ROLES.PRIORITY :=9;

 p_merge( l_TELLER_BOSS_ROLES);


l_TELLER_BOSS_ROLES.USERROLE :='RTVBV10';
l_TELLER_BOSS_ROLES.PRIORITY :=10;

 p_merge( l_TELLER_BOSS_ROLES);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_TELLER_BOSS_ROLES.sql ======
PROMPT ===================================================================================== 
