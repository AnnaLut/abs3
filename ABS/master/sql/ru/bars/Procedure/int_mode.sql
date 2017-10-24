

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INT_MODE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INT_MODE ***

  CREATE OR REPLACE PROCEDURE BARS.INT_MODE 
( p_acc   IN int_accn.acc%type,
  p_id    IN int_accn.id%type,
  ------
  p_DAT0 OUT int_accn.ACR_DAT%type, -- Дата-0, по которую %% уже начислены
  p_OST0 OUT number,                -- Тек.Остаток на счете начисленных %%
  ------
  p_DAT1 OUT date  ,  -- Дата-1, "Предыдущий" день (от Дата-2 =дня условного изм.остатка)
  p_DOS1 OUT number,  -- План.доначисления %% по "Предыдущий" день Дата-1 включительно
  p_OST1 OUT number,  -- План.Остаток на счете начисленных %% за "Предыдущий" день Дата-1
  ------
  p_DAT2  IN date  ,  -- Дата-2, "Текущая" - для планового погашения
  p_S     IN number,  -- План: Погасить - , Выдать (+) в Дату-2
  p_DOS2 OUT number,  -- План.доначисления %% по "Текущую" Дату-2 включительно
  p_OST2 OUT number,  -- План.Остаток на счете начисленных %% за Дату-2
  ------
  p_DAT3  IN date  ,  -- Дата-3, контрольная дата, напр.Последняя календарная Дата месяца
  p_DOS3 OUT number,  -- План.доначисления %% по Дату-3
  p_OST3 OUT number   -- План.Остаток на счете начисленных %% за Дату-3
  )  is

  k_ number;  int_ number; ost_ accounts.ostc%type;
BEGIN
/*
 10.06.2011 Сухова Считалка %
 ...SQL\ETALON\PROCEDURE\int_mode.prc

Использую в ...Bin\Bars010.apd (Окно Form Window: HLP),
 кот вызывается из любого просмотра счетов

Можно использовать в др.приложениях

*/

  if mod(p_id,2) = 0 then k_ := -0.01; else  k_ := 0.01 ; end if;

  begin
    select k_* a.ostc, i.acr_dat, n.ostc + p_S*(1/K_)
    into p_OST0, p_DAT0, ost_
    from int_accn i, accounts a, accounts n
    where i.acc = p_acc
      and i.id  = p_id
      and a.acc = i.acra
      and n.acc = i.acc ;
  exception when NO_DATA_FOUND then   raise_application_error(  -20203,
     '\9356 - INT_MODE Не найден основной счет: Acc='|| p_acc ||' id=' || p_id,  TRUE);
  end;

-------------------------  (Дата-0 ... Дата-1]
-- по реальному остатку
  p_Dat1 := P_DAT2 - 1;

  If p_DAT0 < p_DAT1 then
     acrn.p_int
     (acc_=>p_acc, id_=>p_id, dt1_=>p_DAT0+1, dt2_=>p_dat1, int_=>int_, ost_=>NULL, mode_=>0);
  ElsIf p_DAT0 = p_DAT1 then
     int_:=0;
  else
     acrn.p_int
     (acc_=>p_acc, id_=>p_id, dt1_=>p_DAT1+1, dt2_=>p_dat0, int_=>int_, ost_=>NULL, mode_=>0);
     int_ := - int_;
  end if;
  p_DOS1 := (k_ * int_ );
  p_OST1 := p_ost0 + p_dos1;

----------------------- [ Дата-2] за 1 день
--по  измененному остатку за 1 день
  p_OST2 := p_OST1 + p_S;
  acrn.p_int
     (acc_=>p_acc, id_=>p_id, dt1_=>p_DAT2, dt2_=>p_dat2, int_=>int_, ost_=>ost_, mode_=>0);
  p_DOS2 := (k_ * int_ );
  p_OST2 := p_ost1 + p_dos2;

----------------------- ( Дата-2 ... Дата-3]
--  по  измененному остатку
  If p_DAT2 < p_DAT3 then
     acrn.p_int
     (acc_=>p_acc, id_=>p_id, dt1_=>p_DAT2+1, dt2_=>p_dat3, int_=>int_, ost_=>ost_, mode_=>0);
  ElsIf p_DAT2 = p_DAT3 then
     int_:=0;
  else
     acrn.p_int
     (acc_=>p_acc, id_=>p_id, dt1_=>p_DAT3+1, dt2_=>p_dat2, int_=>int_, ost_=>ost_, mode_=>0);
     int_ := - int_;
  end if;
  p_DOS3 := (k_ * int_ );
  p_OST3 := p_ost2 + p_dos3;
---------------------

end int_mode;
/
show err;

PROMPT *** Create  grants  INT_MODE ***
grant EXECUTE                                                                on INT_MODE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on INT_MODE        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INT_MODE.sql =========*** End *** 
PROMPT ===================================================================================== 
