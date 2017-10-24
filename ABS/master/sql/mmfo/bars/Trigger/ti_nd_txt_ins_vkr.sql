

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ND_TXT_INS_VKR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ND_TXT_INS_VKR ***

  CREATE OR REPLACE TRIGGER BARS.TI_ND_TXT_INS_VKR 
after   insert ON BARS.ND_TXT
referencing NEW as new
for each row
  FOLLOWS TAIUD_ND_TXT_UPDATE
   WHEN (
new.tag = 'VNCRR'
      ) declare
  l_upd_nd_txt nd_txt_update.tag%type;
  l_vidd cc_deal.vidd%type;
  procedure set_nd(p_nd number, p_tag varchar2, p_txt varchar2)
  is
    pragma autonomous_transaction;
  begin

  begin
    select vidd into l_vidd from cc_deal where nd = p_nd;
    exception when no_data_found then return;
  end;

    if l_vidd in (1,2,3,11,12,13) then
    cck_app.Set_ND_TXT(p_nd,p_tag,p_txt);
    commit;
    else return;
    end if;
  end;
begin



 Begin
  select tag into l_upd_nd_txt from nd_txt_update where nd = :new.nd and tag = 'VNCRP' and rownum = 1;
   exception when no_data_found then
     set_nd(:new.nd,'VNCRP',:new.txt);
 end;

end;


/
ALTER TRIGGER BARS.TI_ND_TXT_INS_VKR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ND_TXT_INS_VKR.sql =========*** E
PROMPT ===================================================================================== 
