update operlist set funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_LE_REPORT[EXCEL=>COUNT_5000]'
where name = 'Перелік зарезервованих номерів рахунків 2600, 2650';

commit;