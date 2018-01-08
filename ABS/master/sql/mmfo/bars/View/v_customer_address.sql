

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_ADDRESS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_ADDRESS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_ADDRESS ("RNK", "TYPE_ID", "COUNTRY", "ZIP", "DOMAIN", "REGION", "LOCALITY", "ADDRESS", "TERRITORY_ID", "LOCALITY_TYPE", "STREET_TYPE", "STREET", "HOME_TYPE", "HOME", "HOMEPART_TYPE", "HOMEPART", "ROOM_TYPE", "ROOM", "COMM") AS 
  SELECT ca.rnk,
          ca.type_id,
          ca.country,
          ca.zip,
          ca.domain,
          ca.region,
          ca.locality,
          ca.address,
          ca.territory_id,
          ca.locality_type,
          ca.street_type,
          ca.street,
          ca.home_type,
          ca.home,
          ca.homepart_type,
          ca.homepart,
          ca.room_type,
          ca.room,
          ca.comm
     FROM customer_address ca
   UNION ALL
   SELECT ca.rnk,
          ca.type_id,
          ca.country,
          ca.zip,
          ca.domain,
          ca.region,
          ca.locality,
          ca.address,
          ca.territory_id,
          ca.locality_type,
          ca.street_type,
          ca.street,
          ca.home_type,
          ca.home,
          ca.homepart_type,
          ca.homepart,
          ca.room_type,
          ca.room,
          ca.comm
     FROM clv_customer_address ca, clv_request q
    WHERE ca.rnk = q.rnk AND q.req_type IN (0, 2);

PROMPT *** Create  grants  V_CUSTOMER_ADDRESS ***
grant SELECT                                                                 on V_CUSTOMER_ADDRESS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_ADDRESS.sql =========*** End
PROMPT ===================================================================================== 
