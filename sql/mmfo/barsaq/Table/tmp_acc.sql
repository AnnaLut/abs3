

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_ACC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_ACC 
   (	ACC NUMBER, 
	BANK_ID VARCHAR2(11), 
	ACC_NUM VARCHAR2(15), 
	CUR_ID NUMBER(3,0), 
	DAPP DATE
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_ACC IS '��������� ������� ������';
COMMENT ON COLUMN BARSAQ.TMP_ACC.ACC IS 'Acc �����';
COMMENT ON COLUMN BARSAQ.TMP_ACC.BANK_ID IS '��� �����';
COMMENT ON COLUMN BARSAQ.TMP_ACC.ACC_NUM IS '����� �����';
COMMENT ON COLUMN BARSAQ.TMP_ACC.CUR_ID IS '��� ������';
COMMENT ON COLUMN BARSAQ.TMP_ACC.DAPP IS '���� ���������� ��������';



PROMPT *** Create  grants  TMP_ACC ***
grant SELECT                                                                 on TMP_ACC         to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
