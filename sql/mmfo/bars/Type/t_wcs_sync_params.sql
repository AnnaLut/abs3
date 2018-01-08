
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_wcs_sync_params.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_WCS_SYNC_PARAMS as object
(
  type_id varchar2(100),

  -- ��������� ��� ���� ������������� CABID - ������������ ������ ��
  bid_id number,

  -- �����������
  constructor function t_wcs_sync_params(p_type_id in varchar2)
    return self as result,

  -- �������� ������� ���� CABID - ������������ ������ ��
  static function create_cabid(p_bid_id in number)
    return t_wcs_sync_params
);
/
CREATE OR REPLACE TYPE BODY BARS.T_WCS_SYNC_PARAMS as

  -- �����������
  constructor function t_wcs_sync_params(p_type_id in varchar2) return self as result as
  begin
    self.type_id := p_type_id;
    return;
  end t_wcs_sync_params;

  -- �������� ������� �������� ������� ��� ������ 0 - ����������
  static function create_cabid(p_bid_id in number) return t_wcs_sync_params is
    l_params t_wcs_sync_params := t_wcs_sync_params('CABID');
  begin
    l_params.bid_id := p_bid_id;

    return l_params;
  end create_cabid;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_wcs_sync_params.sql =========*** End 
 PROMPT ===================================================================================== 
 