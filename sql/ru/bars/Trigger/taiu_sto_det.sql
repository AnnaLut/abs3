

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_STO_DET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_STO_DET ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_STO_DET 
after insert or update on sto_det
for each row
 WHEN (
new.freq <> nvl(old.freq,              0) or
       new.wend <> nvl(old.wend,              0) or
       new.dat1 <> nvl(old.dat1, trunc(sysdate)) or
       new.dat2 <> nvl(old.dat2, trunc(sysdate))
      ) begin
  STO_ALL.generate_stoschedules(p_stoid    => :new.idd,
                                p_stodat0  => :new.dat0,
                                p_stodat1  => :new.dat1,
                                p_stodat2  => :new.dat2,
                                p_stofreq  => :new.freq,
                                p_stowend  => :new.wend);
end;
/
ALTER TRIGGER BARS.TAIU_STO_DET ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_STO_DET.sql =========*** End **
PROMPT ===================================================================================== 
