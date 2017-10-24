CREATE OR REPLACE VIEW PFU.V_PFU_FILE_KVIT2_HISTORY AS
SELECT pf."ID",
          pf."ENVELOPE_REQUEST_ID",
          pf."CHECK_SUM",
          pf."CHECK_LINES_COUNT",
          pf."PAYMENT_DATE",
          pf."FILE_NUMBER",
          pf."FILE_NAME",
          pf."FILE_DATA",
          pf."STATE",
          (select pfs.state_name
             from pfu.pfu_file_state pfs
            where pfs.state = pf.state) "STATE_NAME",
          pf."CRT_DATE",
          pf."DATA_SIGN",
          pf."USERID",
          pf."PAY_DATE",
          pf."MATCH_DATE"
     FROM pfu.pfu_file pf
    WHERE pf.state = 'MATCH_SEND';
comment on table PFU.V_PFU_FILE_KVIT2_HISTORY is '������������� ��� ��������� ����� (����� ������) � �������� MATCH_SEND (���������� 2-�� ���������)';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.ID is 'ID ����� (������)';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.ENVELOPE_REQUEST_ID is 'ID ��������';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.CHECK_SUM is '���� ������ � �������';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.CHECK_LINES_COUNT is '�-�� ������ � �����';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.PAYMENT_DATE is '���� ������ ������';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.FILE_NUMBER is '���������� ����� ����� � �������';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.FILE_NAME is '��� ����� ������';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.FILE_DATA is '��� ������';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.STATE is '������ ����� (������)';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.DATA_SIGN is 'ϳ����';
comment on column PFU.V_PFU_FILE_KVIT2_HISTORY.USERID is 'ID �����������, ���� �������� 2-�� ���������';
