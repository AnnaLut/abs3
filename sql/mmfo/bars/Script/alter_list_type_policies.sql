begin
    execute immediate
    'begin
         bpa.alter_policy_info(''LIST_TYPE'', ''CENTER'' , null, null, null, null);
         bpa.alter_policy_info(''LIST_TYPE'', ''FILIAL'' , null, null, null, null);
         bpa.alter_policy_info(''LIST_TYPE'', ''WHOLE'' , null, null, null, null);

         bpa.alter_policies(''LIST_TYPE'');
    end;';
end;
/
