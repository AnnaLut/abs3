

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CUSTOMER_UPD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CUSTOMER_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CUSTOMER_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CUSTOMER_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CUSTOMER_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CUSTOMER_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CUSTOMER_UPD 
   (	RNK NUMBER, 
	MODIFY_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CUSTOMER_UPD ***
 exec bpa.alter_policies('CIM_CUSTOMER_UPD');


COMMENT ON TABLE BARS.CIM_CUSTOMER_UPD IS 'Оновлення даних про клієнта';
COMMENT ON COLUMN BARS.CIM_CUSTOMER_UPD.RNK IS 'RNK';
COMMENT ON COLUMN BARS.CIM_CUSTOMER_UPD.MODIFY_DATE IS 'Дата зміни';



PROMPT *** Create  grants  CIM_CUSTOMER_UPD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CUSTOMER_UPD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CUSTOMER_UPD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CUSTOMER_UPD to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CUSTOMER_UPD.sql =========*** End 
PROMPT ===================================================================================== 
