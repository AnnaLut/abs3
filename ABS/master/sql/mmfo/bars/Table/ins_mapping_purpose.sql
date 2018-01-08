

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_MAPPING_PURPOSE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_MAPPING_PURPOSE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_MAPPING_PURPOSE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_MAPPING_PURPOSE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_MAPPING_PURPOSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_MAPPING_PURPOSE 
   (    OKPO_IC VARCHAR2(400), 
    MASK VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



-- Add/modify columns 
begin
    execute immediate 'alter table INS_MAPPING_PURPOSE add ext_id number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table INS_MAPPING_PURPOSE add ext_code varchar2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/


begin
    execute immediate 'alter table ins_mapping_purpose add ewa_type_id varchar2(255)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/


PROMPT *** ALTER_POLICIES to INS_MAPPING_PURPOSE ***
 exec bpa.alter_policies('INS_MAPPING_PURPOSE');


COMMENT ON TABLE BARS.INS_MAPPING_PURPOSE IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.OKPO_IC IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.MASK IS '';



begin
  for i in (select *
              from user_constraints t
             where t.table_name = 'INS_MAPPING_PURPOSE')
  loop
    execute immediate 'alter table ' || i.table_name || ' drop constraint ' ||  i.constraint_name;
  end loop;
end;
/
begin
  for i in (select *
              from user_indexes t
             where t.table_name = 'INS_MAPPING_PURPOSE')
  loop
    execute immediate 'drop index ' ||  i.index_name;
  end loop;
end;
/

begin
    execute immediate 'create unique index I_MAP_PURP_OKPOIC_EXTID on INS_MAPPING_PURPOSE (EXT_ID, CASE  WHEN EXT_ID IS NULL THEN NULL ELSE OKPO_IC END)
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_MAPPING_PURPOSE.sql =========*** E
PROMPT ===================================================================================== 
