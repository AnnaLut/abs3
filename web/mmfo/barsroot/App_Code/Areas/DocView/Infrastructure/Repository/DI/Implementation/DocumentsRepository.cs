using Bars.DocPrint;
using Bars.Oracle;
using BarsWeb.Areas.DocView.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;
using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace BarsWeb.Areas.DocView.Infrastructure.DI.Implementation
{
    public class DocumentsRepository : IDocumentsRepository
    {
        EntitiesBars _entities;
        public DocumentsRepository()
        {
            _entities = new EntitiesBarsCore().NewEntity();
        }

        public IQueryable<BarsWeb.Models.Documents> GetDocuments(AccessDocType accessType, DateTime dStart, DateTime dEnd, DirectionDocType dirType)
        {
            IQueryable<BarsWeb.Models.Documents> result = null;
            switch (accessType)
            {
                case AccessDocType.Tobo:
                    switch (dirType)
                    {
                        case DirectionDocType.In:
                            result = _entities.V_DOCS_TOBO_IN
                                .Where(i => i.PDAT > dStart && i.PDAT < dEnd).OrderBy(i => i.REF)
                                .Select(i => new BarsWeb.Models.Documents
                                {
                                    REF = i.REF,
                                    USERID = i.USERID,
                                    ND = i.ND,
                                    NLSA = i.NLSA,
                                    S_ = i.S_,
                                    LCV2 = i.LCV2,
                                    MFOB = i.MFOB,
                                    NLSB = i.NLSB,
                                    DK = i.DK,
                                    SK = i.SK,
                                    DATD = i.DATD,
                                    NAZN = i.NAZN,
                                    SOS = i.SOS,
                                    TOBO = i.TOBO,
                                    PDAT = i.PDAT,
                                    TT = i.TT
                                });
                            break;
                        case DirectionDocType.Out:
                            result = _entities.V_DOCS_TOBO_OUT
                                .Where(i => i.PDAT > dStart && i.PDAT < dEnd)
                                .Select(i => new BarsWeb.Models.Documents
                                {
                                    REF = i.REF,
                                    USERID = i.USERID,
                                    ND = i.ND,
                                    NLSA = i.NLSA,
                                    S_ = i.S_,
                                    LCV2 = i.LCV2,
                                    MFOB = i.MFOB,
                                    NLSB = i.NLSB,
                                    DK = i.DK,
                                    SK = i.SK,
                                    DATD = i.DATD,
                                    NAZN = i.NAZN,
                                    SOS = i.SOS,
                                    TOBO = i.TOBO,
                                    PDAT = i.PDAT,
                                    TT = i.TT
                                });
                            break;
                    }
                    break;
                case AccessDocType.User:
                    switch (dirType)
                    {
                        case DirectionDocType.In:
                            result = _entities.V_DOCS_USER_IN
                                .Where(i => i.PDAT > dStart && i.PDAT < dEnd).OrderBy(i => i.REF)
                                .Select(i => new BarsWeb.Models.Documents
                                {
                                    REF = i.REF,
                                    USERID = i.USERID,
                                    ND = i.ND,
                                    NLSA = i.NLSA,
                                    S_ = i.S_,
                                    LCV2 = i.LCV2,
                                    MFOB = i.MFOB,
                                    NLSB = i.NLSB,
                                    DK = i.DK,
                                    SK = i.SK,
                                    DATD = i.DATD,
                                    NAZN = i.NAZN,
                                    SOS = i.SOS,
                                    TOBO = i.TOBO,
                                    PDAT = i.PDAT,
                                    TT = i.TT
                                });
                            break;
                        case DirectionDocType.Out:
                            result = _entities.V_DOCS_USER_OUT
                                .Where(i => i.PDAT > dStart && i.PDAT < dEnd).OrderBy(i => i.REF)
                                .Select(i => new BarsWeb.Models.Documents
                                {
                                    REF = i.REF,
                                    USERID = i.USERID,
                                    ND = i.ND,
                                    NLSA = i.NLSA,
                                    S_ = i.S_,
                                    LCV2 = i.LCV2,
                                    MFOB = i.MFOB,
                                    NLSB = i.NLSB,
                                    DK = i.DK,
                                    SK = i.SK,
                                    DATD = i.DATD,
                                    NAZN = i.NAZN,
                                    SOS = i.SOS,
                                    TOBO = i.TOBO,
                                    PDAT = i.PDAT,
                                    TT = i.TT
                                });
                            break;
                    }
                    break;
            }

            //var documents = result.Where(i => i.PDAT > dStart && i.PDAT < dEnd).OrderBy(i => i.REF);
            return result.OrderByDescending(i => i.REF); 
        }

        public cDocPrint CreateTicket(OracleConnection connect, int id, bool printModel = true)
        {
            return new cDocPrint(connect, id, HttpContext.Current.Server.MapPath("/TEMPLATE.RPT/"), printModel);
        }

        public byte[] GetByteArrayTicket(int id, bool printModel = true)
        {
            var ticket = CreateTicket(new[] { id }, printModel);
            var array = File.ReadAllBytes(ticket.GetTicketFileName());
            ticket.DeleteTempFiles();
            return array;
        }

        public cDocPrint CreateTicket(int[] id, bool printModel = true)
        {
            var conn = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            cDocPrint outTicket;
            using (OracleConnection con = conn.GetUserConnection(HttpContext.Current))
            {
                outTicket = CreateTicket(con, id[0], printModel);
                if (id.Length > 1)
                {
                    using (var sw = new StreamWriter(outTicket.GetTicketFileName(), true))
                    {
                        for (int i = 1; i < id.Length; i++)
                        {
                            using (var ticCon = conn.GetUserConnection(HttpContext.Current))
                            {
                                try
                                {
                                    var ourTick = CreateTicket(ticCon, id[i], printModel);
                                    string text = File.ReadAllText(ourTick.GetTicketFileName(), Encoding.ASCII);
                                    sw.WriteLine(text);
                                    ourTick.DeleteTempFiles();
                                }
                                catch (Exception)
                                {
                                }
                            }
                        }
                    }
                }
            }
            return outTicket;
        }

        public IQueryable<BP_REASON> ReasonsHandbookData()
        {
            const string query = @"select * from BP_REASON";
            var result = _entities.ExecuteStoreQuery<BP_REASON>(query);
            return result.AsQueryable();
        }
    } 
}
