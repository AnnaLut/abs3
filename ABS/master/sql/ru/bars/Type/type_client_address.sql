
prompt -------------------------------------
prompt  создание типа T_CLIENT_ADDRESS
prompt -------------------------------------
/
begin
 execute immediate 'CREATE TYPE T_CLIENT_ADDRESS AS OBJECT
                    (   RNK             NUMBER (38),
                        TYPE_ID         NUMBER (38),
                        COUNTRY         NUMBER (3),
                        ZIP             VARCHAR2 (20 Byte),
                        DOMAIN          VARCHAR2 (30 Byte),
                        REGION          VARCHAR2 (30 Byte),
                        LOCALITY        VARCHAR2 (30 Byte),
                        ADDRESS         VARCHAR2 (100 Byte),
                        TERRITORY_ID    NUMBER (22),
                        LOCALITY_TYPE   NUMBER (22),
                        STREET_TYPE     NUMBER (22),
                        STREET          VARCHAR2 (100 Char),
                        HOME_TYPE       NUMBER (22),
                        HOME            VARCHAR2 (100 Char),
                        HOMEPART_TYPE   NUMBER (22),
                        HOMEPART        VARCHAR2 (100 Char),
                        ROOM_TYPE       NUMBER (22),
                        ROOM            VARCHAR2 (100 Char),
                        COMM            VARCHAR2 (4000 Byte)
                    )';
exception when others then if (sqlcode = -955) then null; else raise; end if;    
end;    
/                    

GRANT EXECUTE ON T_CLIENT_ADDRESS TO BARS_ACCESS_DEFROLE;
/