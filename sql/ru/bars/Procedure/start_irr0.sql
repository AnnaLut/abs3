

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/START_IRR0.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure START_IRR0 ***

  CREATE OR REPLACE PROCEDURE BARS.START_IRR0 
(p_nd cc_deal.nd%type,  --реф КД
 p_dat  date         , -- дата начала
 p_ir   number ,
 s_err out varchar2
 ) is

 s_ number; irr0_ number; acc8_ number;
 irr_old  number;
begin

   s_err := null;

   select nvl(sum(sumg),0), min(acc) into s_, acc8_ from cc_lim
   where nd=p_nd and fdat>p_dat;
   if s_ <=0 then
      s_err := 'нет остаточного потока от даты '|| to_char(p_dat,'dd.mm.yyyy');
      return;
   end if;
   ------------------------------
   irr_old :=  acrn.fprocn(acc8_,-2,gl.bd);

   delete from TMP_IRR;

   insert into TMP_IRR  (n,s)
   select 1 ,- s_ from dual   union all
   select (FDAT-p_dat) + 1, SUMO
   from cc_lim where nd = p_ND and sumo > 0 and FDAT>p_dat;

   begin
     irr0_ := round(  XIRR( nvl(p_ir,15)/100 ) * 100,4);
   exception when others then irr0_ := 0;
   end;

   If irr0_ <= 0 then
       s_Err := 'Не могу расчитать XIRR';
       return;
   end if;

   --Создать карточку для IRR
   delete from int_ratn  where acc = ACC8_ and id = -2 and bdat >= p_dat;

   begin
     insert into int_accn (ACC  ,ID, METR, BASEY, FREQ, acr_dat )
                   values (ACC8_,-2, 0   ,     0,    1, p_dat-1 );
   exception when dup_val_on_index then  null;
   end;

   Insert into int_ratn(acc,bDAT,id,ir) values (ACC8_,p_dat,-2,Irr0_);

   delete from cc_many where nd=p_nd and fdat >=p_dat;

   Insert into CC_many   (ND, FDAT, SS1, SDP, SS2, SN2)
   select p_ND, p_dat, S_/100, 0, 0, 0       from dual
   union all
   select p_ND, fdat, 0, 0, sumg/100, (sumo - sumg)/100
   FROM cc_LIM  where nd = p_ND   and fdat > p_dat;

   logger.info
          ('START_IRR_YES реф='   || p_nd
            || ' dat='    || to_char(p_dat,'dd.mm.yyyy')
            || ' Irr_New='|| Irr0_
            || ' ir_nom=' || p_ir
            || ' Irr_Old='|| Irr_old
            ) ;

end start_irr0 ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/START_IRR0.sql =========*** End **
PROMPT ===================================================================================== 
