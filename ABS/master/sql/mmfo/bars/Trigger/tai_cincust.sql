

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CINCUST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CINCUST ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CINCUST 
  AFTER INSERT ON "BARS"."CIN_CUST"
  REFERENCING FOR EACH ROW
  begin
  insert into CIN_TAG_RNK (RNK, TAG, PR_A1, SK_A1  )
  select :new.rnk, t.tag, t.pr_a1, t.sk_a1
  from cin_tag t
  where not exists (select 1 from CIN_TAG_RNK where RNK= :new.rnk and TAG=t.tag)
  ;
end TAI_CINcust;



/
ALTER TRIGGER BARS.TAI_CINCUST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_CINCUST.sql =========*** End ***
PROMPT ===================================================================================== 
