set define off;
update operlist
set funcname = q'|/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_ARCHIVE&accessCode=1&sPar=[PAR=>
:A(SEM=����,TYPE=D),
:B(SEM=��� ��������-�����-��,TYPE=N,REF=DPT_VIDD),
:C(SEM=��� ��������-�����-��,TYPE=�,REF=OUR_BRANCH)]
[PROC=>DPT_RPT_UTIL.SET_ARCHV_CD(:A,:B,:C)][EXEC=>BEFORE]
[CONDITIONS=> RPT_DT = nvl(DPT_RPT_UTIL.GET_FINISH_DT, RPT_DT)
              and VIDD_ID = nvl(DPT_RPT_UTIL.GET_VIDD_CD, VIDD_ID ) 
              and BRANCH = nvl(DPT_RPT_UTIL.GET_BRANCH_CD, BRANCH)]|'
where codeoper = 1843;
/
commit;
/
set define on;
