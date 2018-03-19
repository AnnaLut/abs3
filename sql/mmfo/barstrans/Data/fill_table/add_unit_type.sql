prompt Importing table TRANSPORT_UNIT_TYPE...
BEGIN
  EXECUTE IMMEDIATE 'Insert into BARSTRANS.TRANSPORT_UNIT_TYPE (ID,TRANSPORT_TYPE_CODE,TRANSPORT_TYPE_NAME,DIRECTION,PROCESSING_BLOCK,COMPRESSED,BASE64,CHECKSUM,INFORMATION_REQUEST) values (1,''BPK_PKG_CHANGES'',''�������� �������\���� �������� �� ������� 2625\����������� ����� 䳿'',1,null,1,1,1,2)';
  EXECUTE IMMEDIATE 'Insert into BARSTRANS.TRANSPORT_UNIT_TYPE (ID,TRANSPORT_TYPE_CODE,TRANSPORT_TYPE_NAME,DIRECTION,PROCESSING_BLOCK,COMPRESSED,BASE64,CHECKSUM,INFORMATION_REQUEST) values (2,''BPK_PKG_RECREATE_RESP'',''�������������� ��������� �� �����. ��� �������� ��� � ���� ���� - ��������, ����� �������� ������ ��������� ���������. �������� ����� �������������� ���������.'',1,null,2,2,2,1)';
  EXECUTE IMMEDIATE 'Insert into BARSTRANS.TRANSPORT_UNIT_TYPE (ID,TRANSPORT_TYPE_CODE,TRANSPORT_TYPE_NAME,DIRECTION,PROCESSING_BLOCK,COMPRESSED,BASE64,CHECKSUM,INFORMATION_REQUEST) values (3,''BPK_PKG_OPENCARD'',''������� �������� ������'',1,null,1,1,1,2)';
  EXECUTE IMMEDIATE 'Insert into BARSTRANS.TRANSPORT_UNIT_TYPE (ID,TRANSPORT_TYPE_CODE,TRANSPORT_TYPE_NAME,DIRECTION,PROCESSING_BLOCK,COMPRESSED,BASE64,CHECKSUM,INFORMATION_REQUEST) values (4,''BPK_PKG_OPENCARDKK'',''������� �������� ��'',1,null,1,1,1,2)';
  EXECUTE IMMEDIATE 'Insert into BARSTRANS.TRANSPORT_UNIT_TYPE (ID,TRANSPORT_TYPE_CODE,TRANSPORT_TYPE_NAME,DIRECTION,PROCESSING_BLOCK,COMPRESSED,BASE64,CHECKSUM,INFORMATION_REQUEST) values (5,''BPK_PKG_OPENCARDS'',''������� �������� ��������� ����� �������'',1,null,1,1,1,2)';
  EXECUTE IMMEDIATE 'Insert into BARSTRANS.TRANSPORT_UNIT_TYPE (ID,TRANSPORT_TYPE_CODE,TRANSPORT_TYPE_NAME,DIRECTION,PROCESSING_BLOCK,COMPRESSED,BASE64,CHECKSUM,INFORMATION_REQUEST) values (6,''BPK_PKG_OPENCARDM'',''������� �������� ������������ �������'',1,null,1,1,1,2)';
EXCEPTION
  WHEN OTHERS THEN 
    IF SQLCODE = -1 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;
/
prompt Done.
