PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Procedure/REZ_SREZERV_OB22_UPD.sql ===*** Run *** ==
PROMPT ===================================================================================== 
PROMPT *** Create  procedure REZ_SREZERV_OB22_UPD ***

CREATE OR REPLACE PROCEDURE BARS.REZ_SREZERV_OB22_UPD (p_mode   INTEGER , p_NBS     CHAR    , p_OB22     VARCHAR2, p_S080   VARCHAR2, p_CUSTTYPE VARCHAR2,
                                                       p_KV     VARCHAR2, p_NBS_REZ CHAR    , p_OB22_REZ VARCHAR2, p_NBS_7F CHAR    , p_OB22_7F  VARCHAR2,
                                                       p_NBS_7R CHAR    , p_OB22_7R VARCHAR2, p_PR       NUMBER  , p_NAL    VARCHAR2, p_R013     NUMBER  ) IS

  s22        SREZERV_OB22%rowtype;
begin

  s22.nbs     := p_NBS    ; s22.ob22    := p_OB22   ; s22.s080     := p_S080    ; s22.custtype := p_CUSTTYPE;
  s22.kv      := p_KV     ; s22.nbs_rez := p_NBS_REZ; s22.ob22_rez := p_OB22_REZ; s22.nbs_7F   := p_NBS_7F  ; 
  s22.ob22_7F := p_OB22_7F; s22.nbs_7R  := p_NBS_7R ; s22.ob22_7R  := p_OB22_7R ; s22.pr       := p_PR      ;
  s22.nal     := p_NAL    ; s22.r013    := p_R013   ;

  If    p_mode=0 then  delete from SREZERV_OB22 
                       where NBS = s22.nbs and  OB22 = s22.ob22 and  S080 = s22.s080  and CUSTTYPE = s22.CUSTTYPE and 
                             kv  = s22.KV  and  PR   = s22.pr   and  NAL  = s22.nal;
  elsIf p_mode=1 then  insert into SREZERV_OB22 values s22;
  elsIf p_mode=2 then  update SREZERV_OB22 set   nbs     = s22.nbs    , ob22     = s22.ob22    ,  s080    = s22.s080  , CUSTTYPE = s22.custtype, KV     = s22.kv    , 
                                                 NBS_REZ = s22.nbs_rez, ob22_rez = s22.ob22_rez,  nbs_7F  = s22.nbs_7F, OB22_7F  = s22.ob22_7F , NBS_7R = s22.nbs_7R, 
                                                 OB22_7R = s22.ob22_7R, PR       =  s22.pr     ,  NAL     = s22.nal   , R013     = s22.r013
                       where  NBS = s22.nbs and  OB22    = s22.ob22    and  S080 = s22.s080  and CUSTTYPE = s22.CUSTTYPE and kv  = s22.KV  and   PR     = s22.pr   and  NAL  = s22.nal;
  end if;
end REZ_SREZERV_OB22_UPD;
/

PROMPT *** Create  grants  REZ_SREZERV_OB22_UPD ***
grant EXECUTE    on REZ_SREZERV_OB22_UPD          to BARS_ACCESS_DEFROLE;
grant EXECUTE    on REZ_SREZERV_OB22_UPD          to RCC_DEAL;
grant EXECUTE    on REZ_SREZERV_OB22_UPD          to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Procedure/REZ_SREZERV_OB22_UPD.sql ===*** End *** ==
PROMPT ===================================================================================== 
