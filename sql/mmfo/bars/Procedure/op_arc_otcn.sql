

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_ARC_OTCN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_ARC_OTCN ***

  CREATE OR REPLACE PROCEDURE BARS.OP_ARC_OTCN (mode_ in number) as
   datb_  date;
   datn_  date;
   dats_  date;
   datm_  date;
   dat1_  date;
   dat2_  date;
BEGIN
   tuda;

   datb_ := bankdate; -- поточна банк?вська дата
   datm_ := trunc(datb_, 'mm'); -- дата початку поточного м?с¤ц¤

   if datb_ between datm_ and datm_ + 9 then
      dat1_ := datm_;
      dat2_ := datm_ + 9;
  elsif datb_ between datm_ + 10 and datm_ + 19 then
      dat1_ := datm_ + 10;
      dat2_ := datm_ + 19;
   else
      dat1_ := datm_ + 20;
      dat2_ := last_day(datm_);
   end if;

   -- останн¤ банк?вська дата в зв?тному пер?од?
   datn_ := Dat_last (dat1_, dat2_);

   dats_ := trunc(sysdate);

   if datn_ = datb_ and trunc(dats_) > datb_ then
      bars.p_arc_otcn (datb_, mode_);
      commit;
   end if;
END;
/
show err;

PROMPT *** Create  grants  OP_ARC_OTCN ***
grant EXECUTE                                                                on OP_ARC_OTCN     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_ARC_OTCN     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_ARC_OTCN.sql =========*** End *
PROMPT ===================================================================================== 
