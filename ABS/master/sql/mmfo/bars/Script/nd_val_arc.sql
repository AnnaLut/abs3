PROMPT *** ALTER_POLICY_INFO to ND_VAL_ARC ***

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''ND_VAL_ARC'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''ND_VAL_ARC'', ''WHOLE''  , null, null, null, null);
       end; 
         '; 
   BEGIN 
      execute immediate 'create table nd_val_arc as select * from nd_val where fdat < to_date(''01-01-2019'',''dd-mm-yyyy'')';
   exception when others then
      -- ORA-00955: name is already used by an existing object
      if SQLCODE = -00955 then null;   else raise; end if;
   end;
   execute immediate 'delete from ND_VAL where fdat < to_date(''01-01-2019'',''dd-mm-yyyy'')';
   commit;
END; 
/
