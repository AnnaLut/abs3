

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_OB22_CL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_OB22_CL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_OB22_CL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_OB22_CL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_OB22_CL ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_OB22_CL 
   (	DEB CHAR(6), 
	KDM NUMBER(*,0), 
	KDX NUMBER(*,0), 
	DZ NUMBER(*,0), 
	RD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_OB22_CL ***
 exec bpa.alter_policies('XOZ_OB22_CL');


COMMENT ON TABLE BARS.XOZ_OB22_CL IS 'Планові Терміни знаходження на балансі';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.DEB IS 'Продукт~R020 + Ob22';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.KDM IS 'Кількість днів Min';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.KDX IS 'Кількість днів Max';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.DZ IS 'Право на деб.запит до ЦА';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.RD IS 'Право на поновлення дати виникнення при частковому погашенні';



PROMPT *** Create  grants  XOZ_OB22_CL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XOZ_OB22_CL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XOZ_OB22_CL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_OB22_CL.sql =========*** End *** =
PROMPT ===================================================================================== 
