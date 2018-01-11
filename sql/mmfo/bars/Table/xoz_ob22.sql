

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_OB22.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_OB22 
   (	DEB CHAR(6), 
	KRD CHAR(6), 
	TXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_OB22 ***
 exec bpa.alter_policies('XOZ_OB22');


COMMENT ON TABLE BARS.XOZ_OB22 IS 'Бух.модели вариантов закрытия хоз.деб.';
COMMENT ON COLUMN BARS.XOZ_OB22.DEB IS 'Продукт-создания (Дебет)';
COMMENT ON COLUMN BARS.XOZ_OB22.KRD IS 'Продукт-закрытия (Кредит)';
COMMENT ON COLUMN BARS.XOZ_OB22.TXT IS 'Коментар';



PROMPT *** Create  grants  XOZ_OB22 ***
grant SELECT                                                                 on XOZ_OB22        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on XOZ_OB22        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XOZ_OB22        to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on XOZ_OB22        to START1;
grant SELECT                                                                 on XOZ_OB22        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_OB22.sql =========*** End *** ====
PROMPT ===================================================================================== 
