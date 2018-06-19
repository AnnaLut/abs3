prompt ---------------------------------------------------------------
prompt 4. CREATE TABLE BARS.AGG_MONBALS9
prompt ---------------------------------------------------------------

exec bars.bpa.alter_policy_info( 'AGG_MONBALS9', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'AGG_MONBALS9', 'FILIAL', null, null, null, null );

begin EXECUTE IMMEDIATE ' CREATE TABLE BARS.AGG_MONBALS9 
(
  FDAT        DATE,
  KF          VARCHAR2(6 BYTE),
  ACC         INTEGER,
  RNK         INTEGER,
  OST         NUMBER(24),
  OSTQ        NUMBER(24),
  DOS         NUMBER(24),
  DOSQ        NUMBER(24),
  KOS         NUMBER(24),
  KOSQ        NUMBER(24),
  CRDOS       NUMBER(24),
  CRDOSQ      NUMBER(24),
  CRKOS       NUMBER(24),
  CRKOSQ      NUMBER(24),
  CUDOS       NUMBER(24),
  CUDOSQ      NUMBER(24),
  CUKOS       NUMBER(24),
  CUKOSQ      NUMBER(24),
  CALDT_ID    NUMBER(38),
  DOS9        NUMBER(24),
  DOSQ9       NUMBER(24),
  KOS9        NUMBER(24),
  KOSQ9       NUMBER(24),
  KV          INTEGER,
  YR_DOS      NUMBER,
  YR_DOS_UAH  NUMBER,
  YR_KOS      NUMBER,
  YR_KOS_UAH  NUMBER)
';
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
exec  bars.bpa.alter_policies('AGG_MONBALS9'); 
commit;
GRANT SELECT  ON BARS.AGG_MONBALS9 TO BARS_ACCESS_DEFROLE;
-----------------------------------------------------------
