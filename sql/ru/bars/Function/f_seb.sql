
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_seb.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SEB (MODE_ int, id_ number, tag_ varchar2)
RETURN varchar2 IS
 sTmp_ varchar2(5); sRet_ varchar2(50); TAGu_ varchar2(15) := UPPER(trim(tag_));
begin
 begin
   If    MODE_ = 1 then /* выборка доп.рекв.клиента */
      SELECT substr(value,1,50)  into sRet_  FROM customerw
      WHERE rnk=id_ AND tag=TAGu_ and rownum=1;
   elsIf MODE_ = 2 then /* выборка макс даты модификации карточки кл */
      select to_char(max(CHGDATE),'YYYY-MM-DD')  into sRet_
      FROM  (select CHGDATE from CUSTOMER_UPDATE where rnk=id_
/* union all select CHGDATE from CUSTOMERW_U     where rnk=id_  */
             );
   elsIf MODE_ = 3 then /* выборка доп.рекв.СЧЕТА */
      SELECT substr(value,1,50)  into sRet_  FROM ACCOUNTSW
      WHERE ACC=id_ AND tag=TAGu_ and rownum=1;
   elsIf MODE_ = 4 then /* код гос для операции */
      sTmp_:=substr('000'||f_dop(id_,'KOD_G'),-3);
      If sTmp_ is not null then
         select A2 into sRet_ from KL_K040 WHERE sTmp_ in (k040,kod_lit);
      end if;
   end if;
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;
 RETURN sRet_;
end f_SEB;
/
 show err;
 
PROMPT *** Create  grants  F_SEB ***
grant EXECUTE                                                                on F_SEB           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SEB           to RCC_DEAL;
grant EXECUTE                                                                on F_SEB           to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_SEB           to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_seb.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 