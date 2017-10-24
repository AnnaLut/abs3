

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_FXDEAL_RNK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FXDEAL_RNK ***

  CREATE OR REPLACE TRIGGER BARS.TBI_FXDEAL_RNK before INSERT  ON BARS.FX_DEAL FOR EACH ROW
DECLARE   kodb_ fx_deal.kodb%type;   kvb_  fx_deal.kvb%type ;   RNK_  fx_deal.rnk%type ;
BEGIN     kodb_ := :new.kodb     ;   kvb_  := :new.kvb;
   IF :new.rnk  is     null and   kvb_  is not null and kodb_ is not null THEN
      begin
        select b.rnk into rnk_        from custbank b, customer c, banks a
        where  b.rnk  = c.rnk and nvl(b.mfo,' ') <> gl.amfo and c.DATE_OFF is null and  b.mfo = a.mfo and a.blk =0
          and  kodb_  = decode( kvb_, 980, b.mfo, b.bic)          and rownum = 1 ;
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
        begin
           select b.rnk into rnk_     from custbank b, customer c
           where  b.rnk  = c.rnk and nvl(b.mfo,' ') <> gl.amfo and c.DATE_OFF is null
             and  kodb_  = decode( kvb_, 980, b.mfo, b.bic)       and  rownum = 1 ;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
           begin
              select  b.rnk into rnk_  from custbank b, customer c
              where b.rnk  = c.rnk and nvl(b.mfo,' ') <> gl.amfo and kodb_ = decode( kvb_,980, b.mfo, b.bic) and rownum = 1 ;
           EXCEPTION WHEN NO_DATA_FOUND THEN null;
           end;
        end;
     end;
     :new.rnk := rnk_;
   end if;
END tbi_fxdeal_rnk;


/
ALTER TRIGGER BARS.TBI_FXDEAL_RNK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_FXDEAL_RNK.sql =========*** End 
PROMPT ===================================================================================== 
