
exec bc.home;

prompt     ���������� ������� ������� otc_ff7_history_acc

begin
    execute immediate 'ALTER TABLE BARS.OTC_FF7_HISTORY_ACC ADD R011 VARCHAR2(1)';
exception
    when others then null;
end;
/    

begin
    execute immediate 'ALTER TABLE BARS.OTC_FF7_HISTORY_ACC ADD S245 VARCHAR2(1)';
exception
    when others then null;
end;
/    

COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.R011 IS '�������� R011';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.S245 IS '�������� S245';


prompt     ���������� ������� ������� otc_ff8_history_acc

begin
    execute immediate 'ALTER TABLE BARS.OTC_FF8_HISTORY_ACC ADD R011 VARCHAR2(1)';
exception
    when others then null;
end;
/    

begin
    execute immediate 'ALTER TABLE BARS.OTC_FF8_HISTORY_ACC ADD S245 VARCHAR2(1)';
exception
    when others then null;
end;
/    

COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.R011 IS '�������� R011';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S245 IS '�������� S245';

