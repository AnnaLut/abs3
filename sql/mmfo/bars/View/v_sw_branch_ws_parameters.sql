create or replace view v_sw_branch_ws_parameters as
select "KF","BRANCH_NAME","URL","LOGIN","PASSWORD" from SW_BRANCH_WS_PARAMETERS;

grant SELECT                                                on v_sw_branch_ws_parameters    to BARS_ACCESS_DEFROLE;
