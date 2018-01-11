
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_wcs_sync_params.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_WCS_SYNC_PARAMS as object
(
  type_id varchar2(100),

  -- параметри для типа синхронизации CABID - Синхронізація заявок ЦА
  bid_id number,

  -- конструктор
  constructor function t_wcs_sync_params(p_type_id in varchar2)
    return self as result,

  -- создание объекта типа CABID - Синхронізація заявок ЦА
  static function create_cabid(p_bid_id in number)
    return t_wcs_sync_params
);
/
CREATE OR REPLACE TYPE BODY BARS.T_WCS_SYNC_PARAMS as

  -- конструктор
  constructor function t_wcs_sync_params(p_type_id in varchar2) return self as result as
  begin
    self.type_id := p_type_id;
    return;
  end t_wcs_sync_params;

  -- создание объекта Комиссия периода для метода 0 - Нормальний
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
 