

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_OPER_CHANGES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_CHANGES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_OPER_CHANGES ("REF", "REFL", "DEAL_TAG", "TT", "VOB", "ND", "PDAT", "VDAT", "DATD", "DATP", "DK", "MFOA", "NAM_A", "ID_A", "NLSA", "KV", "S", "SQ", "MFOB", "NAM_B", "ID_B", "NLSB", "KV2", "S2", "SQ2", "NAZN", "D_REC", "SK", "USERID", "SOS") AS 
  select
  -- референсы и др. идентификаторы
  ref,
  refl,
  deal_tag,
  tt,
  vob,
  nd,
  -- даты
  pdat,
  vdat,
  datd,
  datp,
  -- признак дебет/кредит
  dk,
  -- реквизиты стороны отправителя
  mfoa,
  nam_a,
  id_a,
  nlsa,
  kv,
  s,
  sq,
  -- реквизиты стороны получателя
  mfob,
  nam_b,
  id_b,
  nlsb,
  kv2,
  s2,
  sq2,
  -- назначение платежа
  nazn,
  d_rec,
  -- символ кассы
  sk,
  -- id пользователя, породившего документ
  userid,
  -- состояние документа
  sos
from bars.oper
where ref in (select ref from barsaq.tmp_dual_opldok)
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_OPER_CHANGES.sql =========*** End *
PROMPT ===================================================================================== 
