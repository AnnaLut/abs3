

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cp_zal_old.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to cp_zal_old ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cp_zal_old'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''cp_zal_old'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''cp_zal_old'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
 
PROMPT *** Create  table cp_zal_old ***

begin 
  execute immediate '
  CREATE TABLE BARS.cp_zal_old 
   (	REF NUMBER, 
	ID NUMBER, 
	KOLZ NUMBER, 
	DATZ DATE,
        RNK NUMBER,
	BACK_DATE DATE DEFAULT SYSDATE
   ) TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Alter table cp_zal_old ***

PROMPT *** ALTER_POLICIES to cp_zal_old ***
 exec bpa.alter_policies('cp_zal_old');

COMMENT ON TABLE  BARS.cp_zal_old IS 'Для переходу до нової моделі введення. Бєкап.';
 

PROMPT *** Create  grants  cp_zal_old ***
grant DELETE,INSERT,SELECT,UPDATE                                            on cp_zal_old          to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/cp_zal_old.sql =========*** End *** ======
PROMPT ===================================================================================== 
