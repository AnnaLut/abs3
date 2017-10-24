

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BR_CP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BR_CP ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BR_CP (p_id varchar2, p_branch varchar2)  is
  kaz_ob cp_kaz_ob%rowtype;
  kv_ cp_kod.kv%type;

                  PROCEDURE SPC_op (p_kv int, p_nbs char, p_branch VARCHAR2,  p_ob22 char ) IS
                      --  к открытию счета
                      l_nls accounts.nls%type ;
                      l_acc accounts.acc%type ;

                  BEGIN
                     begin
                       -- если есть, то ничего НЕ делать
                       select acc into l_acc  from accounts where kv  = p_kv  and nbs = p_nbs
                         and branch=p_branch    and ob22=p_ob22  and dazs is null
                         and rownum=1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN   gl.baseval := p_kv;
                       OP_BMASK( p_branch, p_nbs,p_ob22, null, null, null, l_nls, l_acc ) ;
                       update accounts      set tobo = p_branch where acc=l_ACC ;
                       update specparam_int set ob22 = p_OB22   where acc=l_ACC ;
                       if SQL%rowcount = 0 then
                          insert into specparam_int (acc, ob22) values (l_ACC,p_OB22);
                       end if;
                     end;
                  END;
                -----------------------

begin

   begin
    select NLS_98R,          NLS_29r,          NLS_98V,          NLS_28V,
           NLS_98K,          NLS_28K,          NLS_98N,          NLS_28N,          c.kv
    into   kaz_ob.NLS_98R,   kaz_ob.NLS_29r,   kaz_ob.NLS_98V,   kaz_ob.NLS_28V,
           kaz_ob.NLS_98K,   kaz_ob.NLS_28K,   kaz_ob.NLS_98N,   kaz_ob.NLS_28N,   kv_
    from  cp_kaz_ob k , cp_kod c
    where  k.id = p_id and k.id = c.id;
   exception when NO_DATA_FOUND THEN return;
   end;


  SPC_op   (980, '9820', p_branch, kaz_ob.NLS_98R );
  SPC_op   (980, '9819', p_branch, kaz_ob.NLS_98V );
  SPC_op   (980, '9812', p_branch, kaz_ob.NLS_98K );
  SPC_op   (980, '9812', p_branch, kaz_ob.NLS_98N );
 ---------------------
  SPC_op   (kv_, '2901', p_branch, kaz_ob.NLS_29r );
  SPC_op   (kv_, '2801', p_branch, kaz_ob.NLS_28V );
  SPC_op   (kv_, '2801', p_branch, kaz_ob.NLS_28K );
  SPC_op   (kv_, '2801', p_branch, kaz_ob.NLS_28N );
  ---------------------------------------
  gl.baseval := 980;

end OP_BR_CP ;
/
show err;

PROMPT *** Create  grants  OP_BR_CP ***
grant EXECUTE                                                                on OP_BR_CP        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BR_CP.sql =========*** End *** 
PROMPT ===================================================================================== 
