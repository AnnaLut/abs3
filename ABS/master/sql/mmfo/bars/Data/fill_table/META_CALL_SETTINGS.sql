begin
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT)
 Values
   (6, ''CALL_FOREX'', ''FREE'', ''V_FX_SWAP[NSIFUNCTION][PROC=>forex.proc_swap(0, :nDealTag,:BASEY_A,:RATE_A,:BASEY_B,:RATE_B)][PAR=>:BASEY_A(SEM=���_���� �� ���-A,TYPE=N,REF=BASEY),:RATE_A(SEM=���_������ �� ���-A,TYPE=N),:BASEY_B(SEM=���_���� �� ���-B,TYPE=N,REF=BASEY),:RATE_B(SEM=���_������ �� ���-B,TYPE=N)][EXEC=>BEFORE][ACCESSCODE=>1]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;