CREATE OR REPLACE FORCE VIEW BARS.FX_DREC
(
   DEAL_TAG,
   DAT,
   KVA,
   ISOA,
   NAMVA,
   DATA,
   SUMA,
   KVB,
   ISOB,
   NAMVB,
   DATB,
   SUMB,
   BICB,
   SBICA,
   SACCA,
   BICKB,
   SSLB,
   DFB56A,
   DFB57A
)
AS
   SELECT f.deal_tag,
          f.dat,
          f.kva,
          ta.lcv,
          ta.name,
          f.dat_a,
          f.suma,
          f.kvb,
          tb.lcv,
          tb.name,
          f.dat_b,
          f.sumb,
          f.bicb,
          f.swi_bic,
          f.swi_acc,
          f.swo_bic,
          f.swo_acc,
          f.interm_b,
          f.alt_partyb
     FROM fx_deal f, tabval ta, tabval tb
    WHERE   --  f.deal_tag = pul.Get_Mas_Ini_Val ('DEAL_TAG')
          --AND 
          f.kva = ta.kv
          AND f.kvb = tb.kv;

