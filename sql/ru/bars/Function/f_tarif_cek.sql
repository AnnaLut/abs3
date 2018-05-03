CREATE OR REPLACE FUNCTION BARS.F_Tarif_CEK
                 ( z_cek_  VARCHAR2,     -- Наличие предвар.Заявки ('0'-Да)
                   kv_     INTEGER,      -- валюта операции
                   nls_    VARCHAR2,     -- бух.номер счета
                   s_      NUMERIC )     -- сумма операции
-----------------------------------------------------------------------------
--            Ф-я рассчета суммы комиссии за выдачу по ЧЕКУ
--
--   z_cek_ =  '0' - Наличие предварительной Заявки на выдачу налички
--   z_cek_ =  '1' - Без наличия Заявки
-----------------------------------------------------------------------------
RETURN NUMERIC IS
  kod_  integer;    -- код тарифа
  sk_   numeric;    -- расчетная сумма комиссии
  n_tp  number;     -- № ТП
BEGIN
                    --  Определяем № пакета n_tp:
  BEGIN
     SELECT to_number(w.VALUE)
     INTO   n_tp
     FROM   Accounts a, AccountsW w    -- ПАКЕТ есть
     WHERE  a.NLS=nls_  and a.KV=kv_
        and a.ACC = w.ACC
        and w.TAG='SHTAR'
        and nvl(w.VALUE,0)>0;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     n_tp := 0;                        -- ПАКЕТА нет
  END;



  IF n_tp >= 38  or  n_tp in (2.5, 2.9, 2.10, 2.11) then    ---  Пакеты  > 38 :
     -----------------------------------------------

     if trim(z_cek_)<>'0' then

        if     s_ <= 10000000 then  kod_ := 214;
        elsif  s_ <= 50000000 then  kod_ := 215;  -- БЕЗ заявки
        elsif  s_  > 50000000 then  kod_ := 216;
        end if;

     else

        if     s_ <= 10000000 then  kod_ :=  32;
        elsif  s_ <= 50000000 then  kod_ := 332;  -- С заявкой
        elsif  s_  > 50000000 then  kod_ := 432;
        end if;

     end if;
                                        -----------------------
                                        ---  Пакеты  < 38 :
                                        -----------------------


  ELSIF gl.amfo = '351823' and n_tp=0 then  -- ХАРЬКОВ, без пакета и n_tp < 38

        sk_:=F_TARIF_00C(32,kv_,nls_,s_); -- S < экв.10 тысEUR - 1%
        RETURN sk_;                       -- S > экв.10 тысEUR - 0.5%


  ELSIF gl.amfo = '337568' and trim(z_cek_)='0' then -- СУМЫ с заявкой и  n_tp < 38

     if     s_ <=  5000000 then  kod_ :=  32;
     elsif  s_ <= 10000000 then  kod_ := 332;
     elsif  s_ <= 15000000 then  kod_ := 432;
     elsif  s_ <= 20000000 then  kod_ := 532;
     elsif  s_ <= 25000000 then  kod_ := 632;
     elsif  s_  > 25000000 then  kod_ := 732;
     end if;

  ELSE                                 ---  Пакеты < 38 и без пакета:
                                       ------------------------------
     if trim(z_cek_)<>'0' then

        if     s_ <=  5000000 then  kod_ := 214;
        elsif  s_ <= 25000000 then  kod_ := 215;  -- БЕЗ заявки
        elsif  s_  > 25000000 then  kod_ := 216;
        end if;

     else

        if     s_ <=  5000000 then  kod_ :=  32;
        elsif  s_ <= 25000000 then  kod_ := 332;  -- С заявкой
        elsif  s_  > 25000000 then  kod_ := 432;
        end if;

     end if;

  END IF;


  sk_:=F_TARIF(kod_,kv_,nls_,s_);

  RETURN sk_;

END F_Tarif_CEK ;
/

