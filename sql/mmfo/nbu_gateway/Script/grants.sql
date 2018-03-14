grant execute on nbu_service_utl to bars_access_defrole;
grant execute on nbu_data_service to bars_access_defrole;

grant select on nbu_gateway.core_person_uo to bars;
grant select on nbu_gateway.core_person_fo to bars;

grant execute on nbu_gateway.nbu_601_parse_xml to bars_access_defrole;
GRANT EXECUTE, DEBUG ON NBU_GATEWAY.NBU_601_PARSE_XML TO BARSTRANS;
GRANT EXECUTE, DEBUG ON NBU_GATEWAY.NBU_CORE_SERVICE TO BARSTRANS;
