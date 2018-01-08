-- ======================================================================================
-- Module : 
-- Author : BAA
-- Date   : 15.08.2017
-- ======================================================================================
-- create view V_FDAT_KF
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET LINES        200
SET PAGES        200

prompt -- ======================================================
prompt -- create view V_FDAT_KF
prompt -- ======================================================

create or replace view V_FDAT_KF
( KF
, CLOSSED
) as
select MV_KF.KF
     , nvl2( FDAT_KF.KF, 1, 0 ) as CLOSSED
  from MV_KF
  left outer
  join FDAT_KF
    on ( FDAT_KF.KF = MV_KF.KF )
;

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  V_FDAT_KF         IS 'Доступ на вхід в попередню банківську дату';

COMMENT ON COLUMN V_FDAT_KF.KF      IS 'Код філіалу (МФО)';
COMMENT ON COLUMN V_FDAT_KF.CLOSSED IS 'Доступ закритий (1-Так/0-Ні)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON V_FDAT_KF TO BARS_ACCESS_DEFROLE;

begin
  bpa.alter_policy_info( 'V_FDAT_KF', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'V_FDAT_KF', 'FILIAL',  'M',  'M',  'M',  'M' );
  bpa.alter_policy_info( 'V_FDAT_KF', 'WHOLE', null, null, null, null );
end;
/

commit;

begin
  bpa.alter_policies( 'V_FDAT_KF' );
end;
/

commit;
