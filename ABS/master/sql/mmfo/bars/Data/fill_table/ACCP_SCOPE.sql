BEGIN INSERT INTO ACCP_SCOPE(id,text) VALUES (1,'���� �.����');
	EXCEPTION
    	WHEN DUP_VAL_ON_INDEX
        	THEN null;
END;
/

BEGIN INSERT INTO ACCP_SCOPE(id,text) VALUES (2,'���� ������� ������');
	EXCEPTION
    	WHEN DUP_VAL_ON_INDEX
        	THEN null;
END;
/

BEGIN INSERT INTO ACCP_SCOPE(id,text) VALUES (3,'���� �.���� �� ������');
	EXCEPTION
    	WHEN DUP_VAL_ON_INDEX
        	THEN null;
END;
/

commit;   