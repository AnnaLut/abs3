

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/START_IRR1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure START_IRR1 ***

  CREATE OR REPLACE PROCEDURE BARS.START_IRR1 (p_mode int ) is

 irr_  number;
 acc8_ number; ir_ number;
 serr_ varchar2( 250);
 dat_  date;
 begin
 tuda;
  -- только ФЛ
 for d in (select * from cc_deal d where d.vidd in (11) and d.sos>=10 and d.sos<15  and d.wdate>gl.bd
 and not exists(select 1 from nd_acc n, accounts a where n.acc=a.acc and n.nd=d.nd and a.tip='SDI' and a.ostc<>0))
 loop

    begin
      -- остаток, вид ГПК, асс8
      select  a.acc into acc8_  from nd_acc n, accounts a
      where n.nd = d.nd  and n.acc = a.acc and a.tip='LIM'  and dazs is null;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      logger.info  ('START_IRR_NO реф='|| d.nd || ' не найден 8999');
      goto RecNext;
    end ;
    ----------------------------

    -- ном и эфф. ставки
    ir_  :=  acrn.fprocn(acc8_, 0,gl.bd);
    irr_ :=  acrn.fprocn(acc8_,-2,gl.bd);

    -- если вдруг нет єф.ставки- Расчет через новую функцию XIRR
    If not ( nvl(irr_,0) <=0 or irr_ < ir_   or abs(irr_-ir_)>5 ) then
       goto RecNext;
    end if;

        /*
   12/09/2012 Новиков + Сухова

   4. Банк расматривает необходимость разового скрипта который сможет расчитать эф. ставку по мигрированым договорам с даты последней перестройки ГПК в которых:
   - Еф. ставка не рассчитана,
   - Меньше номинальной
   - Еф. ставка Более 50%.
   Сумма берется из ГПК по дате
       */

      serr_:= null;

      select max(fdat) into dat_ from cc_lim
      where nd = d.nd and fdat <= gl.bd  and sumo = 0    and lim2 > 0 ;

      If dat_ is null then serr_ := 'Не могу определить дату начала по ГПК';
      else
         start_irr0 (p_nd =>d.nd,  p_dat =>dat_,  p_ir=>ir_,  s_err=> serr_);
      end if;

      if serr_ is not null then
         logger.info
           ('START_IRR_NO реф='|| d.nd || ' '|| to_char(dat_,'dd.mm.yyyy') ||' '|| serr_);
      end if;

    <<RecNext>> null;

  end loop;

end start_irr1 ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/START_IRR1.sql =========*** End **
PROMPT ===================================================================================== 
