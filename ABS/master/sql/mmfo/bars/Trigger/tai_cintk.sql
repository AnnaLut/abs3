

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CINTK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CINTK ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CINTK 
  AFTER INSERT ON "BARS"."CIN_TK"
  REFERENCING FOR EACH ROW
  begin
  insert into CIN_TAG_tk (RNK,tk, TAG, PR_A1, SK_A1  )
  select :new.rnk, :new.id, t.tag, t.pr_a1, t.sk_a1
  from cin_tag_rnk t
  where rnk= :new.rnk
    and not exists (select 1 from CIN_TAG_tk where tk= :new.id and TAG=t.tag)
  ;
end TAI_CINTK;



/
ALTER TRIGGER BARS.TAI_CINTK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_CINTK.sql =========*** End *** =
PROMPT ===================================================================================== 
