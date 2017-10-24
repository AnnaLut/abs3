

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_NBU49 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_NBU49 
  after update of ostc
  on BARS.ACCOUNTS
  for each row
   WHEN (   (    old.NBS in ('2600','2650')
             or (old.NBS='2604' and old.OB22 in (1,3,5))
             or (old.NBS like '25__' and
                old.NBS not in ('2560','2565','2568','2570','2571','2572'))
           )
           and old.ostc > new.ostc
       ) declare
  oo oper%rowtype;
  ost_ number    ; -- Допустимый рессурс
  s_   number    ; -- сумма операции
  nTmp_ int      ;
begin

  S_ := :old.ostc - :new.ostc ; -- сумма операции


--- Исключаем из контроля "НАФТОГАЗ"  OKПO='20077720':

  Begin
     select 1 into nTmp_
     from   Customer
     where  rnk = :old.rnk and OKPO in ('20077720');
     RETURN ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  End;

--- Исключаем из контроля МППЗТ:

  If gl.amfo = '300465' and :old.NMS like '%МППЗТ%'  then
     RETURN ;
  End If;


  begin

     Select * into oo from oper  where ref = gl.Aref;
     If oo.mfoa = gl.amfo and oo.mfob like '8%'   OR
        oo.sk in (40,50,59)           then

        RETURN ; -- Все ОК. - бизнес логика от Шарадова:

        /* Согласно постановлению HE предусматриваются ограничения для:
           1. Платежi до бюджету, соцiальних фондiв – код банка-получателя
              начинается на 8.
           2. Виплата заробiтної плати, пенсiй, стипендiй, соцiальних виплат,
              вiдряджень:
              а)  виплати заробiтної плати, стипендiй.    СКП=40
              б)  виплати пенсiй, соцiальних виплат       СКП=50,59
        */

     end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RETURN; -- Этого не д.б. - пусть разбирается Миша в GL.
  End;


  If gl.amfo = '300120' then  ost_ := :old.ostc            ; -- "Пертоком." - не учитываем lim
  else
     if :old.lim > 0  then    ost_ := :old.ostc + :old.lim ; -- Учитываем Лимита ОВР (lim > 0)
     else                     ost_ := :old.ostc            ; -- НЕснижаемый остаток (lim < 0) не учитываем.
     end if;
  end if;


  If  :old.dapp = gl.bdate then
      ost_ := ost_ - :old.kos + :old.dos;
      s_   := s_   + :old.DOS ;
  end if;  -- вх.остаток  c учетом лимита ОВР и блок сумм

  If ost_ - s_ >= 0 then
     RETURN; -- 2) Все ОК. Уложились во вх.остаток, т.е. в постанову 49
  end if;


  -- Проверим доп реквизит, который на усмотрение пользователя, разрешает  нарушать 49.
  -- Например, М.б. это безнальная з/п
  begin
     Select 1 into s_ from operw  where ref = gl.Aref and tag ='NBU49' ;
     RETURN;  -- 3) на усмотрение пользователя
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;


-- Проверим:  может это 'BAK'-операция ?
  begin
     Select 1 into s_ from opldok where ref = gl.Aref and dk=0 and tt='BAK' and acc =:old.acc  and rownum=1 ;
     RETURN;  -- 4)  это 'BAK'-операция сегодняшних поступлений
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;


-- Нарушено постановление НБУ №49 от 06.02.2014 (сч.деб.:%s, реф.док.:%s)
-- raise_application_error(-20203, 'Порушено постанову НБУ №49 вiд 06.02.2014 (рах.деб.:' || :old.nls || ', реф.док.:' || gl.Aref || ')');*/
  bars_error.raise_nerror('BRS', 'BROKEN_ACT_NBU49', :old.nls, gl.Aref);


end tau_accounts_NBU49;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_NBU49 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 
