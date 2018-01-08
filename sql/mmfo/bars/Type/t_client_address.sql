
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_client_address.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_CLIENT_ADDRESS AS OBJECT
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
                    )
/

 show err;
 
PROMPT *** Create  grants  T_CLIENT_ADDRESS ***
grant EXECUTE                                                                on T_CLIENT_ADDRESS to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_client_address.sql =========*** End *
 PROMPT ===================================================================================== 
 