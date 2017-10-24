

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_OPER_CHANGES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_CHANGES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_OPER_CHANGES ("REF", "REFL", "DEAL_TAG", "TT", "VOB", "ND", "PDAT", "VDAT", "DATD", "DATP", "DK", "MFOA", "NAM_A", "ID_A", "NLSA", "KV", "S", "SQ", "MFOB", "NAM_B", "ID_B", "NLSB", "KV2", "S2", "SQ2", "NAZN", "D_REC", "SK", "USERID", "SOS") AS 
  select
  -- ��������� � ��. ��������������
  ref,
  refl,
  deal_tag,
  tt,
  vob,
  nd,
  -- ����
  pdat,
  vdat,
  datd,
  datp,
  -- ������� �����/������
  dk,
  -- ��������� ������� �����������
  mfoa,
  nam_a,
  id_a,
  nlsa,
  kv,
  s,
  sq,
  -- ��������� ������� ����������
  mfob,
  nam_b,
  id_b,
  nlsb,
  kv2,
  s2,
  sq2,
  -- ���������� �������
  nazn,
  d_rec,
  -- ������ �����
  sk,
  -- id ������������, ����������� ��������
  userid,
  -- ��������� ���������
  sos
from bars.oper
where ref in (select ref from barsaq.tmp_dual_opldok)
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_OPER_CHANGES.sql =========*** End *
PROMPT ===================================================================================== 
