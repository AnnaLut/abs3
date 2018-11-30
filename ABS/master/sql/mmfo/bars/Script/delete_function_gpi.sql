begin

delete 
 from operlist where NAME = 'GPI. Перегляд документів'
 and FUNCNAME like '%V_SW_GPI_STATUSES%';
end;
 
 /

commit;
/
