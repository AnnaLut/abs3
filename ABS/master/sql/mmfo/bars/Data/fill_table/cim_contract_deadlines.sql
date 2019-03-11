update cim_contract_deadlines 
set delete_date = null
where deadline = 90 and delete_date = to_date('29072016','DDMMYYYY');
/
commit;
