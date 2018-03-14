BEGIN 
    begin
        bpa.alter_policy_info('BRANCH_ATTRIBUTE', 'FILIAL' , null, null, null, null);
        bpa.alter_policy_info('BRANCH_ATTRIBUTE', 'WHOLE' , null, null, null, null);

        bpa.alter_policies('BRANCH_ATTRIBUTE');
    end;
END; 
/
