

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ND_TXT_VNCR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ND_TXT_VNCR ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ND_TXT_VNCR 
after insert or update ON BARS.ND_TXT
for each row
  FOLLOWS TAIUD_ND_TXT_UPDATE
 WHEN ( NEW.TAG = 'VNCRR' AND NEW.TXT IS NOT NULL) declare
  procedure SET_VNCRP( p_nd number, p_txt varchar2 )
  is
    pragma autonomous_transaction;
  begin
    begin
      insert into ND_TXT ( nd, tag, txt ) 
      values ( p_nd, 'VNCRP', p_txt );
      commit;
    exception
      when others then null;
    end;
  end SET_VNCRP;
  ---
begin
  --if :NEW.TAG = 'VNCRP' and :NEW.TXT IS NULL then
  SET_VNCRP( :new.nd, :new.txt );
 -- end if;
end TAIU_ND_TXT_VNCR;
/
ALTER TRIGGER BARS.TAIU_ND_TXT_VNCR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ND_TXT_VNCR.sql =========*** En
PROMPT ===================================================================================== 
