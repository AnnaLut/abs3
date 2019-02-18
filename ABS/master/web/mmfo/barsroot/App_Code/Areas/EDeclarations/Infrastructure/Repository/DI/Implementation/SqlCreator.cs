using Areas.EDeclarations.Models;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.EDeclarations.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"select * from bars.v_eds_crt_log order by 3 desc",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetPersonDocTypes()
        {
            //SqlText = @"select * from bars.v_eds_passp",
            return new BarsSql
            {
                SqlText = "select passp as id, name from bars.passp where passp in (1,5,7,15)",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetCreateRequest(EDeclViewModel model)
        {
            model.PersonDocSerial = String.IsNullOrEmpty(model.PersonDocSerial)? "": model.PersonDocSerial.ToUpper();
            OracleParameter[] parameters = new OracleParameter[10]
            {
                new OracleParameter("p_okpo", OracleDbType.Varchar2, model.Inn, ParameterDirection.Input),
                new OracleParameter("p_birth_date", OracleDbType.Date, model.DateOfBirth, ParameterDirection.Input),
                new OracleParameter("p_doc_type", OracleDbType.Decimal, model.PersonDocType, ParameterDirection.Input),
                new OracleParameter("p_doc_serial", OracleDbType.Varchar2, model.PersonDocSerial, ParameterDirection.Input),
                new OracleParameter("p_doc_number", OracleDbType.Varchar2, model.PersonDocNumber.Replace(" ", ""), ParameterDirection.Input),
                new OracleParameter("p_date_from", OracleDbType.Date, model.DateFrom, ParameterDirection.Input),
                new OracleParameter("p_date_to", OracleDbType.Date, model.DateTo, ParameterDirection.Input),
                new OracleParameter("p_name", OracleDbType.Varchar2, model.Fullname, ParameterDirection.Input),
                new OracleParameter("p_comm", OracleDbType.Varchar2, model.Rnk, ParameterDirection.Input),
                new OracleParameter("p_decl_id", OracleDbType.Int32, model.DeclId, ParameterDirection.InputOutput)
            };

            return new BarsSql
            {
                SqlText = "bars.eds_intg.create_request",
                SqlParams = parameters
            };
        }

        public static BarsSql RenewDeclaration(Int32 id)
        {
            OracleParameter[] parameters = new OracleParameter[]
            {
                new OracleParameter("p_okpo", OracleDbType.Varchar2, null, ParameterDirection.Input),
                new OracleParameter("p_birth_date", OracleDbType.Date, null, ParameterDirection.Input),
                new OracleParameter("p_doc_type", OracleDbType.Decimal, null, ParameterDirection.Input),
                new OracleParameter("p_doc_serial", OracleDbType.Varchar2, null, ParameterDirection.Input),
                new OracleParameter("p_doc_number", OracleDbType.Varchar2, null, ParameterDirection.Input),
                new OracleParameter("p_date_from", OracleDbType.Date, null, ParameterDirection.Input),
                new OracleParameter("p_date_to", OracleDbType.Date, null, ParameterDirection.Input),
                new OracleParameter("p_name", OracleDbType.Varchar2, null, ParameterDirection.Input),
                new OracleParameter("p_comm", OracleDbType.Varchar2, null, ParameterDirection.Input),
                new OracleParameter("p_decl_id", OracleDbType.Int32, id, ParameterDirection.InputOutput)
            };

            return new BarsSql
            {
                SqlText = "bars.eds_intg.create_request",
                SqlParams = parameters
            };
        }

        public static BarsSql IsEDeclarationExists(String num)
        {
            OracleParameter[] parameters = new OracleParameter[2]
            {
                new OracleParameter("p_decl_id", OracleDbType.Decimal, num, ParameterDirection.Input),
                new OracleParameter("p_resp", OracleDbType.Int32, ParameterDirection.Output)
            };
            return new BarsSql
            {
                SqlText = "bars.eds_intg.decl_search",
                SqlParams = parameters
            };
        }

        public static BarsSql GetPdfInBase64Sql(String id)
        {
            OracleParameter[] parameters = new OracleParameter[2]
            {
                new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input),
                new OracleParameter("p_blob", OracleDbType.Varchar2, ParameterDirection.Output)
            };
            return new BarsSql
            {
                SqlText = "bars.eds_intg.get_pdf",
                SqlParams = new OracleParameter [2]{
                    new OracleParameter("p_decl_id", OracleDbType.Decimal, id, ParameterDirection.Input),
                    new OracleParameter("p_clob", OracleDbType.Clob, ParameterDirection.Output)
                }
            };
        }

        public static BarsSql GetClientsByInn(String inn)
        {
            return new BarsSql
            {
                SqlText = @"select c.rnk, c.nmk, c.okpo, p.bday, p.passp docTypeId, ps.name docType, p.ser, p.numdoc from customer c, person p, passp ps
                                  where c.rnk = p.rnk and p.passp = ps.passp and c.okpo =:inn",
                SqlParams = new object[1] {
                    new OracleParameter("inn", OracleDbType.Varchar2, inn, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetClientsByData(EDeclViewModel model)
        {
			if(model.PersonDocSerial.Length > 0)
				return new BarsSql
				{
					SqlText = @"select c.rnk, c.nmk, c.okpo, p.bday, p.passp docTypeId, ps.name docType, p.ser, p.numdoc from customer c, person p, passp ps
									  where c.rnk = p.rnk and p.passp = ps.passp and p.bday = :dateOfBirth and p.passp =: docType and  p.ser =: docSerial and p.numdoc =replace(:docNumber,' ','')",

                    SqlParams = new OracleParameter[4]{
						new OracleParameter("dateOfBirth", OracleDbType.Date,  model.DateOfBirth, ParameterDirection.Input),
						new OracleParameter("docType", OracleDbType.Int32,  model.PersonDocType, ParameterDirection.Input),
						new OracleParameter("docSerial", OracleDbType.Varchar2,  model.PersonDocSerial, ParameterDirection.Input),
						new OracleParameter("docNumber", OracleDbType.Varchar2,  model.PersonDocNumber, ParameterDirection.Input)
					}
				};				
			else
				return new BarsSql
				{
					SqlText = @"select c.rnk, c.nmk, c.okpo, p.bday, p.passp docTypeId, ps.name docType, p.ser, p.numdoc from customer c, person p, passp ps
									  where c.rnk = p.rnk and p.passp = ps.passp and p.bday = :dateOfBirth and p.passp =: docType and p.numdoc =replace(:docNumber,' ','')",

					SqlParams = new OracleParameter[3]{
						new OracleParameter("dateOfBirth", OracleDbType.Date,  model.DateOfBirth, ParameterDirection.Input),
						new OracleParameter("docType", OracleDbType.Int32,  model.PersonDocType, ParameterDirection.Input),
						new OracleParameter("docNumber", OracleDbType.Varchar2,  model.PersonDocNumber, ParameterDirection.Input)
					}
				};	
        }
    }
}