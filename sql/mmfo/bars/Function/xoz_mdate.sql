create or replace FUNCTION XOZ_MDATE 
(
  p_acc   number,     
  p_fdat  date,
  p_nbs   varchar2,
  p_ob22  varchar2, 
  p_mdate date  ) return DATE  is

-- 14.06.2017 Sta Функцию вынесено из пакеджа XOZ для использования в триггере
--                Справочник XOZ_ob22_cl для определения даты погашения
   l_mdate DATE ;
   sp specparam%rowtype   ;

begin

  begin select  (p_fdat + x.KDX )  into l_mdate   from  XOZ_ob22_cl x where x.deb = p_nbs||p_ob22  and x.kdx > 0 ;    
  EXCEPTION WHEN NO_DATA_FOUND THEN 

     begin  select * into sp from specparam where acc = p_ACC;
            If sp.s180 = '3' then l_MDATE := p_FDAT +   7 ;            -- Вiд 0 до  7 дня
            ElsIf sp.s180 = '4' then l_MDATE := p_FDAT +  21 ;            -- Вiд 8 до 21 дня
            ElsIf sp.s180 = '5' then l_MDATE := p_FDAT +  30 ;            -- Вiд 22 до 31 дня
            ElsIf sp.s180 = '6' then l_MDATE := p_FDAT +  90 ;            -- Вiд 32 до 92 днiв
            ElsIf sp.s180 = '7' then l_MDATE := p_FDAT + 183 ;            -- Вiд 93 до 183 днiв
            ElsIf sp.s180 = 'A' then l_MDATE := p_FDAT + 274 ;            -- Вiд 184 до 274 днiв
            ElsIf sp.s180 = 'B' then l_MDATE := add_months(p_FDAT,  12);  -- Вiд 275 до 365(366) днiв
            ElsIf sp.s180 = 'C' then l_MDATE := add_months(p_FDAT,  18);  -- Від 366(367) до 548(549) днiв
            ElsIf sp.s180 = 'D' then l_MDATE := add_months(p_FDAT,  24);  -- Від 549(550) днів до 2 років
            ElsIf sp.s180 = 'E' then l_MDATE := add_months(p_FDAT,  36);  -- Більше 2 до 3 років
            ElsIf sp.s180 = 'F' then l_MDATE := add_months(p_FDAT,  60);  -- Більше 3 до 5 років
            ElsIf sp.s180 = 'G' then l_MDATE := add_months(p_FDAT, 120);  -- Більше 5 до 10 років
            ElsIf sp.s180 = 'H' then l_MDATE := add_months(p_FDAT,1200);  -- Понад 10 років
            end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end ; -- поиск в specparam
  end    ; -- поиск в xoz_ob22_cl

  l_mdate := NVL( l_mdate, p_mdate) ;


   RETURN l_mdate;
end XOZ_MDATE ;
/
show err;
