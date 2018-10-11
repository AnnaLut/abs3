begin
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT)
 Values
   (6, ''CALL_FOREX'', ''FREE'', ''V_FX_SWAP[NSIFUNCTION][PROC=>forex.proc_swap(0, :nDealTag,:BASEY_A,:RATE_A,:BASEY_B,:RATE_B)][PAR=>:BASEY_A(SEM=Прц_база по вал-A,TYPE=N,REF=BASEY),:RATE_A(SEM=Прц_ставка по вал-A,TYPE=N),:BASEY_B(SEM=Прц_база по вал-B,TYPE=N,REF=BASEY),:RATE_B(SEM=Прц_ставка по вал-B,TYPE=N)][EXEC=>BEFORE][ACCESSCODE=>1]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

declare
  l_cnt number;
begin
    select nvl(max(id),0) + 1 into l_cnt from BARS.META_CALL_SETTINGS;
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT)
 Values
   ('||l_cnt||', ''V_CP_INT_DIVIDENTS'', ''FREE'', ''V_CP_INT_DIVIDENTS[NSIFUNCTION][PROC=>value_paper.make_int_dividends_prepare(:P_REF)][EXEC=>BEFORE][ACCESSCODE=>0][showDialogWindow=>false]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

declare
  l_cnt number;
begin
    select nvl(max(id),0) + 1 into l_cnt from BARS.META_CALL_SETTINGS;
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT)
 Values
   ('||l_cnt||', ''V_CP_PREPARE'', ''FREE'', ''V_CP_PREPARE[NSIFUNCTION][showDialogWindow=>false]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

declare
  l_cnt number;
begin
    select nvl(max(id),0) + 1 into l_cnt from BARS.META_CALL_SETTINGS;
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT)
 Values
   ('||l_cnt||', ''V_CP_PAY_DIVIDENTS'', ''FREE'', ''V_CP_PAY_DIVIDENTS[NSIFUNCTION][PROC=>value_paper.make_pay_dividends_prepare(:P_REF)][EXEC=>BEFORE][ACCESSCODE=>0][showDialogWindow=>false]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


COMMIT;