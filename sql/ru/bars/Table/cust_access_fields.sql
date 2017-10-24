BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cust_access_fields'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''cust_access_fields'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/



begin 
  execute immediate '
  CREATE TABLE cust_access_fields
 (  field_code varchar2(50),
    field_desc varchar2(200)
 )
 TABLESPACE brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



exec bpa.alter_policies('cust_access_fields');


COMMENT ON TABLE BARS.cust_access_fields IS 'Поля картки клієнта';
COMMENT ON COLUMN BARS.cust_access_fields.field_code IS 'Код';
COMMENT ON COLUMN BARS.cust_access_fields.field_desc IS 'Назва';


begin   
 execute immediate ' alter table bars.cust_access_fields add constraint xpk_cust_access_fields primary key (field_code) using index tablespace brsmdli  enable';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


grant DELETE,INSERT,SELECT,UPDATE                                            on cust_access_fields        to BARS_ACCESS_DEFROLE;
