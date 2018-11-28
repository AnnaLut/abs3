PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARS/Table/ow_oic_atransfers_acc.sql ===== *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''ow_oic_atransfers_acc'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''ow_oic_atransfers_acc'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''ow_oic_atransfers_acc'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table ow_oic_atransfers_acc ***
begin 
   execute immediate '
   CREATE TABLE ow_oic_atransfers_acc  
   (
      nd              number(38) not null,
      acc_pk          number(38) not null,
      acc_fee         number(38)         ,
      acc_fee_overdue number(38)
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ow_oic_atransfers_acc ***
exec bpa.alter_policies('ow_oic_atransfers_acc');

COMMENT ON TABLE  BARS.ow_oic_atransfers_acc                 IS 'Віртуальний портфель договорів для обслуговування комісій по терміналам';
COMMENT ON COLUMN BARS.ow_oic_atransfers_acc.nd              IS 'Номер договору';
COMMENT ON COLUMN BARS.ow_oic_atransfers_acc.acc_pk          IS 'Транзитний рахунок обліку терміналу 2924/16';
COMMENT ON COLUMN BARS.ow_oic_atransfers_acc.acc_fee         IS 'Рахунок обліку нарахованої комісіі 3570/55';
COMMENT ON COLUMN BARS.ow_oic_atransfers_acc.acc_fee_overdue IS 'Рахунок обліку простроченої нарахованої комісіі 3570/56';

PROMPT *** Create  constraint pk_ow_oic_atransfers_acc ***
begin   
   execute immediate '
   alter table ow_oic_atransfers_acc add constraint pk_ow_oic_atransfers_acc primary key (ND)
   USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/

PROMPT *** Create constraint uk_ow_oic_atransfers_acc_pk ***
begin   
   execute immediate '
   alter table ow_oic_atransfers_acc add constraint uk_ow_oic_atransfers_acc_pk unique (ACC_PK)
   USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/

PROMPT *** Create  grants  ow_oic_atransfers_acc ***
grant SELECT, INSERT, UPDATE, DELETE on ow_oic_atransfers_acc to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/Table/ow_oic_atransfers_acc.sql ===== *** End ***
PROMPT ===================================================================================== 
