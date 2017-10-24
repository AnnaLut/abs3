PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_TO_BLOCK_VSO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_TO_BLOCK_VSO ***


BEGIN 
        execute immediate  
          'begin
	     bpa.alter_policy_info(''acc_to_block_vso'',''FILIAL'',null,null,null,null);
             bpa.alter_policy_info(''acc_to_block_vso'',''WHOLE'',null,null,null,null);
             null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_TO_BLOCK_VSO ***
begin 
  execute immediate '
	create table acc_to_block_vso (acc NUMBER(38))';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_TO_BLOCK_VSO.sql =========*** End ***
PROMPT ===================================================================================== 

