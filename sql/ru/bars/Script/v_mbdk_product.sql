--������� �������� ��� ��
declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute  immediate 
'CREATE FORCE VIEW BARS.V_MBDK_PRODUCT
(   VIDD,    NAME,    TIPD,    TIPP)
AS
    SELECT vidd,
           name,
           tipd,
           (CASE WHEN t.vidd IN (2700, 2701, 3660, 3661)
                 THEN 1
                 ELSE 2
            END) tipp
      FROM bars.cc_vidd t
     WHERE t.vidd IN (2700, 2701, 3660, 3661)';

  execute  immediate 'COMMENT ON TABLE BARS.V_MBDK_PRODUCT IS ''����: ���� ��������''';
  execute  immediate 'COMMENT ON COLUMN BARS.V_MBDK_PRODUCT.VIDD IS ''��� ���� ��������''';
  execute  immediate 'COMMENT ON COLUMN BARS.V_MBDK_PRODUCT.NAME IS ''��� ��������''';
  execute  immediate 'COMMENT ON COLUMN BARS.V_MBDK_PRODUCT.TIPD IS ''��� ���.: 1-���������, 2-���������''';
  execute  immediate 'COMMENT ON COLUMN BARS.V_MBDK_PRODUCT.TIPP IS ''��� ��������: 1-����� , 2-2700,3660 - ��''';

  begin
     execute  immediate 'GRANT SELECT ON BARS.V_MBDK_PRODUCT TO BARS_ACCESS_DEFROLE';
  exception  when others then null;
  end;

  begin
     execute  immediate 'GRANT SELECT ON BARS.V_MBDK_PRODUCT TO BARSREADER_ROLE';
  exception  when others then null;
  end;

  begin
     execute  immediate 'GRANT SELECT ON BARS.V_MBDK_PRODUCT TO BARSUPL, UPLD';
  exception  when others then null;
  end;

  dbms_output.put_line( 'VIEW V_MBDK_PRODUCT created.' );
exception
  when e_tab_exists 
  then dbms_output.put_line( 'VIEW V_MBDK_PRODUCT already exists.' );
end;
/