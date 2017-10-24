

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_INTACCN_VNEB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_INTACCN_VNEB ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_INTACCN_VNEB 
  BEFORE INSERT OR UPDATE ON INT_ACCN
  FOR EACH ROW
declare
  NLSA_ char(1); NLSB_ char(1);  ERR_ varchar2(150);  NLS6_ varchar2(15);
BEGIN
  If :NEW.acra is not null and :NEW.acrb is not null then

     If inserting OR
        updating  and (   :NEW.acra <> nvl(:OLD.acra,0)
                       OR :NEW.acrb <> nvl(:OLD.acrb,0)   ) then
        begin
          select substr(a.nls,1,1), substr(b.nls,1,1) into NLSA_, NLSB_
          from accounts a, accounts b
          where a.acc=:NEW.acra and b.acc=:NEW.acrb;

          -- при ѕ≈–¬ќ… замене сч.ACRB на счет 9 кл - запомнить NLS 6 кл.
          If updating  and
             NLSB_='9' and :OLD.NLSB is null and :OLD.acrb is not null then
             select nls into :NEW.NLSB from accounts where acc=:OLD.acrb;
          end if;

          IF NLSA_='9' and NLSB_<>'9' OR NLSB_='9' and NLSA_<>'9' then
             select  'Ѕал. и ¬неб. сч в проц.карточке счета '||KV||'/'||NLS
             into ERR_ from accounts where acc=:NEW.acc;
             RAISE_APPLICATION_ERROR  (-20001, ERR_);
          END IF;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;
     end if;
  END IF;
END TBIU_intaccn_VNEB;




/
ALTER TRIGGER BARS.TBIU_INTACCN_VNEB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_INTACCN_VNEB.sql =========*** E
PROMPT ===================================================================================== 
