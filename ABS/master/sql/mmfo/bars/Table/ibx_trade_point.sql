 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/table/ibx_trade_point.sql =========*** Run *
 PROMPT ===================================================================================== 

BEGIN
        execute immediate
          'begin
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''WHOLE'' , null, null, null, null);
               null;
           end;
          ';
END;
/

BEGIN
        execute immediate' 
  CREATE TABLE BARS.IBX_TRADE_POINT 
   (  "TRADE_POINT" VARCHAR2(20), 
  "MFO" VARCHAR2(6), 
  "NLS" VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "BRSDYND" 
';
exception when others then
  if sqlcode=-955 then null;else raise;end if; 
end;
/

Begin 
  execute immediate '  alter table BARS.IBX_TRADE_POINT add  "COMM" VARCHAR2(200)';
  exception when others then
    if sqlcode=-1430 then null;else raise;end if;
end;
/




COMMENT ON TABLE BARS.IBX_TRADE_POINT IS '������� ���������� ����� � ������ ���������� ��� ���';
COMMENT ON COLUMN BARS.IBX_TRADE_POINT.TRADE_POINT IS '��� ���������� TOMAS';
COMMENT ON COLUMN BARS.IBX_TRADE_POINT.MFO IS '��� �����';
COMMENT ON COLUMN BARS.IBX_TRADE_POINT.NLS IS '����� �������� ����� 1004';


PROMPT *** Create  grants  IBX_TRADE_POINT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on IBX_TRADE_POINT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IBX_TRADE_POINT to UPLD;
grant FLASHBACK,SELECT                                                       on IBX_TRADE_POINT to WR_REFREAD;

/ 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/table/ibx_trade_point.sql =========*** End *
 PROMPT ===================================================================================== 
/
