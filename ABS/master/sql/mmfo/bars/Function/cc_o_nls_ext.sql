 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_o_nls_ext.sql =========*** Run *
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE FUNCTION BARS.CC_O_NLS_EXT
  (bal_     in varchar2,  
   RNK_     in int,
   sour_    in int,
   ND_      in int,
   kv_      in int,
   tip_bal_ in varchar2,
   tip3_    in varchar2, -- Тип Искомого счета
   PROD_    in varchar2,
   TT_      in out varchar2
  )
RETURN number IS

 -- 08.06.2018 Sta  Уточнения от  Вікторія Семенова <viktoriia.semenova@unity-bars.com>

  ID_  int    := 0;   -- id проц карточки
  ACC_ number :=null ; -- возвращаем 
  a2 accounts%rowtype;
  kk cck_ob22%rowtype;
  a6 accounts%rowtype;

BEGIN

   TT_     := substr( rtrim( ltrim(nvl(TT_,'%%1'))),1,3);
   A2.TIP  := rtrim ( ltrim( tip_bal_));  -- тип базового счета  

   if tip3_ like 'SD_' then  
      ID_ := nvl(to_number(ltrim(substr(tip3_,3,1))) ,0);  
   end if;

   ---- 1
   IF tip3_   ='SN ' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.kv=kv_ and a.tip='SN ' and a.dazs is null );
   ELSIF tip3_='SK0' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.tip='SK0' and a.dazs is null);
   ELSIF tip3_='SN8' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='SN8' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9N' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9N' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9K' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9K' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ElsIf tip3_ like 'SD_' then    ------------------------Счета 6 кл====
      ----------------2
      Begin
         -- 3   ОБЩИЙ Счет доходов по пене
         IF ID_ = 2 and ( A2.tip in ('SP','SL','SPN','SLN','SK9','SN8') or A2.tip is null)  THEN
            select a.acc ,'%%1'   into A6.ACC, tt_   from accounts a where a.tip='SD8' and a.nbs='8006' and a.kv=KV_    and rownum=1;
         Else -- Остальное
            select substr(prod,1,4), substr(prod,5,2), branch   into  a2.NBS, a2.OB22, a2.Branch from cc_deal where nd = nd_;
            select * into kk from cck_ob22 where nbs = A2.NBS and ob22 = A2.OB22 ;
            A6.NBS := null ; A6.OB22:= Null ; A6.Branch := Substr( A2.branch, 1, 15 ); 

            -- 4 Счет доходов для комиссии многоразовой  (вызывается при открытии счета с типом SK0),  в т.ч Для гарантий которые введены в Ощадбанке в КП
            IF ID_ = 2 and bal_ = '8999' and cck_ui.check_product_6353(prod_) = 0   THEN
               If A2.NBS like '9%' then   A6.NBS  := '6518'    ;
               else                       A6.NBS  := '6511'    ;
               end If ;                   A6.Ob22 := kk.SD_SK0 ;

            ELSIF ID_ = 0 and A2.tip in ('SL','S9N','S9K')                          THEN A6.NBS := '8990' ; A6.ob22 := '00'       ;  --- Счет доходов для сомнительных(внебаланс)
            ELSIF ID_ = 0 and (substr(bal_,1,1) = '9' or A2.tip = 'CR9')            THEN A6.NBS := '6518' ; A6.ob22 := kk.SD_9129 ;  --- Счет доходов для ком 9129
            ELSIF ID_ = 4                                                           THEN A6.NBS := '6510' ; A6.ob22 := kk.SD_SK4  ;  --- Дострокове погашення
            Else   ---------------------------------------------------------------------------------------------------------- ПРОЦЕНТНЫЕ/амортизац.доходы
               Select  nbs6 into A6.NBS from NBS_SS_SD where nbs2 = a2.NBS;
               ------------------------------------------------------------------------------------------
               If    KV_ = gl.baseval and ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_M ;   --Дисконт грн
               ElsIf                    ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_J ;   --Дисконт вал
               ElsIf KV_ = gl.baseval                                                 THEN A6.OB22 := kk.SD_N ;   --нач.проц грн
               Else                                                                      A6.OB22 := kk.SD_I ;   --нач.проц вал
               end if ;

            End if ; --4 Счет доходов для комиссии многоразовой  (вызывается при открытии счета с типом SK0),  в т.ч Для гарантий которые введены в Ощадбанке в КП

         end if;  -- 3   ОБЩИЙ Счет доходов по пене
                     if  A6.ACC is null then
							--begin
								 select a.acc into ACC_
									 from accounts a
									 where a.nls = NBS_OB22_BRA ( A6.NBS, A6.OB22, a6.BRANCH );
							--exception when no_data_found then null;end;
					else
							ACC_ := A6.ACC;   --COBUMMFO-8054
					end if;
	 --exception when no_data_found then null;
      end;  ---2

   end if;  -- 1    ---tip3_   ='SN '

   RETURN ACC_;
   
    exception
	  when no_data_found then
         bars_audit.error('<br/><b>cc_o_nls_ext. '||'Не вдалося знайти acc для nbs = '||A6.NBS||' ,ob22 ='||A6.OB22||' ,branch ='
				 ||a6.BRANCH||' nbs = '||a2.nbs||', ob22 = '||a2.ob22||chr(10)||'</b><br/>'||sqlerrm||chr(10) || dbms_utility.format_error_stack());
		RETURN ACC_;
    when others then
         bars_audit.error('<br/><b>cc_o_nls_ext. '||'Помилка в cc_o_nls_ext. nbs = '||A6.NBS||' ,ob22 ='||A6.OB22||' ,branch ='
				 ||a6.BRANCH||' nbs = '||a2.nbs||', ob22 = '||a2.ob22||chr(10)||'</b><br/>'||sqlerrm||chr(10) || dbms_utility.format_error_stack());
	    RETURN ACC_;

END CC_O_NLS_EXT;
/
show err ;

PROMPT *** Create  grants  CC_O_NLS_EXT ***
grant EXECUTE                                                                on CC_O_NLS_EXT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_O_NLS_EXT    to RCC_DEAL;

 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_o_nls_ext.sql =========*** End *
 PROMPT ===================================================================================== 
 