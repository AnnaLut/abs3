

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_ACC_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_ACC_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_ACC_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_ACC_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_ACC_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_ACC_TYPES 
   (ACC_TYPE     VARCHAR2(3)     CONSTRAINT CC_NBURREFACCTYPES_TYPE_NN NOT NULL, 
    DESCRIPTION  VARCHAR2(100)   CONSTRAINT CC_NBURREFACCTYPES_DESC_NN NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_REF_ACC_TYPES ***
exec bpa.alter_policies('NBUR_REF_ACC_TYPES');


COMMENT ON TABLE BARS.NBUR_REF_ACC_TYPES IS 'Довідник для типів рахунків';

COMMENT ON COLUMN BARS.NBUR_REF_ACC_TYPES.ACC_TYPE  IS 'Тип рахунку для звітності';
COMMENT ON COLUMN BARS.NBUR_REF_ACC_TYPES.DESCRIPTION IS 'Опис типу';

begin 
  execute immediate '
  ALTER TABLE BARS.NBUR_REF_ACC_TYPES ADD (
  CONSTRAINT PK_NBURREFACCTYPES
  PRIMARY KEY
  (ACC_TYPE)
  USING INDEX 
  ENABLE VALIDATE)';
exception when others then       
  if sqlcode=-2260 then null; else raise; end if; 
end; 
/

PROMPT *** Create  grants  NBUR_REF_ACC_TYPES ***
grant SELECT on NBUR_REF_ACC_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_ACC_TYPES.sql =========*** En
PROMPT ===================================================================================== 
