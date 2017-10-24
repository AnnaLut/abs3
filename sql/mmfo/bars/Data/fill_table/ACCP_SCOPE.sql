BEGIN INSERT INTO ACCP_SCOPE(id,text) VALUES (1,'“¬Ѕ¬ м. иЇва');
	EXCEPTION
    	WHEN DUP_VAL_ON_INDEX
        	THEN null;
END;
/

BEGIN INSERT INTO ACCP_SCOPE(id,text) VALUES (2,'“¬Ѕ¬  ињвськоњ област≥');
	EXCEPTION
    	WHEN DUP_VAL_ON_INDEX
        	THEN null;
END;
/

BEGIN INSERT INTO ACCP_SCOPE(id,text) VALUES (3,'“¬Ѕ¬ м. иЇва та област≥');
	EXCEPTION
    	WHEN DUP_VAL_ON_INDEX
        	THEN null;
END;
/

commit;   