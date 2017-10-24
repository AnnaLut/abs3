

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NLK_REF_WEB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NLK_REF_WEB ***

  CREATE OR REPLACE PROCEDURE BARS.NLK_REF_WEB (REF_ NUMBER, REFX_ NUMBER, ACC_ NUMBER, ID_ NUMBER)
is
c_ number:=0;
l_amount oper.s%type;
l_amounx oper.s%type;
l_ost oper.s%type;
begin
 If ID_ = 1
  THEN
   SELECT count(*)
     INTO c_
	 FROM nlk_ref nn
	WHERE ref1=REF_
	  and (ref2 is null  or exists (select 1 from oper where ref = nn.REF2 and sos < 0))
	  and acc =ACC_;
   IF c_= 0 THEN
     raise_application_error(-(20000+999),'Увага!!! Документ вже був оплачений або вилучений з картотеки, обновіть екрану форму ',TRUE);
   END IF;

 ELSif id_ = 3  then

   Select s into l_amounx from oper where ref = REF_;
   Select s into l_amount from oper where ref = REFX_;

  UPDATE nlk_ref
      SET amount=nvl(amount,l_amounx)-l_amount,
	      ref2 = case when amount-l_amount = 0 then  REFX_ else null end
	WHERE ref1=REF_
	  --and ref2 is null
	  and acc =ACC_
	   RETURNING amount INTO l_ost;
   IF SQL%ROWCOUNT=0 THEN
     raise_application_error(-(20000+999),'Увага!!! Документ вже був вилучений з картотеки, обновіть екрану форму ',TRUE);
   END IF;


	   if l_ost  < 0
	    then raise_application_error(-(20000+998),'Увага!!! Сума документа перевищила суму в картотеці.',TRUE);
	   end if;

    insert into nlk_ref_hist (ref1, ref2, acc, amount)
	    values (REF_, REFX_ , ACC_, l_amount);



 else
   UPDATE nlk_ref
      SET ref2=REFX_
	WHERE ref1=REF_
	  --and ref2 is null
	  and acc =ACC_;
   IF SQL%ROWCOUNT=0 THEN
     raise_application_error(-(20000+999),'Увага!!! Документ вже був вилучений з картотеки, обновіть екрану форму ',TRUE);
   END IF;
 END IF;

end NLK_REF_WEB;
/
show err;

PROMPT *** Create  grants  NLK_REF_WEB ***
grant EXECUTE                                                                on NLK_REF_WEB     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NLK_REF_WEB.sql =========*** End *
PROMPT ===================================================================================== 
